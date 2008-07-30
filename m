From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PIIX4: DMA timeout issue
Date: Wed, 30 Jul 2008 11:49:34 +0100
Message-ID: <20080730114934.5a593cf4@lxorguk.ukuu.org.uk>
References: <488ED837.2060509@alcatel-lucent.com>
	<488F1C6C.9000002@garzik.org>
	<48902EB5.8070102@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56479 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751812AbYG3LHZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 07:07:25 -0400
In-Reply-To: <48902EB5.8070102@alcatel-lucent.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gshan <gshan@alcatel-lucent.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

> Jeff, I tried moving to ATA driver for PIIX4 today and found ATA need to 
> request
> 2 IRQ lines, each one of them belongs to primary and secondary channel. 
> However,
> when I make PIIX4 worked under IDE driver, it also need to request one 
> IRQ for "ide1".
> So it's necessary to disable secondary channel manually?

If the controller is in legacy mode then libata will claim the interrupt
lines for all channels which are enabled even if there are no devices on
them. This is neccessary for device hot or warm plug support as new disks
could appear on empty channels.
> 
> Another question is my PIIX4 chip has device ID + vendor ID of 
> 0x71108086. But it finally
> was mapped to following ID of piix_pci_tbl[] array. Device of 0x7110 and 
> 0x7010 should
> be quit different, right?

Yes - I find tht one very odd - you might need to debug a bit to see what
is occuring if you think this is the case.

Alan
