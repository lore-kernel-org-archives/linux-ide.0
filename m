From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/63] ide-cd: fix ACER/AOpen 24X CDROM speed reporting on big-endian machines
Date: Thu, 20 Dec 2007 01:51:39 +0100
Message-ID: <200712200151.39973.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:12071 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbXLTBeF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:05 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389250ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:03 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


* Fix ACER/AOpen 24X CDROM speed reporting on big-endian machines
  by adding missing le16_to_cpu() calls.

While at it:
* Replace ntohs() by be16_to_cpu().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -2682,14 +2682,14 @@ void ide_cdrom_update_speed (ide_drive_t
 	if (!drive->id->model[0] &&
 	    !strncmp(drive->id->fw_rev, "241N", 4)) {
 		CDROM_STATE_FLAGS(drive)->current_speed  =
-			(((unsigned int)cap->curspeed) + (176/2)) / 176;
+			(le16_to_cpu(cap->curspeed) + (176/2)) / 176;
 		CDROM_CONFIG_FLAGS(drive)->max_speed =
-			(((unsigned int)cap->maxspeed) + (176/2)) / 176;
+			(le16_to_cpu(cap->maxspeed) + (176/2)) / 176;
 	} else {
 		CDROM_STATE_FLAGS(drive)->current_speed  =
-			(ntohs(cap->curspeed) + (176/2)) / 176;
+			(be16_to_cpu(cap->curspeed) + (176/2)) / 176;
 		CDROM_CONFIG_FLAGS(drive)->max_speed =
-			(ntohs(cap->maxspeed) + (176/2)) / 176;
+			(be16_to_cpu(cap->maxspeed) + (176/2)) / 176;
 	}
 }
 
