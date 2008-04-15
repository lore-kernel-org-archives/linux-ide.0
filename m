From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: make ide_pci_check_iomem() actually work
Date: Tue, 15 Apr 2008 22:45:49 +0200
Message-ID: <200804152245.49554.bzolnier@gmail.com>
References: <200804072027.17520.sshtylyov@ru.mvista.com> <47FB6747.2050301@ru.mvista.com> <200804092034.32063.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:30303 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765603AbYDOVTt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 17:19:49 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2140250fgb.17
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2008 14:19:48 -0700 (PDT)
In-Reply-To: <200804092034.32063.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, Kou Ishizaki <kou.ishizaki@toshiba.co.jp>, Akira Iguchi <akira2.iguchi@toshiba.co.jp>

On Wednesday 09 April 2008, Bartlomiej Zolnierkiewicz wrote:
> 
> [ added Akira & Kou to cc: ]
> 
> On Tuesday 08 April 2008, Sergei Shtylyov wrote:
> > Hi, I just wrote:
> > 
> > >>> This function didn't actually check if a given BAR is in I/O space 
> > >>> because of
> > >>> using the bogus PCI_BASE_ADDRESS_IO_MASK (which equals ~3) to test 
> > >>> the resource
> > >>> flags instead of IORESOURCE_IO -- fix this, make ide_hwif_configure() 
> > >>> check the
> > >>> results failing if necessary, and move the printk() call to the 
> > >>> failure path.
> > 
> > >> This change is OK in itself but I worry that ide_pci_check_iomem() may 
> > >> now
> > >> return "false" errors (bogus PCI_BASE_ADDRESS_IO_MASK check resulted 
> > >> in MEM
> > >> resources always surviving ide_pci_check_iomem() calls before the fix) 
> > >> for
> > >> some host drivers (siimage, scc_pata...) resulting in failed 
> > >> initialization.
> > 
> > >    The SiI chips do have normal I/O resources at BAR0..BAR3. As for 
> > > scc_pata, the control should not even get there because BAR0..BAR3 are 
> > > *not* IDE command/control block bases on this chip (BAR0/1 are 
> > > control/DMA bases if you look into setup_mmio_scc()) but they are 
> > > treated as such by the code immediately following ide_pci_check_iomem() 
> > > calls in ide_hwif_configure(), i.e. we might have an error here. The 
> > > same can be said about the PowerMAC driver which has all its MMIO 
> > > registers at BAR0.
> > 
> > >> How's about removing this dead/broken function instead for now?
> > 
> > >    If we indeed have a MMIO problem here, it's not in this function but 
> > > in its callers.
> > 
> >      Looks like we actually have this problem with scc_pata -- it calls 
> > ide_setup_pci_device() which should lead to calling ide_hwif_configure(). But 
> > this is broken since this call chain expects a normal PCI IDE controller with 
> > BAR0..BAR3 either non-existant or being primary/secondary port bases in I/O space.
> 
> Yep, scc_pata needs fixing before your patch can be applied.

[...]

Sergei, I applied your patch just after scc_pata's one.

Thanks,
Bart
