From: Mark Lord <liml@rtr.ca>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Tue, 21 Mar 2006 14:18:56 -0500
Message-ID: <442051A0.1050200@rtr.ca>
References: <441DC397.9040504@rtr.ca> <441DC9CB.7030203@pobox.com> <441DCAC9.5090603@rtr.ca> <441DCF73.2080600@pobox.com> <441DD101.5050202@rtr.ca> <441DD300.9050702@rtr.ca> <441F544A.6080301@pobox.com> <441F8478.50806@rtr.ca> <441F99AC.4000200@pobox.com> <442006BC.8020100@rtr.ca> <20060321184215.GJ4285@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:33679 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965078AbWCUTTA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 14:19:00 -0500
In-Reply-To: <20060321184215.GJ4285@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jens Axboe wrote:
..
> Seems to me that your reasoning is correct. It's a fact that the
> original block mapped sg lists satisfies all requirements of the device
> driver and/or hardware, otherwise would be a bug. The iommu may go nuts
> of course, but logically that new sg list should be choppable into the
> same requirements.

I just finished going through all of the arch implementations and,
as near as I can tell, they only ever *merge* sg list items,
and never create additional sg entries.

So low-level drivers (at present) can safely report their real limits,
and then in their fill_sg() routines they can run around and split up
any IOMMU merges that their hardware cannot tolerate.

> It would be much nicer if the iommu actually had some more knowledge,
> ideally the same requirements that the block layer is faced with. No
> driver should have to check the mapped sg list.

Yup.  Absolutely.  So long as they continue to never *add* new sg entries
(only doing merges instead), then I believe they just need to know the
device's .dma_boundary parameter.  We could pass this to them as an extra
parameters, or perhaps embed it into the sg_list data structure somehow.

In the case of sata_mv on the Marvell 6081 (which I'm looking at this week)
it's hardware limit is actually 0xffffffff rather than 0xffff.

I wonder how well Linux drivers in general deal with that on a 64-bit machine?

Cheers

