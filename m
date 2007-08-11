From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] hpt366: fix PCI clock detection for HPT374
Date: Sat, 11 Aug 2007 23:31:14 +0200
Message-ID: <200708112331.14270.bzolnier@gmail.com>
References: <200708060006.35511.sshtylyov@ru.mvista.com> <200708111907.29501.bzolnier@gmail.com> <46BDF08C.1070508@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:18783 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757167AbXHKVij (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Aug 2007 17:38:39 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1036100fkz
        for <linux-ide@vger.kernel.org>; Sat, 11 Aug 2007 14:38:37 -0700 (PDT)
In-Reply-To: <46BDF08C.1070508@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Saturday 11 August 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>>>>>>>>+		if (chip_type == HPT374 && (PCI_FUNC(dev->devfn) & 1)) {
> >>>>>>>>>>+			struct pci_dev	*dev1 = pci_get_slot(dev->bus,
> >>>>>>>>>>+							     dev->devfn - 1);
> 
> >>>>>>>>>Can be NULL
> 
> >>>>>>>> Not really. This may not be called if it's NULL -- see hpt374_init_setup().
> >>>>>>>>Maybe worth a comment though...
> 
> >>>>>>>>>>+			unsigned long io_base = pci_resource_start(dev1, 4);
> 
> >>>>>>>>>Kaboom
> 
> >>>>>>>> That was a dud bomb. ;-)
> 
> >>>>>>>What stops a hot unplug of a 374 from causing that to occur. I don't see
> 
> >>>>>>  Pinned as in pci_get_device()? If so, see setup-ide.c:ide_scan_pcibus().
> >>>>>>The IDE core does that for me.
> 
> >>>>>ide_scan_pcibus() is used iff IDE is built-in.
> 
> >>>>>Moreover pci_get_device() holds reference _only_ to the current PCI device
> >>>>>(the reference count to @from PCI device is _always_ decremented).
> 
> >>>>   Indeed... doesn't it look like a buglet in the IDE core?
> 
> >>>It is OK, when ide_scan_pcibus() is not used
> 
> >>    But whan it is used?
> 
> > Then it keeps the reference to PCI device itself by using pci_get_device()...
> 
>     Well, that I know. What I was asking is where the reference is kept after 
> the driver init time -- we're still working with the PCI device, so unplagging 
> it would be wrong thing to do. Actually, we should never call pci_dev_put() 
> since IDE drivers are not unloadable, right?

Now that I look at pci_device_probe() it seems that there should be additional
pci_dev_get() call in ide_scan_pcidev() if d->probe() succeeds.  Care to fix it?

> >>>probing is done by PCI layer
> >>>and it keeps the reference to the PCI device in pci_device_probe().
> 
> >>>>>>>where you have the other pci_dev pinned on a hotplug on a box set to scan
> >>>>>>>the devices in reverse order
> 
> >>>>>>  Function 1 will always be skipped, regardless of the scan order.
> 
> >>>>>Yes, but init_chipset_hpt366() will still try to access Function 1
> 
> >>>>   No!  Re-read the code please: init_chipset_hpt366() won't be called for 
> >>>>function 1 if that one is not detected, and only in this case it does function 
> >>>>0 access to read the saved f_CNT value.
> 
> >>>Argh, thinko on my side.
> 
> >>    Alas, it's your thinko, *again*. ;-)
> 
> >>>Unfortunately patch needs fixing anyway since the new comment is incorrect
> >>>because the reference is kept by hpt366 driver itself - pci_get_slot() in
> >>>init_setup_hpt374() - not the IDE core...
> 
> >>    Actually, init_setup_hpt374() grabs function 1 to register pair of devices 
> >>(in hopes that the callers have already "pinned" function 0), and 
> >>init_chipset_hpt366() "pins" function 0 to read the saved f_CNT.
> 
> > Yep, this would make a nice code comment instead the current one. :)
> 
>    Ugh, will try to reword it... :-|

Thanks.

Bart
