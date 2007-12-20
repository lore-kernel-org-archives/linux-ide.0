From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 38/63] ide-cd: merge cdrom_play_audio() into ide_cd_fake_play_trkind()
Date: Thu, 20 Dec 2007 02:22:09 +0100
Message-ID: <200712200222.10008.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:11752 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757388AbXLTBen (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:43 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389251ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:43 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -2047,21 +2047,6 @@ static int cdrom_select_speed(ide_drive_
 	return cdrom_queue_packet_command(drive, &req);
 }
 
-static int cdrom_play_audio(ide_drive_t *drive, int lba_start, int lba_end)
-{
-	struct request_sense sense;
-	struct request req;
-
-	cdrom_prepare_request(drive, &req);
-
-	req.sense = &sense;
-	req.cmd[0] = GPCMD_PLAY_AUDIO_MSF;
-	lba_to_msf(lba_start, &req.cmd[3], &req.cmd[4], &req.cmd[5]);
-	lba_to_msf(lba_end-1, &req.cmd[6], &req.cmd[7], &req.cmd[8]);
-
-	return cdrom_queue_packet_command(drive, &req);
-}
-
 static int cdrom_get_toc_entry(ide_drive_t *drive, int track,
 				struct atapi_toc_entry **ent)
 {
@@ -2118,6 +2103,8 @@ static int ide_cd_fake_play_trkind(ide_d
 	struct atapi_toc_entry *first_toc, *last_toc;
 	unsigned long lba_start, lba_end;
 	int stat;
+	struct request rq;
+	struct request_sense sense;
 
 	stat = cdrom_get_toc_entry(drive, ti->cdti_trk0, &first_toc);
 	if (stat)
@@ -2135,7 +2122,14 @@ static int ide_cd_fake_play_trkind(ide_d
 	if (lba_end <= lba_start)
 		return -EINVAL;
 
-	return cdrom_play_audio(drive, lba_start, lba_end);
+	cdrom_prepare_request(drive, &rq);
+
+	rq.sense = &sense;
+	rq.cmd[0] = GPCMD_PLAY_AUDIO_MSF;
+	lba_to_msf(lba_start,   &rq.cmd[3], &rq.cmd[4], &rq.cmd[5]);
+	lba_to_msf(lba_end - 1, &rq.cmd[6], &rq.cmd[7], &rq.cmd[8]);
+
+	return cdrom_queue_packet_command(drive, &rq);
 }
 
 /* the generic packet interface to cdrom.c */
