From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [patch v2 3/3] ata: sata_mv: Fix probe failures with optional
 phys
Date: Mon, 03 Feb 2014 22:04:03 +0300
Message-ID: <52EFE823.6060200@cogentembedded.com>
References: <52EF6D38.4060200@ti.com> <1391450446-15580-1-git-send-email-andrew@lunn.ch> <1391450446-15580-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:33996 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbaBCSDt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Feb 2014 13:03:49 -0500
Received: by mail-la0-f52.google.com with SMTP id c6so5735723lan.11
        for <linux-ide@vger.kernel.org>; Mon, 03 Feb 2014 10:03:48 -0800 (PST)
In-Reply-To: <1391450446-15580-3-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, tj@kernel.org, kishon@ti.com
Cc: Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, linux-ide@vger.kernel.org

Hello.

On 02/03/2014 09:00 PM, Andrew Lunn wrote:

> Make use of devm_phy_optional() in order to fix probe failures on

    devm_phy_optional_get() instead.

> Armada 370, XP and others, when there is no phy driver available.

> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v2
> No change
> ---
>   drivers/ata/sata_mv.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 20a7517bd339..52b8181ddafd 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4126,12 +4126,14 @@ static int mv_platform_probe(struct platform_device *pdev)
>   			clk_prepare_enable(hpriv->port_clks[port]);
>
>   		sprintf(port_number, "port%d", port);
> -		hpriv->port_phys[port] = devm_phy_get(&pdev->dev, port_number);
> +		hpriv->port_phys[port] = devm_phy_optional_get(&pdev->dev,
> +							       port_number);

WBR, Sergei


