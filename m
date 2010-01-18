From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 60/64] palm_bk3710: use ->pio_mode value to determine pair device speed
Date: Mon, 18 Jan 2010 18:22:09 +0100
Message-ID: <20100118172209.14623.38294.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:50713 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381Ab0ARRXT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:23:19 -0500
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] palm_bk3710: use ->pio_mode value to determine pair device speed

Use the current PIO mode value instead of the physical maximum one
of the pair device on the port to determine PIO commmand timings used
for both devices on the port.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/palm_bk3710.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/palm_bk3710.c
===================================================================
--- a/drivers/ide/palm_bk3710.c
+++ b/drivers/ide/palm_bk3710.c
@@ -166,7 +166,7 @@ static void palm_bk3710_setpiomode(void
 	writel(val32, base + BK3710_DATRCVR);
 
 	if (mate) {
-		u8 mode2 = ide_get_best_pio_mode(mate, 255, 4);
+		u8 mode2 = mate->pio_mode - XFER_PIO_0;
 
 		if (mode2 < mode)
 			mode = mode2;
