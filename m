From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 24/63] ide-cd: add IDE_CD_CAPABILITIES define
Date: Thu, 20 Dec 2007 02:10:55 +0100
Message-ID: <200712200210.55780.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:12451 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456AbXLTBe2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:28 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389252ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:27 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


While at it remove stale/incorrect comment.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -2559,11 +2559,13 @@ void ide_cdrom_release_real (struct cdro
 		CDROM_STATE_FLAGS(drive)->toc_valid = 0;
 }
 
+#define IDE_CD_CAPABILITIES \
+	(CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK | CDC_SELECT_SPEED | \
+	 CDC_SELECT_DISC | CDC_MULTI_SESSION | CDC_MCN | CDC_MEDIA_CHANGED | \
+	 CDC_PLAY_AUDIO | CDC_RESET | CDC_DRIVE_STATUS | CDC_CD_R | \
+	 CDC_CD_RW | CDC_DVD | CDC_DVD_R | CDC_DVD_RAM | CDC_GENERIC_PACKET | \
+	 CDC_MO_DRIVE | CDC_MRW | CDC_MRW_W | CDC_RAM)
 
-
-/****************************************************************************
- * Device initialization.
- */
 static struct cdrom_device_ops ide_cdrom_dops = {
 	.open			= ide_cdrom_open_real,
 	.release		= ide_cdrom_release_real,
@@ -2576,14 +2578,7 @@ static struct cdrom_device_ops ide_cdrom
 	.get_mcn		= ide_cdrom_get_mcn,
 	.reset			= ide_cdrom_reset,
 	.audio_ioctl		= ide_cdrom_audio_ioctl,
-	.capability		= CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK |
-				CDC_SELECT_SPEED | CDC_SELECT_DISC |
-				CDC_MULTI_SESSION | CDC_MCN |
-				CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET |
-				CDC_DRIVE_STATUS | CDC_CD_R |
-				CDC_CD_RW | CDC_DVD | CDC_DVD_R| CDC_DVD_RAM |
-				CDC_GENERIC_PACKET | CDC_MO_DRIVE | CDC_MRW |
-				CDC_MRW_W | CDC_RAM,
+	.capability		= IDE_CD_CAPABILITIES,
 	.generic_packet		= ide_cdrom_packet,
 };
 
