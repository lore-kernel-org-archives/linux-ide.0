From: Mark Lord <liml@rtr.ca>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Tue, 21 Mar 2006 14:33:57 -0500
Message-ID: <44205525.20306@rtr.ca>
References: <441DC397.9040504@rtr.ca> <441DC9CB.7030203@pobox.com> <441DCAC9.5090603@rtr.ca> <441DCF73.2080600@pobox.com> <441DD101.5050202@rtr.ca> <441DD300.9050702@rtr.ca> <441F544A.6080301@pobox.com> <441F8478.50806@rtr.ca> <441F99AC.4000200@pobox.com> <442006BC.8020100@rtr.ca> <20060321184215.GJ4285@suse.de> <442051A0.1050200@rtr.ca> <4420541E.3070303@pobox.com> <44205484.9000702@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:24228 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964840AbWCUTeA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 14:34:00 -0500
In-Reply-To: <44205484.9000702@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, IDE/ATA development list <linux-ide@vger.kernel.org>, James Bottomley <James.Bottomley@steeleye.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Mark Lord wrote:
> Jeff Garzik wrote:
>>
>>> In the case of sata_mv on the Marvell 6081 (which I'm looking at this 
>>> week)
>>> it's hardware limit is actually 0xffffffff rather than 0xffff.
>>
>> If the limit is not 0xffff, then there's no need for any of this 
>> limitation junk.  No s/g entry splitting after pci_map_sg(), no 
>> artificial sg_tablesize limitation, etc.
> 
> Not even for a merged IOMMU segment that crosses the 4GB "boundary" ?

Clarification:  this is a 64-bit PCI(e/X) device, and the above query
applies mainly to it's use in a 64-bit slot on a 64-bit kernel.

It's not clear to me whether this can be an issue on a 32-bit kernel
on 36-bit hardware, though.

Cheers
