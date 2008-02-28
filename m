From: FUJITA Tomonori <tomof@acm.org>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Thu, 28 Feb 2008 16:36:10 +0900
Message-ID: <20080227233540B.tomof@acm.org>
References: <1204062233.15052.157.camel@pasglop>
	<20080226230701.GC17241@devserv.devel.redhat.com>
	<1204067976.15052.185.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo11.iij4u.or.jp ([210.138.174.79]:53638 "EHLO mo11.iij4u.or.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbYB1HiG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Feb 2008 02:38:06 -0500
In-Reply-To: <1204067976.15052.185.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: alan@redhat.com, liml@rtr.ca, jgarzik@pobox.com, htejun@gmail.com, James.Bottomley@HansenPartnership.com, linux-ide@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp

On Wed, 27 Feb 2008 10:19:36 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Tue, 2008-02-26 at 18:07 -0500, Alan Cox wrote:
> > On Wed, Feb 27, 2008 at 08:43:53AM +1100, Benjamin Herrenschmidt wrote:
> > > As I said before, it should not be fixed.
> > > If it's "fixed", we'll run out of iommu space all the time.
> > > We should stop having stupid requirements instead.
> > 
> > Hints would be extremely good. Teaching the I/O layers to do
> > 
> > 	if (blk_queue_align_64k(queue) == -EGOSTICKYOURHEADINABUCKET)
> > 		size /= 2;
> > 
> > is not very hard - or even an arch helper for
> > 
> > 	n = blk_queue_worst_case(65536, 256);
> 
> Looks like the new iommu stuff will deal with it fine by passing an
> optional boundary not-to-cross requirement down. Normal devices don't
> set that and the iommu can still pack. IDE can pass 64K and the iommu
> will align things that may cross that boundary.
> 
> That should work out fine.

Yeah, nothing changes for drivers that don't set the boundary limit.

Even for drivers setting the boundary limit, the IOMMUs just allocate
a memory area that doesn't cross the boundary. It is NOT the
size-alignment allocation that POWER IOMMU's dma_alloc_coherent does
(as discussed in this thread). So the IOMMU space doesn't run out
quickly.


I have not fixed some IOMMUs yet (as I explained at LSF). If I finish
the job, libata can remove the workaround for splitting sg lists.


> BTW. If we -still- run out of iommu space, do we have sane mechanisms
> nowadays to break things up and retry ?

About SCSI, some drivers do the right thing (retrying), some assume
that IOMMU mapping failure never happens, some just crash. I'll take
care about it after fixing the IOMMUs.
