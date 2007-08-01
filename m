From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] sata_mv: Test patch for Hightpoint RocketRaid 1740/1742
Date: Wed, 1 Aug 2007 16:46:03 +0100
Message-ID: <20070801164603.456f1540@the-village.bc.nu>
References: <20070709143841.133abb71@the-village.bc.nu>
	<46B08F5F.9040500@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57283 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754110AbXHAPiy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 11:38:54 -0400
In-Reply-To: <46B08F5F.9040500@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

On Wed, 01 Aug 2007 09:49:19 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > Underneath all the HPT packaging, PCI identifiers, binary driver modules
> > and stuff you find that ...
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> > 
> > --- drivers/ata/sata_mv.c~	2007-07-09 13:19:57.003052904 +0100
> > +++ drivers/ata/sata_mv.c	2007-07-09 13:19:57.004052752 +0100
> > @@ -573,6 +573,9 @@
> >  	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
> >  	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
> >  	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
> > +	/* RocketRAID 1740/174x have different identifiers */
> > +	{ PCI_VDEVICE(TTI, 0x1740), chip_508x },
> > +	{ PCI_VDEVICE(TTI, 0x1742), chip_508x },
> 
> Is this still a test patch, or can it go upstream?

Upstream
