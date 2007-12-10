From: Marco Gatti <marco@pianoinflames.de>
Subject: Re: Bug: get EXT3-fs error Allocating block in system zone
Date: Mon, 10 Dec 2007 18:47:11 +0100
Message-ID: <475D7B9F.2090407@pianoinflames.de>
References: <fa.Fg53DJSEh/kZhf/uRCv9FYZsaSQ@ifi.uio.no> <fa.nPzIjJ2SchPb1LOa/dRWb/WyEZU@ifi.uio.no> <fa.LkmHGN+Fx6H930bfeCDU6pGdBKM@ifi.uio.no> <fa.oSqMiIX7WubypXrhZGaRKU5wNGU@ifi.uio.no> <fa.0pc9/nNmTq+eWIU9rADRn0xYGdI@ifi.uio.no> <fa.hqM73i24f6G31R5F3sKL8+3H8Ww@ifi.uio.no> <475C2C02.70001@shaw.ca> <alpine.LFD.0.9999.0712091057200.12046@woody.linux-foundation.org> <475D6B78.8000200@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from echo836.server4you.de ([85.25.140.112]:52322 "EHLO
	mail.pianoinflames.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbXLJRrY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 12:47:24 -0500
In-Reply-To: <475D6B78.8000200@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Robert Hancock <hancockr@shaw.ca>, Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Greg KH <greg@kroah.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jgarzik@pobox.com>

Mark Lord schrieb:
>>
>> AHCI is a pretty well tested driver, but 99%+ of all testers still 
>> tend to have less than 4GB of memory. So I do *not* believe that the 
>> highmem bits are all that well tested at all.
>> Can somebody who knows the driver send Marco a test-patch to just 
>> limit DMA to the low 32 bits, and then Marco can at least verify that 
>> yes, that that it. While it looks like DMA problems, there could 
>> obviously be some other subtle issue with big-memory machines (ie the 
>> PCI allocations etc tend to change too!)
> ..
> 
> We have another outstanding bug report of a Marvell chipset being
> used in a funky 32-bit PPC situation with memory above the 4GB mark.
> 
> Possibly related, possibly not.
> 
> The Marvell SATA driver is still VERY EXPERIMENTAL right now,
> missing some errata and stuff.  This should improve over the next few 
> months.
> 

Hello,

I don't have a Marvell chipset. I didn't compiled in this. I have a 
"Intel Corporation PT IDER Controller" and an intel matrix storage 
controller. So I think it doesn't concern my case...

Greets
