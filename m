From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
 different features
Date: Mon, 29 Aug 2011 16:12:14 +0400
Message-ID: <20110829121214.GA15484@oksana.dev.rtsoft.ru>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
 <1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60110 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab1H2MMT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2011 08:12:19 -0400
Received: by wwf5 with SMTP id 5so5637617wwf.1
        for <linux-ide@vger.kernel.org>; Mon, 29 Aug 2011 05:12:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, eric@eukrea.com, eric.miao@linaro.org

Hello,

On Mon, Aug 29, 2011 at 03:18:55PM +0800, Richard Zhu wrote:
> On imx53 AHCI, soft reset fails with IPMS set when PMP
> is enabled but SATA HDD/ODD is connected to SATA port,
> do soft reset again to port 0.
> So the 'ahci_pmp_retry_srst_ops' is required when imx53
> ahci is present.
> 
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> ---
[...]
>  	struct device *dev = &pdev->dev;
>  	struct ahci_platform_data *pdata = dev->platform_data;
> -	struct ata_port_info pi = {
> -		.flags		= AHCI_FLAG_COMMON,
> -		.pio_mask	= ATA_PIO4,
> -		.udma_mask	= ATA_UDMA6,
> -		.port_ops	= &ahci_ops,
> -	};
> +	struct platform_device_id *id_entry = platform_get_device_id(pdev);
> +	struct ata_port_info pi = ahci_port_info[id_entry->driver_data];

Why not pass port info via platform_data? It seems to be platform
specific nowadays, so leave the default as is, but let the platforms
pass their own port info through platform_data.

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
