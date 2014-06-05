From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 8/9] ata: Add support for the Tegra124 SATA controller
Date: Thu, 5 Jun 2014 07:18:10 -0500
Message-ID: <CAL_JsqLh7kqnufNaWKdOEFb=m2mViFX4kTGMHOKmHuTAVMr+fA@mail.gmail.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
	<1401881559-18469-9-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401881559-18469-9-git-send-email-mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Jun 4, 2014 at 6:32 AM, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> This adds support for the integrated AHCI-compliant Serial ATA
> controller present on the NVIDIA Tegra124 system-on-chip.
>
> Signed-off-by: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---

[...]

> +static int tegra_ahci_probe(struct platform_device *pdev)
> +{
> +       const struct of_device_id *match;
> +       struct ahci_host_priv *hpriv;
> +       struct tegra_ahci_priv *tegra;
> +       int ret;
> +
> +       match = of_match_device(tegra_ahci_of_match, &pdev->dev);

This is not needed.

> +       if (!match)
> +               return -EINVAL;
> +
