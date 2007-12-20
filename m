From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 23/63] ide-cd: cleanup ide_cdrom_update_speed()
Date: Thu, 20 Dec 2007 02:10:11 +0100
Message-ID: <200712200210.11607.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:12147 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758404AbXLTBe1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:27 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389253ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:26 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
-39 bytes
 drivers/ide/ide-cd.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -2395,19 +2395,20 @@ int ide_cdrom_get_capabilities(ide_drive
 static
 void ide_cdrom_update_speed (ide_drive_t *drive, struct atapi_capabilities_page *cap)
 {
+	u16 curspeed, maxspeed;
+
 	/* The ACER/AOpen 24X cdrom has the speed fields byte-swapped */
 	if (!drive->id->model[0] &&
 	    !strncmp(drive->id->fw_rev, "241N", 4)) {
-		CDROM_STATE_FLAGS(drive)->current_speed  =
-			(le16_to_cpu(cap->curspeed) + (176/2)) / 176;
-		CDROM_CONFIG_FLAGS(drive)->max_speed =
-			(le16_to_cpu(cap->maxspeed) + (176/2)) / 176;
+		curspeed = le16_to_cpu(cap->curspeed);
+		maxspeed = le16_to_cpu(cap->maxspeed);
 	} else {
-		CDROM_STATE_FLAGS(drive)->current_speed  =
-			(be16_to_cpu(cap->curspeed) + (176/2)) / 176;
-		CDROM_CONFIG_FLAGS(drive)->max_speed =
-			(be16_to_cpu(cap->maxspeed) + (176/2)) / 176;
+		curspeed = be16_to_cpu(cap->curspeed);
+		maxspeed = be16_to_cpu(cap->maxspeed);
 	}
+
+	CDROM_STATE_FLAGS(drive)->current_speed = (curspeed + (176/2)) / 176;
+	CDROM_CONFIG_FLAGS(drive)->max_speed = (maxspeed + (176/2)) / 176;
 }
 
 static
