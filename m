From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH -next] ahci: imx: fix the error handling in imx_ahci_probe()
Date: Sat, 7 Dec 2013 13:55:07 +0100
Message-ID: <201312071355.07752.marex@denx.de>
References: <CAPgLHd-okGke6OMBe2yaX3NdoDFtcN-47bFfcSRL-8h_7nnmYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:34611 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab3LGXUl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Dec 2013 18:20:41 -0500
In-Reply-To: <CAPgLHd-okGke6OMBe2yaX3NdoDFtcN-47bFfcSRL-8h_7nnmYw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: tj@kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, linux-ide@vger.kernel.org

On Saturday, December 07, 2013 at 07:00:19 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Release alloced resources instead of direct return from
> imx_ahci_probe() in the error handling case.
> 
> Fixes: 4a23d1793f8e ('ahci: imx: Add i.MX53 support')
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Marek Vasut <marex@denx.de>

Nice find, thanks.

> ---
>  drivers/ata/ahci_imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 2daa288..dd4d6f7 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -331,7 +331,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  		if (IS_ERR(imxpriv->gpr)) {
>  			dev_err(dev,
>  				"failed to find fsl,imx6q-iomux-gpr regmap\n");
> -			return PTR_ERR(imxpriv->gpr);
> +			ret = PTR_ERR(imxpriv->gpr);
> +			goto err_out;
>  		}
> 
>  		/*

Best regards,
Marek Vasut
