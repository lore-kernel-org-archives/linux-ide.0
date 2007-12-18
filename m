From: Marco Gatti <marco@pianoinflames.de>
Subject: Re: Bug: get EXT3-fs error Allocating block in system zone
Date: Tue, 18 Dec 2007 09:36:50 +0100
Message-ID: <476786A2.2040407@pianoinflames.de>
References: <fa.LkmHGN+Fx6H930bfeCDU6pGdBKM@ifi.uio.no> <fa.oSqMiIX7WubypXrhZGaRKU5wNGU@ifi.uio.no> <fa.0pc9/nNmTq+eWIU9rADRn0xYGdI@ifi.uio.no> <fa.hqM73i24f6G31R5F3sKL8+3H8Ww@ifi.uio.no> <475C2C02.70001@shaw.ca> <alpine.LFD.0.9999.0712091057200.12046@woody.linux-foundation.org> <20071209190913.GB13382@kernel.dk> <475C48EE.8020701@pianoinflames.de> <20071209200440.GC13382@kernel.dk> <475C536B.5070409@pianoinflames.de> <20071209210137.GD13382@kernel.dk> <475D7F03.7050100@pianoinflames.de> <alpine.LFD.0.9999.0712101009410.28293@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from echo836.server4you.de ([85.25.140.112]:55902 "EHLO
	mail.pianoinflames.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbXLRIg7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Dec 2007 03:36:59 -0500
In-Reply-To: <alpine.LFD.0.9999.0712101009410.28293@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, Robert Hancock <hancockr@shaw.ca>, Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Greg KH <greg@kroah.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>

Linus Torvalds schrieb:
> 
> On Mon, 10 Dec 2007, Marco Gatti wrote:
>> I didn't compile completly.
>>
>> drivers/scsi/scsi_lib.c:1565:1: error: unterminated #else
> 
> Heh. That #else should be an #endif, of course.
> 
> It is a bit strange that it still tries to do IO to high memory. Either 
> the whole "64 bit capability" thing in AHCI is broken, or the bounce 
> buffering doesn't work right. Or maybe you tried the "iommu=off" without 
> the original patch that tried to turn off 64-bit DMA?
> 

Hello,

I tried latest kernels 2.6.23.11 and 2.6.24-rc5-git3. No change, same 
issues. The NCQ fixes doesn't affect any 64-bit dma issues with big mem.

Marco
