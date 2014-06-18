From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH RFC 1/2] libahci_platform: add
 ahci_platform_get_of_property
Date: Wed, 18 Jun 2014 15:03:52 +0100
Message-ID: <20140618140352.GD11895@leverpostej>
References: <xuwei5@hisilicon.com,kefeng.wang@linaro.org,>
 <1403067249-8021-1-git-send-email-zhangfei.gao@linaro.org>
 <1403067249-8021-2-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50101 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751792AbaFROEh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2014 10:04:37 -0400
Content-Disposition: inline
In-Reply-To: <1403067249-8021-2-git-send-email-zhangfei.gao@linaro.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: "tj@kernel.org" <tj@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Jun 18, 2014 at 05:54:08AM +0100, Zhangfei Gao wrote:
> Instead of setting hflags in different files,
> ahci_platform_get_of_property set hpriv->flags when ahci_platform_init_host
> according to property in dts.

The AHCI_HFLAGS are a Linux implementation detail, so it would be nice
to have a good justification for each of these being turned into DT
properties.

> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt      |    9 +++++
>  drivers/ata/libahci_platform.c                     |   39 ++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index c96d8dcf98fd..c0b9f6e76ba4 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -26,6 +26,15 @@ Optional properties:
>  - clocks            : must contain the sata, sata_ref and ahb clocks
>  - clock-names       : must contain "ahb" for the ahb clock
>  
> +- no-ncq: when present, controller can't do NCQ, turning off CAP_NCQ
> +- 32bit-only: when present, controller can't do 64bit DMA, forcing 32bit
> +- no-msi: when present, no PCI MSI
> +- no-pmp: when present, controller can't do PMP, turning off CAP_PMP
> +- yes-ncq: when present,controller can do NCQ, turning on CAP_NCQ
> +- no-suspend: when present, controller can't do suspend
> +- yes-fbs: when present, controller can do FBS, turning on CAP_FBS
> +- no-fbs: when present, controller can't do FBS, turning off CAP_FBS

There is absolutely no reason to mention CAP_* here; the DT should
describe the HW, not Linux internals.

Do these all make sense to be placed in DT?

I worry that for other quirks we may need more flags in future. For that
reason I'd rather figure this out in the driver based on the compatible
string.

> +
>  Examples:
>          sata@ffe08000 {
>  		compatible = "snps,spear-ahci";
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 3a5b4ed25a4f..880b9f360056 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -278,6 +278,44 @@ err_out:
>  }
>  EXPORT_SYMBOL_GPL(ahci_platform_get_resources);
>  
> +#ifdef CONFIG_OF
> +static void ahci_platform_get_of_property(struct platform_device *pdev,
> +					  struct ahci_host_priv *hpriv)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	if (of_device_is_available(np)) {
> +		if (of_get_property(np, "no-ncq", NULL))
> +			hpriv->flags |= AHCI_HFLAG_NO_NCQ;

For boolean flags please use of_property_read_bool.

Mark.
