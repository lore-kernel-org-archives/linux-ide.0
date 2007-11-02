From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/9] ide-disk: fix __ide_do_rw_disk() to use ->OUTBSYNC
Date: Fri, 2 Nov 2007 22:59:13 +0100
Message-ID: <200711022259.13661.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:60738 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbXKBWIT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 18:08:19 -0400
Received: by nf-out-0910.google.com with SMTP id g13so940323nfb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 15:08:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Fix __ide_do_rw_disk() to use ->OUTBSYNC instead of ->OUTB
(needed for pmac and scc_pata host drivers).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -273,8 +273,7 @@ static ide_startstop_t __ide_do_rw_disk(
 			command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
 		}
 
-		/* FIXME: ->OUTBSYNC ? */
-		hwif->OUTB(command, IDE_COMMAND_REG);
+		hwif->OUTBSYNC(drive, command, IDE_COMMAND_REG);
 
 		return pre_task_out_intr(drive, rq);
 	}
