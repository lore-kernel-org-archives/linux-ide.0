From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] sata_mv: Test patch for Hightpoint RocketRaid 1740/1742
Date: Sat, 1 Sep 2007 15:49:23 +0100
Message-ID: <20070901154923.557fa4ad@the-village.bc.nu>
References: <20070709143841.133abb71@the-village.bc.nu>
	<46B08F5F.9040500@garzik.org>
	<20070801164603.456f1540@the-village.bc.nu>
	<46D96B63.7050302@ans.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39927 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753218AbXIAOlL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Sep 2007 10:41:11 -0400
In-Reply-To: <46D96B63.7050302@ans.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Oledzki <olel@ans.pl>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, akpm@osdl.org

On Sat, 01 Sep 2007 15:38:43 +0200
Krzysztof Oledzki <olel@ans.pl> wrote:

> On 2007-08-01 17:46, Alan Cox wrote:
> > On Wed, 01 Aug 2007 09:49:19 -0400
> > Jeff Garzik <jeff@garzik.org> wrote:
> > 
> >> Alan Cox wrote:
> >>> Underneath all the HPT packaging, PCI identifiers, binary driver modules
> >>> and stuff you find that ...
> >>>
> >>> Signed-off-by: Alan Cox <alan@redhat.com>
> >>>
> >>> --- drivers/ata/sata_mv.c~	2007-07-09 13:19:57.003052904 +0100
> >>> +++ drivers/ata/sata_mv.c	2007-07-09 13:19:57.004052752 +0100
> >>> @@ -573,6 +573,9 @@
> >>>  	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
> >>>  	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
> >>>  	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
> >>> +	/* RocketRAID 1740/174x have different identifiers */
> >>> +	{ PCI_VDEVICE(TTI, 0x1740), chip_508x },
> >>> +	{ PCI_VDEVICE(TTI, 0x1742), chip_508x },
> >> Is this still a test patch, or can it go upstream?
> > 
> > Upstream
> 
> Are you sure that 1740/1742 are 508x (GEN I)? According to these [1] 
> pictures there may be a 6042 chipset (GEN IIe) placed onboard.

The ones I checked and the code used as a reference clearly indicate a
508x. I've had two reports of a TTI 0x23xx ID number which may perhaps be
a 6042 as it didn't appear to work with a 508x driver.

Alan
