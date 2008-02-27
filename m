From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 5/5] ide-cd: fix remaining checkpatch.pl issues
Date: Wed, 27 Feb 2008 22:18:53 +0100
Message-ID: <200802272218.53175.bzolnier@gmail.com>
References: <1204136449-9490-1-git-send-email-petkovbb@gmail.com> <1204136449-9490-6-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:34222 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634AbYB0VHW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2008 16:07:22 -0500
Received: by ug-out-1314.google.com with SMTP id z38so539764ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2008 13:07:18 -0800 (PST)
In-Reply-To: <1204136449-9490-6-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Wednesday 27 February 2008, Borislav Petkov wrote:
> Some of them are:
> WARNING: braces {} are not necessary for single statement blocks
> CHECK: multiple assignments should be avoided
> WARNING: printk() should include KERN_ facility level
> WARNING: no space between function name and open parenthesis '('
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

interdiff for the merged version

diff -u b/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- b/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -185,8 +185,7 @@
 			if (valid < 0)
 				valid = 0;
 			if (sector < get_capacity(info->disk) &&
-				drive->probed_capacity - sector < 4 * 75)
-
+			    drive->probed_capacity - sector < 4 * 75)
 				set_capacity(info->disk, sector);
 		}
 	}
@@ -218,7 +217,7 @@
 
 	rq->data = sense;
 	rq->cmd[0] = GPCMD_REQUEST_SENSE;
-	rq->cmd[4]   = 18;
+	rq->cmd[4] = 18;
 	rq->data_len = 18;
 
 	rq->cmd_type = REQ_TYPE_SENSE;
@@ -310,8 +309,8 @@
 	sense_key = err >> 4;
 
 	if (rq == NULL) {
-		printk(KERN_ERR "%s: missing rq in cdrom_decode_status\n",
-			drive->name);
+		printk(KERN_ERR "%s: missing rq in %s\n",
+				drive->name, __func__);
 		return 1;
 	}
 
