From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH v2 00/13] removing the on-stack struct request
Date: Thu,  1 May 2008 21:27:57 +0900
Message-ID: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:42681 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753078AbYEAM3R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 08:29:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jens.axboe@oracle.com, bzolnier@gmail.com, petkovbb@gmail.com

This is an updated version of the patchset to clean up the asymmetry
of blk_get/put_request usage:

http://marc.info/?l=linux-ide&m=120882410712466&w=2

This patchset removes the code calling blk_put_request against the
requests that are not allocated via blk_get_request. They can use
__GFP_WAIT allocation so we can easily convert them to
use blk_get/put_request properly.

This patchset enables us to remove the following hack in
blk_put_request:

/*
 * Gee, IDE calls in w/ NULL q.  Fix IDE and remove the
 * following if (q) test.
 */
if (q) {
	spin_lock_irqsave(q->queue_lock, flags);
	__blk_put_request(q, req);
	spin_unlock_irqrestore(q->queue_lock, flags);
}

The major changes are:

- I remove the ide_wait/head_wait path in ide_do_drive_cmd(). It does
the same thing that blk_execute_rq() does. So let's simply use
blk_execute_rq(). The nice side effect is that I unexport
blk_end_sync_rq() since I converted all the users.

- I drop the unnecessary patch to make ide_do_drive_cmd return
rq->errors:

http://marc.info/?l=linux-ide&m=120882410612456&w=2

#1-10 are for the ide subsystem and #11-13 for the block layer. This
is against the lastest Linus tree.


