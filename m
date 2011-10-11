From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_amd: DMA modes do not have 8-bit timings
Date: Tue, 11 Oct 2011 19:45:45 +0200
Message-ID: <201110111945.46105.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_amd: DMA modes do not have 8-bit timings

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_amd.c |    5 -----
 1 file changed, 5 deletions(-)

Index: b/drivers/ata/pata_amd.c
===================================================================
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -65,11 +65,6 @@ static void timing_setup(struct ata_port
 	}
 
 	if (peer) {
-		/* This may be over conservative */
-		if (peer->dma_mode) {
-			ata_timing_compute(peer, peer->dma_mode, &apeer, T, UT);
-			ata_timing_merge(&apeer, &at, &at, ATA_TIMING_8BIT);
-		}
 		ata_timing_compute(peer, peer->pio_mode, &apeer, T, UT);
 		ata_timing_merge(&apeer, &at, &at, ATA_TIMING_8BIT);
 	}
