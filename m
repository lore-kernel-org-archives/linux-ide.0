From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.20-rc3 IRQ race upon resume? => killing SATA IRQ
Date: Thu, 4 Jan 2007 10:13:32 +0000
Message-ID: <20070104101332.165a54d3@localhost.localdomain>
References: <Pine.LNX.4.64.0701040006300.15167@localhost.localdomain>
	<Pine.LNX.4.64.0701040244300.15167@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37508 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932343AbXADKDI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Jan 2007 05:03:08 -0500
In-Reply-To: <Pine.LNX.4.64.0701040244300.15167@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjorn Wesen <bjorn.wesen@axis.com>
Cc: linux-ide@vger.kernel.org

> (correctly probably). Question is, where is the irq coming from then.
> 
> Obviously this is a horribly wrong fix, since if the interrupt is shared, we 
> will shadow the other interrupt so it never gets run (and corrupt our own 
> BM DMA operations).

I wonder if it's left over from the resume I/O completing or the chip
coming back up in a stupid state. What occurs if the bit is cleared
during the early resume before IRQs are turned back on ?
