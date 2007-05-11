From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: give devices one last chance even if recovery failed
 with -EINVAL
Date: Fri, 11 May 2007 14:46:51 +0200
Message-ID: <464465BB.5070203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:35799 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891AbXEKMrE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 08:47:04 -0400
Received: by py-out-1112.google.com with SMTP id a29so774793pyi
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 05:47:04 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>


After certain errors, some devices report complete garbage on
IDENTIFY.  This can cause ata_dev_read_id() to fail with -EINVAL
resulting in immediate disabling of the device.  Give the device one
last chance after -EINVAL to allow recovery from such situations.  As
-EINVAL is triggered very rarely, this shouldn't cause any noticeable
affect on more common error paths.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Harald Dunkel <harald.dunkel@t-online.de>

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8256655..d7f62c7 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2201,14 +2201,10 @@ static int ata_eh_recover(struct ata_por
 	ehc->tries[dev->devno]--;
 
 	switch (rc) {
-	case -EINVAL:
-		/* eeek, something went very wrong, give up */
-		ehc->tries[dev->devno] = 0;
-		break;
-
 	case -ENODEV:
 		/* device missing or wrong IDENTIFY data, schedule probing */
 		ehc->i.probe_mask |= (1 << dev->devno);
+	case -EINVAL:
 		/* give it just one more chance */
 		ehc->tries[dev->devno] = min(ehc->tries[dev->devno], 1);
 	case -EIO:
