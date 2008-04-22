From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH 00/11] removing the on-stack struct request
Date: Tue, 22 Apr 2008 09:26:31 +0900
Message-ID: <1208824002-3596-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo10.iij4u.or.jp ([210.138.174.78]:49542 "EHLO mo10.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756224AbYDVA2I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Apr 2008 20:28:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: fujita.tomonori@lab.ntt.co.jp, bzolnier@gmail.com, jens.axboe@oracle.com

This patchset converts some of the users of struct request on the
stack to use blk_get_request (as discussed in the large command
support thread [*1]).

IDE has the most users of the on-stack struct request. The on-stack
struct request has the benefit that it'll always work but I think that
using blk_get_request properly make the code clearer.

I've not got rid of all the on-stack struct request yet, but at least
this patchset removes the users of struct request that calls
blk_put_request. That is, we can remove the following hack in
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

This patchset is against Bartlomiej's ide tree. #1-9 patches are for
the IDE subsystem and #10-11 are for the block layer. #10-11 depends
on #1-9 so probably it would be easier to push all the patch via a
single tree.

[*1]
http://marc.info/?l=linux-scsi&m=120817161219068&w=2


