From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 57/64] cs5535: use ->pio_mode value to determine pair device speed
Date: Mon, 18 Jan 2010 18:21:48 +0100
Message-ID: <20100118172148.14623.18579.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:34219 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453Ab0ARRW6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:22:58 -0500
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cs5535: use ->pio_mode value to determine pair device speed

Use the current PIO mode value instead of the physical maximum one
of the pair device on the port to determine PIO commmand timings used
for both devices on the port.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cs5535.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/cs5535.c
===================================================================
--- a/drivers/ide/cs5535.c
+++ b/drivers/ide/cs5535.c
@@ -86,7 +86,7 @@ static void cs5535_set_speed(ide_drive_t
 		cmd = pioa = speed - XFER_PIO_0;
 
 		if (pair) {
-			u8 piob = ide_get_best_pio_mode(pair, 255, 4);
+			u8 piob = pair->pio_mode - XFER_PIO_0;
 
 			if (piob < cmd)
 				cmd = piob;
