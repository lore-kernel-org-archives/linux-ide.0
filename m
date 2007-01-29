From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 15:32:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701291532050.3611@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
 <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net>
 <1170051963.6454.7.camel@Homer.simpson.net>
 <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
 <45BE5AF0.3030005@cs.wisc.edu> <Pine.LNX.4.64.0701291250420.3611@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701291414410.3611@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701291453230.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:33985 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964930AbXA2XnO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 18:43:14 -0500
In-Reply-To: <Pine.LNX.4.64.0701291453230.3611@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Mike Galbraith <efault@gmx.de>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Boaz Harrosh <bharrosh@panasas.com>


Uwe, others, does this patch fix your problem?

It will have a few printk's that it spews out, but if it fixes your 
problem, at least we know a bit more.

		Linus
---
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 2528a0c..f0ff151 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -333,8 +333,13 @@ static int sg_io(struct file *file, request_queue_t *q,
 			hdr->sb_len_wr = len;
 	}
 
-	if (blk_rq_unmap_user(bio))
+	if (rq->bio != bio)
+		printk("rq->bio = %p, bio = %p\n", rq->bio, bio);
+
+	if (blk_rq_unmap_user(rq->bio)) {
+		printk("blk_rq_unmap_user failed!\n");
 		ret = -EFAULT;
+	}
 
 	/* may not have succeeded, but output values written to control
 	 * structure (struct sg_io_hdr).  */
