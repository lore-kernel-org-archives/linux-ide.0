From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA Sil680 Disabling IRQ
Date: Fri, 29 Feb 2008 11:21:59 +0000
Message-ID: <20080229112159.2e5adbd1@core>
References: <8202f4270802261647t505cccf7ra3c81e5fccc9366a@mail.gmail.com>
	<47C4B5BE.7010709@garzik.org>
	<8202f4270802271620u6cea6176p2bea5ff8e0b9bbef@mail.gmail.com>
	<20080228202255.5e3f0c43@core>
	<8202f4270802281411j747bf96dx34ff81c4d192d417@mail.gmail.com>
	<20080228231002.325c9e1d@core>
	<8202f4270802281707g6fb80dc4i6a8015cdd13035ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46589 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752654AbYB2LdB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Feb 2008 06:33:01 -0500
In-Reply-To: <8202f4270802281707g6fb80dc4i6a8015cdd13035ec@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>

> I agree with you and Jeff that we can not prevent superuser from
> corrupting the system.  What I want to understand more is if there's
> room to harden PATA PIO code in libata.  For instance, when I set
> wrong data transfer direction in DMA read, I got command timeout,
> which to me is a more graceful failure than IRQ disabling.  I'm not
> sure if the difference of failure mode between PIO and DMA is caused
> by controller or software.  If the cause is software,  it would be
> nice to close the gap.

Its almost impossible to tell - I can't duplicate the case you see. When
I issue wrong commands I see the expected timeout/fail. It may be that
Tejun's drain patches for the PIO fifo are going to help in your case I
don't know. Nothing obvious in the SIL680 docs hit me
