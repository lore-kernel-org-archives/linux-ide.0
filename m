From: Alan Cox <alan@redhat.com>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Tue, 26 Feb 2008 18:07:01 -0500
Message-ID: <20080226230701.GC17241@devserv.devel.redhat.com>
References: <1203987277.15052.68.camel@pasglop> <47C36D64.6010001@rtr.ca> <47C36EC3.4080708@rtr.ca> <1203994454.15052.83.camel@pasglop> <47C397C4.2090309@rtr.ca> <1204003805.15052.112.camel@pasglop> <47C3A71B.2070705@rtr.ca> <1204004844.15052.123.camel@pasglop> <47C43D7F.3010005@rtr.ca> <1204062233.15052.157.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37933 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762820AbYBZXIm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Feb 2008 18:08:42 -0500
Content-Disposition: inline
In-Reply-To: <1204062233.15052.157.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

On Wed, Feb 27, 2008 at 08:43:53AM +1100, Benjamin Herrenschmidt wrote:
> As I said before, it should not be fixed.
> If it's "fixed", we'll run out of iommu space all the time.
> We should stop having stupid requirements instead.

Hints would be extremely good. Teaching the I/O layers to do

	if (blk_queue_align_64k(queue) == -EGOSTICKYOURHEADINABUCKET)
		size /= 2;

is not very hard - or even an arch helper for

	n = blk_queue_worst_case(65536, 256);

Alan

