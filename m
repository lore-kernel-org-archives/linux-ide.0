From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: PATCH: Add fixup functionality to the PCI drivers
Date: Fri, 5 Nov 2004 23:13:06 +0100
Message-ID: <200411052313.06968.bzolnier@elka.pw.edu.pl>
References: <1099672842.5564.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:35536 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261229AbUKEWLX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 17:11:23 -0500
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:40793 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S102184AbUKEWLW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Nov 2004 23:11:22 +0100
Received: from chello062179088136.chello.pl ([62.179.88.136]:63405 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S55972AbUKEWIe (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Fri, 5 Nov 2004 23:08:34 +0100
In-Reply-To: <1099672842.5564.56.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Friday 05 November 2004 17:40, Alan Cox wrote:
> Using the ->fixup field that was added we propogate the fixup
> functionality into PCI interfaces. The fixup needs to be in the data
> structure really as interfaces may be hotplugged/unplugged [plugged only
> in base kernel].
> The PCI interfaces stay the same so no driver changes are needed except
> to use the fixup hook.
> 
> diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/drivers/ide/setup-pci.c linux-2.6.10rc1/drivers/ide/setup-pci.c
> --- linux.vanilla-2.6.10rc1/drivers/ide/setup-pci.c	2004-11-05 15:34:46.000000000 +0000
> +++ linux-2.6.10rc1/drivers/ide/setup-pci.c	2004-11-05 16:27:33.000000000 +0000
> @@ -729,14 +729,26 @@
>  	return index;
>  }
>  
> +/**
> + *	probe_pci_hwif_init	-	probe the hwif then allow fixups
> + *	@hwif: interface to probe
> + *	@d: PCI device
> + *
> + *	Perform the generic probe and if it is successful invoke any
> + *	remaining post probe fixup logic in the driver itself.
> + */
> +static void probe_pci_hwif_init(ide_hwif_t *hwif, ide_pci_device_t *d) {
> +	probe_hwif_init_with_fixup(hwif, d->fixup);
> +}

this wrapper is not needed

> @@ -749,13 +761,13 @@
>  	ata_index_t index_list2 = do_ide_setup_pci_device(dev2, d, 0);
>  
>  	if ((index_list.b.low & 0xf0) != 0xf0)
> -		probe_hwif_init(&ide_hwifs[index_list.b.low]);
> +		probe_pci_hwif_init(&ide_hwifs[index_list.b.low], d);
>  	if ((index_list.b.high & 0xf0) != 0xf0)
> -		probe_hwif_init(&ide_hwifs[index_list.b.high]);
> +		probe_pci_hwif_init(&ide_hwifs[index_list.b.high], d);
>  	if ((index_list2.b.low & 0xf0) != 0xf0)
> -		probe_hwif_init(&ide_hwifs[index_list2.b.low]);
> +		probe_pci_hwif_init(&ide_hwifs[index_list2.b.low], d);
>  	if ((index_list2.b.high & 0xf0) != 0xf0)
> -		probe_hwif_init(&ide_hwifs[index_list2.b.high]);
> +		probe_pci_hwif_init(&ide_hwifs[index_list2.b.high], d);
>  
>  	create_proc_ide_interfaces();
>  }

this chunk is not needed
