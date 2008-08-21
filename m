From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 04/18] ide: remove ide_setup_dma()
Date: Thu, 21 Aug 2008 21:16:11 +0400
Message-ID: <48ADA2DB.3060306@ru.mvista.com>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain> <20080620213350.13202.73557.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:61730 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751792AbYHURP5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Aug 2008 13:15:57 -0400
In-Reply-To: <20080620213350.13202.73557.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Export sff_dma_ops and then remove ide_setup_dma().

> There should be no functional changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/arm/palm_bk3710.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/ide/arm/palm_bk3710.c
> +++ b/drivers/ide/arm/palm_bk3710.c
> @@ -318,15 +318,14 @@ static u8 __devinit palm_bk3710_cable_de
>  static int __devinit palm_bk3710_init_dma(ide_hwif_t *hwif,
>  					  const struct ide_port_info *d)
>  {
> -	unsigned long base =3D
> -		hwif->io_ports.data_addr - IDE_PALM_ATA_PRI_REG_OFFSET;
> -
>  	printk(KERN_INFO "    %s: MMIO-DMA\n", hwif->name);
> =20
>  	if (ide_allocate_dma_engine(hwif))
>  		return -1;
> =20
> -	ide_setup_dma(hwif, base);
> +	hwif->dma_base =3D hwif->io_ports.data_addr - IDE_PALM_ATA_PRI_REG_=
OFFSET;
> +
> +	hwif->dma_ops =3D &sff_dma_ops;
> =20
>  	return 0;
>  }

    Unfortunately, this patch broke this driver:

drivers/ide/arm/palm_bk3710.c:327: error: =91sff_dma_ops=92 undeclared =
(first use=20
in this function). The declatation of sff_dma_ops should've been surrou=
nded by:

#ifdef CONFIG_BLK_DEV_IDEDMA_SFF

not by:

#ifdef CONFIG_BLK_DEV_IDEDMA_PCI

the same as its definition is in ide-dma.c...

MBR, Sergei
