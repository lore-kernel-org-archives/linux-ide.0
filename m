From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/03] sata_mv: PHY_MODEx errata fixes
Date: Fri, 30 May 2008 18:11:05 -0400
Message-ID: <48407B79.4090303@pobox.com>
References: <483C8328.1030807@rtr.ca> <483C838F.9060208@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44911 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbYE3WLI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 May 2008 18:11:08 -0400
In-Reply-To: <483C838F.9060208@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Fix and update the errata handling for the PHY_MODEx registers.
> This improves receiver noise tolerance, among other things.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> --- old/drivers/ata/sata_mv.c    2008-05-27 11:53:01.000000000 -0400
> +++ linux/drivers/ata/sata_mv.c    2008-05-27 12:01:25.000000000 -0400
> @@ -2546,7 +2546,7 @@
>         hp_flags & (MV_HP_ERRATA_60X1B2 | MV_HP_ERRATA_60X1C0);
>     int fix_phy_mode4 =
>         hp_flags & (MV_HP_ERRATA_60X1B2 | MV_HP_ERRATA_60X1C0);
> -    u32 m2, tmp;
> +    u32 m2, m3;
> 
>     if (fix_phy_mode2) {
>         m2 = readl(port_mmio + PHY_MODE2);
> @@ -2563,27 +2563,27 @@
>         udelay(200);
>     }
> 
> -    /* who knows what this magic does */
> -    tmp = readl(port_mmio + PHY_MODE3);
> -    tmp &= ~0x7F800000;
> -    tmp |= 0x2A800000;
> -    writel(tmp, port_mmio + PHY_MODE3);
> +    /*
> +     * Gen-II/IIe PHY_MODE3 errata RM#2:
> +     * Achieves better receiver noise performance than the h/w default:
> +     */
> +    m3 = readl(port_mmio + PHY_MODE3);
> +    m3 = (m3 & 0x1f) | (0x5555601 << 5);
> +    writel(m3, port_mmio + PHY_MODE3);
> 
>     if (fix_phy_mode4) {
>         u32 m4;
> 
>         m4 = readl(port_mmio + PHY_MODE4);
> 
> -        if (hp_flags & MV_HP_ERRATA_60X1B2)
> -            tmp = readl(port_mmio + PHY_MODE3);
> -
>         /* workaround for errata FEr SATA#10 (part 1) */
>         m4 = (m4 & ~(1 << 1)) | (1 << 0);
> 
> -        writel(m4, port_mmio + PHY_MODE4);
> +        /* enforce bit restrictions on GenIIe devices */
> +        if (IS_GEN_IIE(hpriv))
> +            m4 = (m4 & ~0x5DE3FFFC) | (1 << 2);

can this magic number become a named constant?  do we know the bits, can 
they be broken out and enumerated?


