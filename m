From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] ide dma_timer_expiry, then hard lockup
Date: Mon, 18 Jun 2007 22:04:41 +0100
Message-ID: <20070618220441.3a3af8ca@the-village.bc.nu>
References: <20070618175713.GD5836@austin.ibm.com>
	<20070618212704.394912b8@the-village.bc.nu>
	<20070618204601.GF5836@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33887 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764150AbXFRU7G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 16:59:06 -0400
In-Reply-To: <20070618204601.GF5836@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> So what do you suggest? (I could buy an alternate ide controller,
> and hope that goes away, or just buy a different hard drive. But
> that's beside the point).

The DMA timeout itself could be all sorts of things - crap driver, crap
hardware, PCI bus contention, noise, problem disk, phase of the moon.

> I can prepare a patch, but only with a lot of guidance. I can test 
> & debug, I'm highly motivated just right now ... 

If you've got a nice repeatable problem please try using the libata
driver. That handles the error paths differently and doesn't try a FIFO
drain which might matter in this case I guess.

Alan
