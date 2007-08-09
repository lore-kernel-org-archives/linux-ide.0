From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA
 open bugs) II
Date: Fri, 10 Aug 2007 00:24:53 +0100
Message-ID: <20070810002453.384a9b4c@the-village.bc.nu>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48841 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756453AbXHIXRt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 19:17:49 -0400
In-Reply-To: <20070809231141.GB1845@one.firstfloor.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

> BTW unless I'm misreading the i386 code it'll not fail here, but
> allocate memory. Surely that will cause failures later if you
> rely on it failing? If you don't rely on it then changing x86-64
> will also not help you.

Eww that'll do strange things.

Ok so we do in fact need some kind of proper way to ask if a device is
DMA capable ?

Alan
