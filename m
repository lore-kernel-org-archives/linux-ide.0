From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-core: Drop in the final bit of IORDY handling
Date: Mon, 15 Oct 2007 21:25:02 +0100
Message-ID: <20071015212502.73ffc51c@the-village.bc.nu>
References: <20071015192040.5a11bcf7@the-village.bc.nu>
	<4713C2B1.7090701@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46256 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764782AbXJOUVS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 16:21:18 -0400
In-Reply-To: <4713C2B1.7090701@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

> > + 	/* Ancient devices may need us to avoid IORDY */
> > + 	if (ata_pio_need_iordy(dev))
> > + 		tf.nsect = dev->xfer_mode;
> > + 	else
> > + 		tf.nsect = 0x01;
> 
>     This is wrong logic as I've alredy pointed out: according to the ATA-2 
> setting *any* PIO mode via 0x08..0x0c commands assumes IORDY is enabled.
> We should only set mode 0x01 (default w/IORDY disabled) if device supports 
> IORDY and the host doesn't.

ata_pio_need_iordy is false if

- the controller does not support iordy

or

- mode <= PIO 2 and the device does not support iordy

I can tighten that if to

	if (!ata_pio_need_iordy(dev) && ata_has_iordy(dev->id))
		tf.nsect = 0x01;

if you prefer ?

Alan


