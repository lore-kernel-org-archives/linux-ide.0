From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] pata_cmd64x: revert commit d62f5576
Date: Tue, 17 Aug 2010 16:39:17 +0100
Message-ID: <20100817163917.58ea1d06@lxorguk.ukuu.org.uk>
References: <4C6A7CF6.5090706@kernel.org>
	<201008171456.43648.bzolnier@gmail.com>
	<4C6AA436.2090003@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41297 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754783Ab0HQPZU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2010 11:25:20 -0400
In-Reply-To: <4C6AA436.2090003@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, "\"linux-ide@vger.kernel.org\" st" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>, Milan Kocian <milan.kocian@wq.cz>

> The old problem is much less severe tho.  The introduced regression
> causes oops while the old bug probably doesn't show itself too often.

If ever

> Does it really need to merge the DMA timings too?  If the device can't
> do certain timing, it's PIO configuration should reflect that so
> merging PIO part only should be enough for PIO configuration, no?

The timing code knows about DMA/PIO constraints itself. The whole mucking
around passing both timings is just bogus.

Pass pair->dma_mode only and it'll work out the PIO for you. Not that it
matters - no real hardware has a DMA mode with a slower address setup
than its PIO mode.

and for UT just stick in some value (eg 33000) so it works in PCI clocks
