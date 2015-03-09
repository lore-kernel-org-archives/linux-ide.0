From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [V5 PATCH 1/2] ACPI / scan: Add support for ACPI _CLS device
 matching
Date: Mon, 9 Mar 2015 17:20:11 +0200
Message-ID: <20150309152011.GA1563@lahna.fi.intel.com>
References: <1425622302-15193-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1425622302-15193-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425622302-15193-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: rjw@rjwysocki.net, lv.zheng@intel.com, hpa@linux.intel.com, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, arnd@arndb.de, mjg59@srcf.ucam.org, gregkh@linuxfoundation.org, hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-ide@vger.kernel.org

On Fri, Mar 06, 2015 at 12:11:41AM -0600, Suravee Suthikulpanit wrote:
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
>         { "", 0, PCI_CLASS_STORAGE_SATA_AHCI },

How about introducing macro like PCI already has and then do it like:

	{ ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI) },

Also should we allow mask here as well? This would allow partial match
if, for example we are only interested in class and subclass.

>         {},
>     };
> 
> In this case, the corresponded entry in modules.alias file would be:
> 
>     alias acpi*:010601:* ahci_platform
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>  drivers/acpi/acpica/acutils.h     |  3 ++
>  drivers/acpi/acpica/nsxfname.c    | 21 ++++++++++--
>  drivers/acpi/acpica/utids.c       | 71 +++++++++++++++++++++++++++++++++++++++

I think you need to split the ACPICA part to be a separate patch. Those
are merged through ACPICA.

>  drivers/acpi/scan.c               | 17 ++++++++--
>  include/acpi/acnames.h            |  1 +
>  include/acpi/actypes.h            |  4 ++-
>  include/linux/mod_devicetable.h   |  1 +
>  scripts/mod/devicetable-offsets.c |  1 +
>  scripts/mod/file2alias.c          | 13 +++++--
>  9 files changed, 124 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
> index c2f03e8..2aef850 100644
> --- a/drivers/acpi/acpica/acutils.h
> +++ b/drivers/acpi/acpica/acutils.h
> @@ -430,6 +430,9 @@ acpi_status
>  acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
>  		    struct acpi_pnp_device_id_list ** return_cid_list);
>  
> +acpi_status
> +acpi_ut_execute_CLS(struct acpi_namespace_node *device_node,
> +		    struct acpi_pnp_device_id **return_id);
>  /*
>   * utlock - reader/writer locks
>   */
> diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
> index d66c326..590ef06 100644
> --- a/drivers/acpi/acpica/nsxfname.c
> +++ b/drivers/acpi/acpica/nsxfname.c
> @@ -276,11 +276,12 @@ acpi_get_object_info(acpi_handle handle,
>  	struct acpi_pnp_device_id *hid = NULL;
>  	struct acpi_pnp_device_id *uid = NULL;
>  	struct acpi_pnp_device_id *sub = NULL;
> +	struct acpi_pnp_device_id *cls = NULL;
>  	char *next_id_string;
>  	acpi_object_type type;
>  	acpi_name name;
>  	u8 param_count = 0;
> -	u8 valid = 0;
> +	u16 valid = 0;
>  	u32 info_size;
>  	u32 i;
>  	acpi_status status;
> @@ -320,7 +321,7 @@ acpi_get_object_info(acpi_handle handle,
>  	if ((type == ACPI_TYPE_DEVICE) || (type == ACPI_TYPE_PROCESSOR)) {
>  		/*
>  		 * Get extra info for ACPI Device/Processor objects only:
> -		 * Run the Device _HID, _UID, _SUB, and _CID methods.
> +		 * Run the Device _HID, _UID, _SUB, _CID and _CLS methods.
>  		 *
>  		 * Note: none of these methods are required, so they may or may
>  		 * not be present for this device. The Info->Valid bitfield is used
> @@ -351,6 +352,14 @@ acpi_get_object_info(acpi_handle handle,
>  			valid |= ACPI_VALID_SUB;
>  		}
>  
> +		/* Execute the Device._CLS method */
> +
> +		status = acpi_ut_execute_CLS(node, &cls);
> +		if (ACPI_SUCCESS(status)) {
> +			info_size += cls->length;
> +			valid |= ACPI_VALID_CLS;
> +		}
> +
>  		/* Execute the Device._CID method */
>  
>  		status = acpi_ut_execute_CID(node, &cid_list);
> @@ -468,6 +477,11 @@ acpi_get_object_info(acpi_handle handle,
>  							sub, next_id_string);
>  	}
>  
> +	if (cls) {
> +		next_id_string = acpi_ns_copy_device_id(&info->cls,
> +							cls, next_id_string);
> +	}
> +
>  	if (cid_list) {
>  		info->compatible_id_list.count = cid_list->count;
>  		info->compatible_id_list.list_size = cid_list->list_size;
> @@ -507,6 +521,9 @@ cleanup:
>  	if (sub) {
>  		ACPI_FREE(sub);
>  	}
> +	if (cls) {
> +		ACPI_FREE(cls);
> +	}
>  	if (cid_list) {
>  		ACPI_FREE(cid_list);
>  	}
> diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
> index 27431cf..a64b5d1 100644
> --- a/drivers/acpi/acpica/utids.c
> +++ b/drivers/acpi/acpica/utids.c
> @@ -416,3 +416,74 @@ cleanup:
>  	acpi_ut_remove_reference(obj_desc);
>  	return_ACPI_STATUS(status);
>  }
> +
> +/*******************************************************************************
> + *
> + * FUNCTION:    acpi_ut_execute_CLS
> + *
> + * PARAMETERS:  device_node         - Node for the device
> + *              return_id           - Where the string UID is returned
> + *
> + * RETURN:      Status
> + *
> + * DESCRIPTION: Executes the _CLS control method that returns PCI-defined
> + *              class code of the device. The ACPI spec define _CLS as a
> + *              package with three integers. The returned string has format:
> + *
> + *                      "bbsspp"
> + *              where:
> + *                  bb = Base-class code
> + *                  ss = Sub-class code
> + *                  pp = Programming Interface code
> + *
> + ******************************************************************************/
> +
> +acpi_status
> +acpi_ut_execute_CLS(struct acpi_namespace_node *device_node,
> +		    struct acpi_pnp_device_id **return_id)
> +{
> +	struct acpi_pnp_device_id *cls;
> +	union acpi_operand_object *obj_desc;
> +	union acpi_operand_object **cls_objects;
> +	acpi_status status;
> +
> +	ACPI_FUNCTION_TRACE(ut_execute_CLS);
> +	status = acpi_ut_evaluate_object(device_node, METHOD_NAME__CLS,
> +					 ACPI_BTYPE_PACKAGE, &obj_desc);
> +	if (ACPI_FAILURE(status))
> +		return_ACPI_STATUS(status);
> +
> +	cls_objects = obj_desc->package.elements;
> +
> +	if (obj_desc->common.type == ACPI_TYPE_PACKAGE &&
> +	    obj_desc->package.count == 3 &&
> +	    cls_objects[0]->common.type == ACPI_TYPE_INTEGER &&
> +	    cls_objects[1]->common.type == ACPI_TYPE_INTEGER &&
> +	    cls_objects[2]->common.type == ACPI_TYPE_INTEGER) {
> +
> +		/* Allocate a buffer for the CLS */
> +		cls = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_pnp_device_id) +
> +					 (acpi_size) 7);
> +		if (!cls) {
> +			status = AE_NO_MEMORY;
> +			goto cleanup;
> +		}
> +
> +		cls->string =
> +		    ACPI_ADD_PTR(char, cls, sizeof(struct acpi_pnp_device_id));
> +
> +		sprintf(cls->string, "%02x%02x%02x",
> +			(u8)ACPI_TO_INTEGER(cls_objects[0]->integer.value),
> +			(u8)ACPI_TO_INTEGER(cls_objects[1]->integer.value),
> +			(u8)ACPI_TO_INTEGER(cls_objects[2]->integer.value));
> +		cls->length = 7;
> +		*return_id = cls;
> +	}
> +
> +cleanup:
> +
> +	/* On exit, we must delete the return object */
> +
> +	acpi_ut_remove_reference(obj_desc);
> +	return_ACPI_STATUS(status);
> +}
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index bbca783..f6ecbd1 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -907,10 +907,19 @@ static const struct acpi_device_id *__acpi_match_device(
>  	if (!device->status.present)
>  		return NULL;
>  
> -	for (id = ids; id->id[0]; id++)
> -		list_for_each_entry(hwid, &device->pnp.ids, list)
> -			if (!strcmp((char *) id->id, hwid->id))
> +	for (id = ids; id->id[0] || id->cls; id++) {
> +		list_for_each_entry(hwid, &device->pnp.ids, list) {
> +			if (id->id[0] && !strcmp((char *) id->id, hwid->id)) {
>  				return id;
> +			} else if (id->cls) {
> +				char buf[7];
> +
> +				sprintf(buf, "%06x", id->cls);
> +				if (!strcmp(buf, hwid->id))
> +					return id;
> +			}
> +		}
> +	}
>  
>  	return NULL;
>  }
> @@ -1974,6 +1983,8 @@ static void acpi_set_pnp_ids(acpi_handle handle, struct acpi_device_pnp *pnp,
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
> index e530533..9a42522 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -189,6 +189,7 @@ struct css_device_id {
>  struct acpi_device_id {
>  	__u8 id[ACPI_ID_LEN];
>  	kernel_ulong_t driver_data;
> +	__u32 cls;

It would be nice if we could change ordering here but I understand that
it breaks quite many drivers. Perhaps we should consider creating
ACPI_DEVICE() macro and convert existing drivers to that at some point.

>  };
>  
>  #define PNP_ID_LEN	8
> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
> index f282516..7f68268 100644
> --- a/scripts/mod/devicetable-offsets.c
> +++ b/scripts/mod/devicetable-offsets.c
> @@ -63,6 +63,7 @@ int main(void)
>  
>  	DEVID(acpi_device_id);
>  	DEVID_FIELD(acpi_device_id, id);
> +	DEVID_FIELD(acpi_device_id, cls);
>  
>  	DEVID(pnp_device_id);
>  	DEVID_FIELD(pnp_device_id, id);
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index e614ef6..ba5998c 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -511,12 +511,21 @@ static int do_serio_entry(const char *filename,
>  }
>  ADD_TO_DEVTABLE("serio", serio_device_id, do_serio_entry);
>  
> -/* looks like: "acpi:ACPI0003 or acpi:PNP0C0B" or "acpi:LNXVIDEO" */
> +/* looks like: "acpi:ACPI0003" or "acpi:PNP0C0B"  or "acpi:LNXVIDEO" or
> + *             "acpi:bbsspp" (bb=base-class, ss=sub-class, pp=prog-if)
> + *
> + * NOTE: * Each driver should use one of the following : _HID, _CIDs or _CLS.
> + */
>  static int do_acpi_entry(const char *filename,
>  			void *symval, char *alias)
>  {
>  	DEF_FIELD_ADDR(symval, acpi_device_id, id);
> -	sprintf(alias, "acpi*:%s:*", *id);
> +	DEF_FIELD_ADDR(symval, acpi_device_id, cls);
> +
> +	if (id && strlen((const char *)*id))
> +		sprintf(alias, "acpi*:%s:*", *id);
> +	else if (cls)
> +		sprintf(alias, "acpi*:%06x:*", *cls);
>  	return 1;
>  }
>  ADD_TO_DEVTABLE("acpi", acpi_device_id, do_acpi_entry);
> -- 
> 2.1.0
