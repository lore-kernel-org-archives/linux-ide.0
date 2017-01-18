From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 06/14] ARM: davinci: da850: model the SATA refclk
Date: Wed, 18 Jan 2017 14:32:37 +0530
Message-ID: <ff3b3949-1f48-f176-2b06-b9a4c14e6ffa@ti.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
 <1484655976-25382-7-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484655976-25382-7-git-send-email-bgolaszewski@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tuesday 17 January 2017 05:56 PM, Bartosz Golaszewski wrote:
> Register a dummy clock modelling the external SATA oscillator for

I would not call it a dummy clock. Its representing something physically
present. Just call it "fixed rate clock" ?

> da850 DT mode. For non-DT boot we don't register the clock - instead
> we rely on the default MPY value defined in the da850 ahci driver (as
> is done currently).

Here too, like David suggested, it will be nice to register it both for
DT and non-DT case. With that I think your driver will be simple too
since you dont have to worry about the case when refclkpn is not supplied.

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/da8xx-dt.c           |  8 ++++++++
>  arch/arm/mach-davinci/devices-da8xx.c      | 23 +++++++++++++++++++++++
>  arch/arm/mach-davinci/include/mach/da8xx.h |  1 +
>  3 files changed, 32 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index b83e5d1..13137cb 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -61,6 +61,14 @@ static void __init da850_init_machine(void)
>  		pr_warn("%s: registering USB 1.1 PHY clock failed: %d",
>  			__func__, ret);
>  
> +	if (of_machine_is_compatible("ti,da850-evm") ||
> +	    of_machine_is_compatible("ti,da850-lcdk")) {
> +		ret = da850_register_sata_refclk(100000000);
> +		if (ret)
> +			pr_warn("%s: registering SATA_REFCLK clock failed: %d",
> +				__func__, ret);
> +	}

Since all supported boards use 100 Mhz refclk anyway, I would drop the
machine check and just do:

	/* All existing boards use 100MHz SATA refclkpn */
	unsigned long sata_refclkpn = 100 * 1000 * 1000;

	ret = da850_register_sata_refclk(sata_refclkpn);

It should then be easy for the odd board (when it comes) to set
sata_refclkpn to a different value.

Thanks,
Sekhar
