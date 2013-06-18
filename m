From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [v1 2/3] ata: ahci_platform: enable imx6q ahci sata support
Date: Tue, 18 Jun 2013 10:01:54 +0800
Message-ID: <20130618020153.GB28381@S2101-09.ap.freescale.net>
References: <1371462767-16630-1-git-send-email-r65037@freescale.com>
 <1371462767-16630-3-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-db9lp0249.outbound.messaging.microsoft.com ([213.199.154.249]:55898
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751549Ab3FRCA5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jun 2013 22:00:57 -0400
Content-Disposition: inline
In-Reply-To: <1371462767-16630-3-git-send-email-r65037@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>, devicetree-discuss@lists.ozlabs.org

On Mon, Jun 17, 2013 at 05:52:46PM +0800, Richard Zhu wrote:
> imx6q contains the Synopsys AHCI SATA controller which shares
> ahci_platform driver with other controllers.
> 
> This patch updates the DT compatible list for ahci_platform,
> and enable the imx6q ahci sata support.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  drivers/ata/ahci_platform.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 7a8a284..61f2142 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -327,6 +327,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
>  
>  static const struct of_device_id ahci_of_match[] = {
>  	{ .compatible = "snps,spear-ahci", },
> +	{ .compatible = "snps,imx-ahci", },

I'm not sure it makes much sense to invent multiple platform specific
strings for an IP which is completely compatible between them.
Why don't we just have a generic compatible string like "snps,ahci"
for all those compatible platforms, and only add platform specific
string when there is incompatibility on particular platform to deal
with?

Added devicetree-discuss to get DT people's opinion.

Shawn

>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ahci_of_match);
> -- 
> 1.7.5.4
> 

