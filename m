From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 04/14] sata: ahci-da850: get the sata clock using a
 connector id
Date: Tue, 17 Jan 2017 19:02:50 +0300
Message-ID: <5e98507d-eb66-90e8-cad9-ed9c4a099411@cogentembedded.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
 <1484655976-25382-5-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484655976-25382-5-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hello!

On 01/17/2017 03:26 PM, Bartosz Golaszewski wrote:

> In preparation for using two clocks in the driver (the sysclk2-based
> clock and the external REFCLK), check if we got a functional clock
> after calling ahci_platform_get_resources(). If not, retry calling
> get_clk() with con_id specified.

    clk_get().

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/ata/ahci_da850.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
> index 267a3d3..18f57c2 100644
> --- a/drivers/ata/ahci_da850.c
> +++ b/drivers/ata/ahci_da850.c
> @@ -71,12 +71,28 @@ static int ahci_da850_probe(struct platform_device *pdev)
>  	struct ahci_host_priv *hpriv;
>  	struct resource *res;
>  	void __iomem *pwrdn_reg;
> +	struct clk *clk;
>  	int rc;
>
>  	hpriv = ahci_platform_get_resources(pdev);
>  	if (IS_ERR(hpriv))
>  		return PTR_ERR(hpriv);
>
> +	/*
> +	 * Internally ahci_platform_get_resources() calls clk_get(dev, NULL)
> +	 * when trying to obtain the first clock. This SATA controller uses
> +	 * two clocks for which we specify two connector ids. If we don't

    It's called connection ID, IIRC.

[...]

MBR, Sergei
