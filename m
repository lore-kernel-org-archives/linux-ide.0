From: Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 19:04:36 -0600
Message-ID: <45BE99A4.9080503@cs.wisc.edu>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>  <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net> <1170051963.6454.7.camel@Homer.simpson.net> <Pine.LNX.4.64.0701282247070.3611@woody.linux-foundation.org> <45BE5AF0.3030005@cs.wisc.edu> <Pine.LNX.4.64.0701291250420.3611@woody.linux-foundation.org> <Pine.LNX.4.64.0701291414410.3611@woody.linux-foundation.org> <Pine.LNX.4.64.0701291453230.3611@woody.linux-foundation.org> <Pine.LNX.4.64.0701291532050.3611@woody.linux-foundation.org> <45BE864A.2050907@cs.wisc.edu> <Pine.LNX.4.64.0701291614020.3611@woody.linux-foundation.org> <45BE9774.20105@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sabe.cs.wisc.edu ([128.105.6.20]:45073 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604AbXA3BPB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 20:15:01 -0500
In-Reply-To: <45BE9774.20105@cs.wisc.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mike Galbraith <efault@gmx.de>, Uwe Bugla <uwe.bugla@gmx.de>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <jens.axboe@oracle.com>, James Bottomley <James.Bottomley@SteelEye.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Boaz Harrosh <bharrosh@panasas.com>

Mike Christie wrote:
> Linus Torvalds wrote:
>> On Mon, 29 Jan 2007, Mike Christie wrote:
>>> rq->bio is NULL here, so no data is coped back to userspace and it seems
>>> nero just stops trying to talk to the drive after this.
>> Well, except that's what we used to do in 2.6.19 too. So what changed?
> 

Actually, I do not think we did this in 2.6.19. Tomo added a bug when he
ported a patch and mixed up some things so we did something weird for
2.6.20-rc1.

> Oops, you are right. I thought you reverted the place where rq->bio was
> getting set to bio. Ignore my comment.
> 

I think I am right now :)

In 2.6.19, we did:

bio = rq->bio;
blk_execute_rq() <- the execution sets rq->bio to null so that is why we
save a bio pointer.
blk_rq_unmap_user(bio);


For a while in 2.6.20-rc1, we basically did

blk_execute_rq()
blk_rq_unmap_user(rq->bio) <- this was a bug that caused the mem leak
and caused data to not be copied because rq->bio was null.

Tomo and Jens then fixes this in 2.6.20-rc2 or rc3 to what we have in rc6:

bio = rq->bio;
blk_execute_rq() <- the execution sets rq->bio to null so that is why we
save a bio pointer.
blk_rq_unmap_user(bio);

