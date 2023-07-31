Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2201BC001DF
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jul 2023 09:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjGaJ2O (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGaJ2M (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Jul 2023 05:28:12 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDCD10D
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 02:28:11 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-768054797f7so392467985a.2
        for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2023 02:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690795691; x=1691400491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xRd6XfsrUljhkvWS0GIts8s9kgWyMVenYfvpmmzPwCA=;
        b=LsVCcn5PqnhYrxS8zpHZELd37uWJZEpLG5DLU3hpH+8YNCGUWsqyZq/qej9owvkO6M
         8R988/XFagpj15xUOZa5Gs0aYeiP8F2uLIrEW+0I1PopDAK1aeueKk70t9heUn5Tx8TW
         vc8uC5xtuBLC0hRarhLHy0SN/RZMdO/hFu+GrwzG4ic/1Hm2q6ow9Grt+z0c8r099N9b
         cMgyRKhgN2wYGGWwzxmqkNcYy66G03+F0njHa8/Y0iEDmaccA0KLLIwOuPvsN2YDTAAx
         BESQEeOqlKoodDLzU8tCIGOpWGiPtd1dPYoO7ICxN8ETNectYZHyDz7fjxrZpxkBNAUn
         jn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690795691; x=1691400491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRd6XfsrUljhkvWS0GIts8s9kgWyMVenYfvpmmzPwCA=;
        b=EE11SRIB0hIAwRCBOY2l4ciuq9bXIYu/c9E7Ych/OVb2EgKIrDafYany6AYtT13vWf
         VhgQap+7v1nY8JceGS8+UMUHoNn/HekdqKd1Gi7fBK9/WxyVUmUCqtd/YGoC5R8MMwio
         vbEugLGMEZ0u+D8xG/vpnAuhMDb6egY4i4vVV+MiO0z6VhWxDMvNqUX+5Ftm6KNkLwHU
         zev0k+qAfEIWQ9v1buVNRXyQ4M8Y16kQq3scQV3Y7jkZmgIcfl4LCHNPnAe5oYo12AS4
         BRLNavYHfMCeOSceEd6/k+LrvWMdb3btGlA1cd+fF/72NbG0zpWctB8kwW5UINhTzov0
         EavA==
X-Gm-Message-State: ABy/qLaH1m+QLy7bvbg0RhmuyExCSLoEcqoBYKfCBcQjZdiWxqX49+pJ
        2/M/1qZLgvzrMuvegKAtEfxd4MVVsX8aOc+b0wo=
X-Google-Smtp-Source: APBJJlHp0IYkac3quorrJD1GFI4HSv8HI/hwmNpdFAwCl1q6lA1u36fvN8ln7ggWpBDNxyO/kqk0Gw==
X-Received: by 2002:a05:620a:1a03:b0:76c:b2d5:5bbe with SMTP id bk3-20020a05620a1a0300b0076cb2d55bbemr2332665qkb.14.1690795690840;
        Mon, 31 Jul 2023 02:28:10 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id x41-20020a056a000be900b006815fbe3245sm5171093pfu.37.2023.07.31.02.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:28:10 -0700 (PDT)
Date:   Mon, 31 Jul 2023 14:58:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 01/12] ata/pata_arasan_cf: Convert to platform remove
 callback returning void
Message-ID: <20230731092808.jdrwp27vyblna2ug@vireshk-i7>
References: <20230731091636.693193-1-u.kleine-koenig@pengutronix.de>
 <20230731091636.693193-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230731091636.693193-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 31-07-23, 11:16, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/ata/pata_arasan_cf.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index 6ab294322e79..e11eea2e749a 100644
> --- a/drivers/ata/pata_arasan_cf.c
> +++ b/drivers/ata/pata_arasan_cf.c
> @@ -916,15 +916,13 @@ static int arasan_cf_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int arasan_cf_remove(struct platform_device *pdev)
> +static void arasan_cf_remove(struct platform_device *pdev)
>  {
>  	struct ata_host *host = platform_get_drvdata(pdev);
>  	struct arasan_cf_dev *acdev = host->ports[0]->private_data;
>  
>  	ata_host_detach(host);
>  	cf_exit(acdev);
> -
> -	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -965,7 +963,7 @@ MODULE_DEVICE_TABLE(of, arasan_cf_id_table);
>  
>  static struct platform_driver arasan_cf_driver = {
>  	.probe		= arasan_cf_probe,
> -	.remove		= arasan_cf_remove,
> +	.remove_new	= arasan_cf_remove,
>  	.driver		= {
>  		.name	= DRIVER_NAME,
>  		.pm	= &arasan_cf_pm_ops,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
