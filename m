From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY (take 2)
Date: Tue, 8 May 2007 13:20:46 +0100
Message-ID: <20070508132046.70a4d9ed@the-village.bc.nu>
References: <463EAB4D.3000309@tw.ibm.com>
	<463ED8B9.4060501@gmail.com>
	<463F0B25.40103@tw.ibm.com>
	<463F0DAD.5060307@gmail.com>
	<463F1374.1010100@tw.ibm.com>
	<463F1509.30100@gmail.com>
	<46405F50.5090901@tw.ibm.com>
	<20070508130025.7693980c@the-village.bc.nu>
	<464066A4.1010008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38542 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S934639AbXEHM2F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 08:28:05 -0400
In-Reply-To: <464066A4.1010008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

> Oh well, that's how we do PIO data transfer when not polling anyway.  We
> kick HSM directly from the interrupt handler and do PIO inside the
> interrupt handler.  The change made here is to make polling PIO act the
> same way.

Which is making a horrendous problem worse than it was before. In PIO CD
mode I'm actually losing serial characters and time its that bad.

Right now we can push the pio transfer out to run after the IRQ handler a
variety of ways and the locking for it isn't too bad. Make this change
and we are sunk.

Alan
