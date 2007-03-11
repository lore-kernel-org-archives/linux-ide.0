From: "Russell Howe" <rhowe@siksai.co.uk>
Subject: Re: IDE/ATAPI timeouts & lost interrupts on alpha with 2.6.20.2
Date: Sun, 11 Mar 2007 01:29:20 +0000
Message-ID: <20070311012919.GA1517@xiao.rsnet>
References: <20070310225643.GB21407@xiao.rsnet> <200703110102.13652.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youju.siksai.co.uk ([87.127.14.180]:3632 "EHLO
	youju.siksai.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207AbXCKB3l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 20:29:41 -0500
Received: from xiao.siksai.co.uk ([87.127.14.179] ident=rhowe)
	by youju.siksai.co.uk with smtp (Exim 4.50)
	id 1HQCsD-0000yI-2N
	for linux-ide@vger.kernel.org; Sun, 11 Mar 2007 01:29:38 +0000
Content-Disposition: inline
In-Reply-To: <200703110102.13652.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sun, Mar 11, 2007 at 01:02:13AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > [...]
> > CY82C693: IDE controller at PCI slot 0000:00:07.1
> > CY82C693: chipset revision 0
> > CY82C693: not 100% native mode: will probe irqs later
> > CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)
> >     ide0: BM-DMA at 0x9080-0x9087, BIOS settings: hda:pio, hdb:pio
> > PCI: Enabling device: (0000:00:07.2), cmd 47
> > CY82C693: port 0x01f0 already claimed by ide0
> > CY82C693: neither IDE port enabled (BIOS)
> 
> It seems that the generic IDE host driver is loaded first
> (CONFIG_IDE_GENERIC=y/m) and "steals" resources needed by cy82c693.
> 
> Please try again without the generic IDE host driver so the proper
> driver could be used.

OK thanks.. new kernel building as I send this.

Could that be why the cy82c693 driver reports both IDE ports as disabled by
the BIOS, because the generic IDE layer 'stole' them?

... I suppose I'll find out soon enough :)

-- 
Russell Howe       | Why be just another cog in the machine,
rhowe@siksai.co.uk | when you can be the spanner in the works?
