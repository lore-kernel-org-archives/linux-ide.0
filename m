From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 09/64] pata_cmd64x: fix handling of address setup timings
Date: Mon, 18 Jan 2010 18:15:04 +0100
Message-ID: <20100118171504.14623.11688.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754418Ab0ARRQV@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cmd64x: fix handling of address setup timings

Account for the requirements of the DMA mode currently used
by the pair device.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cmd64x.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: b/drivers/ata/pata_cmd64x.c
===================================================================
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -165,8 +165,14 @@ static void cmd64x_set_timing(struct ata
 
 		if (pair) {
 			struct ata_timing tp;
+
 			ata_timing_compute(pair, pair->pio_mode, &tp, T, 0);
 			ata_timing_merge(&t, &tp, &t, ATA_TIMING_SETUP);
+			if (pair->dma_mode) {
+				ata_timing_compute(pair, pair->dma_mode,
+						&tp, T, 0);
+				ata_timing_merge(&tp, &t, &t, ATA_TIMING_SETUP);
+			}
 		}
 	}
 
