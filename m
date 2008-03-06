From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Commit 9f10d9ee breaks CD mounting/burning
Date: Thu, 6 Mar 2008 22:35:00 +0100
Message-ID: <200803062235.00396.bzolnier@gmail.com>
References: <fqngjf$cjf$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:36344 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbYCFVVx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 16:21:53 -0500
Received: by ug-out-1314.google.com with SMTP id z38so4006172ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 13:21:51 -0800 (PST)
In-Reply-To: <fqngjf$cjf$1@ger.gmane.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: walt <w41ter@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@googlemail.com>


On Thursday 06 March 2008, walt wrote:
> Hi Bartolmiej,
> 
> For me, this commit causes the problem it's intended to fix:
> 
> commit 9f10d9ee0ac6d79d7bc8b9a158bf4a29322d84d3
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date:   Tue Feb 26 21:50:35 2008 +0100
> 
>      ide-cd: fix 'ireason' handling for REQ_TYPE_ATA_PC requests
> 
>      This fixes some hangs caused by not finishing the transfer before ending
>      the request and also makes use of 'ireason == 1' quirk for spurious IRQs.
> 
> When I mount a CD there is a long delay, and I see this error message:
> 
> hdc: ide_cd_check_ireason: wrong transfer direction!
> cdrom: failed setting lba address space
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> <repeated many times>
> 
> When I revert this commit everything works properly again, including
> CD burning.
> 
> Here is the drive info:
> 
> hdc: TSSTcorpCD/DVDW SH-S182M, ATAPI CD/DVD-ROM drive
> hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> hdc: UDMA/33 mode selected
> hdc: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
> Uniform CD-ROM driver Revision: 3.20
> hdc: UDMA/33 mode selected
> 
> I'm happy to try patches or supply more info, just let me know
> what you need.

Does the following patch help?

[ Borislav, please take a look and double check that it is OK. ]

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-cd: mark REQ_TYPE_ATA_PC write requests with REQ_RW flag

On Thursday 06 March 2008, walt wrote:

> For me, this commit causes the problem it's intended to fix:
> 
> commit 9f10d9ee0ac6d79d7bc8b9a158bf4a29322d84d3
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date:   Tue Feb 26 21:50:35 2008 +0100
> 
>      ide-cd: fix 'ireason' handling for REQ_TYPE_ATA_PC requests
> 
>      This fixes some hangs caused by not finishing the transfer before ending
>      the request and also makes use of 'ireason == 1' quirk for spurious IRQs.
> 
> When I mount a CD there is a long delay, and I see this error message:
> 
> hdc: ide_cd_check_ireason: wrong transfer direction!
> cdrom: failed setting lba address space
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> <repeated many times>
> 
> When I revert this commit everything works properly again, including
> CD burning.

It turned out that REQ_TYPE_ATA_PC write requests were not marked as such
(the previous commit assumed them to be).

Reported-by: walt <w41ter@gmail.com>
Cc: Borislav Petkov <petkovbb@googlemail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd_ioctl.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: b/drivers/ide/ide-cd_ioctl.c
===================================================================
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -457,6 +457,10 @@ int ide_cdrom_packet(struct cdrom_device
 	   layer. the packet must be complete, as we do not
 	   touch it at all. */
 	ide_cd_init_rq(drive, &req);
+
+	if (cgc->data_direction == CGC_DATA_WRITE)
+		req.cmd_flags |= REQ_RW;
+
 	memcpy(req.cmd, cgc->cmd, CDROM_PACKET_SIZE);
 	if (cgc->sense)
 		memset(cgc->sense, 0, sizeof(struct request_sense));

