From: Mark Lord <liml@rtr.ca>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Tue, 21 Mar 2006 14:36:58 -0500
Message-ID: <442055DA.3090500@rtr.ca>
References: <441DCAC9.5090603@rtr.ca> <441DCF73.2080600@pobox.com> <441DD101.5050202@rtr.ca> <441DD300.9050702@rtr.ca> <441F544A.6080301@pobox.com> <441F8478.50806@rtr.ca> <441F99AC.4000200@pobox.com> <442006BC.8020100@rtr.ca> <20060321184215.GJ4285@suse.de> <442051A0.1050200@rtr.ca> <20060321193143.GN4285@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:25252 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964852AbWCUThB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 14:37:01 -0500
In-Reply-To: <20060321193143.GN4285@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jens Axboe wrote:
> On Tue, Mar 21 2006, Mark Lord wrote:
>> Jens Axboe wrote:
..
>>> It would be much nicer if the iommu actually had some more knowledge,
>>> ideally the same requirements that the block layer is faced with. No
>>> driver should have to check the mapped sg list.
>> Yup.  Absolutely.  So long as they continue to never *add* new sg entries
>> (only doing merges instead), then I believe they just need to know the
>> device's .dma_boundary parameter.  We could pass this to them as an extra
>> parameters, or perhaps embed it into the sg_list data structure somehow.
> 
> You want max size as well, so boundary and max size should be enough.

Oh, now there's a thought.  How do we specify "max segment size" today?
I'll need to make sure that sata_mv still does that (64KB), even though
it doesn't care about crossing 64KB boundaries.

Thanks
