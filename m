From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA Sil680 Disabling IRQ
Date: Thu, 28 Feb 2008 20:22:55 +0000
Message-ID: <20080228202255.5e3f0c43@core>
References: <8202f4270802261647t505cccf7ra3c81e5fccc9366a@mail.gmail.com>
	<47C4B5BE.7010709@garzik.org>
	<8202f4270802271620u6cea6176p2bea5ff8e0b9bbef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58641 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753539AbYB1Udt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Feb 2008 15:33:49 -0500
In-Reply-To: <8202f4270802271620u6cea6176p2bea5ff8e0b9bbef@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>

> PIO read/writes with wrong direction is not the only failure mode,
> PATA sil680 also failed with disabling IRQ with some unsupported
> commands such as Trusted Send (0x5E) even with perfect TF data. Given
> that some ATA commands are optional,  we may have a chance to hit the
> trap even with well programmed code.

That sounds very strange - I regularly test PATA controlles with
unsupported commands and see the correct 0x04 abort patterns.

> What would take to harden the PATA ISR code such that it fails more gracefully?

First thing would be to work out why your system is behaving differently
to the others. What is the trigger here.

Alan
