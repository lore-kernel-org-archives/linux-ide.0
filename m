From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/9] delkin_cb: set proper hwif->gendev.parent value
Date: Mon, 02 Jun 2008 22:23:09 +0200
Message-ID: <20080602202309.7265.47071.sendpatchset@localhost.localdomain>
References: <20080602202253.7265.23590.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:17242 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbYFBUVk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2008 16:21:40 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1229318mue.1
        for <linux-ide@vger.kernel.org>; Mon, 02 Jun 2008 13:21:40 -0700 (PDT)
In-Reply-To: <20080602202253.7265.23590.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

hwif->dev was set too late (after ide_device_add() call)
so hwif->gendev.parent was not initialized properly.

Fix it by setting hw.dev and letting ide_init_port_hw()
do the rest.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/delkin_cb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/delkin_cb.c
===================================================================
--- a/drivers/ide/pci/delkin_cb.c
+++ b/drivers/ide/pci/delkin_cb.c
@@ -79,6 +79,7 @@ delkin_cb_probe (struct pci_dev *dev, co
 	memset(&hw, 0, sizeof(hw));
 	ide_std_init_ports(&hw, base + 0x10, base + 0x1e);
 	hw.irq = dev->irq;
+	hw.dev = &dev->dev;
 	hw.chipset = ide_pci;		/* this enables IRQ sharing */
 
 	hwif = ide_find_port();
@@ -98,7 +99,7 @@ delkin_cb_probe (struct pci_dev *dev, co
 		goto out_disable;
 
 	pci_set_drvdata(dev, hwif);
-	hwif->dev = &dev->dev;
+
 	drive = &hwif->drives[0];
 	if (drive->present) {
 		drive->io_32bit = 1;
