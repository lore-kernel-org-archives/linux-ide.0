From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [V8 PATCH 0/3] Introduce ACPI support for ahci_platform driver
Date: Mon, 6 Apr 2015 10:45:19 -0500
Message-ID: <5522AA0F.8000008@amd.com>
References: <1427752579-19234-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1427752579-19234-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, mika.westerberg@linux.intel.com, robert.moore@intel.com, lv.zheng@intel.com, hanjun.guo@linaro.org
Cc: lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, mjg59@srcf.ucam.org, gregkh@linuxfoundation.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-ide@vger.kernel.org

Ping.

Are there any other concerns for this patch series?

Thanks,

Suravee

On 3/30/2015 4:56 PM, Suravee Suthikulpanit wrote:
> This patch series introduce ACPI support for AHCI platform driver.
> Existing ACPI support for AHCI assumes the device controller is a PCI device.
> Since there is no ACPI _CID for generic AHCI controller, the driver
> could not use it for matching devices. Therefore, this patch introduces
> a mechanism for drivers to match devices using ACPI _CLS method.
> _CLS contains PCI-defined class-code.
>
> This patch series also modifies ACPI modalias to add class-code to the
> exisiting format, which currently only uses _HID and _CIDs. This is required
> to support loadable modules w/ _CLS.
>
> This is rebased from and tested with:
>
>      http://git.linaro.org/leg/acpi/acpi.git acpi-5.1-v11
>
> This topic was discussed earlier here (as part of introducing support for
> AMD Seattle SATA controller):
>
>      http://marc.info/?l=linux-arm-kernel&m=141083492521584&w=2
>
> Changes from V7 (https://lkml.org/lkml/2015/3/26/592)
> 	* [1/3] Return AE_AML_OPERAND_TYPE when _CLS package containing
> 	  invalid type (per Robert Moore suggestion).
> 	* [2/3] Fixed build error due missing ACPI_DEVICE_CLASS definition
> 	  when disabling ACPI.
>
> Changes from V6 (https://lkml.org/lkml/2015/3/25/797)
> 	* Adding Acked-by Mika, and Reviewed-by Hanjun
> 	* Minor clen up to use lower case 0xffffff for cls_msk
> 	  (per Mika suggestions).
> 	* Modify the ACPI_DEVICE_CLASS macro to use designated initializer
> 	  (per Mika suggestions).
>
> Changes from V5 (https://lkml.org/lkml/2015/3/6/24)
> 	* Rebased and tested with acpi-5.1-v11
> 	* Splitting up the ACPICA changes into a separate patch [1/3].
> 	  (per Mika suggestion)
> 	* Adding class-code mask support (per Mika suggestion)
> 	* Use macro to define struct acpi_device_id entry (per Mika suggestion)
> 	* Note: Mika also recommend reordering the member of struct acpi_device_id
> 	  and define a macro to be used for declaring each table entry. This is a
> 	  large amount of changes, and will be done separtely from this patch series.
>
> Changes from V4 (https://lkml.org/lkml/2015/3/2/56)
> 	* [1/2] Bug fixed: Reorder the declaration of
> 	  struct acpi_pnp_device_id cls in the struct acpi_device_info
> 	  (include/acpi/actypes.h) since compatible_id_list must be last one.
> 	* [2/2] Added Acked-by: Tejun Heo <tj@kernel.org>
>
> Changes from V3 (https://lkml.org/lkml/2015/2/8/106)
> 	* Instead of introducing new structure acpi_device_cls, add cls into
> 	  the acpi_device_id, and modify the __acpi_match_device
> 	  to also match for cls. (per Mika suggestion.)
> 	* Add loadable module support, which requires changes in ACPI
> 	  modalias. (per Mika suggestion.)
> 	* Rebased and tested with acpi-5.1-v9
>
> Changes from V2 (https://lkml.org/lkml/2015/1/5/662)
> 	* Update with review comment from Rafael in patch 1/2
> 	* Rebased and tested with acpi-5.1-v8
>
> Changes from V1 (https://lkml.org/lkml/2014/12/19/345)
> 	* Rebased to 3.19.0-rc2
> 	* Change from acpi_cls in device_driver to acpi_match_cls (Hanjun comment)
> 	* Change the matching logic in acpi_driver_match_device() due to the new
> 	  special PRP0001 _HID.
> 	* Simplify the return type of acpi_match_device_cls() to boolean.
>
> Changes from RFC (https://lkml.org/lkml/2014/12/17/446)
> 	* Remove #ifdef and make non-ACPI version of the acpi_match_device_cls
> 	  as inline. (per Arnd)
> 	* Simplify logic to retrieve and evaluate _CLS handle. (per Hanjun)
>
> Suravee Suthikulpanit (3):
>    ACPICA: Add ACPI _CLS processing
>    ACPI / scan: Add support for ACPI _CLS device matching
>    ata: ahci_platform: Add ACPI _CLS matching
>
>   drivers/acpi/acpica/acutils.h     |  3 ++
>   drivers/acpi/acpica/nsxfname.c    | 21 +++++++++--
>   drivers/acpi/acpica/utids.c       | 73 +++++++++++++++++++++++++++++++++++++++
>   drivers/acpi/scan.c               | 36 ++++++++++++++++---
>   drivers/ata/Kconfig               |  2 +-
>   drivers/ata/ahci_platform.c       |  9 +++++
>   include/acpi/acnames.h            |  1 +
>   include/acpi/actypes.h            |  4 ++-
>   include/linux/acpi.h              | 14 ++++++++
>   include/linux/mod_devicetable.h   |  2 ++
>   scripts/mod/devicetable-offsets.c |  2 ++
>   scripts/mod/file2alias.c          | 32 +++++++++++++++--
>   12 files changed, 189 insertions(+), 10 deletions(-)
>


