From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 59/64] it821x: use ->pio_mode value to determine pair device speed
Date: Mon, 18 Jan 2010 18:22:02 +0100
Message-ID: <20100118172202.14623.99244.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755346Ab0ARRX1@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] it821x: use ->pio_mode value to determine pair device speed

Use the current PIO mode value instead of the physical maximum one
of the pair device on the port to determine PIO commmand timings used
for both devices on the port.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/it821x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/it821x.c
===================================================================
--- a/drivers/ide/it821x.c
+++ b/drivers/ide/it821x.c
@@ -252,7 +252,7 @@ static void it821x_set_pio_mode(ide_hwif
 	 * on the cable.
 	 */
 	if (pair) {
-		u8 pair_pio = ide_get_best_pio_mode(pair, 255, 4);
+		u8 pair_pio = pair->pio_mode - XFER_PIO_0;
 		/* trim PIO to the slowest of the master/slave */
 		if (pair_pio < set_pio)
 			set_pio = pair_pio;
