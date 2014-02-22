From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 07/15] ARM: sunxi: Add support for
 Allwinner SUNXi SoCs sata to ahci_platform
Date: Sat, 22 Feb 2014 15:40:29 -0500
Message-ID: <20140222204029.GB16272@mtj.dyndns.org>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
 <1393084424-31099-8-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDQ2FCEAWYLRBQUWUSMAKGQEIWHKXWA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1393084424-31099-8-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Sat, Feb 22, 2014 at 04:53:36PM +0100, Hans de Goede wrote:
...
> +static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
> +{
> +	u32 reg_val;
> +	int timeout;
> +
> +	/* This magic is from the original code */
> +	writel(0, reg_base + AHCI_RWCR);
> +	mdelay(5);
> +
> +	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(19));
> +	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
> +			 (0x7 << 24),
> +			 (0x5 << 24) | BIT(23) | BIT(18));
> +	sunxi_clrsetbits(reg_base + AHCI_PHYCS1R,
> +			 (0x3 << 16) | (0x1f << 8) | (0x3 << 6),
> +			 (0x2 << 16) | (0x6 << 8) | (0x2 << 6));
> +	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(28) | BIT(15));
> +	sunxi_clrbits(reg_base + AHCI_PHYCS1R, BIT(19));
> +	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
> +			 (0x7 << 20), (0x3 << 20));
> +	sunxi_clrsetbits(reg_base + AHCI_PHYCS2R,
> +			 (0x1f << 5), (0x19 << 5));
> +	mdelay(5);

Please use msleep() instead.  This is called with full process
context.  mdelay() is almost always wrong.  Even if the hardware is
broken enough to require millisec level breather, the better thing to
do would be using threaded handler and using msleep(), not mdelay().

Thanks.

-- 
tejun
