From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 4/8] SPEAr13xx: Fixup: Move SPEAr1340 SATA platform
 code to system cfg driver
Date: Fri, 24 Jan 2014 21:53:00 +0100
Message-ID: <201401242153.00848.arnd@arndb.de>
References: <cover.1390471111.git.mohit.kumar@st.com>
 <201401231322.54914.arnd@arndb.de> <20140124042959.GC2369@pratyush-vbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140124042959.GC2369@pratyush-vbox>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pratyush Anand <pratyush.anand@st.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mohit KUMAR DCG <Mohit.KUMAR@st.com>, spear-devel <spear-devel@list.st.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, Tejun Heo <tj@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On Friday 24 January 2014, Pratyush Anand wrote:
> On Thu, Jan 23, 2014 at 08:22:54PM +0800, Arnd Bergmann wrote:
> > On Thursday 23 January 2014, Mohit Kumar wrote:
> > 
> > I assume you'd want a phandle pointing to the syscon device in here
> > as well?
> 
> Since there is only one syscon device in the whole DT, so do I really
> need to add phandle? Currently I am using
> syscon_regmap_lookup_by_compatible to find  syscon device.

I'd much rather use syscon_regmap_lookup_by_phandle than
syscon_regmap_lookup_by_compatible, all the time, since this makes
the relationship between the devices explicit.
 
The phandle method also allows you to pass regmap indexes in the
same property, which can be handy if two variants of the chip have
the same registers at a different offset.

> > > +/* SPEAr1340 Registers */
> > > +/* Power Management Registers */
> > > +#define SPEAR1340_PCM_CFG			0x100
> > > +	#define SPEAR1340_PCM_CFG_SATA_POWER_EN	0x800
> > > +#define SPEAR1340_PCM_WKUP_CFG			0x104
> > > +#define SPEAR1340_SWITCH_CTR			0x108
> > > +
> > > +#define SPEAR1340_PERIP1_SW_RST			0x318
> > > +	#define SPEAR1340_PERIP1_SW_RST_SATA	0x1000
> > > +#define SPEAR1340_PERIP2_SW_RST			0x31C
> > > +#define SPEAR1340_PERIP3_SW_RST			0x320
> > > +
> > > +/* PCIE - SATA configuration registers */
> > > +#define SPEAR1340_PCIE_SATA_CFG			0x424
> > > +	/* PCIE CFG MASks */
> > > +	#define SPEAR1340_PCIE_CFG_DEVICE_PRESENT	(1 << 11)
> > > +	#define SPEAR1340_PCIE_CFG_POWERUP_RESET	(1 << 10)
> > > +	#define SPEAR1340_PCIE_CFG_CORE_CLK_EN		(1 << 9)
> > > +	#define SPEAR1340_PCIE_CFG_AUX_CLK_EN		(1 << 8)
> > > +	#define SPEAR1340_SATA_CFG_TX_CLK_EN		(1 << 4)
> > > +	#define SPEAR1340_SATA_CFG_RX_CLK_EN		(1 << 3)
> > > +	#define SPEAR1340_SATA_CFG_POWERUP_RESET	(1 << 2)
> > > +	#define SPEAR1340_SATA_CFG_PM_CLK_EN		(1 << 1)
> > > +	#define SPEAR1340_PCIE_SATA_SEL_PCIE		(0)
> > > +	#define SPEAR1340_PCIE_SATA_SEL_SATA		(1)
> > > +	#define SPEAR1340_PCIE_SATA_CFG_MASK		0xF1F
> > > +	#define SPEAR1340_PCIE_CFG_VAL	(SPEAR1340_PCIE_SATA_SEL_PCIE | \
> > > +			SPEAR1340_PCIE_CFG_AUX_CLK_EN | \
> > > +			SPEAR1340_PCIE_CFG_CORE_CLK_EN | \
> > > +			SPEAR1340_PCIE_CFG_POWERUP_RESET | \
> > > +			SPEAR1340_PCIE_CFG_DEVICE_PRESENT)
> > > +	#define SPEAR1340_SATA_CFG_VAL	(SPEAR1340_PCIE_SATA_SEL_SATA | \
> > > +			SPEAR1340_SATA_CFG_PM_CLK_EN | \
> > > +			SPEAR1340_SATA_CFG_POWERUP_RESET | \
> > > +			SPEAR1340_SATA_CFG_RX_CLK_EN | \
> > > +			SPEAR1340_SATA_CFG_TX_CLK_EN)
> > > +
> > > +#define SPEAR1340_PCIE_MIPHY_CFG		0x428
> > > +	#define SPEAR1340_MIPHY_OSC_BYPASS_EXT		(1 << 31)
> > > +	#define SPEAR1340_MIPHY_CLK_REF_DIV2		(1 << 27)
> > > +	#define SPEAR1340_MIPHY_CLK_REF_DIV4		(2 << 27)
> > > +	#define SPEAR1340_MIPHY_CLK_REF_DIV8		(3 << 27)
> > > +	#define SPEAR1340_MIPHY_PLL_RATIO_TOP(x)	(x << 0)
> > > +	#define SPEAR1340_PCIE_MIPHY_CFG_MASK		0xF80000FF
> > > +	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA \
> > > +			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
> > > +			SPEAR1340_MIPHY_CLK_REF_DIV2 | \
> > > +			SPEAR1340_MIPHY_PLL_RATIO_TOP(60))
> > > +	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK \
> > > +			(SPEAR1340_MIPHY_PLL_RATIO_TOP(120))
> > > +	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE \
> > > +			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
> > > +			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
> > > +
> > > +struct spear13xx_cfg_priv {
> > > +	struct regmap		*misc;
> > > +};
> > > +
> > > +/* SATA device registration */
> > > +static void spear1340_sata_miphy_init(struct spear13xx_cfg_priv *cfgpriv)
> > > +{
> > > +	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCIE_SATA_CFG,
> > > +			SPEAR1340_PCIE_SATA_CFG_MASK, SPEAR1340_SATA_CFG_VAL);
> > > +	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCIE_MIPHY_CFG,
> > > +			SPEAR1340_PCIE_MIPHY_CFG_MASK,
> > > +			SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK);
> > > +	/* Switch on sata power domain */
> > > +	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCM_CFG,
> > > +			SPEAR1340_PCM_CFG_SATA_POWER_EN,
> > > +			SPEAR1340_PCM_CFG_SATA_POWER_EN);
> > > +	msleep(20);
> > > +	/* Disable PCIE SATA Controller reset */
> > > +	regmap_update_bits(cfgpriv->misc, SPEAR1340_PERIP1_SW_RST,
> > > +			SPEAR1340_PERIP1_SW_RST_SATA, 0);
> > > +	msleep(20);
> > > +}
> > 
> > Looking at the actual code now, this very much looks like it ought to
> > be a "phy" driver and get put in drivers/phy/.
> 
> Actually these registers are part of common system configurations
> register space (called as misc space) for SPEAr SOC. So we opted for
> syscon framework.

The use of syscon for this is good, I have no objection to that, and
was suggesting that you create a logical "phy" device that uses the
misc syscon device as a backend.
 
> PHY registers space starts from 0xEB800000, which can be
> programmed for various phy specific functions like power management,
> tx/rx settings, comparator settings etc. In most of the cases phy
> works with default settings, however there are few exceptions for
> which we will be adding a phy driver for further improvement of SPEAr
> drivers.

I see. So while the code you have here could be expressed as a phy driver
by itself, there is another part of the SoC that controls the actual
phy. How about if you add the phy device node to DT, and write a driver
that doesn't actually program the phy registers for now, but does contain
the code that you have posted here. That would give you flexibility for
future extensions and at the same time let you remove all SPEAr specific
code from the actual AHCI driver by using the generic ahci-platform
driver.

	Arnd
