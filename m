From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA Sil680 Disabling IRQ
Date: Thu, 28 Feb 2008 23:10:02 +0000
Message-ID: <20080228231002.325c9e1d@core>
References: <8202f4270802261647t505cccf7ra3c81e5fccc9366a@mail.gmail.com>
	<47C4B5BE.7010709@garzik.org>
	<8202f4270802271620u6cea6176p2bea5ff8e0b9bbef@mail.gmail.com>
	<20080228202255.5e3f0c43@core>
	<8202f4270802281411j747bf96dx34ff81c4d192d417@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42047 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757317AbYB1XUz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Feb 2008 18:20:55 -0500
In-Reply-To: <8202f4270802281411j747bf96dx34ff81c4d192d417@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>

> For most of unsupported commands, it will be aborted by drive.
> However, for some unsupported commands, it may not.  I suspect these
> bad commands are the new ones in ATA8 issued to some drives with old
> firmware. For instance, can you try command 0x5E (Trusted Send PIO
> data out) with sector count set to 1 and see what happens?

Well the kernel as of 2.6.24 defaults to blocking treacherous computing
commands 8)

> The blame is probably on drives which should have aborted these
> commands. But the reality is that libata will handle variety of drives
> including the ones with old firmware.  So the question here is whether
> libata PATA code can be more fault tolerate. It seems the weakest link
> is on PATA PIO since I have not been able to reproduce the IRQ
> disabling problem on DMA operations.

If you send crap to a drive you will get junk as a result. Only the
superuser can do this so that behaviour is fine. The superuser can also
crash the machine a million other ways. End users cannot send arbitary
commands to the drive.

Ditto they may know that an "unsupported" command for their ATA version
is actually a vendor private command for the specific drive they have.

Alan
