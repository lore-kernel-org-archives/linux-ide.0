From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
Date: Mon, 27 Apr 2015 14:55:41 -0700
Message-ID: <20150427215541.GB32500@ld-irv-0074>
References: <1429757950-28789-1-git-send-email-computersforpeace@gmail.com>
 <3096499.KSW6zqWKEA@wuerfel>
 <20150423164611.GZ32500@ld-irv-0074>
 <2143403.KdtLGyP3SG@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2143403.KdtLGyP3SG@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org

On Fri, Apr 24, 2015 at 09:46:01AM +0200, Arnd Bergmann wrote:
> On Thursday 23 April 2015 09:46:11 Brian Norris wrote:
> > On Thu, Apr 23, 2015 at 09:43:55AM +0200, Arnd Bergmann wrote:
> > > On Wednesday 22 April 2015 19:59:08 Brian Norris wrote:

[snip]
> > So we have a PHY driver, but it doesn't cover everything. Did you want
> > me to write a second PHY driver?? I'm not sure how that'd work...
> 
> I think this is all fine, I mainly wanted to make sure that it had been
> considered and that a decision was made after comparing the options.
> What I'd really like to see is that you put this summary into the
> patch description, because any reviewer will wonder about this.
> You can use a 'Link: https://lkml.org/lkml/2015/3/18/940' tag behind
> your signed-off-by to reference the earlier discussion, in addition to
> the summary.

I summarized most of the conclusions in the cover letter, but I suppose
a plain link to the original thread could do the job too.

> > > > diff --git a/drivers/ata/sata_brcmstb.c b/drivers/ata/sata_brcmstb.c
> > > > new file mode 100644
> > > > index 000000000000..ab8d2261fa96
> > > > --- /dev/null
> > > > +++ b/drivers/ata/sata_brcmstb.c
> > > > @@ -0,0 +1,285 @@
> > > > +/*
> > > > + * Broadcom SATA3 AHCI Controller Driver
> > > 
> > > Is this AHCI or not? Most AHCI drivers are called ahci_*.c, not sata_*.c
> > 
> > It is AHCI. I can rename if necessary...
> > 
> > If you're wondering about the comment there, SATA3 is left to indicate
> > the difference between earlier (non-AHCI) SATA cores that only supported
> > up to Gen2 SATA.
> 
> Up to the ata maintainer of course, but I'd use ahci_brcmstb in the name
> just for consistency with the other drivers.

OK, maybe I'll do that.

> > > > +#ifdef __BIG_ENDIAN
> > > > +#define DATA_ENDIAN			 2 /* AHCI->DDR inbound accesses */
> > > > +#define MMIO_ENDIAN			 2 /* CPU->AHCI outbound accesses */
> > > > +#else
> > > > +#define DATA_ENDIAN			 0
> > > > +#define MMIO_ENDIAN			 0
> > > > +#endif
> > > 
> > > Is this for MIPS or ARM based chips or both?
> > 
> > Both. (This particular iteration of the driver was only tested on
> > ARM, but this particular code has been the same on MIPS.)
> > 
> > > ARM SoCs should never care
> > > about the endianess of the CPU,
> > 
> > Why do you say that? What makes ARM different than MIPS here? If
> > somebody were using ARM BE, then they would (just like in MIPS) need to
> > configure our AHCI core to pretend like it's in LE mode, as that's what
> > libahci.c assumes.
> 
> MIPS is special regarding endianess here, because their CPU cores
> use a power-on setting that defines a fixed endianess, while others
> tend to let software decide at runtime.

I wasn't really considering this. I haven't seen a Broadcom chip where
runtime switching was used. But I haven't played with too many big
endian systems, and all have been MIPS.

> Broadcom usually wires peripherals in a way to match the CPU endianess,
> but this is not necessarily what other MIPS chips do, and on most
> architectures that would be considered a mistake in the hardware
> design, because it breaks device drivers.

I understand this. But this has no relevance to Broadcom IP. It's
probably a good argument for putting good comments, I suppose.

> If you can configure the endianess of the AHCI core through software,
> it would be best to always set it to little-endian unconditionally,
> so you can just use readl() or readl_relaxed() all the time.

We're already doing this in the driver as written, at least for the
three configurations that have been tested (MIPS LE, MIPS BE, ARM LE).
IIUC, you're focusing on ARM BE? This is not in any support plan for
these chips.

But to straighten out what you're saying (correct me if I'm wrong), it
seems like you're saying that on a (theoretical) BCM7xxx ARM in BE mode,
the chip will come up in LE as normal, all busing will be configured for
LE mode, and the BE kernel would only later change CPU endianness. This
would mean that AHCI should be left as it was -- in LE mode -- whereas
this driver submission would actually configure AHCI to do its own
internal swapping, effectively making it BE mode again. And that would
be wrong.

Now I think this has a few problems:

1. ARM BE is not (and won't be) supported on these chips. There has been
no plan and no testing, and I'm sure we'd run into more problems than
those you're suggesting here.

2. To get ARM BE working properly, I'm not confident we'd do (only)
runtime 'setend' endianness switching. We're more likely to get a
bus-level endianness switch and be back with a native-endian driver
again. But then, I'm only speculating (as you are).

> > > > +static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
> > > > +{
> > > > +	void __iomem *phyctrl = priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
> > > > +				(port * SATA_TOP_CTRL_PHY_OFFS);
> > > > +	void __iomem *p;
> > > > +	u32 reg;
> > > > +
> > > > +	/* clear PHY_DEFAULT_POWER_STATE */
> > > > +	p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_1;
> > > > +	reg = __raw_readl(p);
> > > > +	reg &= ~SATA_TOP_CTRL_1_PHY_DEFAULT_POWER_STATE;
> > > > +	__raw_writel(reg, p);
> > > 
> > > Similarly, the use of __raw_readl() is broken on ARM here and won't
> > > work on big-endian kernels. Better use a driver specific helper
> > > function that does the right thing based on the architecture and
> > > endianess. You can use the same conditional as above and do
> > > 
> > > #if defined(__BIG_ENDIAN) && defined(CONFIG_MIPS)
> > > 
> > > static inline brcm_sata_phy_read(struct brcm_ahci_phy *priv, int port int reg)
> > > {
> > > 	void __iomem *phyctrl = priv->regs;
> > > 
> > > 	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
> > > 		return __raw_readl(regs->reg);
> > > 
> > > 	return readl_relaxed(regs->reg);
> > > }
> > 
> > Huh? I'm fine with a driver-specific helper to abstract this out, but
> > why the MIPS fiddling? I'm fairly confident that in *all*
> > configurations, this piece of the IP is wired up to work in native
> > endianness, so it should never be doing an endian swap. The
> > readl_relaxed() you're adding looks like it would just break the
> > (theoretical) ARM BE case.
> > 
> > I understand that you don't like bare __raw_{read,write}l(), but some IP
> > is just wired this way.
> 
> Kevin Cernekee recently introduced the "native-endian" DT property that
> you can use to do runtime detection if that is necessary (i.e. you can't
> tell the endianess from the CPU architecture, and you can't set it either).

I've seen that series. That works fine for IP that's shared on other
systems, and that's what Broadcom has to work with. But I'm not sure
that's worth doing on Broadcom-only IP, which is *always* accessed in
native endianness.

> Using __raw_readl() in driver code just means that the driver is not
> endian-aware at all, and we don't do that any more: new drivers that
> can be used on ARM must be written in a way that works on both
> little-endian and big-endian, and it's a good idea to use endian-safe
> code on other architectures too.
> 
> It's ok to special-case MIPS here when you know that MIPS is weird. If
> you don't want that, use run-time detection instead.

I'm not sure I come to the same conclusions as you. ARM BE is never
tested on these chips, so if you're really stuck on "handling" it
(without testing), I'm almost more inclined to put in compile
dependencies instead. e.g.:

#if defined(CONFIG_ARM) && defined(CONFIG_CPU_BIG_ENDIAN)
#error ARM BE not supported
#endif

Or maybe Kconfig deps instead. Or maybe a 'native-endian' DT property,
and we just fail to probe for !native-endian.

Now, this particular case is pretty trivial, and I'm sure I could just
do what you say (since really, I don't care about ARM BE anyway), but I
guarantee these same questions will come up over and over again on
newly-upstreamed Broadcom drivers, where many of them are intentionally
written for native endianness (because that's how the hardware works for
all supported use cases) and have never been tested (and likely never
will) on big endian ARM. To add extra levels of indirection (either
conditional, or function pointers) to something as low-level as a
register access, and for reasons that look almost 100% theoretical,
seems excessive.

If, however, you really have strong arguments for doing the extra work
(and not testing it, and almost definitely never using it), then I can
try and make sure we don't run across these problems in the future. I
won't be too happy about it, but at least I won't have to waste my time
on these discussions.

Brian
