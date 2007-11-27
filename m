From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 13/13] libata: use PIO for misc ATAPI commands
Date: Tue, 27 Nov 2007 16:56:00 +0000
Message-ID: <20071127165600.39b8c383@the-village.bc.nu>
References: <11961764391983-git-send-email-htejun@gmail.com>
	<11961764413291-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50856 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758880AbXK0RGm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 12:06:42 -0500
In-Reply-To: <11961764413291-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Tejun Heo <htejun@gmail.com>

On Wed, 28 Nov 2007 00:13:59 +0900
Tejun Heo <htejun@gmail.com> wrote:

> ATAPI devices come with plethora of bugs and many ATA controllers have
> trouble dealing with odd byte DMA transfers.  The problem is currently
> somewhat masked by not allowing DMA transfers if the transfer size
> isn't aligned to 16 bytes plus partial masking in problematic LLDs.

NAK. Same complaint I had originally and which is not addressed.


The whole approach being used here is fundamentally in the wrong place.
Its also horribly damaging because of our PIO behaviour currently.

- Until our PIO works without IRQ masking you can't take this approach for
arbitary devices without hurting users badly.
- I still see no evidence in the drives I've looked at that all of this
is drive side (or indeed that most of it is)
- Control over the DMA/PIO strategy belongs with the driver. If we mess
that up it will cost us dearly later.

What we should be doing IMHO is

-	Fix the PIO IRQ masking
-	Creating ata_std_check_atapi_dma()
-	Let drivers select between the std_check_atapi_dma() and their
own rules

Finally ata_std_check_atapi_dma should be blacklist based for all but the
really generic issues (%15 etc), otherwise we punish the 99.999% of
systems that work perfectly well for the sake of a tiny number that are
problematic.

