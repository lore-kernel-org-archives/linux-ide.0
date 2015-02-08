From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [V3 PATCH 0/2] Introduce ACPI support for ahci_platform driver
Date: Mon, 9 Feb 2015 00:20:02 +0800
Message-ID: <1423412404-4690-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-by2on0123.outbound.protection.outlook.com ([207.46.100.123]:6048
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754830AbbBHQUf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Feb 2015 11:20:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, arnd@arndb.de, mjg59@srcf.ucam.org, grant.likely@linaro.org
Cc: hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch series introduce ACPI support for non-PCI AHCI platform driver.
Existing ACPI support for AHCI assumes the device controller is a PCI device.

Also, since there is no ACPI _HID/_CID for generic AHCI controller, the driver
could not use them for matching devices. Therefore, this patch introduces
a mechanism for drivers to match devices using ACPI _CLS method.

This patch series is rebased from and tested with:

    http://git.linaro.org/leg/acpi/acpi.git acpi-5.1-v8

This topic was discussed earlier here (as part of introducing support for
AMD Seattle SATA controller):

    http://marc.info/?l=linux-arm-kernel&m=141083492521584&w=2

Changes from V2 (https://lkml.org/lkml/2015/1/5/662)
	* Update with review comment from Rafael in patch 1/2
	* Rebased and tested with acpi-5.1-v8

Changes from V1 (https://lkml.org/lkml/2014/12/19/345)
	* Rebased to 3.19.0-rc2
	* Change from acpi_cls in device_driver to acpi_match_cls (Hanjun comment)
	* Change the matching logic in acpi_driver_match_device() due to the new
	  special PRP0001 _HID.
	* Simplify the return type of acpi_match_device_cls() to boolean.

Changes from RFC (https://lkml.org/lkml/2014/12/17/446)
	* Remove #ifdef and make non-ACPI version of the acpi_match_device_cls
	  as inline. (per Arnd)
	* Simplify logic to retrieve and evaluate _CLS handle. (per Hanjun)

Suravee Suthikulpanit (2):
  ACPI / scan: Add support for ACPI _CLS device matching
  ata: ahci_platform: Add ACPI _CLS matching

 drivers/acpi/scan.c             | 75 +++++++++++++++++++++++++++++++++++++++--
 drivers/ata/Kconfig             |  2 +-
 drivers/ata/ahci_platform.c     |  3 ++
 include/acpi/acnames.h          |  1 +
 include/linux/acpi.h            | 10 ++++++
 include/linux/device.h          |  1 +
 include/linux/mod_devicetable.h |  6 ++++
 7 files changed, 94 insertions(+), 4 deletions(-)

-- 
2.1.0

