From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: PATCH: Add fixup functionality to the PCI drivers
Date: Sat, 6 Nov 2004 01:44:13 +0100
Message-ID: <200411060144.13024.bzolnier@elka.pw.edu.pl>
References: <1099672842.5564.56.camel@localhost.localdomain> <200411052313.06968.bzolnier@elka.pw.edu.pl> <1099697347.5630.78.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:14310 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261289AbUKFAlf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 19:41:35 -0500
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:42913 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S101532AbUKFAle (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Nov 2004 01:41:34 +0100
Received: from chello062179088136.chello.pl ([62.179.88.136]:65165 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S56283AbUKFAjj (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Sat, 6 Nov 2004 01:39:39 +0100
In-Reply-To: <1099697347.5630.78.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Saturday 06 November 2004 00:29, Alan Cox wrote:
> On Gwe, 2004-11-05 at 22:13, Bartlomiej Zolnierkiewicz wrote:
> > > + *	Perform the generic probe and if it is successful invoke any
> > > + *	remaining post probe fixup logic in the driver itself.
> > > + */
> > > +static void probe_pci_hwif_init(ide_hwif_t *hwif, ide_pci_device_t *d) {
> > > +	probe_hwif_init_with_fixup(hwif, d->fixup);
> > > +}
> > 
> > this wrapper is not needed
> 
> True
> 
> > > @@ -749,13 +761,13 @@
> > >  	ata_index_t index_list2 = do_ide_setup_pci_device(dev2, d, 0);
> > >  
> > >  	if ((index_list.b.low & 0xf0) != 0xf0)
> > > -		probe_hwif_init(&ide_hwifs[index_list.b.low]);
> > > +		probe_pci_hwif_init(&ide_hwifs[index_list.b.low], d);
> > >  	if ((index_list.b.high & 0xf0) != 0xf0)
> > > -		probe_hwif_init(&ide_hwifs[index_list.b.high]);
> > > +		probe_pci_hwif_init(&ide_hwifs[index_list.b.high], d);
> > >  	if ((index_list2.b.low & 0xf0) != 0xf0)
> > > -		probe_hwif_init(&ide_hwifs[index_list2.b.low]);
> > > +		probe_pci_hwif_init(&ide_hwifs[index_list2.b.low], d);
> > >  	if ((index_list2.b.high & 0xf0) != 0xf0)
> > > -		probe_hwif_init(&ide_hwifs[index_list2.b.high]);
> > > +		probe_pci_hwif_init(&ide_hwifs[index_list2.b.high], d);
> > >  
> > >  	create_proc_ide_interfaces();
> > >  }
> > 
> > this chunk is not needed
> 
> Disagree. Look more carefully - we always need to pass d so we can pass
> d->fixup

siimage is the only user of d->fixup right now,
it doesn't use ide_setup_pci_devices()
