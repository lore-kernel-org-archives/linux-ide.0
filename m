From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] ide dma_timer_expiry, then hard lockup
Date: Tue, 19 Jun 2007 17:17:45 +0100
Message-ID: <20070619171745.7c2240bf@the-village.bc.nu>
References: <20070618175713.GD5836@austin.ibm.com>
	<20070618212704.394912b8@the-village.bc.nu>
	<20070618204601.GF5836@austin.ibm.com>
	<20070618220441.3a3af8ca@the-village.bc.nu>
	<4677E3BC.3040307@ru.mvista.com>
	<20070619151919.79c79af1@the-village.bc.nu>
	<4677E726.1080602@ru.mvista.com>
	<4677F881.6060200@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36366 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754802AbXFSQTG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jun 2007 12:19:06 -0400
In-Reply-To: <4677F881.6060200@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Linas Vepstas <linas@austin.ibm.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> >    Indeed... but the thing is we don't know what's asserted in this case 
> > -- remember, it's reading the status register that locks everything up...
> 
> Exactly.  And IORDY shouldn't really apply there,
> unless some nitwit standards person wrote it into a spec..

Could it be we need to reset the state machine at this point before we
touch the registers again - that wouldn't be the first controller with
this limit and undocumented.

On the 370 we already 

Linas; For the debug on the libata one turn on ATA_DEBUG and
ATA_VERBOSE_DEBUG in include/linux/libata.h and it should spew
diagnostics before the freeze. I suspect thats a different problem to the
hang you see now but I'd like to debug both.

Alan
