From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/3] pata_imx: Propagate the real error code on platform_get_irq()
 failure
Date: Sun, 16 Feb 2014 00:38:42 +0400
Message-ID: <52FFD052.6060306@cogentembedded.com>
References: <1392468635-13373-1-git-send-email-festevam@gmail.com> <1392468635-13373-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:37500 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbaBOUik (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Feb 2014 15:38:40 -0500
Received: by mail-lb0-f180.google.com with SMTP id n15so10001173lbi.25
        for <linux-ide@vger.kernel.org>; Sat, 15 Feb 2014 12:38:38 -0800 (PST)
In-Reply-To: <1392468635-13373-2-git-send-email-festevam@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hello.

On 15-02-2014 16:50, Fabio Estevam wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>

> No need to return a 'fake' return value on platform_get_irq() failure.

> Just return the error code itself instead.

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>   drivers/ata/pata_imx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
> index 50e2cf2..1af71b7 100644
> --- a/drivers/ata/pata_imx.c
> +++ b/drivers/ata/pata_imx.c
> @@ -101,7 +101,7 @@ static int pata_imx_probe(struct platform_device *pdev)
>
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq <= 0)
> -		return -EINVAL;
> +		return irq;

    If returned IRQ is 0 (unused), you'll return 0, indicating probe success 
while actually it failed. We need somewhat more complicated code here.

WBR, Sergei

