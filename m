From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v7 03/14] ARM: davinci: add a clock lookup entry for the
 SATA clock
Date: Tue, 31 Jan 2017 20:39:24 +0530
Message-ID: <91e96c08-c762-8022-8a34-31ec1f4106d8@ti.com>
References: <1485770531-6772-1-git-send-email-bgolaszewski@baylibre.com>
 <1485770531-6772-4-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1485770531-6772-4-git-send-email-bgolaszewski@baylibre.com>
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

On Monday 30 January 2017 03:32 PM, Bartosz Golaszewski wrote:
> This entry is needed for the ahci driver to get a functional clock.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

This patch is not adding a clock lookup entry, but AUXDATA. I fixed the
subject line to:

ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for SATA

while applying.

Thanks,
Sekhar

>  arch/arm/mach-davinci/da8xx-dt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index 9ee44da..b83e5d1 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -42,6 +42,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
>  	OF_DEV_AUXDATA("ti,da830-ohci", 0x01e25000, "ohci-da8xx", NULL),
>  	OF_DEV_AUXDATA("ti,da830-musb", 0x01e00000, "musb-da8xx", NULL),
>  	OF_DEV_AUXDATA("ti,da830-usb-phy", 0x01c1417c, "da8xx-usb-phy", NULL),
> +	OF_DEV_AUXDATA("ti,da850-ahci", 0x01e18000, "ahci_da850", NULL),
>  	{}
>  };
>  
> 
