From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 04/64] pata_amd: remove bogus code from timing_setup()
Date: Mon, 18 Jan 2010 18:14:20 +0100
Message-ID: <20100118171420.14623.85263.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754073Ab0ARRPj@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_amd: remove bogus code from timing_setup()

DMA modes don't have 8-bit timings.

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
