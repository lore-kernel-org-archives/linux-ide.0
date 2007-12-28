From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] trm290: do hook dma_host_{on,off} methods (take 2)
Date: Fri, 28 Dec 2007 22:41:26 +0300
Message-ID: <47755166.7030809@ru.mvista.com>
References: <200712271355.36105.sshtylyov@ru.mvista.com> <200712271705.32867.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:8980 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755844AbXL1Tk7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Dec 2007 14:40:59 -0500
In-Reply-To: <200712271705.32867.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>Using default methods caused the chip's DMA PRD count registers, inadvertently
>>starting DMA!  While fixing it, also do:

> nasty, this could possibly explain the following trm290.c hack:

    Frankly speaking, I'm not sure it's that destructive: the register in 
question is accessed by inw()/outw() while the genric code would only "spoil" 
it by inb(). So, I don't know if this would be access to the same register as
outw() does (that write starts DMA, and it is a number of 32-bit words in PRD 
table - 1). Actually, the PRD address is loaded by 32-bit write at address 2 
bytes below the one in question, and so overlaps our register -- the chip must 
be looking at byte enables when deciding what register is addressed).

> ...
> #if 0 /* play it safe for now */
			  IDE_HFLAG_TRUST_BIOS_FOR_DMA |
> #endif
> ...

>>- get rid of the 'ide_' prefixes in several functions for which the prefix in
>>  the method's name has been 'ide_' ectomized already;

>>- align the code hooking the IDE DMA methods in init_hwif_trm290()...

>>---
>>Fixed the header, added 'static' to the new method definitions.
>>The patch is against Linus' kernel tree...

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> applied

    The next patch is cooking... :-)

WBR, Sergei
