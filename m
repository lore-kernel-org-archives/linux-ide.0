From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] cdrom: don't check CDC_PLAY_AUDIO in cdrom_count_tracks()
Date: Tue, 17 Jun 2008 14:20:20 +0900
Message-ID: <48574994.9090503@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40668 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbYFQFVp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jun 2008 01:21:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

According to MMC-3 (or any later versions) READ TOCs are mandatory
commands and have nothing to do with CDC_PLAY_AUDIO.  I have no idea
why the check was put there in the first place but it now only breaks
automatic actions on certain drives.

Note that this test was only effective when ide-cdrom was being used
as sr didn't mask CDC_PLAY_AUDIO according to the capabilities.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/cdrom/cdrom.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 69f26eb..11574c5 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1491,10 +1491,6 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype* tracks)
 	tracks->xa=0;
 	tracks->error=0;
 	cdinfo(CD_COUNT_TRACKS, "entering cdrom_count_tracks\n"); 
-        if (!CDROM_CAN(CDC_PLAY_AUDIO)) { 
-                tracks->error=CDS_NO_INFO;
-                return;
-        }        
 	/* Grab the TOC header so we can see how many tracks there are */
 	if ((ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCHDR, &header))) {
 		if (ret == -ENOMEDIUM)
