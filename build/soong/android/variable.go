package android
type Product_variables struct {
	Additional_gralloc_10_usage_bits struct {
		Cppflags []string
	}
	Target_init_vendor_lib struct {
		Whole_static_libs []string
	}
	Supports_extended_compress_format struct {
		Cflags []string
	}
	Qcom_um_soong_namespace struct {
		Cflags []string
		Header_libs []string
	}
}

type ProductVariables struct {
	Additional_gralloc_10_usage_bits  *string `json:",omitempty"`
	Target_init_vendor_lib  *string `json:",omitempty"`
	Supports_extended_compress_format  *bool `json:",omitempty"`
	Qcom_um_soong_namespace  *string `json:",omitempty"`
}
