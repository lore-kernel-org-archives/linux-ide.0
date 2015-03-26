From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [V6 PATCH 2/3] ACPI / scan: Add support for ACPI _CLS device
 matching
Date: Thu, 26 Mar 2015 12:29:41 +0200
Message-ID: <20150326102941.GF1878@lahna.fi.intel.com>
References: <1427316368-20965-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1427316368-20965-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427316368-20965-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: rjw@rjwysocki.net, robert.moore@intel.com, lv.zheng@intel.com, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, mjg59@srcf.ucam.org, gregkh@linuxfoundation.org, hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-ide@vger.kernel.org

On Wed, Mar 25, 2015 at 03:46:07PM -0500, Suravee Suthikulpanit wrote:
> Device drivers typically use ACPI _HIDs/_CIDs listed in struct device_driver
> acpi_match_table to match devices. However, for generic drivers, we do not
> want to list _HID for all supported devices. Also, certain classes of devices
> do not have _CID (e.g. SATA, USB). Instead, we can leverage ACPI _CLS,
> which specifies PCI-defined class code (i.e. base-class, subclass and
> programming interface). This patch adds support for matching ACPI devices using
> the _CLS method.
> 
> To support loadable module, current design uses _HID or _CID to match device's
> modalias. With the new way of matching with _CLS this would requires modification
> to the current ACPI modalias key to include _CLS. This patch appends PCI-defined
> class-code to the existing ACPI modalias as following.
> 
>     acpi:<HID>:<CID1>:<CID2>:..:<CIDn>:<bbsspp>:
> E.g:
>     # cat /sys/devices/platform/AMDI0600:00/modalias
>     acpi:AMDI0600:010601:
> 
> where bb is th base-class code, ss is te sub-class code, and pp is the
> programming interface code
> 
> Since there would not be _HID/_CID in the ACPI matching table of the driver,
> this patch adds a field to acpi_device_id to specify the matching _CLS.
> 
>     static const struct acpi_device_id ahci_acpi_match[] = {
>         { ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xFFFFFF) },
>         {},
>     };
> 
> In this case, the corresponded entry in modules.alias file would be:
> 
>     alias acpi*:010601:* ahci_platform
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>  drivers/acpi/scan.c               | 39 +++++++++++++++++++++++++++++++++++----
>  include/acpi/acnames.h            |  1 +
>  include/acpi/actypes.h            |  4 +++-
>  include/linux/mod_devicetable.h   |  4 ++++
>  scripts/mod/devicetable-offsets.c |  2 ++
>  scripts/mod/file2alias.c          | 32 ++++++++++++++++++++++++++++++--
>  6 files changed, 75 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 52a62aa..f26bf80 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -895,6 +895,32 @@ static void acpi_device_remove_files(struct acpi_device *dev)
>  			ACPI Bus operations
>     -------------------------------------------------------------------------- */
>  
> +static bool __acpi_match_device_cls(const struct acpi_device_id *id,
> +				    struct acpi_hardware_id *hwid)
> +{
> +	int i, msk, byte_shift;
> +	bool found = true;
> +	char buf[3];
> +
> +	if (!id->cls)
> +		return false;
> +
> +	/* Apply class-code bitmask, before checking each class-code byte */
> +	for (i = 1; i <= 3; i++) {
> +		byte_shift = 8 * (3 - i);
> +		msk = (id->cls_msk >> byte_shift) & 0xFF;
> +		if (!msk)
> +			continue;
> +
> +		sprintf(buf, "%02x", (id->cls >> byte_shift) & msk);
> +		if (strncmp(buf, &hwid->id[(i - 1) * 2], 2)) {
> +			found = false;
> +			break;

You can return false directly here.

> +		}
> +	}
> +	return found;
> +}
> +
>  static const struct acpi_device_id *__acpi_match_device(
>  	struct acpi_device *device, const struct acpi_device_id *ids)
>  {
> @@ -908,11 +934,14 @@ static const struct acpi_device_id *__acpi_match_device(
>  	if (!device->status.present)
>  		return NULL;
>  
> -	for (id = ids; id->id[0]; id++)
> -		list_for_each_entry(hwid, &device->pnp.ids, list)
> -			if (!strcmp((char *) id->id, hwid->id))
> +	for (id = ids; id->id[0] || id->cls; id++) {
> +		list_for_each_entry(hwid, &device->pnp.ids, list) {
> +			if (id->id[0] && !strcmp((char *) id->id, hwid->id))
>  				return id;
> -
> +			else if (__acpi_match_device_cls(id, hwid))
> +				return id;
> +		}
> +	}
>  	return NULL;
>  }
>  
> @@ -2005,6 +2034,8 @@ static void acpi_set_pnp_ids(acpi_handle handle, struct acpi_device_pnp *pnp,
>  		if (info->valid & ACPI_VALID_UID)
>  			pnp->unique_id = kstrdup(info->unique_id.string,
>  							GFP_KERNEL);
> +		if (info->valid & ACPI_VALID_CLS)
> +			acpi_add_id(pnp, info->cls.string);
>  
>  		kfree(info);
>  
> diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
> index 273de70..b52c0dc 100644
> --- a/include/acpi/acnames.h
> +++ b/include/acpi/acnames.h
> @@ -51,6 +51,7 @@
>  #define METHOD_NAME__BBN        "_BBN"
>  #define METHOD_NAME__CBA        "_CBA"
>  #define METHOD_NAME__CID        "_CID"
> +#define METHOD_NAME__CLS        "_CLS"
>  #define METHOD_NAME__CRS        "_CRS"
>  #define METHOD_NAME__DDN        "_DDN"
>  #define METHOD_NAME__HID        "_HID"
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index b034f10..ab3dac8 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -1148,7 +1148,7 @@ struct acpi_device_info {
>  	u32 name;		/* ACPI object Name */
>  	acpi_object_type type;	/* ACPI object Type */
>  	u8 param_count;		/* If a method, required parameter count */
> -	u8 valid;		/* Indicates which optional fields are valid */
> +	u16 valid;		/* Indicates which optional fields are valid */
>  	u8 flags;		/* Miscellaneous info */
>  	u8 highest_dstates[4];	/* _sx_d values: 0xFF indicates not valid */
>  	u8 lowest_dstates[5];	/* _sx_w values: 0xFF indicates not valid */
> @@ -1157,6 +1157,7 @@ struct acpi_device_info {
>  	struct acpi_pnp_device_id hardware_id;	/* _HID value */
>  	struct acpi_pnp_device_id unique_id;	/* _UID value */
>  	struct acpi_pnp_device_id subsystem_id;	/* _SUB value */
> +	struct acpi_pnp_device_id cls;		/* _CLS value */
>  	struct acpi_pnp_device_id_list compatible_id_list;	/* _CID list <must be last> */
>  };
>  
> @@ -1174,6 +1175,7 @@ struct acpi_device_info {
>  #define ACPI_VALID_CID                  0x20
>  #define ACPI_VALID_SXDS                 0x40
>  #define ACPI_VALID_SXWS                 0x80
> +#define ACPI_VALID_CLS                  0x100
>  
>  /* Flags for _STA return value (current_status above) */
>  
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index e530533..9563abe 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -189,8 +189,12 @@ struct css_device_id {
>  struct acpi_device_id {
>  	__u8 id[ACPI_ID_LEN];
>  	kernel_ulong_t driver_data;
> +	__u32 cls;
> +	__u32 cls_msk;
>  };
>  
> +#define ACPI_DEVICE_CLASS(cls, msk)		"", 0, cls, msk

Consider moving this to <linux/acpi.h>, just like PCI_DEVICE_CLASS() is
defined in <linux/pci.h>.

Also please use designated initializers here, eg:

#define ACPI_DEVICE_CLASS(cls, msk)	.cls = (cls), .cls_mask = (msk)

Once done you can add my,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> +
>  #define PNP_ID_LEN	8
>  #define PNP_MAX_DEVICES	8
