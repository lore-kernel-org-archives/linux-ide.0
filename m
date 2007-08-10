From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] hpt366: fix PCI clock detection for HPT374
Date: Fri, 10 Aug 2007 23:54:21 +0200
Message-ID: <200708102354.21897.bzolnier@gmail.com>
References: <200708060006.35511.sshtylyov@ru.mvista.com> <20070810181907.61fd514d@the-village.bc.nu> <46BCA06A.8040609@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:25511 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbXHJV4J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:56:09 -0400
Received: by nf-out-0910.google.com with SMTP id g13so325943nfb
        for <linux-ide@vger.kernel.org>; Fri, 10 Aug 2007 14:56:07 -0700 (PDT)
In-Reply-To: <46BCA06A.8040609@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, rah@bash.sh, linux-ide@vger.kernel.org

On Friday 10 August 2007, Sergei Shtylyov wrote:
> Alan Cox wrote:
> 
> >>>>+		if (chip_type == HPT374 && (PCI_FUNC(dev->devfn) & 1)) {
> >>>>+			struct pci_dev	*dev1 = pci_get_slot(dev->bus,
> >>>>+							     dev->devfn - 1);
> 
> >>>Can be NULL
> 
> >>    Not really. This may not be called if it's NULL -- see hpt374_init_setup().
> >>Maybe worth a comment though...
> 
> >>>>+			unsigned long io_base = pci_resource_start(dev1, 4);
> >>
> >>>Kaboom
> >>
> >>    That was a dud bomb. ;-)
> 
> > What stops a hot unplug of a 374 from causing that to occur. I don't see
> 
>     Pinned as in pci_get_device()? If so, see setup-ide.c:ide_scan_pcibus().
> The IDE core does that for me.

ide_scan_pcibus() is used iff IDE is built-in.

Moreover pci_get_device() holds reference _only_ to the current PCI device
(the reference count to @from PCI device is _always_ decremented).

> > where you have the other pci_dev pinned on a hotplug on a box set to scan
> > the devices in reverse order
> 
>     Function 1 will always be skipped, regardless of the scan order.

Yes, but init_chipset_hpt366() will still try to access Function 1
even if earlier init_setup_hpt374() failed to obtain reference to it.

> > (yes its an extremely obscure case ;))
> 
>     "Security through obscurity". :-)

Not in this case. :-)

Bart
