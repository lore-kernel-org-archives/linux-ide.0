From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC PATCH 1/2] ACPI / scan: Add support for ACPI _CLS device
 matching
Date: Fri, 19 Dec 2014 22:56:53 +0800
Message-ID: <54943CB5.2030206@linaro.org>
References: <1418858195-22857-1-git-send-email-suravee.suthikulpanit@amd.com> <1418858195-22857-2-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1418858195-22857-2-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, rjw@rjwysocki.net, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, arnd@arndb.de, mjg59@srcf.ucam.org
Cc: leo.duran@amd.com, graeme.gregory@linaro.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-ide@vger.kernel.org

Hi Suravee,

On 2014=E5=B9=B412=E6=9C=8818=E6=97=A5 07:16, Suravee Suthikulpanit wro=
te:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>
> Device drivers typically use ACPI _HIDs/_CIDs listed in struct device=
_driver
> acpi_match_table to match devices. However, for generic drivers, we d=
o
> not want to list _HID for all supported devices, and some device clas=
ses
> do not have _CID (e.g. SATA, USB). Instead, we can leverage ACPI _CLS=
,
> which specifies PCI-defined class code (i.e. base-class, subclass and
> programming interface).
>
> This patch adds support for matching ACPI devices using the _CLS meth=
od.
>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>   drivers/acpi/scan.c             | 73 ++++++++++++++++++++++++++++++=
+++++++++++
>   include/acpi/acnames.h          |  1 +
>   include/linux/acpi.h            | 12 ++++++-
>   include/linux/device.h          |  1 +
>   include/linux/mod_devicetable.h |  6 ++++
>   5 files changed, 92 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index d670158..6406648 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -864,6 +864,79 @@ int acpi_match_device_ids(struct acpi_device *de=
vice,
>   }
>   EXPORT_SYMBOL(acpi_match_device_ids);
>
> +/**
> + * acpi_match_device_cls - Match a struct device against a ACPI _CLS=
 method
> + * @dev_cls: A pointer to struct acpi_device_cls object to match aga=
inst.
> + * @dev: The ACPI device structure to match.
> + *
> + * Check if @dev has a valid ACPI and _CLS handle. If there is a
> + * struct acpi_device_cls object for that handle, use that object to=
 match
> + * against the given struct acpi_device_cls object.
> + *
> + * Return 0 on success or error code on failure.
> + */
> +int acpi_match_device_cls(const struct acpi_device_cls *dev_cls,
> +			  const struct device *dev)
> +{
> +	int ret =3D -EINVAL;
> +	acpi_status status;
> +	struct acpi_device *adev;
> +	union acpi_object *pkg;
> +	struct acpi_device_cls cls;
> +	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_buffer format =3D { sizeof("NNN"), "NNN" };
> +	struct acpi_buffer state =3D { 0, NULL };
> +	acpi_handle handle =3D ACPI_HANDLE(dev);

=2E..

> +	acpi_handle cls_handle;
> +
> +	if (!handle || acpi_bus_get_device(handle, &adev))

if handle is not NULL, adev will not NULL too :)
because you get the handle from adev, ACPI_HANDLE() is defined as:
acpi_device_handle(ACPI_COMPANION(dev)), and adev =3D ACPI_COMPANION(de=
v);

you may use adev =3D ACPI_COMPANION(dev) to simplify the code.

> +		return ret;
> +
> +	if (!adev->status.present || !dev_cls)
> +		return ret;
> +
> +	status =3D acpi_get_handle(adev->handle, METHOD_NAME__CLS, &cls_han=
dle);

do we need this function called here? _CLS is the method under ACPI
device object in DSDT/SSDT, and you will get adev->handle =3D=3D cls_ha=
ndle
if I'm not wrong :)

> +	if (ACPI_FAILURE(status))
> +		return ret;
> +
> +	status =3D acpi_evaluate_object(cls_handle, "_CLS", NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_EXCEPTION((AE_INFO, status, "Failed to Evaluat _CLS"));
> +		return ret;
> +	}

I think you can evaluate _CLS directly with handle here.

Thanks
Hanjun

> +
> +	/**
> +	 * Note:
> +	 * ACPIv5.1 defines the package to contain 3 integers for
> +	 * Base-Class code, Sub-Class code, and Programming Interface code.
> +	 */
> +	pkg =3D buffer.pointer;
> +	if (!pkg ||
> +	    (pkg->type !=3D ACPI_TYPE_PACKAGE) ||
> +	    (pkg->package.count !=3D 3)) {
> +		dev_err(&adev->dev, "Invalid _CLS data\n");
> +		goto out;
> +	}
> +
> +	state.length =3D sizeof(struct acpi_device_cls);
> +	state.pointer =3D &cls;
> +
> +	status =3D acpi_extract_package(pkg, &format, &state);
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_EXCEPTION((AE_INFO, status, "Invalid data"));
> +		goto out;
> +	}
> +
> +	if ((dev_cls->base_class =3D=3D cls.base_class) &&
> +	    (dev_cls->sub_class =3D=3D cls.sub_class) &&
> +	    (dev_cls->prog_interface =3D=3D cls.prog_interface))
> +		ret =3D 0;
> +out:
> +	kfree(buffer.pointer);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(acpi_match_device_cls);
> +
>   static void acpi_free_power_resources_lists(struct acpi_device *dev=
ice)
>   {
>   	int i;
> diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
> index 7461327..22332a6 100644
> --- a/include/acpi/acnames.h
> +++ b/include/acpi/acnames.h
> @@ -51,6 +51,7 @@
>   #define METHOD_NAME__BBN        "_BBN"
>   #define METHOD_NAME__CBA        "_CBA"
>   #define METHOD_NAME__CID        "_CID"
> +#define METHOD_NAME__CLS        "_CLS"
>   #define METHOD_NAME__CRS        "_CRS"
>   #define METHOD_NAME__DDN        "_DDN"
>   #define METHOD_NAME__HID        "_HID"
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 5a92d49..8680afa 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -428,10 +428,14 @@ extern int acpi_nvs_for_each_region(int (*func)=
(__u64, __u64, void *),
>   const struct acpi_device_id *acpi_match_device(const struct acpi_de=
vice_id *ids,
>   					       const struct device *dev);
>
> +int acpi_match_device_cls(const struct acpi_device_cls *dev_cls,
> +			  const struct device *dev);
> +
>   static inline bool acpi_driver_match_device(struct device *dev,
>   					    const struct device_driver *drv)
>   {
> -	return !!acpi_match_device(drv->acpi_match_table, dev);
> +	return (!!acpi_match_device(drv->acpi_match_table, dev) ||
> +		 !acpi_match_device_cls(drv->acpi_cls, dev));
>   }
>
>   int acpi_device_uevent_modalias(struct device *, struct kobj_uevent=
_env *);
> @@ -511,6 +515,12 @@ static inline const struct acpi_device_id *acpi_=
match_device(
>   	return NULL;
>   }
>
> +static int acpi_match_device_cls(const struct acpi_device_cls *dev_c=
ls,
> +				 const struct device *dev)
> +{
> +	return -EINVAL;
> +}
> +
>   static inline bool acpi_driver_match_device(struct device *dev,
>   					    const struct device_driver *drv)
>   {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ce1f2160..a469adc 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -237,6 +237,7 @@ struct device_driver {
>
>   	const struct of_device_id	*of_match_table;
>   	const struct acpi_device_id	*acpi_match_table;
> +	const struct acpi_device_cls	*acpi_cls;
>
>   	int (*probe) (struct device *dev);
>   	int (*remove) (struct device *dev);
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devi=
cetable.h
> index 44eeef0..f2ef3c6 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -186,6 +186,12 @@ struct css_device_id {
>
>   #define ACPI_ID_LEN	9
>
> +struct acpi_device_cls {
> +	kernel_ulong_t base_class;
> +	kernel_ulong_t sub_class;
> +	kernel_ulong_t prog_interface;
> +};
> +
>   struct acpi_device_id {
>   	__u8 id[ACPI_ID_LEN];
>   	kernel_ulong_t driver_data;
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
