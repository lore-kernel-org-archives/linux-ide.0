From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] IDE updates (part 2)
Date: Sat, 13 Oct 2007 22:44:52 +0100
Message-ID: <20071013224452.71d6f61f@the-village.bc.nu>
References: <200710131825.24768.bzolnier@gmail.com>
	<20071013205618.3ddc91e9@the-village.bc.nu>
	<200710132259.53574.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41053 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752863AbXJMVkk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 17:40:40 -0400
In-Reply-To: <200710132259.53574.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> Comment in pmac_ide_init_hwif_ports() is highly misleading as this function
> returns early only for "normal" IDE PCI devices (pmac_ide_init_hwif_ports()
> can be called outside ide-pmac driver through ppc_ide_md).

Follow the code you pasted

> 	pmif->regbase = (unsigned long) base + 0x2000;
> ...
> 	rc = pmac_ide_setup_device(pmif, hwif);

Ok so regbase is set

> ...
> }
> 
> static int
> pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif)
> {
> ...
> 	pmac_ide_init_hwif_ports(&hwif->hw, pmif->regbase, 0, &hwif->irq);

Now we pass a honking great zero for the ctrl_port
> ...
> }
> 
> void
> pmac_ide_init_hwif_ports(hw_regs_t *hw,
> 			      unsigned long data_port, unsigned long ctrl_port,
> 			      int *irq)
> {
> ...
> 	for (ix = 0; ix < MAX_HWIFS; ++ix)
> 		if (data_port == pmac_ide[ix].regbase)
> 			break;
> ---> since pmif->regbase was set earlier ix will be < MAX_HWIFS

> 	if (ix >= MAX_HWIFS) {
> 		/* Probably a PCI interface... */
> 		for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; ++i)
> 			hw->io_ports[i] = data_port + i - IDE_DATA_OFFSET;
> 		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;

Which is zero..


See the problem ?

Alan
