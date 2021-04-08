Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F130CC433ED
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 19:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7FC610E6
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 19:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhDHT6V (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhDHT6V (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2021 15:58:21 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2BDC061760;
        Thu,  8 Apr 2021 12:58:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d12so5969932lfv.11;
        Thu, 08 Apr 2021 12:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c0I+5ABydgeUMYGikWNT2jbIpevXFH6iMkyWNZ96ZK0=;
        b=ai7/jrDvUdF4dSn5CVBuVxTXAKkrGqJ88wy23hzx41TKa7hZzyNFeQOpvVRsn70DDe
         5bA0UT7yaL6s1B86Il8NffinLFzrxXSi0iZCaq1nC0VePrrEE0OhhL9urHECOfziKOvu
         ZXSf10Gp9fp+byDY9ziKnjR5T25vYOhQkRL8yAtljvevw3mlIbz9PTjw70+q4eFNIYcm
         NNR9/auR2uD9zy3sdZEvlg78N10zMnkn/YI5kv4qTVqetDHzMDRMaUxzN057bqO3fx0I
         5aEnozkRINRrch2jmL50gWds+YjV/IdKwzmcS6ZwBdikG3P+4wzSxIHP/czoV4oQNZ9N
         WE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c0I+5ABydgeUMYGikWNT2jbIpevXFH6iMkyWNZ96ZK0=;
        b=G0cKVd259uNu+Bxpp3YdFqGsswdKknnfqSAJyrxLbyqsYpthAOcKGTRh1ohwxcLXaf
         J28yFeju2k3ASiqZh7hfu8M2bZTj0HEiK5xYXtgycsj6gzLoZyiq6kgsdnjKOgLTPvNm
         Fc+IwCIgsCzFKLOnu2EUwnlIbiDxRGVX5PlIUREmZR8rHRiKu4sN6vi5cw9x/Fe1jxv4
         yP7So11zPn7xxago1AZMgOA3QuhhBzJuFDXcDesdirLUH4+ACxCQPGDH4dFW5P8AtkT7
         ni6VaoQL/RViY+ZvLUV2QNWNdH1AS1seDPWLnirSKJVNRDebW0ccLX5bKtcmBvBc3ykU
         8Jzg==
X-Gm-Message-State: AOAM532jrw6S3LUn1QsBqPSwLLM9z/AeHqLsRsxQUxFtiyYfJBW2uqUE
        j9FNbWE0JAt9BeIx/slGIsp1pBGAM5U=
X-Google-Smtp-Source: ABdhPJw8dBGctQy6gvBJlnwgfYIsNWw4lfW+wh8LlOesfZpw+YSquKgA8n3T/rVzlkaJVcZtaJqNLg==
X-Received: by 2002:a19:8682:: with SMTP id i124mr7872861lfd.406.1617911887666;
        Thu, 08 Apr 2021 12:58:07 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-85.dynamic.spd-mgts.ru. [109.252.193.85])
        by smtp.googlemail.com with ESMTPSA id w5sm29406ljo.11.2021.04.08.12.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 12:58:07 -0700 (PDT)
Subject: Re: [PATCH v1] ata: ahci_tegra: call tegra_powergate_power_off only
 when PM domain is not present
To:     Sowjanya Komatineni <skomatineni@nvidia.com>, axboe@kernel.dk,
        thierry.reding@gmail.com
Cc:     jonathanh@nvidia.com, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1617900043-10506-1-git-send-email-skomatineni@nvidia.com>
 <1617900043-10506-2-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <32ff84ba-60a7-e498-d656-bcd29d23fb02@gmail.com>
Date:   Thu, 8 Apr 2021 22:58:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1617900043-10506-2-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

08.04.2021 19:40, Sowjanya Komatineni пишет:
> This patch adds a check on present of PM domain and calls legacy power
> domain API tegra_powergate_power_off() only when PM domain is not present.
> 
> This is a follow-up patch to Tegra186 AHCI support patch series
> https://lore.kernel.org/patchwork/cover/1408752/
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> 
> ---
>  drivers/ata/ahci_tegra.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index 56612af..bd484dd 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c
> @@ -287,7 +287,8 @@ static void tegra_ahci_power_off(struct ahci_host_priv *hpriv)
>  	reset_control_assert(tegra->sata_cold_rst);
>  
>  	clk_disable_unprepare(tegra->sata_clk);
> -	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
> +	if (!tegra->pdev->dev.pm_domain)
> +		tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
>  
>  	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
>  }
> 

There are two instances of tegra_powergate_power_off() in the driver.
