From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: make ide_pci_check_iomem() actually work
Date: Wed, 9 Apr 2008 20:34:31 +0200
Message-ID: <200804092034.32063.bzolnier@gmail.com>
References: <200804072027.17520.sshtylyov@ru.mvista.com> <47FB5ADF.20608@ru.mvista.com> <47FB6747.2050301@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:49187 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbYDISi2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Apr 2008 14:38:28 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3699702mue.5
        for <linux-ide@vger.kernel.org>; Wed, 09 Apr 2008 11:38:24 -0700 (PDT)
In-Reply-To: <47FB6747.2050301@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, Kou Ishizaki <kou.ishizaki@toshiba.co.jp>, Akira Iguchi <akira2.iguchi@toshiba.co.jp>


[ added Akira & Kou to cc: ]

On Tuesday 08 April 2008, Sergei Shtylyov wrote:
> Hi, I just wrote:
> 
> >>> This function didn't actually check if a given BAR is in I/O space 
> >>> because of
> >>> using the bogus PCI_BASE_ADDRESS_IO_MASK (which equals ~3) to test 
> >>> the resource
> >>> flags instead of IORESOURCE_IO -- fix this, make ide_hwif_configure() 
> >>> check the
> >>> results failing if necessary, and move the printk() call to the 
> >>> failure path.
> 
> >> This change is OK in itself but I worry that ide_pci_check_iomem() may 
> >> now
> >> return "false" errors (bogus PCI_BASE_ADDRESS_IO_MASK check resulted 
> >> in MEM
> >> resources always surviving ide_pci_check_iomem() calls before the fix) 
> >> for
> >> some host drivers (siimage, scc_pata...) resulting in failed 
> >> initialization.
> 
> >    The SiI chips do have normal I/O resources at BAR0..BAR3. As for 
> > scc_pata, the control should not even get there because BAR0..BAR3 are 
> > *not* IDE command/control block bases on this chip (BAR0/1 are 
> > control/DMA bases if you look into setup_mmio_scc()) but they are 
> > treated as such by the code immediately following ide_pci_check_iomem() 
> > calls in ide_hwif_configure(), i.e. we might have an error here. The 
> > same can be said about the PowerMAC driver which has all its MMIO 
> > registers at BAR0.
> 
> >> How's about removing this dead/broken function instead for now?
> 
> >    If we indeed have a MMIO problem here, it's not in this function but 
> > in its callers.
> 
>      Looks like we actually have this problem with scc_pata -- it calls 
> ide_setup_pci_device() which should lead to calling ide_hwif_configure(). But 
> this is broken since this call chain expects a normal PCI IDE controller with 
> BAR0..BAR3 either non-existant or being primary/secondary port bases in I/O space.

Yep, scc_pata needs fixing before your patch can be applied.

Looks like it just needs to do all the needed setup itself in init_setup_scc()
instead of calling ide_setup_pci_device() [ similarly to how cs5520 host driver
handles this in cs5520.c::cs5520_init_one() ].

PS it would be also nice to call pci_enable_device() before setup_mmio_scc()
   (which accesses PCI BARs, calls pci_set_master() etc.) while we are at it
   (driver seems to work fine without it ATM but it may break in future).

Thanks,
Bart
