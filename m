From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/15] ide-cris: handle PIO auto-tuning in tune_cris_ide()
Date: Sat, 30 Jun 2007 21:08:59 +0200
Message-ID: <200706302108.59127.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:9971 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343AbXF3TAR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 15:00:17 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1014814ugf
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 12:00:16 -0700 (PDT)
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
@@ -690,6 +690,8 @@ static void tune_cris_ide(ide_drive_t *d
 {
 	int setup, strobe, hold;
 
+	pio = ide_get_best_pio_mode(drive, pio, 4);
+
 	switch(pio)
 	{
 		case 0:
