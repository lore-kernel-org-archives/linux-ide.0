From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA
 open bugs) II
Date: Fri, 10 Aug 2007 14:54:30 +0100
Message-ID: <20070810145430.17d72a76@the-village.bc.nu>
References: <46BA9101.6080407@gmail.com>
	<20070809145336.6d728f9b@the-village.bc.nu>
	<20070809170540.GA30700@one.firstfloor.org>
	<20070809182101.710c3c5b@the-village.bc.nu>
	<20070809172304.GB30700@one.firstfloor.org>
	<20070809185310.682dffbc@the-village.bc.nu>
	<20070809192850.GA32280@one.firstfloor.org>
	<20070809233458.12d8447c@the-village.bc.nu>
	<20070809224305.GA1611@one.firstfloor.org>
	<20070810001443.610185e1@the-village.bc.nu>
	<20070809231141.GB1845@one.firstfloor.org>
	<20070810002453.384a9b4c@the-village.bc.nu>
	<p73sl6rencd.fsf@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60718 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759493AbXHJNri (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 09:47:38 -0400
In-Reply-To: <p73sl6rencd.fsf@bingen.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

> > Ok so we do in fact need some kind of proper way to ask if a device is
> > DMA capable ?
> 
> Right now it seems to be (dev->dma_mask != NULL) 

I'll follow that path for now then
