Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF9EE9371D
	for <linux-ide@archiver.kernel.org>; Mon,  9 Oct 2023 22:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378897AbjJIWeC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Oct 2023 18:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378146AbjJIWd4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 Oct 2023 18:33:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD109D;
        Mon,  9 Oct 2023 15:33:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888ADC433C7;
        Mon,  9 Oct 2023 22:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696890832;
        bh=SqwELZKRRuBe3Ch6v8C6DiGONdk8e4b2k3YhcgPmCwg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DAA0AWXW50izTDwLp/Y7ZNeZZhO07pOVHrat8HIGbz1WDA6jbvuRM0nYtTNTlWsFS
         rwpkl4ie0RoQFWRpUMviigTIy+Kac4IPI6YngEHmJzxaj4S9Us9gyPW/6hAUoam0LB
         HkhDvyid2Mb1bYICOLh79Pd4h2M0zP566RFpO+dG8FEQIV9L4MPI7lpeMAOlmKMazj
         SK5ZCrIQR8MhU8fNtshHWYipAEH+Df9l5LTK6GGuChbP0imSgoYzmmSGPDD6QUCkyV
         FKo1ldIM73Hp4jNnlgxfV6OYLe8yvE0SH9OdeAyny5rgg8wPPVvMxJ1PEB2R+DFumh
         NLe70IWTq9uLQ==
Message-ID: <2c877878-7e30-43d6-ba93-d37cc2fbb1ef@kernel.org>
Date:   Tue, 10 Oct 2023 07:33:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: sata_mv: aspeed: fix value check in
 mv_platform_probe()
To:     Ma Ke <make_ruc2021@163.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231009124955.4046988-1-make_ruc2021@163.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231009124955.4046988-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/9/23 21:49, Ma Ke wrote:
> In mv_platform_probe(), check the return value of clk_prepare_enable()
> and return the error code if clk_prepare_enable() returns an
> unexpected value.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/ata/sata_mv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 45e48d653c60..df3a02e7a50b 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4125,8 +4125,10 @@ static int mv_platform_probe(struct platform_device *pdev)
>  	hpriv->clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(hpriv->clk))
>  		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
> -	else
> -		clk_prepare_enable(hpriv->clk);
> +	else {
> +		rc = clk_prepare_enable(hpriv->clk);
> +		goto err;

This is wrong. The goto err should only be done if there is an error.
Did you even test your own patch ???

> +	}
>  
>  	for (port = 0; port < n_ports; port++) {
>  		char port_number[16];

-- 
Damien Le Moal
Western Digital Research

