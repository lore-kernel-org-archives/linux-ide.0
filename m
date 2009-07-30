From: Mark Lord <liml@rtr.ca>
Subject: Re: hdparm-9.17 released, with experimental trim/wiper scripts for
   SSDs
Date: Thu, 30 Jul 2009 08:54:56 -0400
Message-ID: <4A719820.20900@rtr.ca>
References: <4A70DCB8.9000909@rtr.ca> <4A70DDC5.3000607@rtr.ca> <4A7149C6.4030508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:48840 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbZG3My4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Jul 2009 08:54:56 -0400
In-Reply-To: <4A7149C6.4030508@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>

Robert Hancock wrote:
> On 07/29/2009 05:39 PM, Mark Lord wrote:
>> Mark Lord wrote:
>>> hdparm-9.17 is now available from sourceforge.net.
>>>
>>> New in this release:
>>> - added wiper/ subdirectory with preliminary SSD-wiper (TRIM)
>> ..
>>
>> Tejun: on a related note, my Sil-3132 PCIe SATA controller doesn't
>> seem to like DSM/TRIM commands passing through it.
>>
>> [ 3479.010001] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
>> frozen
>> [ 3479.010008] ata4.00: irq_stat 0x00020002, protocol mismatch
>> [ 3479.010019] ata4.00: cmd 06/01:01:00:00:00/00:00:00:00:00/e0 tag 0
>> dma 512 out
>> [ 3479.010021] res dc/33:00:00:00:00/00:00:00:00:dc/00 Emask 0x2 (HSM
>> violation)
>> [ 3479.010025] ata4.00: status: { Busy }
>> [ 3479.010029] ata4.00: error: { IDNF }
>> [ 3479.010041] ata4: hard resetting link
>> [ 3481.193102] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> [ 3481.197043] ata4.00: configured for UDMA/100
>> [ 3481.197082] ata4: EH complete
>>
>> I haven't taken time to dig further yet, but perhaps somebody here
>> might know if they've hardcoded all of the ATA opcodes in silicon or
>> something, and now get confused by DSM/TRIM ?
>>
>> I'll dig further into that later this summer.
> 
> Yeah, according to the datasheet "The SiI3124 will decode the 8-bit ATA
> command at PRB offset 0x0a and automatically execute the default 
> protocol for the command. In certain cases it might be desirable to 
> specify a non-default protocol to be used, such as with vendor specific 
> device commands." The DSM command seems to be DMA data-out and the chip 
> likely doesn't know that command. I have to wonder why they decided to 
> use that design instead of just making the driver indicate the protocol 
> explicitly. In any case, it looks like the driver needs code to override 
> the protocol setting for this command. (Maybe we should just set the 
> protocol override for what we know the command is supposed to be in all 
> cases?)
..

If you can puzzle out how to do that, and post a quick(?) patch,
it would certainly make testing SSDs easier for me here.

I would like to use the Sil3124 ExpressCard controller with my notebook
for this stuff, rather than having to power up one of the noisy
full-size systems under the table.  ;)

On a related note.. anyone else out there have access to a TRIM-capable
SSD yet? If you do, you probably are under NDA, but that shouldn't stop
you from at least trying out the scripts in the hdparm package and
letting me know how things go.. in a very non vendor/model specific fashion. :)

Thanks
