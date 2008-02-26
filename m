From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Wed, 27 Feb 2008 08:43:14 +1100
Message-ID: <1204062194.15052.155.camel@pasglop>
References: <47C3572D.1060904@rtr.ca>  <47C35A3B.8080604@pobox.com>
	 <1203987277.15052.68.camel@pasglop> <47C36D64.6010001@rtr.ca>
	 <47C36EC3.4080708@rtr.ca> <1203994454.15052.83.camel@pasglop>
	 <47C397C4.2090309@rtr.ca> <1204003805.15052.112.camel@pasglop>
	 <47C3A71B.2070705@rtr.ca>  <1204004844.15052.123.camel@pasglop>
	 <1204042187.3254.70.camel@localhost.localdomain>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50899 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761208AbYBZWEG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Feb 2008 17:04:06 -0500
In-Reply-To: <1204042187.3254.70.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>


On Tue, 2008-02-26 at 08:09 -0800, James Bottomley wrote:
> > The iommu code makes no guarantee vs. preserving the alignment of a
> > segment, at least not below PAGE_SIZE.
> 
> It's supposed to, precisely to forestall this case.  The alignment
> guarantees of the parisc iommu code are sg length aligned up to a fixed
> maximum (128k on 32 bit and 256k on 64 bit because of the way the
> allocator works).   However, tomo's code is fixing this, so it shouldn't
> be a problem much longer.

It will be. If we start enforcing that alignment, pSeries machines will
continuously run out of iommu space when the BIO starts handing out
large chunks.

Not acceptable for us. I suspect x86_64 will have a similar problem as,
afaik, the IOMMU space is very scarce there.

Can you guys stop designing the whole IO layer around PA-RISC ?

Ben.


