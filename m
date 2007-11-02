From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/9] ide-disk: guarantee 400ns delay after writing command register
Date: Fri, 2 Nov 2007 22:59:44 +0100
Message-ID: <200711022259.44214.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:61145 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927AbXKBWIS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 18:08:18 -0400
Received: by nf-out-0910.google.com with SMTP id g13so940287nfb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 15:08:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -274,6 +274,7 @@ static ide_startstop_t __ide_do_rw_disk(
 		}
 
 		hwif->OUTBSYNC(drive, command, IDE_COMMAND_REG);
+		ndelay(400);	/* FIXME */
 
 		return pre_task_out_intr(drive, rq);
 	}
