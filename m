From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bug: get EXT3-fs error Allocating block in system zone
Date: Sun, 9 Dec 2007 10:59:50 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712091057200.12046@woody.linux-foundation.org>
References: <fa.Fg53DJSEh/kZhf/uRCv9FYZsaSQ@ifi.uio.no> <fa.nPzIjJ2SchPb1LOa/dRWb/WyEZU@ifi.uio.no> <fa.LkmHGN+Fx6H930bfeCDU6pGdBKM@ifi.uio.no> <fa.oSqMiIX7WubypXrhZGaRKU5wNGU@ifi.uio.no> <fa.0pc9/nNmTq+eWIU9rADRn0xYGdI@ifi.uio.no> <fa.hqM73i24f6G31R5F3sKL8+3H8Ww@ifi.uio.no>
 <475C2C02.70001@shaw.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44317 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750861AbXLITBQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 14:01:16 -0500
In-Reply-To: <475C2C02.70001@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Marco Gatti <marco@pianoinflames.de>, Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Greg KH <greg@kroah.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jgarzik@pobox.com>



On Sun, 9 Dec 2007, Robert Hancock wrote:
> 
> The obvious suspect with a filesystem problem would be the disk 
> controller driver, AHCI here. However, the controller appears to set the 
> flag to indicate that it supports 64-bit DMA, so it should be fine, 
> unless it lies of course (which we know that ATI SB600 chipset does, but 
> I don't believe Intel is known to).
> 
> Could still be a DMA mapping bug that only shows up when IOMMU is used. 
> However, AHCI is a pretty well tested driver..

AHCI is a pretty well tested driver, but 99%+ of all testers still tend to 
have less than 4GB of memory. So I do *not* believe that the highmem bits 
are all that well tested at all. 

Can somebody who knows the driver send Marco a test-patch to just limit 
DMA to the low 32 bits, and then Marco can at least verify that yes, that 
that it. While it looks like DMA problems, there could obviously be some 
other subtle issue with big-memory machines (ie the PCI allocations etc 
tend to change too!)

		Linus
