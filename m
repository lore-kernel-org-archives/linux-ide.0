From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/3] ata: sata_dwc_460ex: add phy support
Date: Wed, 16 Dec 2015 14:14:00 +0300
Message-ID: <56714778.4070100@cogentembedded.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
 <1450221935-6034-2-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35011 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577AbbLPLOE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Dec 2015 06:14:04 -0500
Received: by mail-lb0-f172.google.com with SMTP id u9so23223293lbp.2
        for <linux-ide@vger.kernel.org>; Wed, 16 Dec 2015 03:14:03 -0800 (PST)
In-Reply-To: <1450221935-6034-2-git-send-email-mans@mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hello.

On 12/16/2015 2:25 AM, Mans Rullgard wrote:

> This adds support for powering on an optional PHY when activating the
> device.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
[...]
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 9985749..d07aae1 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
[...]
> @@ -1318,6 +1320,21 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>   	}
>   #endif
>
> +	hsdev->phy = devm_phy_optional_get(hsdev->dev, "sata-phy");
> +	if (IS_ERR(hsdev->phy)) {
> +		err = PTR_ERR(hsdev->phy);
> +		hsdev->phy = NULL;
> +		goto error_out;
> +	}
> +
> +	err = phy_init(hsdev->phy);
> +	if (err)
> +		goto error_out;

    If phy_init() fails, do we really need to call phy_exit()?

> +
> +	err = phy_power_on(hsdev->phy);
> +	if (err)
> +		goto error_out;
> +
>   	/*
>   	 * Now, register with libATA core, this will also initiate the
>   	 * device discovery process, invoking our port_start() handler &
> @@ -1331,6 +1348,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>   	return 0;
>
>   error_out:
> +	phy_exit(hsdev->phy);
>   	iounmap(base);
>   	return err;
>   }
[...]

MBR, Sergei

