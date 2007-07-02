From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [info] What's in libata-dev.git?
Date: Mon, 2 Jul 2007 16:53:27 +0100
Message-ID: <20070702165327.2646a761@the-village.bc.nu>
References: <20070702151639.GA10948@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52947 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752722AbXGBPrY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 11:47:24 -0400
In-Reply-To: <20070702151639.GA10948@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, 2 Jul 2007 11:16:39 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> 
> 
> What follows are the changes contained in libata-dev.git, listed on a
> branch-by-branch basis.  The double "====" lines separate each branch's
> contents.  Each branch is accompanied by a 'STATUS' line, indicating the
> upstream status of each branch.
> 
> I have patches from Alan (pata_sis FIFO whack, pata_dma option), Tejun,
> Albert and Kristen still to be reviewed.  Will get to those on Friday,
> after the July 4th US holiday.tions(-)

I have a pile more for you here including finally nailing a nasty
corruptor on some chipsets. Guess what certain chips do given a PRD entry
of

            someaddress
            0x00000000

Not generating those seems to sort out the CS5530 and probably the SC1200.

I've also got the patches to print all the iomap addresses properly, get
the HPT343 working fully solidly in PIO (some DMA problems - anyone got
ancient HPT docs for the 343/345/363 anywhere). The ide/pci driver isn't
any use as a reference as that one doesn't work either.

Alan
