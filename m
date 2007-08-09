From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA open
 bugs)
Date: Thu, 9 Aug 2007 14:53:36 +0100
Message-ID: <20070809145336.6d728f9b@the-village.bc.nu>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com>
	<46BA9101.6080407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39638 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933764AbXHINwy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 09:52:54 -0400
In-Reply-To: <46BA9101.6080407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, Andi Kleen <andi@firstfloor.org>

> > http://bugzilla.kernel.org/show_bug.cgi?id=8424 - patch review
> This one is on Alan.

I think not - something horrible is happening in dma_alloc_coherent when
called from dmam_* with a non PCI device


Seems to be some kind of AMD64 specific DMA mapping bug ?
