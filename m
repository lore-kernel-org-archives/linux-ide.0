From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 42/63] ide-cd: coding style fixes for cdrom_get_toc_entry()
Date: Thu, 20 Dec 2007 02:25:00 +0100
Message-ID: <200712200225.00426.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:11752 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758890AbXLTBeq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:46 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389251ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:46 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


This is a preparation to move code handling cdrom.c IOCTLs out of ide-cd.c.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1993,11 +1993,13 @@ static int cdrom_get_toc_entry(ide_drive
 
 	/* Check validity of requested track number. */
 	ntracks = toc->hdr.last_track - toc->hdr.first_track + 1;
-	if (toc->hdr.first_track == CDROM_LEADOUT) ntracks = 0;
+
+	if (toc->hdr.first_track == CDROM_LEADOUT)
+		ntracks = 0;
+
 	if (track == CDROM_LEADOUT)
 		*ent = &toc->ent[ntracks];
-	else if (track < toc->hdr.first_track ||
-		 track > toc->hdr.last_track)
+	else if (track < toc->hdr.first_track || track > toc->hdr.last_track)
 		return -EINVAL;
 	else
 		*ent = &toc->ent[track - toc->hdr.first_track];
