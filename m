From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 8/9] ata: Add support for the Tegra124 SATA controller
Date: Mon, 16 Jun 2014 16:14:34 -0600
Message-ID: <539F6C4A.2030005@wwwdotorg.org>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com> <1401881559-18469-9-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401881559-18469-9-git-send-email-mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> This adds support for the integrated AHCI-compliant Serial ATA
> controller present on the NVIDIA Tegra124 system-on-chip.

> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c

> +static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)

> +	/* Pad calibration */
> +
> +	ret = tegra_fuse_readl(0x224, &val);
> +	if (ret) {
> +		dev_err(&tegra->pdev->dev,
> +			"failed to read sata calibration fuse: %d\n", ret);
> +		return ret;
> +	}
> +
> +	calib = tegra124_pad_calibration[val];

Shouldn't val be range-checked before blindly using it?
