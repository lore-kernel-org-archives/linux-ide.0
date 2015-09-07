From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] Revert "ahci: added support for Freescale AHCI sata"
Date: Mon, 7 Sep 2015 10:52:14 +0200
Message-ID: <55ED503E.5000902@redhat.com>
References: <1441614196-4284-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441614196-4284-1-git-send-email-Yuantian.Tang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yuantian.Tang-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 07-09-15 10:23, Yuantian.Tang-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
> From: Tang Yuantian <Yuantian.Tang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>
> This reverts commit 5163fb62541e
> ("ahci: added support for Freescale AHCI sata")
>
> The reverted patch added Freescale QorIQ AHCI sata support to
> ahci_platform driver though, but it left SoC specific settings to uboot.
> It leads to QorIQ sata heavily depending on uboot. In order to removing
> the dependency we first revert the old patch and then will add a new driver
> for QorIQ SATA.
> Since there are no LS* platforms that have been upstreamed, So
> the revert would not break anything exists.
>
> Signed-off-by: Tang Yuantian <Yuantian.Tang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

The entire series looks good to me and is:

Reviewed-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Regards,

Hans


> ---
>   Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 --
>   drivers/ata/ahci_platform.c                             | 1 -
>   2 files changed, 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index a232181..c2340ee 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -16,8 +16,6 @@ Required properties:
>     - "snps,dwc-ahci"
>     - "snps,exynos5440-ahci"
>     - "snps,spear-ahci"
> -  - "fsl,qoriq-ahci" : for qoriq series socs which include ls1021, ls2085, etc.
> -  - "fsl,<chip>-ahci" : chip could be ls1021, ls2085 etc.
>     - "generic-ahci"
>   - interrupts        : <interrupt mapping for SATA IRQ>
>   - reg               : <registers mapping>
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 1befb11..04975b8 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -76,7 +76,6 @@ static const struct of_device_id ahci_of_match[] = {
>   	{ .compatible = "ibm,476gtr-ahci", },
>   	{ .compatible = "snps,dwc-ahci", },
>   	{ .compatible = "hisilicon,hisi-ahci", },
> -	{ .compatible = "fsl,qoriq-ahci", },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, ahci_of_match);
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
