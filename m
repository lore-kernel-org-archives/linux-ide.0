From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 15:01:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701291453230.3611@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
 <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net>
 <1170051963.6454.7.camel@Homer.simpson.net>
 <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org>
 <45BE5AF0.3030005@cs.wisc.edu> <Pine.LNX.4.64.0701291250420.3611@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701291414410.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:32874 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964854AbXA2XLR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 18:11:17 -0500
In-Reply-To: <Pine.LNX.4.64.0701291414410.3611@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Mike Galbraith <efault@gmx.de>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Boaz Harrosh <bharrosh@panasas.com>



On Mon, 29 Jan 2007, Linus Torvalds wrote:
> 
> Two more reboots and I should know exactly which one broke "nero".

This one.

However, the scary thing is that I think the patch really is correct, and 
I wonder if nero has some strange work-around for an older bug.. Although 
I don't see how you could even have that, since afaik, the behaviour 
before the fix was literally just a leak that a user process shouldn't be 
able to see.

Very strange. Will add some debugging printk's.

		Linus

----
commit 77d172ce2719b5ad2dc0637452c8871d9cba344c
Author: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date:   Mon Dec 11 10:01:34 2006 +0100

    [PATCH] fix SG_IO bio leak
    
    This patch fixes bio leaks in SG_IO. rq->bio can be changed after io
    completion, so we need to reset rq->bio before calling blk_rq_unmap_user()
    
    http://marc.theaimsgroup.com/?l=linux-kernel&m=116570666807983&w=2
    
    Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
    Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
---
 block/scsi_ioctl.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index b3e2107..045cabd 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -228,6 +228,7 @@ static int sg_io(struct file *file, request_queue_t *q,
 	struct request *rq;
 	char sense[SCSI_SENSE_BUFFERSIZE];
 	unsigned char cmd[BLK_MAX_CDB];
+	struct bio *bio;
 
 	if (hdr->interface_id != 'S')
 		return -EINVAL;
@@ -308,6 +309,7 @@ static int sg_io(struct file *file, request_queue_t *q,
 	if (ret)
 		goto out;
 
+	bio = rq->bio;
 	rq->retries = 0;
 
 	start_time = jiffies;
@@ -338,6 +340,7 @@ static int sg_io(struct file *file, request_queue_t *q,
 			hdr->sb_len_wr = len;
 	}
 
+	rq->bio = bio;
 	if (blk_rq_unmap_user(rq))
 		ret = -EFAULT;
 
