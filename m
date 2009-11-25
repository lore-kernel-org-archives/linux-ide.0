From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 36/86] pata_it8213: add UDMA100 and UDMA133 support
Date: Wed, 25 Nov 2009 18:06:37 +0100
Message-ID: <20091125170637.5446.77089.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932400AbZKYRHV@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_it8213: add UDMA100 and UDMA133 support

There shouldn't be any problems with it as IDE it8213 host driver
has been supporting UDMA100 and UDMA133 for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_it8213.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_it8213.c
===================================================================
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -164,7 +164,7 @@ static void it8213_set_dmamode (struct a
 
 		/* Clocks follow the PIIX style */
 		u_speed = min(2 - (udma & 1), udma);
-		if (udma == 5)
+		if (udma > 4)
 			u_clock = 0x1000;	/* 100Mhz */
 		else if (udma > 2)
 			u_clock = 1;		/* 66Mhz */
@@ -264,7 +264,7 @@ static int it8213_init_one (struct pci_d
 		.flags		= ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
-		.udma_mask 	= ATA_UDMA4, /* FIXME: want UDMA 100? */
+		.udma_mask 	= ATA_UDMA6,
 		.port_ops	= &it8213_ops,
 	};
 	/* Current IT8213 stuff is single port */
