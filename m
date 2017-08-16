From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sata: ahci-da850: Fix some error handling paths in
 'ahci_da850_probe()'
Date: Wed, 16 Aug 2017 12:04:52 +0300
Message-ID: <928002bb-9f1c-d7df-e04f-fcd5dc5dd73e@cogentembedded.com>
References: <20170816053103.19773-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:37092 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbdHPJEy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Aug 2017 05:04:54 -0400
Received: by mail-lf0-f42.google.com with SMTP id m86so13641922lfi.4
        for <linux-ide@vger.kernel.org>; Wed, 16 Aug 2017 02:04:53 -0700 (PDT)
In-Reply-To: <20170816053103.19773-1-christophe.jaillet@wanadoo.fr>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello!

On 8/16/2017 8:31 AM, Christophe JAILLET wrote:

> 'rc' is known to be 0 at this point.
> If 'platform_get_resource()' or 'devm_ioremap()' fail, return -ENOMEM
> instead of 0 which means success.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/ata/ahci_da850.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
> index 1a50cd3b4233..eb46cad4d514 100644
> --- a/drivers/ata/ahci_da850.c
> +++ b/drivers/ata/ahci_da850.c
> @@ -216,12 +216,16 @@ static int ahci_da850_probe(struct platform_device *pdev)
>   		return rc;
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (!res)
> +	if (!res) {
> +		rc = -ENOMEM;

    -ENODEV would fit better here.

[...]

MBR, Sergei
