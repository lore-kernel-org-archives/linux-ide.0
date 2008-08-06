From: Alexander Inyukhin <shurick@sectorb.msk.ru>
Subject: [patch] cdrom: Handle TOC
Date: Thu, 7 Aug 2008 01:03:58 +0400
Message-ID: <20080806210358.GA7386@shurick.s2s.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from forum.snto-msu.net ([194.88.210.5]:34205 "EHLO
	hq.sectorb.msk.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbYHFVhd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2008 17:37:33 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Borislav Petkov <petkovbb@googlemail.com>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

This patch should fix TOC handling for cdroms that can not play audio.
It extends commit af744e3294d09d706c4eae26cffaaa68a8d40337
with a safety check and non-audio ioctls support.

Since CDC_PLAY_AUDIO flag was used not only to check ability
to play audio but also to ensure that audio_ioctl was not NULL,
all TOC-related operations had to use it.

As far as I understand, now audio_ioctl is never NULL,
so a sanity check during device registration should be sufficient.

The patch is against 2.6.27-rc2. It was tested on Optiarc AD7203A
device, that has no ability to play audio.

--yrj/dFKFPuw6o+aM
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index d9d1b65..efc3aa0 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -394,6 +394,8 @@ int register_cdrom(struct cdrom_device_info *cdi)
 
 	if (cdo->open == NULL || cdo->release == NULL)
 		return -EINVAL;
+	if (cdo->audio_ioctl == NULL)
+		return -EINVAL;
 	if (!banner_printed) {
 		printk(KERN_INFO "Uniform CD-ROM driver " REVISION "\n");
 		banner_printed = 1;
@@ -408,7 +410,6 @@ int register_cdrom(struct cdrom_device_info *cdi)
 	ENSURE(get_last_session, CDC_MULTI_SESSION);
 	ENSURE(get_mcn, CDC_MCN);
 	ENSURE(reset, CDC_RESET);
-	ENSURE(audio_ioctl, CDC_PLAY_AUDIO);
 	ENSURE(generic_packet, CDC_GENERIC_PACKET);
 	cdi->mc_flags = 0;
 	cdo->n_minors = 0;
@@ -2506,8 +2507,6 @@ static int cdrom_ioctl_get_subchnl(struct cdrom_device_info *cdi,
 
 	/* cdinfo(CD_DO_IOCTL,"entering CDROMSUBCHNL\n");*/
 
-	if (!CDROM_CAN(CDC_PLAY_AUDIO))
-		return -ENOSYS;
 	if (copy_from_user(&q, argp, sizeof(q)))
 		return -EFAULT;
 
@@ -2538,8 +2537,6 @@ static int cdrom_ioctl_read_tochdr(struct cdrom_device_info *cdi,
 
 	/* cdinfo(CD_DO_IOCTL, "entering CDROMREADTOCHDR\n"); */
 
-	if (!CDROM_CAN(CDC_PLAY_AUDIO))
-		return -ENOSYS;
 	if (copy_from_user(&header, argp, sizeof(header)))
 		return -EFAULT;
 
@@ -2562,8 +2559,6 @@ static int cdrom_ioctl_read_tocentry(struct cdrom_device_info *cdi,
 
 	/* cdinfo(CD_DO_IOCTL, "entering CDROMREADTOCENTRY\n"); */
 
-	if (!CDROM_CAN(CDC_PLAY_AUDIO))
-		return -ENOSYS;
 	if (copy_from_user(&entry, argp, sizeof(entry)))
 		return -EFAULT;
 

--yrj/dFKFPuw6o+aM--
