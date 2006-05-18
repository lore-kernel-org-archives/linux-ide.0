From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Subject: RE: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
	c pl atform
Date: Thu, 18 May 2006 12:03:50 +0800
Message-ID: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:44786 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1750807AbWEREDz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 May 2006 00:03:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com, Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>, Kumar Gala <galak@kernel.crashing.org>


-----Original Message-----
=46rom: Kumar Gala [mailto:galak@kernel.crashing.org]
Sent: 2006=E5=B9=B45=E6=9C=8817=E6=97=A5 21:28
To: Zang Roy-r61911
Cc: Paul Mackerras; linuxppc-dev list; Alexandre.Bounine@tundra.com; Ya=
ng Xin-Xin-r48390
Subject: Re: [PATCH/2.6.17-rc4 10/10] bugs fix for marvell SATA on powe=
rpc pl atform



On May 17, 2006, at 5:14 AM, Zang Roy-r61911 wrote:

> Fix Marvell SATA driver bugs on PowerPC platform:
> SATA device can't work for the problem on little-endian mode.
> U-Boot can't find SATA device after kernel reboots.
>
> Signed-off-by: Hongjun cheng	<hong-jun.chen@reescale.com>
> Signed-off-by: Roy Zang		<tie-fei.zang@freescale.com>
>
>> From nobody Mon Sep 17 00:00:00 2001
> From: roy zang <tie-fei.zang@freescale.com>
> Date: Tue May 16 15:25:23 2006 +0800
> Subject: [PATCH] Fix bugs on powerpc platform for mv sata driver

This needs to go to Jeff Garzik as SATA driver maintainer.

- kumar

>
>  drivers/scsi/sata_mv.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> d82ac19d259f8487a31105eaf844a93cbd9008e8
> diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
> index d5fdcb9..4166422 100644
> --- a/drivers/scsi/sata_mv.c
> +++ b/drivers/scsi/sata_mv.c
> @@ -1032,6 +1032,9 @@ static inline void mv_crqb_pack_cmd(u16
>  {
>  	*cmdw =3D data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
>  		(last ? CRQB_CMD_LAST : 0);
> +#ifdef CONFIG_PPC
> +	*cmdw =3D cpu_to_le16(*cmdw);
> +#endif
>  }
>
>  /**
> @@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
>  static void mv5_enable_leds(struct mv_host_priv *hpriv, void =20
> __iomem *mmio)
>  {
>  	u32 tmp;
> -
> +#ifndef CONFIG_PPC
>  	writel(0, mmio + MV_GPIO_PORT_CTL);
> +#endif
>
>  	/* FIXME: handle MV_HP_ERRATA_50XXB2 errata */
>
>  	tmp =3D readl(mmio + MV_PCI_EXP_ROM_BAR_CTL);
> +#ifdef CONFIG_PPC
> +	tmp &=3D ~(1 << 0);
> +#else=09
>  	tmp |=3D ~(1 << 0);
> +#endif
>  	writel(tmp, mmio + MV_PCI_EXP_ROM_BAR_CTL);
>  }
>
> --=20
> 1.3.0
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
