From: Mark Lord <liml@rtr.ca>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Tue, 21 Mar 2006 15:51:10 -0500
Message-ID: <4420673E.3090003@rtr.ca>
References: <441DCAC9.5090603@rtr.ca> <441DCF73.2080600@pobox.com> <441DD101.5050202@rtr.ca> <441DD300.9050702@rtr.ca> <441F544A.6080301@pobox.com> <441F8478.50806@rtr.ca> <441F99AC.4000200@pobox.com> <442006BC.8020100@rtr.ca> <20060321184215.GJ4285@suse.de> <442051A0.1050200@rtr.ca> <20060321193143.GN4285@suse.de> <442055DA.3090500@rtr.ca> <4420576F.80304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:50325 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965099AbWCUUvP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 15:51:15 -0500
In-Reply-To: <4420576F.80304@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Oh, now there's a thought.  How do we specify "max segment size" today?
>> I'll need to make sure that sata_mv still does that (64KB), even though
>> it doesn't care about crossing 64KB boundaries.
> 
> Agreed.  50xx is the same:  64k segment size limit, dma boundary is 
> really 0xffffffff.  Good catch, I had made the mistaken assumption that 
> there was the standard IDE 64k boundary as well.

Okay, good.  I can do this with a scsi slave config function,
or we could (longer term) add it to libata somewhere.

Short term, I've already added a mv_slave_config() SCSI function here.

Cheers
