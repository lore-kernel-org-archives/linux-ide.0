From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: Re: [v4 02/10] ata: ahci_brcmstb: add quirk for broken ncq
Date: Tue, 17 Nov 2015 14:31:48 +0900
Message-ID: <9F5DD1EA-4BBE-445A-AF44-9F110E0B664B@gmail.com>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com> <1446213684-2625-3-git-send-email-jaedon.shin@gmail.com> <20151117021603.GW8456@google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3111\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20151117021603.GW8456@google.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Brian Norris <computersforpeace@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Brian,

> On Nov 17, 2015, at 11:16 AM, Brian Norris <computersforpeace@gmail.com> wrote:
> 
> Hi,
> 
> On Fri, Oct 30, 2015 at 11:01:16PM +0900, Jaedon Shin wrote:
>> Add quirk for broken ncq. Some chipsets (eg. BCM7349A0, BCM7445A0,
>> BCM7445B0, and all 40nm chipsets including BCM7425) need a workaround
>> disabling NCQ.
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
>> drivers/ata/ahci_brcmstb.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 46 insertions(+)
>> 
>> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
>> index 73e3b0b2a3c2..194aeda8f14d 100644
>> --- a/drivers/ata/ahci_brcmstb.c
>> +++ b/drivers/ata/ahci_brcmstb.c
>> @@ -69,10 +69,15 @@
>> 	(DATA_ENDIAN << DMADESC_ENDIAN_SHIFT) |		\
>> 	(MMIO_ENDIAN << MMIO_ENDIAN_SHIFT))
>> 
>> +enum brcm_ahci_quirks {
>> +	BRCM_AHCI_QUIRK_NONCQ		= BIT(0),
>> +};
>> +
>> struct brcm_ahci_priv {
>> 	struct device *dev;
>> 	void __iomem *top_ctrl;
>> 	u32 port_mask;
>> +	u32 quirks;
>> };
>> 
>> static const struct ata_port_info ahci_brcm_port_info = {
>> @@ -202,6 +207,42 @@ static u32 brcm_ahci_get_portmask(struct platform_device *pdev,
>> 	return impl;
>> }
>> 
>> +static void brcm_sata_quirks(struct platform_device *pdev,
>> +			     struct brcm_ahci_priv *priv)
>> +{
>> +	if (priv->quirks & BRCM_AHCI_QUIRK_NONCQ) {
>> +		void __iomem *ctrl = priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL;
>> +		void __iomem *ahci;
>> +		struct resource *res;
>> +		u32 reg;
>> +
>> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +						   "ahci");
>> +		ahci = devm_ioremap_resource(&pdev->dev, res);
>> +		if (IS_ERR(ahci))
>> +			return;
>> +
>> +		reg = brcm_sata_readreg(ctrl);
>> +		reg |= OVERRIDE_HWINIT;
>> +		brcm_sata_writereg(reg, ctrl);
>> +
>> +		/* Clear out the NCQ bit so the AHCI driver will not issue
>> +		 * FPDMA/NCQ commands.
>> +		 */
>> +		reg = readl(ahci + HOST_CAP);
>> +		reg &= ~HOST_CAP_NCQ;
>> +		writel(reg, ahci + HOST_CAP);
> 
> You're using readl()/writel() to access the AHCI block, but...
> 
>> +
>> +		reg = brcm_sata_readreg(ctrl);
>> +		reg &= ~OVERRIDE_HWINIT;
>> +		brcm_sata_writereg(reg, ctrl);
>> +
>> +		devm_iounmap(&pdev->dev, ahci);
>> +		devm_release_mem_region(&pdev->dev, res->start,
>> +					resource_size(res));
>> +	}
>> +}
>> +
>> static void brcm_sata_init(struct brcm_ahci_priv *priv)
>> {
>> 	/* Configure endianness */
>> @@ -256,6 +297,11 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>> 	if (IS_ERR(priv->top_ctrl))
>> 		return PTR_ERR(priv->top_ctrl);
>> 
>> +	if (of_device_is_compatible(dev->of_node, "brcm,bcm7425-ahci"))
>> +		priv->quirks |= BRCM_AHCI_QUIRK_NONCQ;
>> +
>> +	brcm_sata_quirks(pdev, priv);
>> +
>> 	brcm_sata_init(priv);
> 
> ...the MMIO endianness is only configured in brcm_sata_init(). You won't
> see this problem on ARM LE, but you should on MIPS BE. Maybe
> brcm_sata_quirks() should be after brcm_sata_init()?
> 

Florian already pointed out, the NCQ disabling occurs prior to initializing 
the SATA controller endianness in the original BSP. Therefore I think it's better
to change to brcm_sata_{read,write}reg() instead of {read,write}l() for 
HOST_CAP overwriting.

>> 
>> 	priv->port_mask = brcm_ahci_get_portmask(pdev, priv);
> 
> Brian
