From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bug: get EXT3-fs error Allocating block in system zone
Date: Mon, 10 Dec 2007 10:11:46 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712101009410.28293@woody.linux-foundation.org>
References: <fa.LkmHGN+Fx6H930bfeCDU6pGdBKM@ifi.uio.no> <fa.oSqMiIX7WubypXrhZGaRKU5wNGU@ifi.uio.no> <fa.0pc9/nNmTq+eWIU9rADRn0xYGdI@ifi.uio.no> <fa.hqM73i24f6G31R5F3sKL8+3H8Ww@ifi.uio.no> <475C2C02.70001@shaw.ca> <alpine.LFD.0.9999.0712091057200.12046@woody.linux-foundation.org>
 <20071209190913.GB13382@kernel.dk> <475C48EE.8020701@pianoinflames.de> <20071209200440.GC13382@kernel.dk> <475C536B.5070409@pianoinflames.de> <20071209210137.GD13382@kernel.dk> <475D7F03.7050100@pianoinflames.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43293 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751756AbXLJSNg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 13:13:36 -0500
In-Reply-To: <475D7F03.7050100@pianoinflames.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marco Gatti <marco@pianoinflames.de>
Cc: Jens Axboe <jens.axboe@oracle.com>, Robert Hancock <hancockr@shaw.ca>, Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Greg KH <greg@kroah.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>



On Mon, 10 Dec 2007, Marco Gatti wrote:
> 
> I didn't compile completly.
> 
> drivers/scsi/scsi_lib.c:1565:1: error: unterminated #else

Heh. That #else should be an #endif, of course.

It is a bit strange that it still tries to do IO to high memory. Either 
the whole "64 bit capability" thing in AHCI is broken, or the bounce 
buffering doesn't work right. Or maybe you tried the "iommu=off" without 
the original patch that tried to turn off 64-bit DMA?

		Linus
