From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious
 IRQs
Date: Fri, 21 Nov 2008 10:25:04 +0000
Message-ID: <20081121102504.63007bf6@lxorguk.ukuu.org.uk>
References: <49263552.8090602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55457 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752110AbYKUKZD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Nov 2008 05:25:03 -0500
In-Reply-To: <49263552.8090602@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, 21 Nov 2008 13:13:06 +0900
Tejun Heo <tj@kernel.org> wrote:

> The DMA_IRQ bit in the bmdma status register is always set when IDEIRQ
> is asserted allowing spurious IRQ detection.  Detect spurious IRQs and
> clear them.  This protects ata_piix against nobody-cared which gets
> reported not so rarely.

Various controllers have the ability to report the IRQ more reliably in
similar fashion, should this not be part of ata_sff_interrupt with an
optional ops->irq_pending call ?

