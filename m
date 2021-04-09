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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69749C433B4
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 00:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39DC561159
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 00:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhDIATf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Apr 2021 20:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIATf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2021 20:19:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F87C061760;
        Thu,  8 Apr 2021 17:19:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b4so6893647lfi.6;
        Thu, 08 Apr 2021 17:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0HUbUfwF1GD6jHQI39o5Gguska1AcCknFJCxAkrKEFI=;
        b=PYLLgXwSLFzdxpo7XlNcHo2sUNYz5BiicXISITBvdFckFdmsRNzsM8O4aO5ezy9CKm
         xTVauxmg0CiBDMUxjQV0TbVp23eCJUk1Yg7KQxkc4dpGb5MFWxZqmfVvutm1d3gsDlHP
         ktJc8eHAALm4QAkQkVRjjvaTmN2xXF4UjVT4WAJgHkou8oszAiX8Ba1vYEVkakMw6wG2
         Uc/PuntOYTu2xk+rge+6YxSvHhMFnE/SMPbf+5B0A+hR4Vc09fD/IQkcSHKCvh9I0ov4
         0HlnhoQEZlil6qFwNMeXXlMDuDNiJ2XaUOe3L5xo8OnFOf+nLQg06rDsO5sITBBCmzsg
         T+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0HUbUfwF1GD6jHQI39o5Gguska1AcCknFJCxAkrKEFI=;
        b=LBUtk1S+BSK3sgcQqXIQrGy6b/3SpMdDNKaervu5s3h8MYPvURJ6tpgrdtog+9shiT
         eYK8l1nDKaJPuQ7t7iBZAZ3qieapi/ckc47mjGpSVn55YqftLEF28I7Y6n0aJyaaKEgv
         +hIL3+NlBYUmY34/xwvodop8ZWOkPYypnPBQs89ksGgxDgKoF2M8OA2JhQW9eYDyJj6P
         LY22TqI5qZ7e9FBiqyM4OB9aY4EOd8GKHqEvJ3AQVOYt6YqIhc7hyZZUtf2u9NHkBdHl
         klUUAW7c6FxrfcbDuapm9ede+IMR+AIdKI1PTRENzVVeeNuNrBnIs31L9gxK4gEhXwa+
         kxXg==
X-Gm-Message-State: AOAM532+gcurVVf/nMkAVB5dgk+n8ri3zmB3BlCNetRsZ3ajc32BMHGS
        ljGeKI1dhYYw/F3/OAo80/5L21JE91Q=
X-Google-Smtp-Source: ABdhPJxYaR9exT6hkhu9x7zkbtQIn1ii0FCi0b8pz7mpADBkwOQCHIxfNwJUTueQdC+GgbRKf6gIWQ==
X-Received: by 2002:a05:6512:c27:: with SMTP id z39mr8669631lfu.244.1617927561147;
        Thu, 08 Apr 2021 17:19:21 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-85.dynamic.spd-mgts.ru. [109.252.193.85])
        by smtp.googlemail.com with ESMTPSA id u19sm91738lfq.252.2021.04.08.17.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 17:19:20 -0700 (PDT)
Subject: Re: [PATCH v2] ata: ahci_tegra: call tegra_powergate_power_off only
 when PM domain is not present
To:     Sowjanya Komatineni <skomatineni@nvidia.com>, axboe@kernel.dk,
        thierry.reding@gmail.com
Cc:     jonathanh@nvidia.com, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1617915315-13639-1-git-send-email-skomatineni@nvidia.com>
 <1617915315-13639-2-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f1c7a30b-7a29-2913-1ef5-f25eec8fb4ba@gmail.com>
Date:   Fri, 9 Apr 2021 03:19:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1617915315-13639-2-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

08.04.2021 23:55, Sowjanya Komatineni пишет:
> This patch adds check to call legacy power domain API
> tegra_powergate_power_off() only when PM domain is not present.
> 
> This is a follow-up patch to Tegra186 AHCI support patch series.
> ---
>  drivers/ata/ahci_tegra.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index 56612af..4fb94db 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c
> @@ -268,7 +268,8 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
>  disable_power:
>  	clk_disable_unprepare(tegra->sata_clk);
>  
> -	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
> +	if (!tegra->pdev->dev.pm_domain)
> +		tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
>  
>  disable_regulators:
>  	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
> @@ -287,7 +288,8 @@ static void tegra_ahci_power_off(struct ahci_host_priv *hpriv)
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

Looks good, thank you.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
