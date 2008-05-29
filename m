From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RESEND: [PATCH] libata-sff: Fix oops reported in kerneloops.org
 for pnp devices with no ctl
Date: Thu, 29 May 2008 21:18:49 +0100
Message-ID: <20080529211849.59aafbc0@core>
References: <20080529161453.24735.805.stgit@core>
	<alpine.LFD.1.10.0805290950230.2958@woody.linux-foundation.org>
	<20080529190235.258d304e@core>
	<483EF536.90801@garzik.org>
	<20080529193813.4bc0a677@core>
	<alpine.LFD.1.10.0805291245330.2958@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49772 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751341AbYE2UdO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 16:33:14 -0400
In-Reply-To: <alpine.LFD.1.10.0805291245330.2958@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> The old function oopsed for the case that you worry about. That is WORSE 
> than anything else you can come up with. There is absolutely zero upside 
> to using that old and broken thing.

The worst case is uncaught data corruption. An oops is harmless in
comparison. Someone using altstatus to enforce DMA timing barriers and
getting nothing else will find their disk contents 'degraded'.

I'm just putting together a patch that removes ata_altstatus entirely
from public use, and that actually looks far nicer.
