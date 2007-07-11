From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/6] ide-cris: fix ->set_pio_mode method to set transfer mode on the device
Date: Wed, 11 Jul 2007 02:03:30 +0200
Message-ID: <200707110203.30176.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.182]:52596 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbXGJXw0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 19:52:26 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1038257ika
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 16:52:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cris/ide-cris.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -722,6 +722,8 @@ static void cris_set_pio_mode(ide_drive_
 	}
 
 	cris_ide_set_speed(TYPE_PIO, setup, strobe, hold);
+
+	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
 static int speed_cris_ide(ide_drive_t *drive, const u8 speed)
