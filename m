From: Sagar Borikar <sagar.borikar@gmail.com>
Subject: Re: [PATCH 2/2] sata_sil: disable DMA engine in ->freeze
Date: Wed, 8 Apr 2009 10:43:31 +0530
Message-ID: <3fb94e50904072213n637525b1w4b032544dcef3618@mail.gmail.com>
References: <20090407232247.GA16086@havoc.gtf.org>
	 <20090407232331.GA16190@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:20739 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbZDHFNc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Apr 2009 01:13:32 -0400
In-Reply-To: <20090407232331.GA16190@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, d.harrison@sutus.com

This patch works for our platform.

Thanks
Sagar

On Wed, Apr 8, 2009 at 4:53 AM, Jeff Garzik <jeff@garzik.org> wrote:
>
> Dustin, please see if these two patches solve your problem?
>
>
> commit a6a2da59f2a4ba834a6e20e2d2a4d030bb9371ea
> Author: Jeff Garzik <jeff@garzik.org>
> Date: =A0 Tue Apr 7 19:18:32 2009 -0400
>
> =A0 =A0[libata] sata_sil: disable DMA engine in sil_freeze()
>
> =A0 =A0We must disable the DMA engine before accessing taskfile regis=
ters.
>
> =A0 =A0Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
>
> diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
> index e67ce8e..896975f 100644
> --- a/drivers/ata/sata_sil.c
> +++ b/drivers/ata/sata_sil.c
> @@ -565,6 +565,19 @@ static void sil_freeze(struct ata_port *ap)
> =A0 =A0 =A0 =A0tmp |=3D SIL_MASK_IDE0_INT << ap->port_no;
> =A0 =A0 =A0 =A0writel(tmp, mmio_base + SIL_SYSCFG);
> =A0 =A0 =A0 =A0readl(mmio_base + SIL_SYSCFG); =A0/* flush */
> +
> + =A0 =A0 =A0 /* Ensure DMA_ENABLE is off.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* This is because the controller will not give us ac=
cess to the
> + =A0 =A0 =A0 =A0* taskfile registers while a DMA is in progress
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 iowrite8(ioread8(ap->ioaddr.bmdma_addr) & ~SIL_DMA_ENAB=
LE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ap->ioaddr.bmdma_addr);
> +
> + =A0 =A0 =A0 /* According to ata_bmdma_stop, an HDMA transition requ=
ires
> + =A0 =A0 =A0 =A0* on PIO cycle. But we can't read a taskfile registe=
r.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 ioread8(ap->ioaddr.bmdma_addr);
> =A0}
>
> =A0static void sil_thaw(struct ata_port *ap)
>
