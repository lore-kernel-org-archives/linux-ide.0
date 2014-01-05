From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 2/4] ARM: sunxi: Add ahci-sunxi driver
 for the Allwinner SUNXi SoCs sata
Date: Sun, 5 Jan 2014 12:35:11 +0100
Message-ID: <201401051235.11910.arnd@arndb.de>
References: <1388826878-5602-1-git-send-email-hdegoede@redhat.com> <4502242.kKUgLAVDcb@wuerfel> <52C89CC6.3010409@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: Text/Plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDEKVJM7XAHRBEEHUWLAKGQEBE5FVAI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <52C89CC6.3010409-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Sunday 05 January 2014, Hans de Goede wrote:
> >
> > Also, please send the binding as a separate patch with Cc to
> > the devicetree-discuss mailing list.
> 
> Hmm, this contradicts what others are saying who have requested for
> the binding docs to be part of the same commit as the driver (with
> various other drivers). Note that I've cc-ed devicetree already.

Probably my fault then, I've been away for some time and may misremember
what we discussed. Maybe someone else can clarify.

> >> +static int sunxi_ahci_phy_init(struct device *dev, void __iomem *reg_base)
> >> +{
> >> +	u32 reg_val;
> >> +	int timeout;
> >> +
> >> +	/* This magic is from the original code */
> >> +	writel(0, reg_base + AHCI_RWCR);
> >> +	mdelay(5);
> >
> > This function should probably be in a separate phy driver.  I would
> > very much hope that we can minimize the required code in an AHCI
> > driver and move code from this new file into the ahci-platform
> > driver. The clock, regulator and phy setup can all be optional
> > properties of the generic driver, and then there shouldn't
> > be much left that is sunxi specific.
> 
> Writing a phy driver, and extending ahci-platform to use that
> was my original plan. But the phy really is part of the
> ahci ip-block here, and not a separate ip-block. Its registers
> are smack in the middle of the io-range for the ahci function.

I see. I wonder if the register layout is common with some other
implementation then. If it's part of the AHCI block, it's probably
not an Allwinner invention but comes from whoever implemented the
AHCI.

> Also note that sunxi_ahci_pre_start_engine is rather sunxi
> specific. Needing to put that in a generic ahci_platform driver
> and only activating it for sunxi socs would only serve to
> prove my point that at some point it is simply easier and
> better to write a non generic platform glue driver when dealing
> with exotic ahci ip blocks.
> 
> If we end up putting all sort of if soca do foo else if socb
> do bar, else do nothing magic in ahci_platform.c I think we're
> over generalizing. If something nicely fits as a generic
> platform dev, by all means we should use a generic platform
> driver, but that just won't work cleanly here.

Yes, but there may be some middle ground. I still think it would
be worthwhile to make the clock handling part of the common
ahci (or ahci-platform) driver and reuse that, since it seems
to be needed on a number of implementations. IIRC there is already
some inheritence model in libata that can be used to define
variations of drivers and have common parts done only once.

> Actually I've just completed writing a phy driver for
> the usbphy in the same soc, and a patch to extend ehci-platform
> to take an optional clk and phy. So I completely agree with the
> basic idea, it just does not seem doable cleanly in this case,
> hence my choice to write a separate platform driver. For the
> usb stuff (wip) see:
> https://github.com/jwrdegoede/linux-sunxi/commit/4655dd01936f42d8a75da08a00af439e0a34eaf7
> https://github.com/jwrdegoede/linux-sunxi/commit/bcb674859d015ff9e082829dbd5cf239b8b53d4a

Ah, very nice!

> >> +static int sunxi_ahci_susp(struct device *dev)
> >> +{
> >> +	struct ata_host *host = dev_get_drvdata(dev);
> >> +	struct ahci_host_priv *hpriv = host->private_data;
> >> +	struct sunxi_ahci *ahci = hpriv->plat_data;
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * AHCI spec rev1.1 section 8.3.3:
> >> +	 * Software must disable interrupts prior to requesting a
> >> +	 * transition of the HBA to D3 state.
> >> +	 */
> >> +	sunxi_clrbits(hpriv->mmio + HOST_CTL, HOST_IRQ_EN);
> >> +
> >> +	ret = ata_host_suspend(host, PMSG_SUSPEND);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	sunxi_ahci_disable_clks(ahci);
> >> +
> >> +	return 0;
> >> +}
> >
> > The only thing in here that seems sunxi-specific is the irq disabling
> > part. Can't you do this instead by calling disable_irq() and make
> > the function completely generic?
> 
> The irq disabling part actually is not sunxi specific, ahci_platform.c
> has it too.

Ok. Can this function be shared in some way then, e.g. by exporting the
ahci-platform implementation?

	Arnd
