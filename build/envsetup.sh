function __print_derp_functions_help() {
cat <<EOF
Invoke ". build/envsetup.sh" from your shell to add the following functions to your environment:
- lunch:     lunch <product_name>-<build_variant>
- gerrit:    Adds a remote for DerpFest Gerrit


Look at the source to view more functions. The complete list is:
EOF
    local T=$(gettop)
    local A=""
    local i
    for i in `cat $T/vendor/derp/build/envsetup.sh | sed -n "/^[[:blank:]]*function /s/function \([a-z_]*\).*/\1/p" | sort | uniq`; do
      A="$A $i"
    done
    echo $A
}

function mk_timer()
{
    local start_time=$(date +"%s")
    $@
    local ret=$?
    local end_time=$(date +"%s")
    local tdiff=$(($end_time-$start_time))
    local hours=$(($tdiff / 3600 ))
    local mins=$((($tdiff % 3600) / 60))
    local secs=$(($tdiff % 60))
    local ncolors=$(tput colors 2>/dev/null)
    echo
    if [ $ret -eq 0 ] ; then
        echo -n "#### make completed successfully "
    else
        echo -n "#### make failed to build some targets "
    fi
    if [ $hours -gt 0 ] ; then
        printf "(%02g:%02g:%02g (hh:mm:ss))" $hours $mins $secs
    elif [ $mins -gt 0 ] ; then
        printf "(%02g:%02g (mm:ss))" $mins $secs
    elif [ $secs -gt 0 ] ; then
        printf "(%s seconds)" $secs
    fi
    echo " ####"
    echo
    return $ret
}

function repopick()
{
    T=$(gettop)
    $T/vendor/derp/build/tools/repopick.py $@
}

# Repo sync with various flags I'm lazy to type each time
function syncc() {
    time repo sync --force-sync --no-clone-bundle --current-branch --no-tags "$@"
}

function gerrit()
{
    if [ ! -d ".git" ]; then
        echo -e "Please run this inside a git directory";
    else
        git remote rm gerrit 2>/dev/null;
        [[ -z "${GERRIT_USER}" ]] && export GERRIT_USER=$(git config --get review.review.derp.dev.username);
        if [[ -z "${GERRIT_USER}" ]]; then
            git remote add gerrit $(git remote -v | grep -i "github\.com[:\/]DerpFest" | awk '{print $2}' | uniq | sed -e "s|.*github.com[:\/]DerpFest|ssh://review.derp.dev:29418/DERP|");
        else
            git remote add gerrit $(git remote -v | grep -i "github\.com[:\/]DerpFest" | awk '{print $2}' | uniq | sed -e "s|.*github.com[:\/]DerpFest|ssh://${GERRIT_USER}@review.derp.dev:29418/DERP|");
        fi
    fi
}

# Make using all available CPUs
function mka() {
    m -j$(nproc --all) "$@"
}

function cout()
{
    if [  "$OUT" ]; then
        cd $OUT
    else
        echo "Couldn't locate out directory.  Try setting OUT."
    fi
}

function fixup_common_out_dir() {
    common_out_dir=$(get_build_var OUT_DIR)/target/common
    target_device=$(get_build_var TARGET_DEVICE)
    common_target_out=common-${target_device}
    if [ ! -z $DERP_FIXUP_COMMON_OUT ]; then
        if [ -d ${common_out_dir} ] && [ ! -L ${common_out_dir} ]; then
            mv ${common_out_dir} ${common_out_dir}-${target_device}
            ln -s ${common_target_out} ${common_out_dir}
        else
            [ -L ${common_out_dir} ] && rm ${common_out_dir}
            mkdir -p ${common_out_dir}-${target_device}
            ln -s ${common_target_out} ${common_out_dir}
        fi
    else
        [ -L ${common_out_dir} ] && rm ${common_out_dir}
        mkdir -p ${common_out_dir}
    fi
}

function merge_aosp() {
    "$ANDROID_BUILD_TOP"/vendor/derp/scripts/merge_aosp.main.kts "$@"
}

# Disable ABI checking
export SKIP_ABI_CHECKS=true

# Override host metadata to make builds more reproducible and avoid leaking info
export BUILD_HOSTNAME=derpbox
export BUILD_USERNAME=community
