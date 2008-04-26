From: Alek Du <alek.du@intel.com>
Subject: [PATCH] ata: Add Intel SCH PATA support
Date: Sat, 26 Apr 2008 14:00:07 +0800
Message-ID: <20080426140007.63cfeede@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37240 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363AbYDZGG4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Apr 2008 02:06:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Seems I need to post the patch here instead of LKML

[PATCH] ata: Add Intel SCH PATA support

This patch adds Intel SCH chipsets (US15W, US15L, UL11L) PATA controller
support.

Signed-off-by: Alek Du <alek.du@intel.com>
---
 include/linux/pci_ids.h |    2 ++
 drivers/ata/ata_piix.c  |   40 ++++++++++++++++++++++++++++++++++++++--
 drivers/ide/pci/piix.c  |    2 ++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70eb3c8..b72b3b4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2413,6 +2413,8 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_0  0x71a0
 #define PCI_DEVICE_ID_INTEL_82443GX_2  0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1  0x7601
+#define PCI_DEVICE_ID_INTEL_SCH_LPC    0x8119
+#define PCI_DEVICE_ID_INTEL_SCH_IDE    0x811a
 #define PCI_DEVICE_ID_INTEL_82454GX    0x84c4
 #define PCI_DEVICE_ID_INTEL_82450GX    0x84c5
 #define PCI_DEVICE_ID_INTEL_82451NX    0x84ca
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index b7c38ee..7f95a9a 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -214,6 +214,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
        /* ICH7/7-R (i945, i975) UDMA 100*/
        { 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
        { 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
+       /* INTEL SCH UDMA 100 */
+       { 0x8086, 0x811A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
        /* ICH8 Mobile PATA Controller */
        { 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },

@@ -561,6 +563,10 @@ struct ich_laptop {
        u16 subdevice;
 };

+struct sch_80 {
+       u16 device;
+};
+
 /*
  *     List of laptops that use short cables rather than 80 wire
  */
@@ -577,6 +583,17 @@ static const struct ich_laptop ich_laptop[] = {
        { 0, }
 };

+/*
+ *     List of chipsets whose port IOCFG and enable bit registers are reserved
+ */
+
+static const struct sch_80 sch_80[] = {
+       /* devid */
+       { 0x811A },     /* Intel SCH chipset */
+       /* end marker */
+       { 0, }
+};
+
 /**
  *     ich_pata_cable_detect - Probe host controller cable detect info
  *     @ap: Port for which cable detect info is desired
@@ -592,6 +609,7 @@ static int ich_pata_cable_detect(struct ata_port *ap)
 {
        struct pci_dev *pdev = to_pci_dev(ap->host->dev);
        const struct ich_laptop *lap = &ich_laptop[0];
+       const struct sch_80 *sch = &sch_80[0];
        u8 tmp, mask;

        /* Check for specials - Acer Aspire 5602WLMi */
@@ -604,6 +622,13 @@ static int ich_pata_cable_detect(struct ata_port *ap)
                lap++;
        }

+       /* Check for specials - Intel SCH chipset */
+       while (sch->device) {
+               if (sch->device == pdev->device)
+                       return ATA_CBL_PATA80;
+               sch++;
+       }
+
        /* check BIOS cable detect results */
        mask = ap->port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
        pci_read_config_byte(pdev, PIIX_IOCFG, &tmp);
@@ -624,9 +649,20 @@ static int piix_pata_prereset(struct ata_link *link, unsigned long deadline)
 {
        struct ata_port *ap = link->ap;
        struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+       const struct sch_80 *sch = &sch_80[0];
+       int skip_check = 0;

-       if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no]))
-               return -ENOENT;
+       /* Check for specials - Intel SCH chipset */
+       while (sch->device) {
+               if (sch->device == pdev->device) {
+                       skip_check = 1;
+                       break;
+               }
+               sch++;
+       }
+       if (!skip_check)
+               if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no]))
+                       return -ENOENT;
        return ata_sff_prereset(link, deadline);
 }

diff --git a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
index decef0f..dce830b 100644
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -377,6 +377,7 @@ static const struct ide_port_info piix_pci_info[] __devinitdata = {
        /* 22 */ DECLARE_ICH_DEV("ICH4",        ATA_UDMA5),
        /* 23 */ DECLARE_ICH_DEV("ESB2",        ATA_UDMA5),
        /* 24 */ DECLARE_ICH_DEV("ICH8M",       ATA_UDMA5),
+       /* 25 */ DECLARE_ICH_DEV("SCH",         ATA_UDMA5),
 };

 /**
@@ -450,6 +451,7 @@ static const struct pci_device_id piix_pci_tbl[] = {
        { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82801DB_1),  22 },
        { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ESB2_18),    23 },
        { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ICH8_6),     24 },
+       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_SCH_IDE),      25 },
        { 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
--
1.5.2.5
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
