From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/01] sata_mv: PHY_MODE4 cleanups
Date: Wed, 04 Jun 2008 06:29:48 -0400
Message-ID: <48466E9C.6040606@pobox.com>
References: <483C8328.1030807@rtr.ca> <483C838F.9060208@rtr.ca> <48407B79.4090303@pobox.com> <4841B92A.1050508@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46843 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759657AbYFDK3u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jun 2008 06:29:50 -0400
In-Reply-To: <4841B92A.1050508@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> The handling for PHY_MODE4 was originally just cloned from the
> Marvell proprietary driver (with their blessing).
> But we can do better than that.
> 
> Tidy things up with some judicious mask definitions, to improve 
> maintainability.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> 
> As requested..
> 
> --- old/drivers/ata/sata_mv.c    2008-05-28 12:20:05.000000000 -0400
> +++ linux/drivers/ata/sata_mv.c    2008-05-30 19:36:52.000000000 -0400
> @@ -224,6 +224,11 @@
> 
>     PHY_MODE3        = 0x310,
>     PHY_MODE4        = 0x314,
> +    PHY_MODE4_CFG_MASK    = 0x00000003,    /* phy internal config field */
> +    PHY_MODE4_CFG_VALUE    = 0x00000001,    /* phy internal config 
> field */
> +    PHY_MODE4_RSVD_ZEROS    = 0x5de3fffa,    /* Gen2e always write 
> zeros */
> +    PHY_MODE4_RSVD_ONES    = 0x00000005,    /* Gen2e always write ones */
> +
>     PHY_MODE2        = 0x330,
>     SATA_IFCTL_OFS        = 0x344,
>     SATA_TESTCTL_OFS    = 0x348,
> @@ -2563,17 +2568,16 @@
>         m3 &= ~0x1c;
> 
>     if (fix_phy_mode4) {
> -        u32 m4;
> -
> -        m4 = readl(port_mmio + PHY_MODE4);
> -
> -        /* workaround for errata FEr SATA#10 (part 1) */
> -        m4 = (m4 & ~(1 << 1)) | (1 << 0);
> -
> -        /* enforce bit restrictions on GenIIe devices */
> +        u32 m4 = readl(port_mmio + PHY_MODE4);
> +        /*
> +         * Enforce reserved-bit restrictions on GenIIe devices only.
> +         * For earlier chipsets, force only the internal config field
> +         *  (workaround for errata FEr SATA#10 part 1).
> +         */
>         if (IS_GEN_IIE(hpriv))
> -            m4 = (m4 & ~0x5DE3FFFC) | (1 << 2);
> -
> +            m4 = (m4 & ~PHY_MODE4_RSVD_ZEROS) | PHY_MODE4_RSVD_ONES;
> +        else

applied, thanks


