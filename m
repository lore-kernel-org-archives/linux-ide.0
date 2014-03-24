From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/3] ata: add new-style AHCI platform driver for DaVinci
	DA850 AHCI controller
Date: Mon, 24 Mar 2014 18:58:05 +0530
Message-ID: <533032E5.2090004@ti.com>
References: <1395340026-3969-1-git-send-email-b.zolnierkie@samsung.com>
	<1395340026-3969-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1395340026-3969-4-git-send-email-b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Viresh Kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Thursday 20 March 2014 11:57 PM, Bartlomiej Zolnierkiewicz wrote:
> Add the new ahci_da850 host driver and remove the deprecated
> ahci_platform_data platform code.
> 
> Please note that the new driver doesn't have the superfluous
> clock control code as clock is already handled by the generic
> AHCI platform library code.
> 
> Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Looks much better now and re-tested it on DA850 EVM. Few issues 
pointed out below.

> ---
> v2:
> - dropped the experimental tag from the config option help
> - fixed SYSCFG1 memory resource handling
> - hardcoded the multiplier data and added a note about it
> - used readl()/writel() instead of __raw_readl()/__raw_writel()
> - dropped the superflous clock control
> - cleaned up da850_sata_init()
> - changed the platform device name and removed the platform ids table
> - removed the deprecated ahci_platform_data platform code
> - updated the patch description
> 
>  arch/arm/mach-davinci/devices-da8xx.c |  99 +++--------------------------
>  drivers/ata/Kconfig                   |   9 +++
>  drivers/ata/Makefile                  |   1 +
>  drivers/ata/ahci_da850.c              | 116 ++++++++++++++++++++++++++++++++++
>  4 files changed, 134 insertions(+), 91 deletions(-)

I prefer not to mix platform and driver together in one patch. If you 
separate out the platform changes, I can take then through my tree with 
out risk of conflicts. The platform changes can come after the driver 
is introduced so there is no breakage.

>  create mode 100644 drivers/ata/ahci_da850.c
> 
> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index 0486cdf2..72bb8d6 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -1020,7 +1020,6 @@ int __init da8xx_register_spi_bus(int instance, unsigned num_chipselect)
>  }
>  
>  #ifdef CONFIG_ARCH_DAVINCI_DA850
> -
>  static struct resource da850_sata_resources[] = {
>  	{
>  		.start	= DA850_SATA_BASE,
> @@ -1028,103 +1027,22 @@ static struct resource da850_sata_resources[] = {
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	{
> +		.start	= DA8XX_SYSCFG1_BASE,
> +		.end	= DA8XX_SYSCFG1_BASE + SZ_4K - 1,
> +		.flags	= IORESOURCE_MEM,

This is not correct. The entire SYSCFG is not owned by SATA driver.
Its just that one PWRDN register. Here is a patch which applies on
top of your patch patch fixing it. Feel free to roll it in.

---8<---
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 72bb8d6..56ea41d 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -1027,8 +1027,8 @@ static struct resource da850_sata_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= DA8XX_SYSCFG1_BASE,
-		.end	= DA8XX_SYSCFG1_BASE + SZ_4K - 1,
+		.start	= DA8XX_SYSCFG1_BASE + DA8XX_PWRDN_REG,
+		.end	= DA8XX_SYSCFG1_BASE + DA8XX_PWRDN_REG + 0x3,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 899270a..2c83613 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -16,8 +16,6 @@
 #include <linux/ahci_platform.h>
 #include "ahci.h"
 
-#define DA8XX_PWRDN_REG		0x18
-
 /* SATA PHY Control Register offset from AHCI base */
 #define SATA_P0PHYCR_REG	0x178
 
@@ -37,15 +35,15 @@
  */
 #define DA850_SATA_CLK_MULTIPLIER	7
 
-static void da850_sata_init(struct device *dev, void __iomem *syscfg1_base,
+static void da850_sata_init(struct device *dev, void __iomem *pwrdn_reg,
 			    void __iomem *ahci_base)
 {
 	unsigned int val;
 
 	/* Enable SATA clock receiver */
-	val = readl(syscfg1_base + DA8XX_PWRDN_REG);
+	val = readl(pwrdn_reg);
 	val &= ~BIT(0);
-	writel(val, syscfg1_base + DA8XX_PWRDN_REG);
+	writel(val, pwrdn_reg);
 
 	val = SATA_PHY_MPY(DA850_SATA_CLK_MULTIPLIER + 1) | SATA_PHY_LOS(1) |
 	      SATA_PHY_RXCDR(4) | SATA_PHY_RXEQ(1) | SATA_PHY_TXSWING(3) |
@@ -66,7 +64,7 @@ static int ahci_da850_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	struct resource *res;
-	void __iomem *syscfg1_base;
+	void __iomem *pwrdn_reg;
 	int rc;
 
 	hpriv = ahci_platform_get_resources(pdev);
@@ -81,11 +79,11 @@ static int ahci_da850_probe(struct platform_device *pdev)
 	if (!res)
 		goto disable_resources;
 
-	syscfg1_base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!syscfg1_base)
+	pwrdn_reg = devm_ioremap(dev, res->start, resource_size(res));
+	if (!pwrdn_reg)
 		goto disable_resources;
 
-	da850_sata_init(dev, syscfg1_base, hpriv->mmio);
+	da850_sata_init(dev, pwrdn_reg, hpriv->mmio);
 
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_da850_port_info, 0, 0);
 	if (rc)
---

Also, there is an additional change required in platform side
to make sure clock look-up succeeds. Here is the change needed,
please roll it into your platform changes patch.

---8<---
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 2ab0043..85399c9 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -472,7 +472,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK("vpif",		NULL,		&vpif_clk),
-	CLK("ahci",		NULL,		&sata_clk),
+	CLK("ahci_da850",		NULL,		&sata_clk),
 	CLK("davinci-rproc.0",	NULL,		&dsp_clk),
 	CLK("ehrpwm",		"fck",		&ehrpwm_clk),
 	CLK("ehrpwm",		"tbclk",	&ehrpwm_tbclk),
---

Thanks,
Sekhar
