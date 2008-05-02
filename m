From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH v2 00/13] removing the on-stack struct request
Date: Sat, 03 May 2008 01:13:58 +0900
Message-ID: <20080503011358E.fujita.tomonori@lab.ntt.co.jp>
References: <1209644890-12040-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<20080502140454.GC22899@gollum.tnic>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tama50.ecl.ntt.co.jp ([129.60.39.147]:45210 "EHLO
	tama50.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759216AbYEBQPy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2008 12:15:54 -0400
In-Reply-To: <20080502140454.GC22899@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: fujita.tomonori@lab.ntt.co.jp, linux-ide@vger.kernel.org, jens.axboe@oracle.com, bzolnier@gmail.com

Hi, thanks for the comments,

On Fri, 2 May 2008 16:04:54 +0200
Borislav Petkov <petkovbb@googlemail.com> wrote:

> Hi,
> 
> On Thu, May 01, 2008 at 09:27:57PM +0900, FUJITA Tomonori wrote:
> > This is an updated version of the patchset to clean up the asymmetry
> > of blk_get/put_request usage:
> > 
> > http://marc.info/?l=linux-ide&m=120882410712466&w=2
> > 
> > This patchset removes the code calling blk_put_request against the
> > requests that are not allocated via blk_get_request. They can use
> > __GFP_WAIT allocation so we can easily convert them to
> > use blk_get/put_request properly.
> > 
> > This patchset enables us to remove the following hack in
> > blk_put_request:
> > 
> > /*
> >  * Gee, IDE calls in w/ NULL q.  Fix IDE and remove the
> >  * following if (q) test.
> >  */
> > if (q) {
> > 	spin_lock_irqsave(q->queue_lock, flags);
> > 	__blk_put_request(q, req);
> > 	spin_unlock_irqrestore(q->queue_lock, flags);
> > }
> > 
> > The major changes are:
> > 
> > - I remove the ide_wait/head_wait path in ide_do_drive_cmd(). It does
> > the same thing that blk_execute_rq() does.
> 
> Are you sure about that? Not that I'm that familiar with the blk layer internals
> but at a glance blk_execute_rq() calls blk_execute_rq_nowait() and in it, the
> rq is added to the elevator and the device queue is being plugged (4th arg
> to __elv_add_request(...,1)) and after the last returns the device is being
> unplugged again: __generic_unplug_device(q). This way no rq's are getting merged
> and it might hurt performance, IMHO.

Yes, no requests are merged, but

1. the ide_wait/head_wait path in ide_do_drive_cmd() doesn't handle any
mergeable requests. All the requests are for kinda management. We like
to execute such as soon as possible.

2. I don't think that ide_do_drive_cmd merges requests. In case of
ELEVATOR_INSERT_FRONT, it calls ide_do_request right after
elv_insert. ide_do_request takes a request from the queue and executes
it? In case of ELEVATOR_INSERT_BACK, elv_insert calls q->request_fn,
that is, ide_do_request is called.
