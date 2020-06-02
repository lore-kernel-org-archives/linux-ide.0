Return-Path: <SRS0=xCVQ=7P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF88C433E1
	for <linux-ide@archiver.kernel.org>; Tue,  2 Jun 2020 22:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF81206E2
	for <linux-ide@archiver.kernel.org>; Tue,  2 Jun 2020 22:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZmxnaFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbgFBWuC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 Jun 2020 18:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbgFBWuC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jun 2020 18:50:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4144C08C5C0;
        Tue,  2 Jun 2020 15:50:01 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z206so70602lfc.6;
        Tue, 02 Jun 2020 15:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K9/SgI9YdO/9LT3+Izi8n6c8S/w+ByCB2jxpSWaCAkY=;
        b=QZmxnaFyacmIQbFLMQ/PnU4x0JCALc+F7ifH8M1UhOriKjuHPMoB6ZgyyJu+jNK/Ra
         IFN4bfvWvQPI3nPohkNHPVWlseiPNu4TFNaoDpGXKyxc95gSsaxO3gxRW7LVawYPx+A6
         NvuARXBHOc4Qw7clC8MfW/EkJkcJMBEltK22ceI0A/wxCXfoJYqgiBz0N2K9ZLy6Gx8P
         P9l6D119uApNn4vQR/HeBuZVQTBXmsiatc4N8y+MBomPTZm0Ej61aExGlzbh/Us2DW9r
         vPBe1Sfgu3iKt0HEKyhR3u4Id0kn80SPbn2kAnKrNVrQl+4rhDG8ZGLucePRJyGTy3yT
         ez7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K9/SgI9YdO/9LT3+Izi8n6c8S/w+ByCB2jxpSWaCAkY=;
        b=OYpRa1LqXorPhTKqWQiAmTC2D4qVDEa3DzjPUc77z17JpGHWVix5a2ilxtAJwD4eMO
         p970ucdILzdpuYtYYAkwJAeU7R56EItBgP1c7XJcM0ElSgcAO+/ew3pHG3Ad9gcrzGGM
         mV9erYBkhcR+PWNLQ23ASC+RUAtvIB6TdXqlgtDlXr/AZ+Wb7DO3rZvnz13hckXnm0ox
         v553Fzw4JrjuvzGSBk3N5Wreg2YXh5qtDsZOs5akcjhZ3XHox64kA17j2+mc6oBYBVDK
         du74LHCzlxd0kyBYYOEWXMue14zBWmFJjK4oJZ2xOUPlDM8tnHJGmhjZNnp+3SVF7rMI
         jNuQ==
X-Gm-Message-State: AOAM5314hwFwHX5gJB7gs6m0OxFC1iUqYqKYy+HZ5qJDWUzxABmgvYic
        45hJBQjWhrmtV/ClmKwmtzIGJ32b
X-Google-Smtp-Source: ABdhPJxaG2sb/6jK3MGpf0asba7yX6FRD8JQxmwB7Mz7pBlOjg99gaFWaTIFle1G7zsW7o9E1zV55w==
X-Received: by 2002:a19:6e0e:: with SMTP id j14mr796240lfc.155.1591138199679;
        Tue, 02 Jun 2020 15:49:59 -0700 (PDT)
Received: from [192.168.2.145] (109-252-173-94.dynamic.spd-mgts.ru. [109.252.173.94])
        by smtp.googlemail.com with ESMTPSA id m11sm101077lfl.70.2020.06.02.15.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 15:49:58 -0700 (PDT)
Subject: Re: tegra124-jetson-tk1: sata doesnt work since 5.2
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        pgaikwad@nvidia.com, pdeschrijver@nvidia.com,
        mturquette@baylibre.com, sboyd@kernel.org, axboe@kernel.dk,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-ide@vger.kernel.org
References: <20200319074401.GA4116@Red> <20200531193111.GA15331@Red>
 <ff9923ca-1d02-ab5e-c335-83ee2e993061@gmail.com> <20200602081958.GA21773@Red>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <56700c1d-ffb0-e44e-ea8e-48a848ccf3bf@gmail.com>
Date:   Wed, 3 Jun 2020 01:49:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200602081958.GA21773@Red>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

02.06.2020 11:19, LABBE Corentin пишет:
...
>> Sounds like PLLE needs to be enabled for SATA, but ahci-tegra driver
>> doesn't do that.
>>
>> Could you please try this change:
>>
>> --- >8 ---
>> diff --git a/drivers/clk/tegra/clk-tegra124.c
>> b/drivers/clk/tegra/clk-tegra124.c
>> index e931319dcc9d..7dbc14652830 100644
>> --- a/drivers/clk/tegra/clk-tegra124.c
>> +++ b/drivers/clk/tegra/clk-tegra124.c
>> @@ -1330,6 +1330,7 @@ static struct tegra_clk_init_table
>> common_init_table[] __initdata = {
>>  	{ TEGRA124_CLK_I2S3_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
>>  	{ TEGRA124_CLK_I2S4_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
>>  	{ TEGRA124_CLK_VIMCLK_SYNC, TEGRA124_CLK_CLK_MAX, 24576000, 0 },
>> +	{ TEGRA124_CLK_PLL_E, TEGRA124_CLK_CLK_MAX, 0, 1 },
>>  	/* must be the last entry */
>>  	{ TEGRA124_CLK_CLK_MAX, TEGRA124_CLK_CLK_MAX, 0, 0 },
>>  };
>> --- >8 ---
> 
> This patch alone does not fix the issue.

I'd try to enable all the clocks and voltage regulators that are enabled
by the USB driver. Also won't hurt to check the clock rate
configurations with the enabled / disabled USB, try to replicate the
working configuration.
