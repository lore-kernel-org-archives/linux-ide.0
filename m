From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [patch v3 3/3] ata: sata_mv: Fix probe failures with optional
 phys
Date: Mon, 03 Feb 2014 22:21:53 +0300
Message-ID: <52EFEC51.3070603@cogentembedded.com>
References: <52EFE823.6060200@cogentembedded.com> <1391451440-15959-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:39169 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576AbaBCSVg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Feb 2014 13:21:36 -0500
Received: by mail-la0-f48.google.com with SMTP id mc6so5583736lab.21
        for <linux-ide@vger.kernel.org>; Mon, 03 Feb 2014 10:21:34 -0800 (PST)
In-Reply-To: <1391451440-15959-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, tj@kernel.org, kishon@ti.com
Cc: Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, linux-ide@vger.kernel.org

Hello.

On 02/03/2014 09:17 PM, Andrew Lunn wrote:

> Make use of devm_optional_get() in order to fix probe failures on

    It's devm_phy_optional_get() according to your own source.

> Armada 370, XP and others, when there is no phy driver available.

> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v2
> No change
> v3
> Fix commit log devm_get_optional->devm_option_get.
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

