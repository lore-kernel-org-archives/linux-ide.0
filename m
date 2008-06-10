From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 09/14] ide-pnp: print driver banner message early
Date: Tue, 10 Jun 2008 22:52:20 +0200
Message-ID: <20080610205220.18469.99649.sendpatchset@localhost.localdomain>
References: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:23878 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757595AbYFJUur (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 16:50:47 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1912360mue.1
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 13:50:42 -0700 (PDT)
In-Reply-To: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Print driver banner message early and without interface number.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-pnp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-pnp.c
===================================================================
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -33,6 +33,8 @@ static int idepnp_probe(struct pnp_dev *
 	ide_hwif_t *hwif;
 	unsigned long base, ctl;
 
+	printk(KERN_INFO DRV_NAME ": generic PnP IDE interface\n");
+
 	if (!(pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) && pnp_irq_valid(dev, 0)))
 		return -1;
 
@@ -64,7 +66,6 @@ static int idepnp_probe(struct pnp_dev *
 
 		ide_init_port_hw(hwif, &hw);
 
-		printk(KERN_INFO "ide%d: generic PnP IDE interface\n", index);
 		pnp_set_drvdata(dev, hwif);
 
 		ide_device_add(idx, NULL);
