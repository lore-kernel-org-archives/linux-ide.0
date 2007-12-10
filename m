From: Mark Lord <liml@rtr.ca>
Subject: Re: Bug: get EXT3-fs error Allocating block in system zone
Date: Mon, 10 Dec 2007 11:38:16 -0500
Message-ID: <475D6B78.8000200@rtr.ca>
References: <fa.Fg53DJSEh/kZhf/uRCv9FYZsaSQ@ifi.uio.no> <fa.nPzIjJ2SchPb1LOa/dRWb/WyEZU@ifi.uio.no> <fa.LkmHGN+Fx6H930bfeCDU6pGdBKM@ifi.uio.no> <fa.oSqMiIX7WubypXrhZGaRKU5wNGU@ifi.uio.no> <fa.0pc9/nNmTq+eWIU9rADRn0xYGdI@ifi.uio.no> <fa.hqM73i24f6G31R5F3sKL8+3H8Ww@ifi.uio.no> <475C2C02.70001@shaw.ca> <alpine.LFD.0.9999.0712091057200.12046@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3155 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348AbXLJQiS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Dec 2007 11:38:18 -0500
In-Reply-To: <alpine.LFD.0.9999.0712091057200.12046@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Marco Gatti <marco@pianoinflames.de>, Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Greg KH <greg@kroah.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jgarzik@pobox.com>

Linus Torvalds wrote:
> 
> On Sun, 9 Dec 2007, Robert Hancock wrote:
>> The obvious suspect with a filesystem problem would be the disk 
>> controller driver, AHCI here. However, the controller appears to set the 
>> flag to indicate that it supports 64-bit DMA, so it should be fine, 
>> unless it lies of course (which we know that ATI SB600 chipset does, but 
>> I don't believe Intel is known to).
>>
>> Could still be a DMA mapping bug that only shows up when IOMMU is used. 
>> However, AHCI is a pretty well tested driver..
> 
> AHCI is a pretty well tested driver, but 99%+ of all testers still tend to 
> have less than 4GB of memory. So I do *not* believe that the highmem bits 
> are all that well tested at all. 
> 
> Can somebody who knows the driver send Marco a test-patch to just limit 
> DMA to the low 32 bits, and then Marco can at least verify that yes, that 
> that it. While it looks like DMA problems, there could obviously be some 
> other subtle issue with big-memory machines (ie the PCI allocations etc 
> tend to change too!)
..

We have another outstanding bug report of a Marvell chipset being
used in a funky 32-bit PPC situation with memory above the 4GB mark.

Possibly related, possibly not.

The Marvell SATA driver is still VERY EXPERIMENTAL right now,
missing some errata and stuff.  This should improve over the next few months.

Cheers
