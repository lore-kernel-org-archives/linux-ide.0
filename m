From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] IDE updates (part 2)
Date: Sun, 14 Oct 2007 00:09:06 +0200
Message-ID: <200710140009.06260.bzolnier@gmail.com>
References: <200710131825.24768.bzolnier@gmail.com> <200710132259.53574.bzolnier@gmail.com> <20071013224452.71d6f61f@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:7160 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbXJMWFF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 18:05:05 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1378462mue
        for <linux-ide@vger.kernel.org>; Sat, 13 Oct 2007 15:05:03 -0700 (PDT)
In-Reply-To: <20071013224452.71d6f61f@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 13 October 2007, Alan Cox wrote:
> > Comment in pmac_ide_init_hwif_ports() is highly misleading as this function
> > returns early only for "normal" IDE PCI devices (pmac_ide_init_hwif_ports()
> > can be called outside ide-pmac driver through ppc_ide_md).
> 
> Follow the code you pasted
> 
> > 	pmif->regbase = (unsigned long) base + 0x2000;
> > ...
> > 	rc = pmac_ide_setup_device(pmif, hwif);
> 
> Ok so regbase is set
> 
> > ...
> > }
> > 
> > static int
> > pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif)
> > {
> > ...
> > 	pmac_ide_init_hwif_ports(&hwif->hw, pmif->regbase, 0, &hwif->irq);
> 
> Now we pass a honking great zero for the ctrl_port
> > ...
> > }
> > 
> > void
> > pmac_ide_init_hwif_ports(hw_regs_t *hw,
> > 			      unsigned long data_port, unsigned long ctrl_port,
> > 			      int *irq)
> > {
> > ...
> > 	for (ix = 0; ix < MAX_HWIFS; ++ix)

this loop is a tricky part, regbase is set so we break out early

> > 		if (data_port == pmac_ide[ix].regbase)
> > 			break;
> > ---> since pmif->regbase was set earlier ix will be < MAX_HWIFS
                                             ^^^^^^^^^^^^^^^^^^^^^^
> > 	if (ix >= MAX_HWIFS) {
            ^^^^^^^^^^^^^^^
> > 		/* Probably a PCI interface... */
> > 		for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; ++i)
> > 			hw->io_ports[i] = data_port + i - IDE_DATA_OFFSET;
> > 		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
> 
> Which is zero..
> 
> 
> See the problem ?
