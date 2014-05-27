From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] ahci: imx: Fix imx_ahci_resume()
Date: Tue, 27 May 2014 16:20:20 +0800
Message-ID: <20140527082019.GB8860@dragon>
References: <1401132577-24999-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1blp0185.outbound.protection.outlook.com ([207.46.163.185]:2336
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752681AbaE0IUd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 May 2014 04:20:33 -0400
Content-Disposition: inline
In-Reply-To: <1401132577-24999-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, festevam@gmail.com

On Mon, May 26, 2014 at 04:29:37PM -0300, Fabio Estevam wrote:
> The following warning is seen after suspend/resume sequence:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 661 at drivers/ata/libahci.c:224 ahci_enable_ahci+0x74/0x8)
> Modules linked in:
> CPU: 0 PID: 661 Comm: sh Tainted: G        W     3.15.0-rc5-next-20140521-000027
> Backtrace:
> [<80011c90>] (dump_backtrace) from [<80011e2c>] (show_stack+0x18/0x1c)
>  r6:803a22f4 r5:00000000 r4:00000000 r3:00000000
> [<80011e14>] (show_stack) from [<80661e60>] (dump_stack+0x88/0xa4)
> [<80661dd8>] (dump_stack) from [<80028fdc>] (warn_slowpath_common+0x70/0x94)
>  r5:00000009 r4:00000000
> [<80028f6c>] (warn_slowpath_common) from [<80029024>] (warn_slowpath_null+0x24/)
>  r8:808f68c4 r7:00000000 r6:00000000 r5:00000000 r4:e0810004
> [<80029000>] (warn_slowpath_null) from [<803a22f4>] (ahci_enable_ahci+0x74/0x80)
> [<803a2280>] (ahci_enable_ahci) from [<803a2324>] (ahci_reset_controller+0x24/0)
>  r8:ddcd9410 r7:80351178 r6:ddcd9444 r5:dde8b850 r4:e0810000 r3:ddf35e90
> [<803a2300>] (ahci_reset_controller) from [<803a2c68>] (ahci_platform_resume_ho)
>  r7:80351178 r6:ddcd9444 r5:dde8b850 r4:ddcd9410
> [<803a2c30>] (ahci_platform_resume_host) from [<803a38f0>] (imx_ahci_resume+0x2)
>  r5:00000000 r4:ddcd9410
> [<803a38c4>] (imx_ahci_resume) from [<803511ac>] (platform_pm_resume+0x34/0x54)
> ....
> 
> Add the missing ahci_platform_resume_host() call in order to fix the resume
> of the driver.

As Bartlomiej already pointed out, you must mean
ahci_platform_enable_resources() here.  Even with it, I'm not sure this
is correct.  Calling ahci_platform_enable_resources() in .resume hook
only makes sense in case that ahci_platform_disable_resources() is being
called in .suspend hook.

All ahci_platform_enable[disable]_resources() do is handling resources
phy, clock and regulator, which should have been managed by
imx_sata_enable[disable]() in imx case.

> 
> Tested on imx6q-sabresd and imx53-qsb boards.

I'm still wondering why I cannot reproduce the issue on my imx6q-sabresd
board.

Shawn

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/ata/ahci_imx.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 8befeb6..1941896 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -468,11 +468,25 @@ static int imx_ahci_resume(struct device *dev)
>  	struct ahci_host_priv *hpriv = host->private_data;
>  	int ret;
>  
> -	ret = imx_sata_enable(hpriv);
> +	ret = ahci_platform_enable_resources(hpriv);
>  	if (ret)
>  		return ret;
>  
> -	return ahci_platform_resume_host(dev);
> +	ret = imx_sata_enable(hpriv);
> +	if (ret)
> +		goto disable_resources;
> +
> +	ret = ahci_platform_resume_host(dev);
> +	if (ret)
> +		goto disable_sata;
> +
> +	return 0;
> +
> +disable_sata:
> +	imx_sata_disable(hpriv);
> +disable_resources:
> +	ahci_platform_disable_resources(hpriv);
> +	return ret;
>  }
>  #endif
>  
> -- 
> 1.8.3.2
> 
