From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [V3 PATCH 1/2] ACPI / scan: Add support for ACPI _CLS device matching
Date: Mon, 09 Feb 2015 00:02:43 +0100
Message-ID: <6495379.TIpKZohZf0@vostro.rjw.lan>
References: <1423412404-4690-1-git-send-email-Suravee.Suthikulpanit@amd.com> <1423412404-4690-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1423412404-4690-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, arnd@arndb.de, mjg59@srcf.ucam.org, grant.likely@linaro.org, hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-ide@vger.kernel.org

On Monday, February 09, 2015 12:20:03 AM Suravee Suthikulpanit wrote:
> Device drivers typically use ACPI _HIDs/_CIDs listed in struct device_driver
> acpi_match_table to match devices. However, for generic drivers, we do
> not want to list _HID for all supported devices, and some device classes
> do not have _CID (e.g. SATA, USB). Instead, we can leverage ACPI _CLS,
> which specifies PCI-defined class code (i.e. base-class, subclass and
> programming interface).
> 
> This patch adds support for matching ACPI devices using the _CLS method.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Greg, Mika, any problems with this?

> ---
>  drivers/acpi/scan.c             | 75 +++++++++++++++++++++++++++++++++++++++--
>  include/acpi/acnames.h          |  1 +
>  include/linux/acpi.h            | 10 ++++++
>  include/linux/device.h          |  1 +
>  include/linux/mod_devicetable.h |  6 ++++
>  5 files changed, 90 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index dc4d896..0579395 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -987,13 +987,82 @@ static bool acpi_of_driver_match_device(struct device *dev,
>  bool acpi_driver_match_device(struct device *dev,
>  			      const struct device_driver *drv)
>  {
> -	if (!drv->acpi_match_table)
> -		return acpi_of_driver_match_device(dev, drv);
> +	bool ret = false;
>  
> -	return !!acpi_match_device(drv->acpi_match_table, dev);
> +	if (drv->acpi_match_table)
> +		ret = !!acpi_match_device(drv->acpi_match_table, dev);
> +
> +	/* Next, try to match with special "PRP0001" _HID */
> +	if (!ret && drv->of_match_table)
> +		ret = acpi_of_driver_match_device(dev, drv);
> +
> +	/* Next, try to match with PCI-defined class-code */
> +	if (!ret && drv->acpi_match_cls)
> +		ret = acpi_match_device_cls(drv->acpi_match_cls, dev);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(acpi_driver_match_device);
>  
> +/**
> + * acpi_match_device_cls - Match a struct device against a ACPI _CLS method
> + * @dev_cls: A pointer to struct acpi_device_cls object to match against.
> + * @dev: The ACPI device structure to match.
> + *
> + * Check if @dev has a valid ACPI and _CLS handle. If there is a
> + * struct acpi_device_cls object for that handle, use that object to match
> + * against the given struct acpi_device_cls object.
> + *
> + * Return true on success or false on failure.
> + */
> +bool acpi_match_device_cls(const struct acpi_device_cls *dev_cls,
> +			  const struct device *dev)
> +{
> +	acpi_status status;
> +	union acpi_object *pkg;
> +	struct acpi_device_cls cls;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_buffer format = { sizeof("NNN"), "NNN" };
> +	struct acpi_buffer state = { 0, NULL };
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +	if (!adev || !adev->status.present || !dev_cls)
> +		return false;
> +
> +	status = acpi_evaluate_object(adev->handle, METHOD_NAME__CLS,
> +				      NULL, &buffer);
> +	if (ACPI_FAILURE(status))
> +		return false;
> +
> +	/**
> +	 * Note:
> +	 * ACPIv5.1 defines the package to contain 3 integers for
> +	 * Base-Class code, Sub-Class code, and Programming Interface code.
> +	 */
> +	pkg = buffer.pointer;
> +	if (!pkg ||
> +	    (pkg->type != ACPI_TYPE_PACKAGE) ||
> +	    (pkg->package.count != 3)) {
> +		dev_dbg(&adev->dev, "Invalid _CLS data\n");
> +		goto out;
> +	}
> +
> +	state.length = sizeof(struct acpi_device_cls);
> +	state.pointer = &cls;
> +
> +	status = acpi_extract_package(pkg, &format, &state);
> +	if (ACPI_FAILURE(status))
> +		goto out;
> +
> +	return (dev_cls->base_class == cls.base_class &&
> +		dev_cls->sub_class == cls.sub_class &&
> +		dev_cls->prog_interface == cls.prog_interface);
> +out:
> +	kfree(pkg);
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(acpi_match_device_cls);
> +
>  static void acpi_free_power_resources_lists(struct acpi_device *device)
>  {
>  	int i;
> diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
> index 7461327..22332a6 100644
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

Shouldn't this change go through ACPICA?

> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 536991b..9a01d5d 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -442,6 +442,10 @@ const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
>  
>  extern bool acpi_driver_match_device(struct device *dev,
>  				     const struct device_driver *drv);
> +
> +bool acpi_match_device_cls(const struct acpi_device_cls *dev_cls,
> +			   const struct device *dev);
> +
>  int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
>  int acpi_device_modalias(struct device *, char *, int);
>  void acpi_walk_dep_device_list(acpi_handle handle);
> @@ -542,6 +546,12 @@ static inline const struct acpi_device_id *acpi_match_device(
>  	return NULL;
>  }
>  
> +static inline bool acpi_match_device_cls(const struct acpi_device_cls *dev_cls,
> +					 const struct device *dev)
> +{
> +	return false;
> +}
> +
>  static inline bool acpi_driver_match_device(struct device *dev,
>  					    const struct device_driver *drv)
>  {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index fb50673..8e259c5c 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -237,6 +237,7 @@ struct device_driver {
>  
>  	const struct of_device_id	*of_match_table;
>  	const struct acpi_device_id	*acpi_match_table;
> +	const struct acpi_device_cls	*acpi_match_cls;
>  
>  	int (*probe) (struct device *dev);
>  	int (*remove) (struct device *dev);
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 745def8..cf0e0d198 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -191,6 +191,12 @@ struct acpi_device_id {
>  	kernel_ulong_t driver_data;
>  };
>  
> +struct acpi_device_cls {
> +	kernel_ulong_t base_class;
> +	kernel_ulong_t sub_class;
> +	kernel_ulong_t prog_interface;
> +};
> +
>  #define PNP_ID_LEN	8
>  #define PNP_MAX_DEVICES	8
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
