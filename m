From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] IDE updates (part 2)
Date: Sat, 13 Oct 2007 22:59:53 +0200
Message-ID: <200710132259.53574.bzolnier@gmail.com>
References: <200710131825.24768.bzolnier@gmail.com> <20071013205618.3ddc91e9@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:62071 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758151AbXJMU4d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 16:56:33 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1005411nfb
        for <linux-ide@vger.kernel.org>; Sat, 13 Oct 2007 13:56:32 -0700 (PDT)
In-Reply-To: <20071013205618.3ddc91e9@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 13 October 2007, Alan Cox wrote:
> On Sat, 13 Oct 2007 18:25:24 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > 
> > Hi,
> > 
> > highlights of this update:
> > 
> > * Rework of IDE PMAC host driver: bugfixes, removal of the code
> >   duplicated from the IDE core and conversion to use the generic
> >   DMA tuning code path (the rework cuts ide-pmac.c by ~200 LOC).
> 
> Reading the current driver from the git tree I don't see how the PCI
> driver ever sets the ctl register base. It seems to always be set to zero
> which means you can't issue SRST and reset sequences ?

Hi Alan,

Comment in pmac_ide_init_hwif_ports() is highly misleading as this function
returns early only for "normal" IDE PCI devices (pmac_ide_init_hwif_ports()
can be called outside ide-pmac driver through ppc_ide_md).

static int __devinit
pmac_ide_pci_attach(struct pci_dev *pdev, const struct pci_device_id *id)
{
...
	pmif = &pmac_ide[i];
...
	pmif->regbase = (unsigned long) base + 0x2000;
...
	rc = pmac_ide_setup_device(pmif, hwif);
...
}

static int
pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif)
{
...
	pmac_ide_init_hwif_ports(&hwif->hw, pmif->regbase, 0, &hwif->irq);
...
}

void
pmac_ide_init_hwif_ports(hw_regs_t *hw,
			      unsigned long data_port, unsigned long ctrl_port,
			      int *irq)
{
...
	for (ix = 0; ix < MAX_HWIFS; ++ix)
		if (data_port == pmac_ide[ix].regbase)
			break;
---> since pmif->regbase was set earlier ix will be < MAX_HWIFS
	if (ix >= MAX_HWIFS) {
		/* Probably a PCI interface... */
		for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; ++i)
			hw->io_ports[i] = data_port + i - IDE_DATA_OFFSET;
		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
		return;
	}

	for (i = 0; i < 8; ++i)
		hw->io_ports[i] = data_port + i * 0x10;
---> ctl register base will be set here
	hw->io_ports[8] = data_port + 0x160;
...
}

Bart
