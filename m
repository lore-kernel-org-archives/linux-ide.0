From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/4] libata: add per-dev pio/mwdma/udma_mask
Date: Mon, 13 Mar 2006 05:13:36 -0500
Message-ID: <441545D0.4010100@pobox.com>
References: <11421469551000-git-send-email-htejun@gmail.com> <44152D64.6000903@pobox.com> <20060313093052.GB2091@htj.dyndns.org> <441540DC.2050001@pobox.com> <20060313100927.GE2091@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:10472 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750737AbWCMKQA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 05:16:00 -0500
In-Reply-To: <20060313100927.GE2091@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> On Mon, Mar 13, 2006 at 04:52:28AM -0500, Jeff Garzik wrote:
> 
>>Tejun Heo wrote:
>>
>>>On Mon, Mar 13, 2006 at 03:29:24AM -0500, Jeff Garzik wrote:
>>>
>>>
>>>>Tejun Heo wrote:
>>>>
>>>>
>>>>>Add per-dev pio/mwdma/udma_mask.  All transfer mode limits used to be
>>>>>applied to ap->*_mask which unnecessarily restricted other devices
>>>>>sharing the port.  This change will also benefit later EH speed down
>>>>>and hotplug.
>>>>>
>>>>>Signed-off-by: Tejun Heo <htejun@gmail.com>
>>>>
>>>>I don't see much value in the separation.  Rather than 3 separate masks, 
>>>>it seems like this patch would be simplified if you simply added 
>>>>dev->xfer_mask.
>>>>
>>>
>>>
>>>The thing is that ap->*_mask's are separated the same way and all
>>>masking constants are defined as such.  e.g.
>>>
>>>	ap->udma_mask &= ATA_UDMA5;
>>>or
>>>	ap->udma_mask &= ATA_UDMA_MASK_40C;
>>>
>>>Making dev->*_mask's the same enables share those constants and code
>>>convention.  So, things to consider here are...
>>>
>>>1. Port xfer masks are defined as three separate masks.
>>>
>>>2. All the constants are defined according to that.
>>>
>>>3. Three separate masks are easier to deal with for LLDD's.
>>
>>Separate masks is better for the LLDD interface, but the packed version 
>>seems superior for internal libata use.
> 
> 
> Yeah, dev->*_mask's will be used by LLDD's.  Actually, in patch #4 of
> this series, sata_sil's ->dev_config() does exactly that.  Also, mode
> mask filtering can be done by diddling dev->*_mask's.
> 
> 
>>No reason why ATA_UDMA_MASK_40C can't simply operate on a packed 
>>xfer_mask variable, for example.
> 
> 
> Because it's used to filter ap->*_mask and to allow LLDD's use the
> same constants on dev->*_mask's.
> 
> Do you think LLDD's shouldn't access dev->*_mask's?

When I spoke of "LLDD API", I largely meant the pio_mask/etc. in 
ata_port_info.  That's the easiest way to present such information to 
driver maintainers.

OTOH, at runtime ->dev_config() and friends should probably just 
manipulate dev->xfer_mask.

	Jeff


