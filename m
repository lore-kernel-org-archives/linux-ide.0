From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: NS87415 on C3K broken
Date: Thu, 16 Sep 2004 17:25:31 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040916232531.GB24048@colo.lackof.org>
References: <20040916161749.GA17660@colo.lackof.org> <200409170050.15042.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:52190 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S268425AbUIPXZd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Sep 2004 19:25:33 -0400
Content-Disposition: inline
In-Reply-To: <200409170050.15042.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: Grant Grundler <grundler@parisc-linux.org>, parisc-linux@lists.parisc-linux.org, linux-ide@vger.kernel.org

On Fri, Sep 17, 2004 at 12:50:15AM +0200, Bartlomiej Zolnierkiewicz wrote:
> I don't think ide-probe.c changes are the cause of HPMC.
> 
> probe_hwif_init() is only called after PCI device is fully setup,
> see ide_setup_pci_device().

Sorry - you are right. I overlooked the first line of:
void ide_setup_pci_device (struct pci_dev *dev, ide_pci_device_t *d)
{
        ata_index_t index_list = do_ide_setup_pci_device(dev, d, 1);
...

and only saw the probe_hwif_init() calls that follow.
*sigh*.

> ide_setup_pci_controller()
> 	-> ide_pci_enable()
> 		-> pci_enable_device()
> 
> and ide_setup_pci_controller() is called at the beginning
> of ide_setup_pci_device() before ->init_chipset()

Yes - I tracked the pci_enabled_device back to ide_setup_pci_controller().
But I just realized I had another brainfart: ide_setup_pci_controller()
is not ide_setup_pci_device(). I should stop coding late at night...

> Ideally this should be done by host drivers
> but moving this out of setup-pci.c is non-trivial.

Yes - I reached the same conclusion.

> > Anyway, ns87415 driver has more problems. The patch below adds
> > "init_chipset" entry point and init_chipset_ns87415() calls
> > pci_enable_device() and pci_set_master() before the probe.
> > And my C3k still HPMCs. My guess is more of the code from
> > init_hwif_ns87415() needs to be moved to init_chipset_ns87415().
> > And possible call some special suckyio init routines.
> > I won't be able to touch this for a few days.
> > Anyone else on parisc-linux ml want to take a whack at this?
...
> Yep, also if they are to stay please move them to ns87415.c
> because using <linux/ide.h> outside drivers/ide is WRONG.

they? superio_ide_init_iops() or something else?
Willy mentioned that as a TODO item and it's on my list.
But I didn't plan on touching that before the HPMC is resolved
or the PCI resource mgt issues are resolved.

thanks for the correction,
grant
