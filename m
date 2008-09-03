From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ahci: Fix long standing Marvell regressions
Date: Wed, 3 Sep 2008 20:06:49 +0100
Message-ID: <20080903200649.71eb6bfb@lxorguk.ukuu.org.uk>
References: <20080903000538.7500eaf8@lxorguk.ukuu.org.uk>
	<48BDCF09.7000603@garzik.org>
	<20080903142941.3f25d235@lxorguk.ukuu.org.uk>
	<20080903144834.35276de7@lxorguk.ukuu.org.uk>
	<alpine.DEB.1.10.0809031151200.742@hygvzn-guhyr.pnirva.bet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56848 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756242AbYICTJJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Sep 2008 15:09:09 -0400
In-Reply-To: <alpine.DEB.1.10.0809031151200.742@hygvzn-guhyr.pnirva.bet>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard A Nelson <cowboy@cavein.org>
Cc: Jeff Garzik <jeff@garzik.org>, torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 3 Sep 2008 11:54:36 -0700 (PDT)
Richard A Nelson <cowboy@cavein.org> wrote:

> On Wed, 3 Sep 2008, Alan Cox wrote:
> 
> > We can't automate that for the other devices as we don't actually know
> > how to check the PATA port on them.
> 
> I happen to have one of the others:
>  	Marvell Technology Group Ltd. 88SE6121 SATA II Controller (rev b1)
> 
> It is not in use, likely as a result of the issues at hand, I don't
> recall exactly what transpired at the time.
> 
> I have no specs, but would be happy to run any software diagnostics
> if they'd be of help

Load the pata_marvell driver and it dumps out BAR5: .... lists of values

Can you do that with a PATA device attached and with no PATA device
attached and see what changes.
