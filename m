From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Wed, 27 Feb 2008 10:19:36 +1100
Message-ID: <1204067976.15052.185.camel@pasglop>
References: <1203987277.15052.68.camel@pasglop> <47C36D64.6010001@rtr.ca>
	 <47C36EC3.4080708@rtr.ca> <1203994454.15052.83.camel@pasglop>
	 <47C397C4.2090309@rtr.ca> <1204003805.15052.112.camel@pasglop>
	 <47C3A71B.2070705@rtr.ca> <1204004844.15052.123.camel@pasglop>
	 <47C43D7F.3010005@rtr.ca> <1204062233.15052.157.camel@pasglop>
	 <20080226230701.GC17241@devserv.devel.redhat.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54539 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757522AbYBZXU4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Feb 2008 18:20:56 -0500
In-Reply-To: <20080226230701.GC17241@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>


On Tue, 2008-02-26 at 18:07 -0500, Alan Cox wrote:
> On Wed, Feb 27, 2008 at 08:43:53AM +1100, Benjamin Herrenschmidt wrote:
> > As I said before, it should not be fixed.
> > If it's "fixed", we'll run out of iommu space all the time.
> > We should stop having stupid requirements instead.
> 
> Hints would be extremely good. Teaching the I/O layers to do
> 
> 	if (blk_queue_align_64k(queue) == -EGOSTICKYOURHEADINABUCKET)
> 		size /= 2;
> 
> is not very hard - or even an arch helper for
> 
> 	n = blk_queue_worst_case(65536, 256);

Looks like the new iommu stuff will deal with it fine by passing an
optional boundary not-to-cross requirement down. Normal devices don't
set that and the iommu can still pack. IDE can pass 64K and the iommu
will align things that may cross that boundary.

That should work out fine.

BTW. If we -still- run out of iommu space, do we have sane mechanisms
nowadays to break things up and retry ?

Ben.


