From: ming.lei@canonical.com
Subject: [PATCH] ata: make DVD drive recognisable on systems with Intel Sandybridge CPT chipset
Date: Thu, 22 Sep 2011 09:55:12 +0800
Message-ID: <1316656512-4829-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40073 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab1IVBz1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2011 21:55:27 -0400
Received: by gyg10 with SMTP id 10so1634603gyg.19
        for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2011 18:55:27 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, alan@linux.intel.com
Cc: linux-ide@vger.kernel.org, seth.heasley@intel.com, Ming Lei <ming.lei@canonical.com>

From: Ming Lei <ming.lei@canonical.com>

This quirk patch fixes one kind of bug inside Intel Sandybridge CPT
chipset, see reports from

	https://bugzilla.kernel.org/show_bug.cgi?id=40592.

Many guys also have reported the problem before:

	https://bugs.launchpad.net/bugs/737388
	https://bugs.launchpad.net/bugs/794642
	......

With help from Tejun, the problem is found to be caused by 32bit PIO
mode, so introduce the quirk patch to disable 32bit PIO on SATA piix
for Sandybridge CPT chipset.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/ata/ata_piix.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 43107e9..eb7ea56 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -341,11 +341,12 @@ static struct ata_port_operations piix_sata_ops = {
 };
 
 static struct ata_port_operations piix_pata_ops = {
-	.inherits		= &piix_sata_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= piix_set_piomode,
 	.set_dmamode		= piix_set_dmamode,
 	.prereset		= piix_pata_prereset,
+	.sff_irq_check		= piix_irq_check,
 };
 
 static struct ata_port_operations piix_vmw_ops = {
@@ -1585,6 +1586,15 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 				"on poweroff and hibernation\n");
 	}
 
+	/*
+	 * Sandybridge chipset H61/P67/H67 have broken 32 mode up to now
+	 * see https://bugzilla.kernel.org/show_bug.cgi?id=40592
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL && pdev->device == 0x1c00)
+		piix_sata_ops.inherits = &ata_bmdma_port_ops;
+	else
+		piix_sata_ops.inherits = &ata_bmdma32_port_ops;
+
 	port_info[0] = piix_port_info[ent->driver_data];
 	port_info[1] = piix_port_info[ent->driver_data];
 
-- 
1.7.5.4

