From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] ahci: don't attach if ICH6 is in combined
 mode
Date: Thu, 06 Dec 2007 15:09:43 +0900
Message-ID: <47579227.3070007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:26643 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbXLFGJt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Dec 2007 01:09:49 -0500
Received: by wa-out-1112.google.com with SMTP id v27so239633wah
        for <linux-ide@vger.kernel.org>; Wed, 05 Dec 2007 22:09:48 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, notting@redhat.com

ICH6 R/Ms share PCI ID between piix and ahci modes and we've been
allowing ahci to attach regardless of how BIOS configured it.
However, enabling AHCI mode when the controller is in combined mode
can result in unexpected behavior.  Don't attach if the controller is
in combined mode.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Bill Nottingham <notting@redhat.com>
---
 drivers/ata/ahci.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -193,6 +193,8 @@ enum {
 					  ATA_FLAG_ACPI_SATA | ATA_FLAG_AN |
 					  ATA_FLAG_IPM,
 	AHCI_LFLAG_COMMON		= ATA_LFLAG_SKIP_D2H_BSY,
+
+	ICH_MAP				= 0x90, /* ICH MAP register */
 };
 
 struct ahci_cmd_hdr {
@@ -2273,6 +2275,22 @@ static int ahci_init_one(struct pci_dev 
 	if (rc)
 		return rc;
 
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
+	    (pdev->device == 0x2652 || pdev->device == 0x2653)) {
+		u8 map;
+
+		/* ICH6s share the same PCI ID for both piix and ahci
+		 * modes.  Enabling ahci mode while MAP indicates
+		 * combined mode is a bad idea.  Yield to ata_piix.
+		 */
+		pci_read_config_byte(pdev, ICH_MAP, &map);
+		if (map & 0x3) {
+			dev_printk(KERN_INFO, &pdev->dev, "controller is in "
+				   "combined mode, can't enable AHCI mode\n");
+			return -ENODEV;
+		}
+	}
+
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv)
 		return -ENOMEM;
