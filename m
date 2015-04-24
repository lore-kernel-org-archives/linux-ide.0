From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
Date: Fri, 24 Apr 2015 09:46:01 +0200
Message-ID: <2143403.KdtLGyP3SG@wuerfel>
References: <1429757950-28789-1-git-send-email-computersforpeace@gmail.com> <3096499.KSW6zqWKEA@wuerfel> <20150423164611.GZ32500@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150423164611.GZ32500@ld-irv-0074>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org

On Thursday 23 April 2015 09:46:11 Brian Norris wrote:
> Hi Arnd,
> 
> On Thu, Apr 23, 2015 at 09:43:55AM +0200, Arnd Bergmann wrote:
> > On Wednesday 22 April 2015 19:59:08 Brian Norris wrote:
> > > Pretty straightforward driver, using the nice library-ization of the
> > > generic ahci_platform driver.
> > > 
> > > Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> > 
> > There is an alternative way to do this, by writing a separate phy driver
> > for drivers/phy and using the generic ahci-platform driver. Have you
> > considered that as well? I don't know which approach works better here,
> > but in general we should try to have the generic driver handle as many
> > chips as possible.
> 
> Did you read v1 [1]? There was discussion all over the place, with each
> person recommending their own favorite Right Way. It was suggested in
> various ways that code be moved into drivers/ata/ or drivers/phy/ at
> various points. In the end, I couldn't follow all suggestions and
> instead came up with this:
> 
> 1. SATA_TOP_CTRL deals with AHCI-related registers and some high-level
> PHY bits (power on or off the PHY).
> 2. There is another discrete bit of hardware that handles analog aspects
> of the PHY
> 3. The device tree should describe hardware, not how software wants to
> use it
> 4. Software should avoid sharing register ranges
> 
> So, this suggested we should have two DT nodes; one for #1 and one for
> #2. It seemed natural that because #1 modifies the AHCI core (e.g., the
> endianness of it), that it belongs in a 'SATA' driver. So I use
> libahci_platform instead of using the generic driver. The bits from #2
> go in drivers/phy/.
> 
> So we have a PHY driver, but it doesn't cover everything. Did you want
> me to write a second PHY driver?? I'm not sure how that'd work...

I think this is all fine, I mainly wanted to make sure that it had been
considered and that a decision was made after comparing the options.
What I'd really like to see is that you put this summary into the
patch description, because any reviewer will wonder about this.
You can use a 'Link: https://lkml.org/lkml/2015/3/18/940' tag behind
your signed-off-by to reference the earlier discussion, in addition to
the summary.

> > > diff --git a/drivers/ata/sata_brcmstb.c b/drivers/ata/sata_brcmstb.c
> > > new file mode 100644
> > > index 000000000000..ab8d2261fa96
> > > --- /dev/null
> > > +++ b/drivers/ata/sata_brcmstb.c
> > > @@ -0,0 +1,285 @@
> > > +/*
> > > + * Broadcom SATA3 AHCI Controller Driver
> > 
> > Is this AHCI or not? Most AHCI drivers are called ahci_*.c, not sata_*.c
> 
> It is AHCI. I can rename if necessary...
> 
> If you're wondering about the comment there, SATA3 is left to indicate
> the difference between earlier (non-AHCI) SATA cores that only supported
> up to Gen2 SATA.

Up to the ata maintainer of course, but I'd use ahci_brcmstb in the name
just for consistency with the other drivers.

> > > +#ifdef __BIG_ENDIAN
> > > +#define DATA_ENDIAN			 2 /* AHCI->DDR inbound accesses */
> > > +#define MMIO_ENDIAN			 2 /* CPU->AHCI outbound accesses */
> > > +#else
> > > +#define DATA_ENDIAN			 0
> > > +#define MMIO_ENDIAN			 0
> > > +#endif
> > 
> > Is this for MIPS or ARM based chips or both?
> 
> Both. (This particular iteration of the driver was only tested on
> ARM, but this particular code has been the same on MIPS.)
> 
> > ARM SoCs should never care
> > about the endianess of the CPU,
> 
> Why do you say that? What makes ARM different than MIPS here? If
> somebody were using ARM BE, then they would (just like in MIPS) need to
> configure our AHCI core to pretend like it's in LE mode, as that's what
> libahci.c assumes.

MIPS is special regarding endianess here, because their CPU cores
use a power-on setting that defines a fixed endianess, while others
tend to let software decide at runtime.

Broadcom usually wires peripherals in a way to match the CPU endianess,
but this is not necessarily what other MIPS chips do, and on most
architectures that would be considered a mistake in the hardware
design, because it breaks device drivers.

If you can configure the endianess of the AHCI core through software,
it would be best to always set it to little-endian unconditionally,
so you can just use readl() or readl_relaxed() all the time.

> > > +static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
> > > +{
> > > +	void __iomem *phyctrl = priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
> > > +				(port * SATA_TOP_CTRL_PHY_OFFS);
> > > +	void __iomem *p;
> > > +	u32 reg;
> > > +
> > > +	/* clear PHY_DEFAULT_POWER_STATE */
> > > +	p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_1;
> > > +	reg = __raw_readl(p);
> > > +	reg &= ~SATA_TOP_CTRL_1_PHY_DEFAULT_POWER_STATE;
> > > +	__raw_writel(reg, p);
> > 
> > Similarly, the use of __raw_readl() is broken on ARM here and won't
> > work on big-endian kernels. Better use a driver specific helper
> > function that does the right thing based on the architecture and
> > endianess. You can use the same conditional as above and do
> > 
> > #if defined(__BIG_ENDIAN) && defined(CONFIG_MIPS)
> > 
> > static inline brcm_sata_phy_read(struct brcm_ahci_phy *priv, int port int reg)
> > {
> > 	void __iomem *phyctrl = priv->regs;
> > 
> > 	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
> > 		return __raw_readl(regs->reg);
> > 
> > 	return readl_relaxed(regs->reg);
> > }
> 
> Huh? I'm fine with a driver-specific helper to abstract this out, but
> why the MIPS fiddling? I'm fairly confident that in *all*
> configurations, this piece of the IP is wired up to work in native
> endianness, so it should never be doing an endian swap. The
> readl_relaxed() you're adding looks like it would just break the
> (theoretical) ARM BE case.
> 
> I understand that you don't like bare __raw_{read,write}l(), but some IP
> is just wired this way.

Kevin Cernekee recently introduced the "native-endian" DT property that
you can use to do runtime detection if that is necessary (i.e. you can't
tell the endianess from the CPU architecture, and you can't set it either).

Using __raw_readl() in driver code just means that the driver is not
endian-aware at all, and we don't do that any more: new drivers that
can be used on ARM must be written in a way that works on both
little-endian and big-endian, and it's a good idea to use endian-safe
code on other architectures too.

It's ok to special-case MIPS here when you know that MIPS is weird. If
you don't want that, use run-time detection instead.

> > > +static const struct of_device_id ahci_of_match[] = {
> > > +	{.compatible = "brcm,sata3-ahci"},
> > > +	{},
> > 
> > This sounds awefully generic. Can you guarantee that no part of Broadcom
> > has produced another ahci-like SATA3 controller in the past, or will
> > have one in the future?
> 
> I know this controller is used by several chips across Broadcom, though
> I can't guarantee there are not others at the moment. I can look into
> that.

Ok.

> > If not, please be more specific here, and use the internal specifier for
> > this version of the IP block. If you can't find out what that is, use the
> > identifier for the oldest chip you know that has it.
> 
> The binding documentation already notes "brcm,bcm7445-ahci", but we just
> don't bind against it here yet, since that hasn't been necessary. I
> suppose I can include the revision number, though; I forgot this block
> had one. (EDIT: in checking two random chips, I see that two cores both
> say v0.1 but have slightly different register layouts. Chip guys suck
> sometimes. So I'll stick to chip-based matching instead.)

Ok, I missed the part in the binding. In principle it's ok like you do
then, but using "brcm,bcm7445-ahci" (or whichever one) as the "most generic"
string is probably better, because of the PHY registers here that might
not be present (or might be incompatible) in a future Broadcom chip.

	Arnd
