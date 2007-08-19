From: Mark Lord <liml@rtr.ca>
Subject: Re: CompactFlash and HD unhappy together on the same IDE channel
Date: Sun, 19 Aug 2007 10:18:40 -0400
Message-ID: <46C85140.9050906@rtr.ca>
References: <46C69913.1060505@g7.org> <46C799E8.8080407@rtr.ca> <46C81EC4.9080407@ouabain.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2699 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278AbXHSOTJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Aug 2007 10:19:09 -0400
In-Reply-To: <46C81EC4.9080407@ouabain.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Malcolm Gillies <linux-ide@ouabain.org>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Malcolm Gillies wrote:
> Mark Lord wrote:
>> Malcolm Gillies wrote:
>>> By swapping around components, I've established that the problem is 
>>> unlikely due to the cable (which is 50cm long 80-wire), hard disk or 
>>> controller. When I swap to another, slower CF card (one that only 
>>> supports PIO rather than MWDMA), the error goes away and the hard 
>>> disk operates happily at UDMA/33.
>> ..
>>> ata1.00: CFA: SanDisk SDCFH-1024, HDX 4.07, max MWDMA2
>>> ata1.00: 2001888 sectors, multi 0: LBA
>>> ata1.01: ATA-7: SAMSUNG HD400LD, WQ100-14, max UDMA/100
>>> ata1.01: 781422768 sectors, multi 0: LBA48
>>> ata1.01: limited to UDMA/33 due to 40-wire cable
>>> ata1.00: configured for MWDMA2
>>> ata1.01: configured for UDMA/33
>> ..
>> The fastest DMA speed reported for the CF is MWDMA2, which is 
>> considerably
>> slower than UDMA/33.  When two devices share a cable, normally both 
>> must be
>> limited to the speed of the slower device, which is MWDMA2 in this case.
>>
>> Both devices report being capable of 120ns cycle times for DMA,
>> but UDMA double-clocks those cycles, something that is incompatible
>> with non-UDMA devices.
>>
>> I don't think we can safely assume that UDMA can co-operate with non-UDMA
>> on the same cable.  In this case, it might be causing the CF device to 
>> falsely detect control cycles.
> 
> The mystery for me is that
> 
> 1) there are no errors reported for the CF device, only for the UDMA HD

That fits perfectly with the supposition I made above.

When the host adaptor is speaking "UDMA" to the HD, the CF device may
falsely begin to respond on occasion, corrupting the HD data transfer.

When the host adaptor is speaking "MDMA2" to the CF, the HD device has
no trouble at all with the timing, and remains silent (as it should).    

> 2) the HD runs error-free at UDMA/33 when I use a different, PIO-only CF 
> card but otherwise the same cabling, adaptor etc.

It would be useful to see the boot log for this scenario.
In particular, I'm curious what timings get chosen for the two devices.
But since that CF card cannot do DMA, it should not respond at all to
any HD DMA cycles, even if the timing is too fast for it's decoders to
work properly.

-ml
