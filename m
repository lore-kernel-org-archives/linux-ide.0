From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cs5535: check ide_config_drive_speed() return value
Date: Thu, 26 Jul 2007 21:56:31 +0200
Message-ID: <200707262156.31586.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:63144 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936252AbXGZT77 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 15:59:59 -0400
Received: by ug-out-1314.google.com with SMTP id j3so591347ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 12:59:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5535.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -141,7 +141,9 @@ static void cs5535_set_speed(ide_drive_t
  */
 static int cs5535_set_drive(ide_drive_t *drive, u8 speed)
 {
-	ide_config_drive_speed(drive, speed);
+	if (ide_config_drive_speed(drive, speed))
+		return 1;
+
 	cs5535_set_speed(drive, speed);
 
 	return 0;
@@ -156,7 +158,9 @@ static int cs5535_set_drive(ide_drive_t 
  */
 static void cs5535_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	ide_config_drive_speed(drive, XFER_PIO_0 + pio);
+	if (ide_config_drive_speed(drive, XFER_PIO_0 + pio))
+		return;
+
 	cs5535_set_speed(drive, XFER_PIO_0 + pio);
 }
 
