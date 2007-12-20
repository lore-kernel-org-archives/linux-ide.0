From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 41/63] ide-cd: move lba_to_msf() and msf_to_lba() to <linux/cdrom.h>
Date: Thu, 20 Dec 2007 02:24:16 +0100
Message-ID: <200712200224.16183.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:12071 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758866AbXLTBeq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:46 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389250ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:45 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>


* Move lba_to_msf() and msf_to_lba() to <linux/cdrom.h>
  (use 'u8' type instead of 'byte' while at it).

* Remove msf_to_lba() copy from drivers/cdrom/cdrom.c.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/cdrom/cdrom.c |    6 ------
 drivers/ide/ide-cd.c  |   18 ------------------
 include/linux/cdrom.h |   14 ++++++++++++++
 3 files changed, 14 insertions(+), 24 deletions(-)

Index: b/drivers/cdrom/cdrom.c
===================================================================
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2787,12 +2787,6 @@ int cdrom_ioctl(struct file * file, stru
 	return -ENOSYS;
 }
 
-static inline
-int msf_to_lba(char m, char s, char f)
-{
-	return (((m * CD_SECS) + s) * CD_FRAMES + f) - CD_MSF_OFFSET;
-}
-
 /*
  * Required when we need to use READ_10 to issue other than 2048 block
  * reads
Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1643,24 +1643,6 @@ void msf_from_bcd (struct atapi_msf *msf
 	msf->frame  = BCD2BIN(msf->frame);
 }
 
-static inline
-void lba_to_msf (int lba, byte *m, byte *s, byte *f)
-{
-	lba += CD_MSF_OFFSET;
-	lba &= 0xffffff;  /* negative lbas use only 24 bits */
-	*m = lba / (CD_SECS * CD_FRAMES);
-	lba %= (CD_SECS * CD_FRAMES);
-	*s = lba / CD_FRAMES;
-	*f = lba % CD_FRAMES;
-}
-
-
-static inline
-int msf_to_lba (byte m, byte s, byte f)
-{
-	return (((m * CD_SECS) + s) * CD_FRAMES + f) - CD_MSF_OFFSET;
-}
-
 static int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense)
 {
 	struct request req;
Index: b/include/linux/cdrom.h
===================================================================
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -1184,6 +1184,20 @@ struct media_event_desc {
 
 extern int cdrom_get_media_event(struct cdrom_device_info *cdi, struct media_event_desc *med);
 
+static inline void lba_to_msf(int lba, u8 *m, u8 *s, u8 *f)
+{
+	lba += CD_MSF_OFFSET;
+	lba &= 0xffffff;  /* negative lbas use only 24 bits */
+	*m = lba / (CD_SECS * CD_FRAMES);
+	lba %= (CD_SECS * CD_FRAMES);
+	*s = lba / CD_FRAMES;
+	*f = lba % CD_FRAMES;
+}
+
+static inline int msf_to_lba(u8 m, u8 s, u8 f)
+{
+	return (((m * CD_SECS) + s) * CD_FRAMES + f) - CD_MSF_OFFSET;
+}
 #endif  /* End of kernel only stuff */ 
 
 #endif  /* _LINUX_CDROM_H */
