From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA driver for Atmel AVR32
Date: Mon, 23 Jul 2007 20:44:24 +0100
Message-ID: <20070723204424.15534b4b@the-village.bc.nu>
References: <200707201108.19174.kngregertsen@norway.atmel.com>
	<200707201112.12444.kngregertsen@norway.atmel.com>
	<20070720121443.4c1d6fa5@the-village.bc.nu>
	<46A4FAE6.5060901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36724 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759295AbXGWTjq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 15:39:46 -0400
In-Reply-To: <46A4FAE6.5060901@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>, linux-ide@vger.kernel.org, kernel@avr32linux.org, gregerts@stud.ntnu.no

> > Any mode for PIO2+ will use IORDY. Modes below may require
> > it sometimes (and its a good signal check). See ata_pio_need_iordy(atadev)
> 
>     For PIO3+ you wanted to say? PIO2 doesn't require IORDY (and the majority 
> of drives report 240 ns lowest cycle time w/o IORDY which is PIO2).

I did yes. 
