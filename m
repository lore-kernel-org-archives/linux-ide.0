From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA
 open bugs)
Date: Thu, 9 Aug 2007 23:37:08 +0100
Message-ID: <20070809233708.11e6f3c4@the-village.bc.nu>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com>
	<46BA9101.6080407@gmail.com>
	<20070809145336.6d728f9b@the-village.bc.nu>
	<20070809170540.GA30700@one.firstfloor.org>
	<20070809182101.710c3c5b@the-village.bc.nu>
	<20070809172304.GB30700@one.firstfloor.org>
	<20070809185310.682dffbc@the-village.bc.nu>
	<1186690789.3426.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59744 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756486AbXHIWgH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 18:36:07 -0400
In-Reply-To: <1186690789.3426.4.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

> You cannot allocate a dma_coherent buffer without passing in the correct
> underlying device ... on parisc we'd explode trying to find the iommu to
> map through (some of our hw has more than one).

We do pass the correct underlying device. Then dma_alloc_coherent oopses
on x86_64 if you pass some valid devices (eg pcmcia). 

