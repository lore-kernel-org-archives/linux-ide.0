From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [V8 PATCH 5/5] MX53 Enable the AHCI SATA on MX53 SMD board
Date: Thu, 22 Sep 2011 15:42:07 +0400
Message-ID: <4E7B1F0F.10601@ru.mvista.com>
References: <1316686488-4684-1-git-send-email-richard.zhu@linaro.org> <1316686488-4684-6-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38810 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab1IVLm5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2011 07:42:57 -0400
Received: by wwf22 with SMTP id 22so2071925wwf.1
        for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2011 04:42:56 -0700 (PDT)
In-Reply-To: <1316686488-4684-6-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org

Hello.

On 22-09-2011 14:14, Richard Zhu wrote:

> Signed-off-by: Richard Zhu<richard.zhu@linaro.org>
> ---
>   arch/arm/mach-mx5/board-mx53_smd.c |   16 ++++++++++++++++
>   1 files changed, 16 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
> index bc02894..9d06fbe 100644
> --- a/arch/arm/mach-mx5/board-mx53_smd.c
> +++ b/arch/arm/mach-mx5/board-mx53_smd.c
[...]
> @@ -111,6 +112,19 @@ static const struct imxi2c_platform_data mx53_smd_i2c_data __initconst = {
>   	.bitrate = 100000,
>   };
>
> +static inline void mx53_smd_ahci_pwr_on(void)
> +{
> +	int ret;
> +
> +	/* Enable SATA PWR */
> +	ret = gpio_request(MX53_SMD_SATA_PWR_EN, "ahci-sata-pwr");
> +	if (ret) {
> +		printk(KERN_ERR "failed to get SATA_PWR_EN: %d\n", ret);
> +		return;
> +	}
> +	gpio_direction_output(MX53_SMD_SATA_PWR_EN, 1);

    You can use gpio_request_one() instead of gpio_request()/gpio_direction_*().

WBR, Sergei
