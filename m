From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: porting IDE patches to PATA driver
Date: Thu, 25 Jun 2009 12:29:58 +0100
Message-ID: <20090625122958.510c28ad@lxorguk.ukuu.org.uk>
References: <323951117.20090625100956@web.de>
	<20090625092324.2dd4de5a@lxorguk.ukuu.org.uk>
	<14164712.20090625103834@web.de>
	<20090625100542.525dba02@lxorguk.ukuu.org.uk>
	<951976828.20090625123021@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59386 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751311AbZFYL20 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jun 2009 07:28:26 -0400
In-Reply-To: <951976828.20090625123021@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrei Martynov <andrei.martynov@web.de>
Cc: linux-ide@vger.kernel.org

> ide_dma_off_quietly and ide_dma_on commands. The logic implemented in
> the old code is "stop DMA transfer but do not disable DMA in case of errors".

The two layers don't line up 1:1. In the event of a timeout then libata
layer calls the ->lost_interrupt() which if you inherit from bmdma checks
controller status in the taskfiles to see if the command finished fine by
the IRQ was lost before deciding an error situation occurs

If we get an error we quiesce the channel entirely and then recover it.

It would be useful I think if you posted the current code, and also to
know if you see the same problem (lost IRQ etc) with ATAPI as well as ATA

