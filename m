From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 2/4] ARM: sunxi: Add ahci-sunxi driver
 for the Allwinner SUNXi SoCs sata
Date: Sat, 04 Jan 2014 22:39:50 +0100
Message-ID: <4502242.kKUgLAVDcb@wuerfel>
References: <1388826878-5602-1-git-send-email-hdegoede@redhat.com> <1388826878-5602-3-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDEKVJM7XAHRBMH7UGLAKGQECBXKLSQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1388826878-5602-3-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Saturday 04 January 2014 10:14:36 Hans de Goede wrote:
> diff --git a/Documentation/devicetree/bindings/ata/ahci-sunxi.txt b/Documentation/devicetree/bindings/ata/ahci-sunxi.txt
> new file mode 100644
> index 0000000..0792fa5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-sunxi.txt
> @@ -0,0 +1,24 @@
> +Allwinner SUNXI AHCI SATA Controller
> +
> +SATA nodes are defined to describe on-chip Serial ATA controllers.
> +Each SATA controller should have its own node.
> +
> +Required properties:
> +- compatible	: compatible list, contains "allwinner,sun4i-a10-ahci"
> +- reg		: <registers mapping>
> +- interrupts	: <interrupt mapping for AHCI IRQ>
> +- clocks	: clocks for ACHI
> +- clock-names	: clock names for AHCI

The binding needs to specify the required names for the clocks.

> +Optional properties:
> +- pwr-supply	: regulator to control the power supply GPIO
> +
> +Example:
> +	ahci@01c18000 {
> +		compatible = "allwinner,sun4i-a10-ahci";
> +		reg = <0x01c18000 0x1000>;
> +		interrupts = <0 56 1>;
> +		clocks = <&ahb_gates 25>, <&pll6 0>;
> +		clock-names = "ahb_sata", "pll6_sata";

"pll6_sata" doesn't sound particularly generic. The name should
reflect what the clock is used for, not what drives it.

Also, please send the binding as a separate patch with Cc to
the devicetree-discuss mailing list.

> +
> +static int sunxi_ahci_phy_init(struct device *dev, void __iomem *reg_base)
> +{
> +	u32 reg_val;
> +	int timeout;
> +
> +	/* This magic is from the original code */
> +	writel(0, reg_base + AHCI_RWCR);
> +	mdelay(5);

This function should probably be in a separate phy driver. I would
very much hope that we can minimize the required code in an AHCI
driver and move code from this new file into the ahci-platform
driver. The clock, regulator and phy setup can all be optional
properties of the generic driver, and then there shouldn't
be much left that is sunxi specific.

> +static int sunxi_ahci_susp(struct device *dev)
> +{
> +	struct ata_host *host = dev_get_drvdata(dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	struct sunxi_ahci *ahci = hpriv->plat_data;
> +	int ret;
> +
> +	/*
> +	 * AHCI spec rev1.1 section 8.3.3:
> +	 * Software must disable interrupts prior to requesting a
> +	 * transition of the HBA to D3 state.
> +	 */
> +	sunxi_clrbits(hpriv->mmio + HOST_CTL, HOST_IRQ_EN);
> +
> +	ret = ata_host_suspend(host, PMSG_SUSPEND);
> +	if (ret)
> +		return ret;
> +
> +	sunxi_ahci_disable_clks(ahci);
> +
> +	return 0;
> +}

The only thing in here that seems sunxi-specific is the irq disabling
part. Can't you do this instead by calling disable_irq() and make
the function completely generic?

	Arnd
