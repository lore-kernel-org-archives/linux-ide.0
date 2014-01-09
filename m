From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v4 2/3] ata: ahci_platform: Manage SATA PHY
Date: Thu, 09 Jan 2014 15:20:09 +0400
Message-ID: <52CE85E9.7040703@cogentembedded.com>
References: <1389264962-22858-1-git-send-email-rogerq@ti.com> <1389264962-22858-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:40939 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbaAILUH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jan 2014 06:20:07 -0500
Received: by mail-la0-f50.google.com with SMTP id el20so2061341lab.9
        for <linux-ide@vger.kernel.org>; Thu, 09 Jan 2014 03:20:05 -0800 (PST)
In-Reply-To: <1389264962-22858-3-git-send-email-rogerq@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tj@kernel.org
Cc: kishon@ti.com, b.zolnierkie@samsung.com, hdegoede@redhat.com, arnd@arndb.de, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Balaji T K <balajitk@ti.com>

On 09-01-2014 14:56, Roger Quadros wrote:

> From: Balaji T K <balajitk@ti.com>

> Some platforms have a PHY hooked up to the
> SATA controller. The PHY needs to be initialized
> and powered up for SATA to work. We do that
> using the PHY framework.

> [Roger Q] Cleaned up.

> CC: Tejun Heo <tj@kernel.org>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
[...]

> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index d5ced13..b476642 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -142,6 +142,39 @@ static int ahci_probe(struct platform_device *pdev)
>   		}
>   	}
>
> +	hpriv->phy = devm_phy_get(dev, "sata-phy");
> +	if (IS_ERR(hpriv->phy)) {
> +		rc = PTR_ERR(hpriv->phy);
> +		switch (rc) {
> +		case -ENODEV:
> +		case -ENOSYS:
> +			/* continue normally */
> +			hpriv->phy = NULL;
> +			break;
> +
> +		case -EPROBE_DEFER:
> +			goto disable_unprepare_clk;
> +			break;

    Well, well, *break* after *goto*? :-)

> +
> +		default:
> +			dev_err(dev, "couldn't get sata-phy\n");
> +			goto disable_unprepare_clk;
> +			break;

    Again?

WBR, Sergei

