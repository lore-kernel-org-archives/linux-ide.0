From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 50/64] ide-timings: use ->pio_mode value to determine fastest PIO speed
Date: Mon, 18 Jan 2010 18:20:58 +0100
Message-ID: <20100118172058.14623.81306.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755416Ab0ARRWW@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-timings: use ->pio_mode value to determine fastest PIO speed

Use the current PIO mode value instead of the physical maximum one
to determine the fastest allowed PIO for shared PIO/DMA timings.

Affected host drivers: amd74xx and via82cxxx.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-timings.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/drivers/ide/ide-timings.c
===================================================================
--- a/drivers/ide/ide-timings.c
+++ b/drivers/ide/ide-timings.c
@@ -189,8 +189,7 @@ int ide_timing_compute(ide_drive_t *driv
 	 * DMA cycle timing is slower/equal than the fastest PIO timing.
 	 */
 	if (speed >= XFER_SW_DMA_0) {
-		u8 pio = ide_get_best_pio_mode(drive, 255, 5);
-		ide_timing_compute(drive, XFER_PIO_0 + pio, &p, T, UT);
+		ide_timing_compute(drive, drive->pio_mode, &p, T, UT);
 		ide_timing_merge(&p, t, t, IDE_TIMING_ALL);
 	}
 
