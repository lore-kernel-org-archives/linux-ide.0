From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 13/13 DONOTMERGE] ata: ahci_sunxi: remove
 PHY code
Date: Thu, 30 Aug 2018 22:27:49 +0200
Message-ID: <33b1bd21-7bad-2ab9-0606-97d416789066@redhat.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-14-clabbe.montjoie@gmail.com>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORBSFGUHOAKGQE6EHLVRA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180830190120.722-14-clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

HI,

On 30-08-18 21:01, Corentin Labbe wrote:
> Since PHY code is now handled by sun4i-a10-sata-phy, the code in
> ahci_sunxi is useless, remove it.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/ata/ahci_sunxi.c | 93 ------------------------------------------------
>   1 file changed, 93 deletions(-)
> 
> diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
> index b8cf3a1be80b..af17f8ce65b2 100644
> --- a/drivers/ata/ahci_sunxi.c
> +++ b/drivers/ata/ahci_sunxi.c
> @@ -58,15 +58,6 @@ MODULE_PARM_DESC(enable_pmp,
>   #define AHCI_P0PHYCR	0x0178
>   #define AHCI_P0PHYSR	0x017c
>   
> -static void sunxi_clrbits(void __iomem *reg, u32 clr_val)
> -{
> -	u32 reg_val;
> -
> -	reg_val = readl(reg);
> -	reg_val &= ~(clr_val);
> -	writel(reg_val, reg);
> -}
> -
>   static void sunxi_setbits(void __iomem *reg, u32 set_val)
>   {
>   	u32 reg_val;
> @@ -86,81 +77,6 @@ static void sunxi_clrsetbits(void __iomem *reg, u32 clr_val, u32 set_val)
>   	writel(reg_val, reg);
>   }
>   
> -static u32 sunxi_getbits(void __iomem *reg, u8 mask, u8 shift)
> -{
> -	return (readl(reg) >> shift) & mask;
> -}
> -
> -static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
> -{
> -	u32 reg_val;
> -	int timeout;
> -
> -	/*
> -	 * When using the new binding, the presence of a sata port node
> -	 * means that PHY is handled by the PHY driver.
> -	 * */
> -	if (of_get_child_count(dev->of_node)) {
> -		dev_info(dev, "Bypassing PHY init\n");
> -		return 0;
> -	}
> -
> -	/* This magic is from the original code */
> -	writel(0, reg_base + AHCI_RWCR);
> -	msleep(5);
> -
> -	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(19));
> -	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
> -			 (0x7 << 24),
> -			 (0x5 << 24) | BIT(23) | BIT(18));
> -	sunxi_clrsetbits(reg_base + AHCI_PHYCS1R,
> -			 (0x3 << 16) | (0x1f << 8) | (0x3 << 6),
> -			 (0x2 << 16) | (0x6 << 8) | (0x2 << 6));
> -	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(28) | BIT(15));
> -	sunxi_clrbits(reg_base + AHCI_PHYCS1R, BIT(19));
> -	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
> -			 (0x7 << 20), (0x3 << 20));
> -	sunxi_clrsetbits(reg_base + AHCI_PHYCS2R,
> -			 (0x1f << 5), (0x19 << 5));
> -	msleep(5);
> -
> -	sunxi_setbits(reg_base + AHCI_PHYCS0R, (0x1 << 19));
> -
> -	timeout = 250; /* Power up takes aprox 50 us */
> -	do {
> -		reg_val = sunxi_getbits(reg_base + AHCI_PHYCS0R, 0x7, 28);
> -		if (reg_val == 0x02)
> -			break;
> -
> -		if (--timeout == 0) {
> -			dev_err(dev, "PHY power up failed.\n");
> -			return -EIO;
> -		}
> -		udelay(1);
> -	} while (1);
> -
> -	sunxi_setbits(reg_base + AHCI_PHYCS2R, (0x1 << 24));
> -
> -	timeout = 100; /* Calibration takes aprox 10 us */
> -	do {
> -		reg_val = sunxi_getbits(reg_base + AHCI_PHYCS2R, 0x1, 24);
> -		if (reg_val == 0x00)
> -			break;
> -
> -		if (--timeout == 0) {
> -			dev_err(dev, "PHY calibration failed.\n");
> -			return -EIO;
> -		}
> -		udelay(1);
> -	} while (1);
> -
> -	msleep(15);
> -
> -	writel(0x7, reg_base + AHCI_RWCR);
> -
> -	return 0;
> -}
> -
>   static void ahci_sunxi_start_engine(struct ata_port *ap)
>   {
>   	void __iomem *port_mmio = ahci_port_base(ap);
> @@ -186,7 +102,6 @@ static struct scsi_host_template ahci_platform_sht = {
>   
>   static int ahci_sunxi_probe(struct platform_device *pdev)
>   {
> -	struct device *dev = &pdev->dev;
>   	struct ahci_host_priv *hpriv;
>   	int rc;
>   
> @@ -200,10 +115,6 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
>   	if (rc)
>   		return rc;
>   
> -	rc = ahci_sunxi_phy_init(dev, hpriv->mmio);
> -	if (rc)
> -		goto disable_resources;
> -
>   	hpriv->flags = AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
>   		       AHCI_HFLAG_YES_NCQ;
>   
> @@ -238,10 +149,6 @@ static int ahci_sunxi_resume(struct device *dev)
>   	if (rc)
>   		return rc;
>   
> -	rc = ahci_sunxi_phy_init(dev, hpriv->mmio);
> -	if (rc)
> -		goto disable_resources;
> -
>   	rc = ahci_platform_resume_host(dev);
>   	if (rc)
>   		goto disable_resources;
> 

After this change ahci_sunxi_resume() is the same as ahci_platform_resume,
so you can drop the entire function and directly refer to
ahci_platform_resume in ahci_sunxi_pm_ops.

Regards,

Hans
