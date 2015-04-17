From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [V8 PATCH 1/3] ACPICA: Add ACPI _CLS processing
Date: Fri, 17 Apr 2015 03:48:12 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2BEAE4@ORSMSX112.amr.corp.intel.com>
References: <1427752579-19234-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1427752579-19234-2-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1AE640813FDE7649BE1B193DEA596E8802704682@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802704682@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "leo.duran@amd.com" <leo.duran@amd.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
List-Id: linux-ide@vger.kernel.org

Yes, this is a good question that we should think about.
Bob


> -----Original Message-----
> From: Zheng, Lv
> Sent: Thursday, April 16, 2015 6:46 PM
> To: Suravee Suthikulpanit; rjw@rjwysocki.net;
> mika.westerberg@linux.intel.com; Moore, Robert; hanjun.guo@linaro.org
> Cc: lenb@kernel.org; hdegoede@redhat.com; tj@kernel.org;
> mjg59@srcf.ucam.org; gregkh@linuxfoundation.org; al.stone@linaro.org;
> graeme.gregory@linaro.org; leo.duran@amd.com; linux-ide@vger.kernel.org;
> linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linaro-
> acpi@lists.linaro.org
> Subject: RE: [V8 PATCH 1/3] ACPICA: Add ACPI _CLS processing
> 
> Before back porting this to ACPICA, let me ask one simple question.
> According to the spec, the _CLS is optional and PCI specific.
> So why should we implement it in ACPICA core not OSPM specific modules?
> If this need to be implemented in ACPICA, then what about the following
> device identification objects?
> _DDN, _HRV, _MLS, _PLD, _STR, _SUN
> 
> Thanks and best regards
> -Lv
> 
> > From: Suravee Suthikulpanit [mailto:Suravee.Suthikulpanit@amd.com]
> > Sent: Tuesday, March 31, 2015 5:56 AM
> >
> > ACPI Device configuration often contain _CLS object to suppy
> > PCI-defined class code for the device. This patch introduces logic to
> > process the _CLS object.
> >
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> > Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > ---
> >  drivers/acpi/acpica/acutils.h  |  3 ++
> > drivers/acpi/acpica/nsxfname.c | 21 ++++++++++--
> >  drivers/acpi/acpica/utids.c    | 73
> ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 95 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/acutils.h
> > b/drivers/acpi/acpica/acutils.h index c2f03e8..2aef850 100644
> > --- a/drivers/acpi/acpica/acutils.h
> > +++ b/drivers/acpi/acpica/acutils.h
> > @@ -430,6 +430,9 @@ acpi_status
> >  acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
> >  		    struct acpi_pnp_device_id_list ** return_cid_list);
> >
> > +acpi_status
> > +acpi_ut_execute_CLS(struct acpi_namespace_node *device_node,
> > +		    struct acpi_pnp_device_id **return_id);
> >  /*
> >   * utlock - reader/writer locks
> >   */
> > diff --git a/drivers/acpi/acpica/nsxfname.c
> > b/drivers/acpi/acpica/nsxfname.c index d66c326..590ef06 100644
> > --- a/drivers/acpi/acpica/nsxfname.c
> > +++ b/drivers/acpi/acpica/nsxfname.c
> > @@ -276,11 +276,12 @@ acpi_get_object_info(acpi_handle handle,
> >  	struct acpi_pnp_device_id *hid = NULL;
> >  	struct acpi_pnp_device_id *uid = NULL;
> >  	struct acpi_pnp_device_id *sub = NULL;
> > +	struct acpi_pnp_device_id *cls = NULL;
> >  	char *next_id_string;
> >  	acpi_object_type type;
> >  	acpi_name name;
> >  	u8 param_count = 0;
> > -	u8 valid = 0;
> > +	u16 valid = 0;
> >  	u32 info_size;
> >  	u32 i;
> >  	acpi_status status;
> > @@ -320,7 +321,7 @@ acpi_get_object_info(acpi_handle handle,
> >  	if ((type == ACPI_TYPE_DEVICE) || (type == ACPI_TYPE_PROCESSOR)) {
> >  		/*
> >  		 * Get extra info for ACPI Device/Processor objects only:
> > -		 * Run the Device _HID, _UID, _SUB, and _CID methods.
> > +		 * Run the Device _HID, _UID, _SUB, _CID and _CLS methods.
> >  		 *
> >  		 * Note: none of these methods are required, so they may or
> may
> >  		 * not be present for this device. The Info->Valid bitfield is
> used
> > @@ -351,6 +352,14 @@ acpi_get_object_info(acpi_handle handle,
> >  			valid |= ACPI_VALID_SUB;
> >  		}
> >
> > +		/* Execute the Device._CLS method */
> > +
> > +		status = acpi_ut_execute_CLS(node, &cls);
> > +		if (ACPI_SUCCESS(status)) {
> > +			info_size += cls->length;
> > +			valid |= ACPI_VALID_CLS;
> > +		}
> > +
> >  		/* Execute the Device._CID method */
> >
> >  		status = acpi_ut_execute_CID(node, &cid_list); @@ -468,6
> +477,11 @@
> > acpi_get_object_info(acpi_handle handle,
> >  							sub, next_id_string);
> >  	}
> >
> > +	if (cls) {
> > +		next_id_string = acpi_ns_copy_device_id(&info->cls,
> > +							cls, next_id_string);
> > +	}
> > +
> >  	if (cid_list) {
> >  		info->compatible_id_list.count = cid_list->count;
> >  		info->compatible_id_list.list_size = cid_list->list_size; @@ -
> 507,6
> > +521,9 @@ cleanup:
> >  	if (sub) {
> >  		ACPI_FREE(sub);
> >  	}
> > +	if (cls) {
> > +		ACPI_FREE(cls);
> > +	}
> >  	if (cid_list) {
> >  		ACPI_FREE(cid_list);
> >  	}
> > diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
> > index 27431cf..9745065 100644
> > --- a/drivers/acpi/acpica/utids.c
> > +++ b/drivers/acpi/acpica/utids.c
> > @@ -416,3 +416,76 @@ cleanup:
> >  	acpi_ut_remove_reference(obj_desc);
> >  	return_ACPI_STATUS(status);
> >  }
> > +
> > +/********************************************************************
> > +***********
> > + *
> > + * FUNCTION:    acpi_ut_execute_CLS
> > + *
> > + * PARAMETERS:  device_node         - Node for the device
> > + *              return_id           - Where the string UID is returned
> > + *
> > + * RETURN:      Status
> > + *
> > + * DESCRIPTION: Executes the _CLS control method that returns PCI-
> defined
> > + *              class code of the device. The ACPI spec define _CLS as
> a
> > + *              package with three integers. The returned string has
> format:
> > + *
> > + *                      "bbsspp"
> > + *              where:
> > + *                  bb = Base-class code
> > + *                  ss = Sub-class code
> > + *                  pp = Programming Interface code
> > + *
> > +
> > +*********************************************************************
> > +*********/
> > +
> > +acpi_status
> > +acpi_ut_execute_CLS(struct acpi_namespace_node *device_node,
> > +		    struct acpi_pnp_device_id **return_id) {
> > +	struct acpi_pnp_device_id *cls;
> > +	union acpi_operand_object *obj_desc;
> > +	union acpi_operand_object **cls_objects;
> > +	acpi_status status;
> > +
> > +	ACPI_FUNCTION_TRACE(ut_execute_CLS);
> > +	status = acpi_ut_evaluate_object(device_node, METHOD_NAME__CLS,
> > +					 ACPI_BTYPE_PACKAGE, &obj_desc);
> > +	if (ACPI_FAILURE(status))
> > +		return_ACPI_STATUS(status);
> > +
> > +	cls_objects = obj_desc->package.elements;
> > +
> > +	if (obj_desc->common.type == ACPI_TYPE_PACKAGE &&
> > +	    obj_desc->package.count == 3 &&
> > +	    cls_objects[0]->common.type == ACPI_TYPE_INTEGER &&
> > +	    cls_objects[1]->common.type == ACPI_TYPE_INTEGER &&
> > +	    cls_objects[2]->common.type == ACPI_TYPE_INTEGER) {
> > +
> > +		/* Allocate a buffer for the CLS */
> > +		cls = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_pnp_device_id) +
> > +					 (acpi_size) 7);
> > +		if (!cls) {
> > +			status = AE_NO_MEMORY;
> > +			goto cleanup;
> > +		}
> > +
> > +		cls->string =
> > +		    ACPI_ADD_PTR(char, cls, sizeof(struct
> acpi_pnp_device_id));
> > +
> > +		sprintf(cls->string, "%02x%02x%02x",
> > +			(u8)ACPI_TO_INTEGER(cls_objects[0]->integer.value),
> > +			(u8)ACPI_TO_INTEGER(cls_objects[1]->integer.value),
> > +			(u8)ACPI_TO_INTEGER(cls_objects[2]->integer.value));
> > +		cls->length = 7;
> > +		*return_id = cls;
> > +	} else {
> > +		status = AE_AML_OPERAND_TYPE;
> > +	}
> > +
> > +cleanup:
> > +
> > +	/* On exit, we must delete the return object */
> > +
> > +	acpi_ut_remove_reference(obj_desc);
> > +	return_ACPI_STATUS(status);
> > +}
> > --
> > 2.1.0
