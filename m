From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.0 build issues
Date: Fri, 28 Nov 2003 19:05:00 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031128080657.D88232C2B6@lists.samba.org>
References: <3FC677B9.C9046973@eyal.emu.id.au>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dp.samba.org ([66.70.73.150]:6027 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262055AbTK1IG6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Nov 2003 03:06:58 -0500
In-reply-to: Your message of "Fri, 28 Nov 2003 09:16:25 +1100."
             <3FC677B9.C9046973@eyal.emu.id.au>
List-Id: linux-ide@vger.kernel.org
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: B.Zolnierkiewicz%elka.pw.edu.pl.linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, mec@shout.net

In message <3FC677B9.C9046973@eyal.emu.id.au> you write:
> *** Warning: "ide_pci_unregister_driver" [drivers/ide/pci/via82cxxx.ko] undefined!
> *** Warning: "ide_pci_register_driver" [drivers/ide/pci/via82cxxx.ko] undefined!
> *** Warning: "ide_setup_pci_device" [drivers/ide/pci/via82cxxx.ko] undefined!
> *** Warning: "ide_pci_register_host_proc" [drivers/ide/pci/via82cxxx.ko] undefined!
> *** Warning: "ide_pci_unregister_driver" [drivers/ide/pci/trm290.ko] undefined
!

Thanks for the report, Eyal!

It's an IDE Makefile problem (sorry Bart!).  You've set CONFIG_IDE=m,
but CONFIG_BLK_DEV_IDEDMA_PCI=y.  That might be OK, but the kernel
only goes into the drivers/ide dir for modules:

drivers/Makefile: obj-$(CONFIG_IDE)		+= ide/

But making this obj-y reveals that setup-pci.c's ide_match_hwif()
needs ide_hwifs, which is in ide.c, so maybe the Kconfig is wrong?

Help!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
