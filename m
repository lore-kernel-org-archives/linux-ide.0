From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/6] ide-cd: no need to zero drive->special.all
Date: Tue, 19 Aug 2008 20:39:41 +0200
Message-ID: <20080819183941.16469.88841.sendpatchset@localhost.localdomain>
References: <20080819183934.16469.69799.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:25109 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbYHSSmA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Aug 2008 14:42:00 -0400
Received: by gv-out-0910.google.com with SMTP id e6so46458gvc.37
        for <linux-ide@vger.kernel.org>; Tue, 19 Aug 2008 11:41:59 -0700 (PDT)
In-Reply-To: <20080819183934.16469.69799.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1882,8 +1882,6 @@ static int ide_cdrom_setup(ide_drive_t *
 	if (!drive->queue->unplug_delay)
 		drive->queue->unplug_delay = 1;
 
-	drive->special.all	= 0;
-
 	drive->atapi_flags = IDE_AFLAG_MEDIA_CHANGED | IDE_AFLAG_NO_EJECT |
 		       ide_cd_flags(id);
 
