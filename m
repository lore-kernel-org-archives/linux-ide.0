From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 16/64] pata_efar: fix secondary port support
Date: Mon, 18 Jan 2010 18:16:03 +0100
Message-ID: <20100118171603.14623.7966.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754783Ab0ARRR3@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_efar: fix secondary port support

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_efar.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_efar.c
===================================================================
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -2,7 +2,7 @@
  *    pata_efar.c - EFAR PIIX clone controller driver
  *
  *	(C) 2005 Red Hat
- *	(C) 2009 Bartlomiej Zolnierkiewicz
+ *	(C) 2009-2010 Bartlomiej Zolnierkiewicz
  *
  *    Some parts based on ata_piix.c by Jeff Garzik and others.
  *
@@ -222,7 +222,7 @@ static int efar_init_one (struct pci_dev
 		.udma_mask 	= ATA_UDMA4,
 		.port_ops	= &efar_ops,
 	};
-	const struct ata_port_info *ppi[] = { &info, NULL };
+	const struct ata_port_info *ppi[] = { &info, &info };
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
