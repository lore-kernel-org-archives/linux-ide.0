From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2 11/14] sata: ahci-da850: un-hardcode the MPY bits
Date: Tue, 17 Jan 2017 12:51:49 -0600
Message-ID: <062b5ef3-cc3a-0f9c-c040-93495f374dac@lechnology.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
 <1484655976-25382-12-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:56392 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbdAQSvt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 17 Jan 2017 13:51:49 -0500
In-Reply-To: <1484655976-25382-12-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/17/2017 06:26 AM, Bartosz Golaszewski wrote:
> In order to make the MPY bits configurable, try to obtain the refclk
> and calculate the required multiplier from its rate.
>
> If we fail to get the clock, fall back to the default value which
> keeps backwards compatibility.

It seems like it would be wiser to make is so that if we fail to get the 
clock, it is an error. This way, if someone makes a new board and 
forgets to configure a clock, they will get an error instead of 
wondering why things are not working because it is using the wrong 
multiplier.

>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/ata/ahci_da850.c | 88 +++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 76 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
> index a7a7161..f48b7d0 100644
> --- a/drivers/ata/ahci_da850.c
> +++ b/drivers/ata/ahci_da850.c
> @@ -14,6 +14,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/libata.h>
>  #include <linux/ahci_platform.h>
> +#include <asm/div64.h>
>  #include "ahci.h"
>
>  #define DRV_NAME		"ahci_da850"
> @@ -30,16 +31,14 @@
>  #define SATA_PHY_ENPLL(x)	((x) << 31)
>
>  /*
> - * The multiplier needed for 1.5GHz PLL output.
> - *
> - * NOTE: This is currently hardcoded to be suitable for 100MHz crystal
> - * frequency (which is used by DA850 EVM board) and may need to be changed
> - * if you would like to use this driver on some other board.
> + * This is the default multiplier value used if the refclk could not be
> + * obtained. It corresponds with a crystal rate of 100MHz for 1.5GHz PLL
> + * output.
>   */
> -#define DA850_SATA_CLK_MULTIPLIER	7
> +#define DA850_SATA_MPY_DEFAULT	0x8
>
>  static void da850_sata_init(struct device *dev, void __iomem *pwrdn_reg,
> -			    void __iomem *ahci_base)
> +			    void __iomem *ahci_base, u32 mpy)
>  {
>  	unsigned int val;
>
> @@ -48,13 +47,56 @@ static void da850_sata_init(struct device *dev, void __iomem *pwrdn_reg,
>  	val &= ~BIT(0);
>  	writel(val, pwrdn_reg);
>
> -	val = SATA_PHY_MPY(DA850_SATA_CLK_MULTIPLIER + 1) | SATA_PHY_LOS(1) |
> -	      SATA_PHY_RXCDR(4) | SATA_PHY_RXEQ(1) | SATA_PHY_TXSWING(3) |
> -	      SATA_PHY_ENPLL(1);
> +	val = SATA_PHY_MPY(mpy) | SATA_PHY_LOS(1) | SATA_PHY_RXCDR(4) |
> +	      SATA_PHY_RXEQ(1) | SATA_PHY_TXSWING(3) | SATA_PHY_ENPLL(1);
>
>  	writel(val, ahci_base + SATA_P0PHYCR_REG);
>  }
>
> +static u32 ahci_da850_calculate_mpy(unsigned long refclk_rate)
> +{
> +	u64 pll_output = 1500000000;
> +	u32 needed;
> +
> +	/*
> +	 * We need to determine the value of the multiplier (MPY) bits.
> +	 *
> +	 * In order to include the 12.5 multiplier we need to first multiply
> +	 * the desired rate of 1.5GHz by 10 before division.
> +	 */
> +	pll_output *= 10;
> +	needed = __div64_32(&pll_output, refclk_rate);

What if this does not divide evenly and there is a remainder. Shouldn't 
there be an error in that case?

...
