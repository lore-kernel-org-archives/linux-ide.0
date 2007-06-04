From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: always use polling SETXFER
Date: Mon, 4 Jun 2007 16:38:58 -0400
Message-ID: <20070604203858.GE20299@havoc.gtf.org>
References: <46598350.6030403@gmail.com> <4662E5B3.4020205@garzik.org> <20070604154231.708b2b9b@the-village.bc.nu> <alpine.LFD.0.98.0706041332050.23741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:37235 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbXFDUi7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Jun 2007 16:38:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706041332050.23741@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, Jun 04, 2007 at 01:34:21PM -0700, Linus Torvalds wrote:
> Ok, I think everybody agreed.
> 
> Jeff, do you want me to just take the patch you sent earlier if I can 
> still find it, or should I pull it from somewhere (btw, the changelog 
> should probably be fixed, since there were at least two people who were 
> confused by the fact that it mentioned VIA controllers and LITE-ON 
> devices, even though it definitely wasn't restricted to that set).
> 
> I was going to do an -rc4 yesterday, but slipped, so since I slipped 
> anyway, I would prefer to just get this in before doing the -rc..

I'll send the patch in an hour or so.

I'd like to get in the updated patch description, that documents we
intentionally do not apply these workarounds in non-SFF drivers.

That will eventually be relevant for, e.g. the upcoming Marvell PATA
driver (libata-dev.git#mv-ahci-pata) that needs to care about this
problem, but where the workaround does not exist at all, since the
controller is ultra-modern.

	Jeff



