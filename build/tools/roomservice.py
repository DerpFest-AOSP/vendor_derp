#!/usr/bin/env python3
# Copyright (C) 2012-2013, The CyanogenMod Project
#           (C) 2017-2018,2020-2021, The LineageOS Project
# Copyright (C) 2012-2015, SlimRoms Project
# Copyright (C) 2016-2018, AOSiP
# Copyright (C) 2021, DerpFest
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import base64
import json
import netrc
import os
import sys

from xml.etree import ElementTree

import urllib.error
import urllib.parse
import urllib.request

DEBUG = False
default_manifest = ".repo/manifest.xml"

custom_local_manifest = ".repo/local_manifests/derp_manifest.xml"
custom_default_revision = "14"
custom_dependencies = "derp.dependencies"
org_manifest = "derp-devices"  # leave empty if org is provided in manifest
org_display = "DerpFest-Devices"  # needed for displaying

default_manifest = ".repo/manifests/default.xml"
derp_manifest = ".repo/manifests/snippets/derp.xml"
lineage_manifest = ".repo/manifests/snippets/lineage.xml"

github_auth = os.getenv('GITHUB_API_TOKEN', None)


local_manifests = '.repo/local_manifests'
if not os.path.exists(local_manifests):
    os.makedirs(local_manifests)


def debug(*args, **kwargs):
    if DEBUG:
        print(*args, **kwargs)


def add_auth(g_req):
    global github_auth
    if github_auth is None:
        try:
            auth = netrc.netrc().authenticators("api.github.com")
        except (netrc.NetrcParseError, IOError):
            auth = None
        if auth:
            github_auth = base64.b64encode(
                ('%s:%s' % (auth[0], auth[2])).encode()
            )
        else:
            github_auth = ""
    if github_auth:
        g_req.add_header("Authorization", "token %s" % github_auth)

def exists_in_tree(lm, repository):
     for child in list(lm):
        try:
            if child.attrib['path'].endswith(repository):
                return child
        except:
            pass
     return None

def indent(elem, level=0):
    # in-place prettyprint formatter
    i = "\n" + "  " * level
    if len(elem):
        if not elem.text or not elem.text.strip():
            elem.text = i + "  "
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
        for elem in elem:
            indent(elem, level+1)
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
    else:
        if level and (not elem.tail or not elem.tail.strip()):
            elem.tail = i


def load_manifest(manifest):
    try:
        man = ElementTree.parse(manifest).getroot()
    except (IOError, ElementTree.ParseError):
        man = ElementTree.Element("manifest")
    return man


def get_default(manifest=None):
    m = manifest or load_manifest(default_manifest)
    d = m.findall('default')[0]
    return d


def get_remote(manifest=None, remote_name=None):
    m = manifest or load_manifest(default_manifest)
    if not remote_name:
        remote_name = get_default(manifest=m).get('remote')
    remotes = m.findall('remote')
    for remote in remotes:
        if remote_name == remote.get('name'):
            return remote


def get_revision(manifest=None, p="build"):
    return custom_default_revision

def get_from_manifest(device_name):
    if os.path.exists(custom_local_manifest):
        man = load_manifest(custom_local_manifest)
        for local_path in man.findall("project"):
            lp = local_path.get("path").strip('/')
            if lp.startswith("device/") and lp.endswith("/" + device_name):
                return lp
    return None


def is_in_manifest(project_path):
    for local_path in load_manifest(custom_local_manifest).findall("project"):
        if local_path.get("path") == project_path:
            return True
    return False


def add_to_manifest(repos, fallback_branch=None):
    lm = load_manifest(custom_local_manifest)
    mlm = load_manifest(default_manifest)
    derpm = load_manifest(derp_manifest)
    lineagem = load_manifest(lineage_manifest)

    for repo in repos:

        if 'repository' not in repo: # Remove repo if the name isn't set
            print('Error adding %s', repo)
            del repos[repo]
            continue
        repo_name = repo['repository']
        if 'target_path' in repo:
            repo_path = repo['target_path']
        else: # If path isn't set, its the same as name
            repo_path = repo_name.split('/')[-1]

        if 'branch' in repo:
            repo_branch=repo['branch']
        else:
            repo_branch=custom_default_revision

        if 'remote' in repo:
            repo_remote=repo['remote']
        elif "/" not in repo_name:
            repo_remote=org_manifest
        elif "/" in repo_name:
            repo_remote="github"

        if is_in_manifest(repo_path):
            print('%s already exists in the manifest' % repo_path)
            continue

        existing_m_project = None
        if exists_in_tree(mlm, repo_path) != None:
           existing_m_project = exists_in_tree(mlm, repo_path)
        elif exists_in_tree(derpm, repo_path) != None:
             existing_m_project = exists_in_tree(derpm, repo_path)
        elif exists_in_tree(lineagem, repo_path) != None:
             existing_m_project = exists_in_tree(lineagem, repo_path)

        if existing_m_project != None:
            if existing_m_project.attrib['path'] == repo['target_path']:
                print('%s already exists in main manifest, replacing with new dep' % repo_name)
                lm.append(ElementTree.Element("remove-project", attrib = {
                    "name": existing_m_project.attrib['name']
                }))

        print('Adding dependency:\nRepository: %s\nBranch: %s\nRemote: %s\nPath: %s\n' % (repo_name, repo_branch,repo_remote, repo_path))

        project = ElementTree.Element(
            "project",
            attrib={"path": repo_path,
                    "remote": repo_remote,
                    "name":  repo_name}
        )

        if repo_branch is not None:
            project.set('revision', repo_branch)
        elif fallback_branch:
            print("Using branch %s for %s" %
                  (fallback_branch, repo_name))
            project.set('revision', fallback_branch)
        else:
            print("Using default branch for %s" % repo_name)
        if 'clone-depth' in repo:
            print("Setting clone-depth to %s for %s" % (repo['clone-depth'], repo_name))
            project.set('clone-depth', repo['clone-depth'])

        lm.append(project)

    indent(lm)
    raw_xml = "\n".join(('<?xml version="1.0" encoding="UTF-8"?>',
                         ElementTree.tostring(lm).decode()))

    f = open(custom_local_manifest, 'w')
    f.write(raw_xml)
    f.close()

_fetch_dep_cache = []


def fetch_dependencies(repo_path, fallback_branch=None):
    global _fetch_dep_cache
    if repo_path in _fetch_dep_cache:
        return
    _fetch_dep_cache.append(repo_path)

    print('Looking for dependencies')

    dep_p = '/'.join((repo_path, custom_dependencies))
    if os.path.exists(dep_p):
        with open(dep_p) as dep_f:
            dependencies = json.load(dep_f)
    else:
        dependencies = {}
        debug('Dependencies file not found, bailing out.')

    fetch_list = []
    syncable_repos = []

    for dependency in dependencies:
        if not is_in_manifest(dependency['target_path']):
            if not dependency.get('branch'):
                dependency['branch'] = (get_revision() or
                                        custom_default_revision)

            fetch_list.append(dependency)
            syncable_repos.append(dependency['target_path'])
        else:
            print("Dependency already present in manifest: %s => %s" % (dependency['repository'], dependency['target_path']))

    if fetch_list:
        print('Adding dependencies to manifest\n')
        add_to_manifest(fetch_list, fallback_branch)

    if syncable_repos:
        print('Syncing dependencies')
        os.system('repo sync --force-sync --no-tags --current-branch --no-clone-bundle %s' % ' '.join(syncable_repos))

    for deprepo in syncable_repos:
        fetch_dependencies(deprepo)


def has_branch(branches, revision):
    return revision in (branch['name'] for branch in branches)


def detect_revision(repo):
    """
    returns None if using the default revision, else return
    the branch name if using a different revision
    """
    print("Checking branch info")
    githubreq = urllib.request.Request(
        repo['branches_url'].replace('{/branch}', ''))
    add_auth(githubreq)
    result = json.loads(urllib.request.urlopen(githubreq).read().decode())

    calc_revision = get_revision()
    print("Calculated revision: %s" % calc_revision)

    if has_branch(result, calc_revision):
        return calc_revision

    fallbacks = os.getenv('ROOMSERVICE_BRANCHES', '').split()
    for fallback in fallbacks:
        if has_branch(result, fallback):
            print("Using fallback branch: %s" % fallback)
            return fallback

    if has_branch(result, custom_default_revision):
        print("Falling back to custom revision: %s"
              % custom_default_revision)
        return custom_default_revision

    print("Branches found:")
    for branch in result:
        print(branch['name'])
    print("Use the ROOMSERVICE_BRANCHES environment variable to "
          "specify a list of fallback branches.")
    sys.exit()


def main():
    global DEBUG
    try:
        depsonly = bool(sys.argv[2] in ['true', 1])
    except IndexError:
        depsonly = False

    if os.getenv('ROOMSERVICE_DEBUG'):
        DEBUG = True

    product = sys.argv[1]
    device = product[product.find("_") + 1:] or product

    if depsonly:
        repo_path = get_from_manifest(device)
        if repo_path:
            fetch_dependencies(repo_path)
        else:
            print("Trying dependencies-only mode on a "
                  "non-existing device tree?")
        sys.exit()

    print("Device {0} not found. Attempting to retrieve device repository from "
          "{1} Github (http://github.com/{1}).".format(device, org_display))

    if os.getenv('IS_CIENV', "false") == "false":
        print('Building in a non-CI environment, will not run roomservice. If you would like to run roomservice please "export IS_CIENV=true".')
        return

    githubreq = urllib.request.Request(
        "https://api.github.com/search/repositories?"
        "q={0}+user:{1}+in:name+fork:true".format(device, org_display))
    add_auth(githubreq)

    repositories = []

    try:
        result = json.loads(urllib.request.urlopen(githubreq).read().decode())
    except urllib.error.URLError:
        print("Failed to search GitHub")
        sys.exit(1)
    except ValueError:
        print("Failed to parse return data from GitHub")
        sys.exit(1)
    for res in result.get('items', []):
        repositories.append(res)

    for repository in repositories:
        repo_name = repository['name']

        if not (repo_name.startswith("device_") and
                repo_name.endswith("_" + device)):
            continue
        print("Found repository: %s" % repository['name'])

        fallback_branch = detect_revision(repository)
        manufacturer = repo_name[7:-(len(device)+1)]
        repo_path = "device/%s/%s" % (manufacturer, device)
        adding = [{'repository': repo_name, 'target_path': repo_path}]

        add_to_manifest(adding, fallback_branch)

        print("Syncing repository to retrieve project.")
        os.system('repo sync --force-sync --no-tags --current-branch --no-clone-bundle %s' % repo_path)
        print("Repository synced!")

        fetch_dependencies(repo_path, fallback_branch)
        print("Done")
        sys.exit()

    print("Repository for %s not found in the %s Github repository list."
          % (device, org_display))
    print("If this is in error, you may need to manually add it to your "
          "%s" % custom_local_manifest)

if __name__ == "__main__":
    main()
