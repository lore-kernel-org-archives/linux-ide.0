From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sata: rcar_sata: Reset SATA PHY when Salvator-X board
 resumes
Date: Mon, 1 Jan 2018 13:38:32 +0300
Message-ID: <219695fb-67eb-6770-675e-46fcc5c7f681@cogentembedded.com>
References: <1512585925-4251-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36296 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeAAKif (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jan 2018 05:38:35 -0500
Received: by mail-lf0-f67.google.com with SMTP id c19so33399087lfg.3
        for <linux-ide@vger.kernel.org>; Mon, 01 Jan 2018 02:38:34 -0800 (PST)
In-Reply-To: <1512585925-4251-1-git-send-email-ykaneko0929@gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org

Hello!

On 12/6/2017 9:45 PM, Yoshihiro Kaneko wrote:

> From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> 
> Because power of Salvator-X board is cut off in suspend,
> it needs to reset SATA PHY state in resume.
> Otherwise, SATA partition could not be accessed anymore.
> 
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> Signed-off-by: Hien Dang <hien.dang.eb@rvc.renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
> 
> This patch is based on the for-next branch of libata tree.
> 
>   drivers/ata/sata_rcar.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 80ee2f2..aba6121 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -977,11 +977,43 @@ static int sata_rcar_resume(struct device *dev)
>   	struct sata_rcar_priv *priv = host->private_data;
>   	void __iomem *base = priv->base;
>   	int ret;
> +	u32 val;
>   
>   	ret = clk_prepare_enable(priv->clk);
>   	if (ret)
>   		return ret;
>   
> +	/* Re-use from sata_rcar_init_controller() */

    Why not just call it? Or at least factor out a common part?

[...]

MBR, Sergei
