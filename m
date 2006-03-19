From: Mark Lord <liml@rtr.ca>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Sun, 19 Mar 2006 16:54:08 -0500
Message-ID: <441DD300.9050702@rtr.ca>
References: <441DC397.9040504@rtr.ca> <441DC9CB.7030203@pobox.com> <441DCAC9.5090603@rtr.ca> <441DCF73.2080600@pobox.com> <441DD101.5050202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:36529 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750834AbWCSVyT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Mar 2006 16:54:19 -0500
In-Reply-To: <441DD101.5050202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
>
>> The idiot IOMMU layer may merge too aggressively, which is the reason 
>> for this code and similar code in ata_fill_sg().  The IOMMU stuff 
>> always happens at pci_map_sg() time, after the block layer gets out of 
>> the way.
> 
> Ahh.. then how does the low-level driver know what to use for 
> ".sg_tablesize"?
> 
> It cannot use the real hardware/driver value, because it may need to do
> request splitting.  I wonder what the worst case number of splits required
> is, for each sg[] entry?

Mmmm.  I suppose the answer is that the block layer guarantees
no more than .sg_tablesize entries, and the IOMMU layer may reduce
the segment count, but never increase it.

So the low-level driver should be able to safely use it's own internal
hardware/driver limit when registering .sg_tablesize.

Mmm..  sata_mv.c currently divides by two.
