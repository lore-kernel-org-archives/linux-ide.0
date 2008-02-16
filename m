From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/9] sgiioc4: use ide_find_port()
Date: Sat, 16 Feb 2008 21:26:34 +0100
Message-ID: <20080216202634.25536.78915.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:13719 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278AbYBPUME (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 15:12:04 -0500
Received: by fg-out-1718.google.com with SMTP id e21so897292fga.17
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 12:11:59 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sgiioc4.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -591,20 +591,12 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	unsigned long bar0, cmd_phys_base, ctl;
 	void __iomem *virt_base;
 	ide_hwif_t *hwif;
-	int h;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 	hw_regs_t hw;
 	struct ide_port_info d = sgiioc4_port_info;
 
-	/*
-	 * Find an empty HWIF; if none available, return -ENOMEM.
-	 */
-	for (h = 0; h < MAX_HWIFS; ++h) {
-		hwif = &ide_hwifs[h];
-		if (hwif->chipset == ide_unknown)
-			break;
-	}
-	if (h == MAX_HWIFS) {
+	hwif = ide_find_port();
+	if (hwif == NULL) {
 		printk(KERN_ERR "%s: too many IDE interfaces, no room in table\n",
 				DRV_NAME);
 		return -ENOMEM;
