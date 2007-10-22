From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AHCI with ATA/IDE Drives
Date: Mon, 22 Oct 2007 11:22:47 +0100
Message-ID: <20071022112247.63d517a5@the-village.bc.nu>
References: <a14fb1800710200440hbcb0438sf2b0ee627e6e8209@mail.gmail.com>
	<471A09B8.2040708@rtr.ca>
	<471C6EC1.6000703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35171 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751352AbXJVKUJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Oct 2007 06:20:09 -0400
In-Reply-To: <471C6EC1.6000703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Girish Shirasat <girish.shirasat@googlemail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>

On Mon, 22 Oct 2007 18:34:57 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Mark Lord wrote:
> > Alan / Tejun,
> > 
> > Another case of MDMA2 not working through a SATA->PATA bridge.
> > Do we have an easy way yet, for Girish to force non-MDMA2 modes?
> 
> libata.dma=1 should do the trick for 2.6.24-rcX.  For 2.6.23, there
> isn't any.  :-(

For CF specifying libata.dma=3 should do the trick even better as it will
leave DMA enabled on disk and ATAPI
