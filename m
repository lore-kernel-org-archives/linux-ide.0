From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 35/86] pata_it8213: fix UDMA handling
Date: Wed, 25 Nov 2009 18:06:30 +0100
Message-ID: <20091125170630.5446.62655.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932473AbZKYRHP@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_it8213: fix UDMA handling

Driver should program the cycle timing not the mode number
(doing the latter results in wrong timings being used).

There shouldn't be any problems with it as IDE it8213 host driver
has been doing it this way for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_it8213.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_it8213.c
===================================================================
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -173,10 +173,10 @@ static void it8213_set_dmamode (struct a
 
 		udma_enable |= (1 << devid);
 
-		/* Load the UDMA mode number */
+		/* Load the UDMA cycle time */
 		pci_read_config_word(dev, 0x4A, &udma_timing);
 		udma_timing &= ~(3 << (4 * devid));
-		udma_timing |= (udma & 3) << (4 * devid);
+		udma_timing |= u_speed << (4 * devid);
 		pci_write_config_word(dev, 0x4A, udma_timing);
 
 		/* Load the clock selection */
