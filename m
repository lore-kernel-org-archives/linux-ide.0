From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] hpt366: fix PCI clock detection for HPT374
Date: Fri, 10 Aug 2007 18:19:07 +0100
Message-ID: <20070810181907.61fd514d@the-village.bc.nu>
References: <200708060006.35511.sshtylyov@ru.mvista.com>
	<20070806202958.25670cc1@the-village.bc.nu>
	<46BC8747.4020307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59864 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751993AbXHJRLt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 13:11:49 -0400
In-Reply-To: <46BC8747.4020307@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, rah@bash.sh, linux-ide@vger.kernel.org

On Fri, 10 Aug 2007 19:41:59 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Alan Cox wrote:
> 
> >>+		if (chip_type == HPT374 && (PCI_FUNC(dev->devfn) & 1)) {
> >>+			struct pci_dev	*dev1 = pci_get_slot(dev->bus,
> >>+							     dev->devfn - 1);
> 
> > Can be NULL
> 
>     Not really. This may not be called if it's NULL -- see hpt374_init_setup().
> Maybe worth a comment though...
> 
> >>+			unsigned long io_base = pci_resource_start(dev1, 4);
> 
> > Kaboom
> 
>     That was a dud bomb. ;-)


What stops a hot unplug of a 374 from causing that to occur. I don't see
where you have the other pci_dev pinned on a hotplug on a box set to scan
the devices in reverse order

(yes its an extremely obscure case ;))
