From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Fri, 18 Jan 2008 15:04:02 +0000
Message-ID: <20080118150402.16a3a387@lxorguk.ukuu.org.uk>
References: <200801172150.57059.asalnikov@ru.mvista.com>
	<20080117232303.3f34c87a@lxorguk.ukuu.org.uk>
	<4790B459.3000407@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54051 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754226AbYARPFs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2008 10:05:48 -0500
In-Reply-To: <4790B459.3000407@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Anton Salnikov <asalnikov@ru.mvista.com>, linux-ide@vger.kernel.org, bzolnier@gmail.com

> >>+		/* udmatim Register */
> >>+		palm_bk3710_base->config.udmatim &= 0xFFF0;
> >>+		palm_bk3710_base->config.udmatim |= level;
> 
> > Direct memory access to I/O space - should be using read/write functions
> 
>     Sigh, I was anticipationg that somebody would say that... :-)

Well yes - its not very nice code and it isn't really upstream to scratch.

>     Why?  ATA/PI says in the note to the table "Register transfer to/from device":
> 
> 5 Mode shall be selected no higher than the *highest* mode supported by the 
> *slowest* device.

You are correct, ignore that. You don't touch the timing for the other
device.

>     It won't -- we can *not* call ide_setup_dma() which fills them out as this 
> is not a PCI chip.

Gak.

Alan
