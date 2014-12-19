From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 2/2] ata: ahci_platform: Add ACPI _CLS matching
Date: Fri, 19 Dec 2014 14:13:08 -0600
Message-ID: <1419019988-4398-3-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1419019988-4398-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1bon0117.outbound.protection.outlook.com ([157.56.111.117]:44384
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751281AbaLSU2j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Dec 2014 15:28:39 -0500
In-Reply-To: <1419019988-4398-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, arnd@arndb.de, mjg59@srcf.ucam.org
Cc: hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch adds ACPI supports for AHCI platform driver, which uses _CLS
method to match the device.

The following is an example of ASL structure in DSDT for a SATA controller,
which contains _CLS package to be matched by the ahci_platform driver:

  Device (AHC0) // AHCI Controller
  {
    Name(_HID, "AMDI0600")
    Name (_CCA, 1)
    Name (_CLS, Package (3)
    {
      0x01, // Base Class: Mass Storage
      0x06, // Sub-Class: serial ATA
      0x01, // Interface: AHCI
    })
    Name (_CRS, ResourceTemplate ()
    {
      Memory32Fixed (ReadWrite, 0xE0300000, 0x00010000)
      Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive,,,) { 387 }
    })
  }

Also, since ATA driver should not require PCI support for ATA_ACPI,
this patch removes dependency in the driver/ata/Kconfig.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/ata/Kconfig         | 2 +-
 drivers/ata/ahci_platform.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index cd4cccb..edb00c6 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -48,7 +48,7 @@ config ATA_VERBOSE_ERROR
 
 config ATA_ACPI
 	bool "ATA ACPI Support"
-	depends on ACPI && PCI
+	depends on ACPI
 	default y
 	help
 	  This option adds support for ATA-related ACPI objects.
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 06f1d59..4879f9b 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -71,6 +71,8 @@ static const struct of_device_id ahci_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
 
+static const struct acpi_device_cls ahci_cls = {0x01, 0x06, 0x01};
+
 static struct platform_driver ahci_driver = {
 	.probe = ahci_probe,
 	.remove = ata_platform_remove_one,
@@ -78,6 +80,7 @@ static struct platform_driver ahci_driver = {
 		.name = "ahci",
 		.owner = THIS_MODULE,
 		.of_match_table = ahci_of_match,
+		.acpi_cls = &ahci_cls,
 		.pm = &ahci_pm_ops,
 	},
 };
-- 
1.9.3

