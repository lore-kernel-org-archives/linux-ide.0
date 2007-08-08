From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] pata_hpt37x: actually clock HPT374 by 50 MHz DPLL
Date: Wed, 8 Aug 2007 02:17:03 +0100
Message-ID: <20070808021703.77114775@the-village.bc.nu>
References: <200708052245.16406.sshtylyov@ru.mvista.com>
	<20070805202359.41fd0236@the-village.bc.nu>
	<46B9131E.3040404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46235 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933776AbXHHBKK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 21:10:10 -0400
In-Reply-To: <46B9131E.3040404@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, rah@bash.sh

On Tue, 07 Aug 2007 20:49:34 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> >>  		/* Compute DPLL */
> >> -		dpll = 2;
> >> -		if (port->udma_mask & 0xE0)
> >> -			dpll = 3;
> >> +		dpll = (port->udma_mask & 0xC0) ? 3 : 2;
> > 
> > Gak, I'd much rather people kept to the nice easy to read if() but fine
> > 
> > is_author_p()?Signed-off-by:Acked-by Alan Cox <alan@redhat.com>
> 
> Does your ACK stand, even though it still locks up for Bob Ham?


Its a real fix for a real bug. The 374 needs a bit more stuff which is
sitting in my tree and I'll push for Sergei to comment tomorrow
