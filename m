From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [PATCH] PA-RISC update to 87415
Date: Wed, 3 Nov 2004 14:19:22 -0700
Message-ID: <20041103211922.GA23415@colo.lackof.org>
References: <20041103200059.GC17672@colo.lackof.org> <58cb370e04110312215ee851e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:646 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261878AbUKCVTX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Nov 2004 16:19:23 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e04110312215ee851e4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: matthew@wil.cx, linux-ide@vger.kernel.org

On Wed, Nov 03, 2004 at 09:21:02PM +0100, Bartlomiej Zolnierkiewicz wrote:
> I only wonder about this change:
> 
> > @@ -132,10 +212,6 @@ static void __init init_hwif_ns87415 (id
> >         hwif->autodma = 0;
> >         hwif->selectproc = &ns87415_selectproc;
> > 
> > -       /* Set a good latency timer and cache line size value. */
> > -       (void) pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
> > -       /* FIXME: use pci_set_master() to ensure good latency timer value */
> > -

I don't expect a driver to always blindly write this value since
it affects the max latency other PCI bus guests will see. 64 is a
fairly safe value if you really want to keep that bit of code in.

ide_hwif_setup_dma() calls pci_set_master() if necessary.
pci_set_master() (indirectly via pcibios_set_master() sets
PCI_LATENCY_TIMER to a "reasonable" value.

grundler <506>fgrep pci_set_master drivers/ide/*
drivers/ide/setup-pci.c:                        pci_set_master(dev);

thanks,
grant
