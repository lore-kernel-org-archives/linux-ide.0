From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 1/2] ACPI / scan: Add support for ACPI _CLS device matching
Date: Mon, 22 Dec 2014 19:30:06 +0800
Message-ID: <549800BE.3010702@linaro.org>
References: <1419019988-4398-1-git-send-email-Suravee.Suthikulpanit@amd.com> <1419019988-4398-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:53814 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbaLVLaO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Dec 2014 06:30:14 -0500
Received: by mail-pd0-f182.google.com with SMTP id p10so5706197pdj.27
        for <linux-ide@vger.kernel.org>; Mon, 22 Dec 2014 03:30:14 -0800 (PST)
In-Reply-To: <1419019988-4398-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, rjw@rjwysocki.net, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, arnd@arndb.de, mjg59@srcf.ucam.org
Cc: al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 2014=E5=B9=B412=E6=9C=8820=E6=97=A5 04:13, Suravee Suthikulpanit wro=
te:
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
>   drivers/acpi/scan.c             | 63 ++++++++++++++++++++++++++++++=
+++++++++++
>   include/acpi/acnames.h          |  1 +
>   include/linux/acpi.h            | 12 +++++++-
>   include/linux/device.h          |  1 +
>   include/linux/mod_devicetable.h |  6 ++++
>   5 files changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index d670158..6bf6f90 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -864,6 +864,69 @@ int acpi_match_device_ids(struct acpi_device *de=
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
> +	union acpi_object *pkg;
> +	struct acpi_device_cls cls;
> +	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_buffer format =3D { sizeof("NNN"), "NNN" };
> +	struct acpi_buffer state =3D { 0, NULL };
> +	struct acpi_device *adev =3D ACPI_COMPANION(dev);
> +	acpi_handle handle =3D ACPI_HANDLE(dev);
> +
> +	if (!handle || !adev || !adev->status.present || !dev_cls)
> +		return ret;
> +
> +	status =3D acpi_evaluate_object(handle, METHOD_NAME__CLS, NULL, &bu=
ffer);
> +	if (ACPI_FAILURE(status))
> +		return ret;
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
> index 5a92d49..d377623 100644
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
> +static inline int acpi_match_device_cls(const struct acpi_device_cls=
 *dev_cls,
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

How about const struct acpi_device_cls *acpi_match_cls; ?

Other than that,
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
