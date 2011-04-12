From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH V4 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
Date: Tue, 12 Apr 2011 15:28:00 +0400
Message-ID: <4DA43740.9050806@ru.mvista.com>
References: <1302587472-20435-1-git-send-email-Hong-Xing.Zhu@freescale.com> <1302587472-20435-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34698 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab1DLL3h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Apr 2011 07:29:37 -0400
Received: by bwz15 with SMTP id 15so5272377bwz.19
        for <linux-ide@vger.kernel.org>; Tue, 12 Apr 2011 04:29:36 -0700 (PDT)
In-Reply-To: <1302587472-20435-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org

Hello.

On 12-04-2011 9:51, Richard Zhu wrote:

> Signed-off-by: Richard Zhu<Hong-Xing.Zhu@freescale.com>
> ---
>   arch/arm/mach-mx5/board-mx53_loco.c |   76 +++++++++++++++++++++++++++++++++++
>   1 files changed, 76 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> index 0a18f8d..644aaa2 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
[...]
> @@ -203,6 +206,78 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
>   	.bitrate = 100000,
>   };
>
> +/* HW Initialization, if return 0, initialization is successful. */
> +static int mx53_loco_sata_init(struct device *dev, void __iomem *addr)
> +{
> +	u32 tmpdata;
> +	int ret = 0;
> +	struct clk *clk;
> +
> +	sata_clk = clk_get(dev, NULL);
> +	if (IS_ERR(sata_clk)) {
> +		dev_err(dev, "no sata clock.\n");
> +		return PTR_ERR(sata_clk);
> +	}
> +	ret = clk_enable(sata_clk);
> +	if (ret) {
> +		dev_err(dev, "can't enable sata clock.\n");
> +		clk_put(sata_clk);

    Why duplicate clk_put() which you already have at the end of function?
Just define another label there.

> +		return ret;
> +	}
> +
> +	/* FSL IMX AHCI SATA uses the internal usb phy1 clk on loco */
> +	sata_ref_clk = clk_get(NULL, "usb_phy1");
> +	if (IS_ERR(sata_ref_clk)) {
> +		dev_err(dev, "no sata ref clock.\n");
> +		ret = PTR_ERR(sata_ref_clk);
> +		goto release_sata_clk;
> +	}
> +	ret = clk_enable(sata_ref_clk);
> +	if (ret) {
> +		dev_err(dev, "can't enable sata ref clock.\n");
> +		clk_put(sata_ref_clk);

    Same question.

> +		goto release_sata_clk;
> +	}
> +
> +	/* Get the AHB clock rate, and configure the TIMER1MS reg later */
> +	clk = clk_get(NULL, "ahb");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "no ahb clock.\n");
> +		ret = PTR_ERR(clk);
> +		goto release_sata_ref_clk;
> +	}
> +	tmpdata = clk_get_rate(clk) / 1000;
> +	clk_put(clk);
> +
> +	sata_init(addr, tmpdata);
> +
> +	return ret;
> +
> +release_sata_ref_clk:
> +	clk_disable(sata_ref_clk);
> +	clk_put(sata_ref_clk);
> +
> +release_sata_clk:
> +	clk_disable(sata_clk);
> +	clk_put(sata_clk);
> +
> +	return ret;
> +}

WBR, Sergei
