From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Add fixup functionality to the PCI drivers
Date: Fri, 05 Nov 2004 23:29:09 +0000
Message-ID: <1099697347.5630.78.camel@localhost.localdomain>
References: <1099672842.5564.56.camel@localhost.localdomain>
	 <200411052313.06968.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:35269 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261284AbUKFAcD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 19:32:03 -0500
In-Reply-To: <200411052313.06968.bzolnier@elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Gwe, 2004-11-05 at 22:13, Bartlomiej Zolnierkiewicz wrote:
> > + *	Perform the generic probe and if it is successful invoke any
> > + *	remaining post probe fixup logic in the driver itself.
> > + */
> > +static void probe_pci_hwif_init(ide_hwif_t *hwif, ide_pci_device_t *d) {
> > +	probe_hwif_init_with_fixup(hwif, d->fixup);
> > +}
> 
> this wrapper is not needed

True

> > @@ -749,13 +761,13 @@
> >  	ata_index_t index_list2 = do_ide_setup_pci_device(dev2, d, 0);
> >  
> >  	if ((index_list.b.low & 0xf0) != 0xf0)
> > -		probe_hwif_init(&ide_hwifs[index_list.b.low]);
> > +		probe_pci_hwif_init(&ide_hwifs[index_list.b.low], d);
> >  	if ((index_list.b.high & 0xf0) != 0xf0)
> > -		probe_hwif_init(&ide_hwifs[index_list.b.high]);
> > +		probe_pci_hwif_init(&ide_hwifs[index_list.b.high], d);
> >  	if ((index_list2.b.low & 0xf0) != 0xf0)
> > -		probe_hwif_init(&ide_hwifs[index_list2.b.low]);
> > +		probe_pci_hwif_init(&ide_hwifs[index_list2.b.low], d);
> >  	if ((index_list2.b.high & 0xf0) != 0xf0)
> > -		probe_hwif_init(&ide_hwifs[index_list2.b.high]);
> > +		probe_pci_hwif_init(&ide_hwifs[index_list2.b.high], d);
> >  
> >  	create_proc_ide_interfaces();
> >  }
> 
> this chunk is not needed

Disagree. Look more carefully - we always need to pass d so we can pass
d->fixup

