From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 4/4] libata sata_qstor conversion to new error handling
 (EH).
Date: Wed, 07 Nov 2007 18:58:24 -0500
Message-ID: <47325120.8020500@rtr.ca>
References: <4731DF06.3050202@rtr.ca> <4731DFA7.8010202@rtr.ca> <20071107232721.GB26706@havoc.gtf.org> <47324B0D.9060706@rtr.ca> <47324BED.9010302@rtr.ca> <20071107234514.GC26706@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3505 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbXKGX6Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Nov 2007 18:58:25 -0500
In-Reply-To: <20071107234514.GC26706@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> On Wed, Nov 07, 2007 at 06:36:13PM -0500, Mark Lord wrote:
>> Mark Lord wrote:
>> ..
>>> and SG_IO WRITEs don't work.  That's really no different from
>>> the existing 2.6.24 version.  Regular I/O looks fine.
>> ...
>>
>> I should qualify that:  SG_IO *PIO* WRITEs don't work.
>> SG_IO PIO READs do work, and SG_IO DMA R/W both work.
> 
> multi-sector or single-sector PIO?
..

I was issuing single-sector PIO writes for one sector.
Something gets confused somewhere by that.

It really didn't seem worth tracking down further,
as regular kernel initiated I/O is fine (DMA though),
and this chip doesn't have much of a user/testing base.

I suppose it has to do with the initial DRQ interrupt
from a PIO WRITE --> the chip designers actually never
tested anything other than READ and IDENTIFY in register
PIO mode, so it could even be a chip issue.

The full-fledged qstor driver uses the chip's packet mode
for *everything*, including "PIO" R/W, so this is actually
the first time that direct PIO has even been attempted.
No surprise that it might fail.

If the chip were more commonly available/used, then I would
probably update sata_qstor to use packet mode for PIO as well.
But that's more effort than it's worth, really.

Cheers
