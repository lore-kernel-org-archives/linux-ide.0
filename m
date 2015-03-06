From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [V4 PATCH 1/2] ACPI / scan: Add support for ACPI _CLS device
 matching
Date: Fri, 6 Mar 2015 10:31:59 -0600
Message-ID: <54F9D67F.9040306@amd.com>
References: <1425284840-9233-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1425284840-9233-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1bon0148.outbound.protection.outlook.com ([157.56.111.148]:21056
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750843AbbCFQcZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Mar 2015 11:32:25 -0500
In-Reply-To: <1425284840-9233-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rjw@rjwysocki.net, mika.westerberg@linux.intel.com, lv.zheng@intel.com, hpa@linux.intel.com
Cc: lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, arnd@arndb.de, mjg59@srcf.ucam.org, gregkh@linuxfoundation.org, hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 3/2/2015 2:27 AM, Suravee Suthikulpanit wrote:
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
>      acpi:<HID>:<CID1>:<CID2>:..:<CIDn>:<bbsspp>:
> E.g:
>      # cat /sys/devices/platform/AMDI0600:00/modalias
>      acpi:AMDI0600:010601:
>
> where bb is th base-class code, ss is te sub-class code, and pp is the
> programming interface code
>
> Since there would not be _HID/_CID in the ACPI matching table of the driver,
> this patch adds a field to acpi_device_id to specify the matching _CLS.
>
>      static const struct acpi_device_id ahci_acpi_match[] = {
>          { "", 0, PCI_CLASS_STORAGE_SATA_AHCI },
>          {},
>      };
>
> In this case, the corresponded entry in modules.alias file would be:
>
>      alias acpi*:010601:* ahci_platform
>
> Signed-off-by: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>
> ---
>   drivers/acpi/acpica/acutils.h     |  3 ++
>   drivers/acpi/acpica/nsxfname.c    | 20 +++++++++--
>   drivers/acpi/acpica/utids.c       | 71 +++++++++++++++++++++++++++++++++++++++
>   drivers/acpi/scan.c               | 17 ++++++++--
>   include/acpi/acnames.h            |  1 +
>   include/acpi/actypes.h            |  4 ++-
>   include/linux/mod_devicetable.h   |  1 +
>   scripts/mod/devicetable-offsets.c |  1 +
>   scripts/mod/file2alias.c          | 13 +++++--
>   9 files changed, 123 insertions(+), 8 deletions(-)
>
> [....]
 >
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index b034f10..50d8019 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -1148,7 +1148,7 @@ struct acpi_device_info {
>   	u32 name;		/* ACPI object Name */
>   	acpi_object_type type;	/* ACPI object Type */
>   	u8 param_count;		/* If a method, required parameter count */
> -	u8 valid;		/* Indicates which optional fields are valid */
> +	u16 valid;		/* Indicates which optional fields are valid */
>   	u8 flags;		/* Miscellaneous info */
>   	u8 highest_dstates[4];	/* _sx_d values: 0xFF indicates not valid */
>   	u8 lowest_dstates[5];	/* _sx_w values: 0xFF indicates not valid */
> @@ -1158,6 +1158,7 @@ struct acpi_device_info {
>   	struct acpi_pnp_device_id unique_id;	/* _UID value */
>   	struct acpi_pnp_device_id subsystem_id;	/* _SUB value */
>   	struct acpi_pnp_device_id_list compatible_id_list;	/* _CID list <must be last> */
> +	struct acpi_pnp_device_id cls;	/* _CLS value */
>   };

Please disregard this patch. I found out a mistake on my part here.  I 
have sent out V5 here (https://lkml.org/lkml/2015/3/6/24)

Thank you,

Suravee

