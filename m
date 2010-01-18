From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 63/64] via82cxxx: use ->pio_mode value to determine pair device speed
Date: Mon, 18 Jan 2010 18:22:30 +0100
Message-ID: <20100118172230.14623.55986.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755542Ab0ARRXr@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] via82cxxx: use ->pio_mode value to determine pair device speed

Use the current PIO mode value instead of the current transfer speed
of the pair device on the port to determine PIO commmand timings used
for both devices on the port.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/via82cxxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/via82cxxx.c
===================================================================
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -199,7 +199,7 @@ static void via_set_drive(ide_hwif_t *hw
 	ide_timing_compute(drive, speed, &t, T, UT);
 
 	if (peer) {
-		ide_timing_compute(peer, peer->current_speed, &p, T, UT);
+		ide_timing_compute(peer, peer->pio_mode, &p, T, UT);
 		ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
 	}
 
