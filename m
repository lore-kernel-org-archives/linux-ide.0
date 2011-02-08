From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 08/20] pata_it8213: add UDMA100 and UDMA133 support
Date: Tue, 08 Feb 2011 13:24:31 +0100
Message-ID: <20110208122431.19110.30142.sendpatchset@linux-mhg7.site>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

>From d7d8c9c8372230ec596814ca3281564156f94926 Mon Sep 17 00:00:00 2001
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Tue, 8 Feb 2011 12:39:26 +0100
Subject: [PATCH 08/20] pata_it8213: add UDMA100 and UDMA133 support

Fixes IDE -> libata regression.

IDE's it8213 host driver has been supporting those modes
(per official documentation) since the initial driver's merge
on Feb 7 2007 (commit 9c6712c0 "ide: add it8213 IDE driver").

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_it8213.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index ccfd1ae..e045eab 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -164,7 +164,7 @@ static void it8213_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 
 		/* Clocks follow the PIIX style */
 		u_speed = min(2 - (udma & 1), udma);
-		if (udma == 5)
+		if (udma > 4)
 			u_clock = 0x1000;	/* 100Mhz */
 		else if (udma > 2)
 			u_clock = 1;		/* 66Mhz */
@@ -234,7 +234,7 @@ static int it8213_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA12_ONLY,
-		.udma_mask 	= ATA_UDMA4, /* FIXME: want UDMA 100? */
+		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &it8213_ops,
 	};
 	/* Current IT8213 stuff is single port */
-- 
1.7.1
