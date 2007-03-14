From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PATA Sil680 Command Timeout on ARM XScale
Date: Wed, 14 Mar 2007 18:36:13 -0400
Message-ID: <45F878DD.9000404@garzik.org>
References: <8202f4270703131134x68c028fbv7fb536c694a6b898@mail.gmail.com>	 <20070313193957.396d7d1d@lxorguk.ukuu.org.uk>	 <8202f4270703131417t3daacf1tf361e0449ad1f93b@mail.gmail.com> <8202f4270703141527g459165dah647a8ad4116b96bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44896 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbXCNWgQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Mar 2007 18:36:16 -0400
In-Reply-To: <8202f4270703141527g459165dah647a8ad4116b96bb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Fajun Chen wrote:
> Since primary channel and secondary channel share the same IRQ,  the
> ISR could be called to service one or both channels. So I would think
> it's normal to see "irq trap" traces when both channels are in IO
> operation, correct?

The irq trap code only occurs after a certain number of unhandled 
interrupts.


> I have another question in regard to ata_host_intr() function in
> libata-core.c. For PIO read/write, the status of interrupt pin was not
> checked before moving the host state machine.  Sil680 spec. recommend
> checking IDE channel interupt (bit 11 in the IDEx Task File Timing and
> Config + Status register) though.  Could someone explain why interrupt
> status does not need to be checked for PIO?

Reading the Status register (as opposed to AltStatus) should clear the 
interrupt condition, on standard hardware.

	Jeff


