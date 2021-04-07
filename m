Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC378C433ED
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 21:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97ED7611C9
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 21:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhDGVg1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 17:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbhDGVg1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2021 17:36:27 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D126BC061760;
        Wed,  7 Apr 2021 14:36:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 15so22521683ljj.0;
        Wed, 07 Apr 2021 14:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JrUeoWDAwLF8WfYbVwCG1k/leFVTfETayh9XXmigLwk=;
        b=kFmtJUs1w4nKq60D1Z8YxtsCiBEbdvDH3/I4tZiUyMHXhs4+1MA2XJuNQoYA2uoVOS
         xNcUY3Dm1Z4XBdtqfVPqoOxW9LjZ4J6zTwNOSD9aIYKTLNCf0YhH8SHT85N7kKEMIoU+
         SU68YHOFjWDrdyhti4FCfMmSTnrg+6oihdZoAzYlTmYcXplXjUDX9D0wu0c6H6Ss3eyj
         FrJAbGkOwCCBxZkQj46c+YmKR7cOQ4oVjGxr/Y8Z+TkAPZdAxiyJooQUKpdGUOk6iD0f
         ifeBAL90FS6OWqc6n4i16QI/uNP0rh5OHfWf6fsJT5jepIF1UUCOzHwaFrnMK4BnqVNM
         3AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JrUeoWDAwLF8WfYbVwCG1k/leFVTfETayh9XXmigLwk=;
        b=NCPHVDrBNAC8KK0laVCXck5sq3TO8qHWK+AzOh/BG86G1ax7sdcRX3tvVsiFC02RG6
         b4EtUtM5WpYfHtQr5UDrFomZ5H9pArFlOPe5qXHjpeLDXmfbG/UHaB8QyUPG10Lfjvtr
         yo1n7+pCjagb3RghEZDeP2A6bFUnUL3n3Ssq5dpXAPV1MUkoAy0md5vL4WdU6ZBvt/sa
         kwdQJmpVOPJe8p5hFuy9IyK3rxOmIg6aOfcAg3V+clK4v3z52RDGEC0KgwWtdVqaxoud
         HdFAcdp0fw/GR3HWaQmf5O1nDAJ7V279ZGzz7WMTnciq4RHGJD2N4ZxN3dNcQNXWFlyv
         OuEg==
X-Gm-Message-State: AOAM531h/nbMdA2/Zjh/suYPhc9fASx3qsQEUgtPE5mNp3wNntGn9HlB
        0wlY1lbfhqIxAz8BEDtqOBUE6UVujgI=
X-Google-Smtp-Source: ABdhPJzXy6omT4lMRxJFSdIcGojW5H/pyAypO3SuWneV+c78my2iE3yh5F+IDsk/049EzdtBPXb3Bw==
X-Received: by 2002:a2e:9acc:: with SMTP id p12mr3334037ljj.442.1617831374250;
        Wed, 07 Apr 2021 14:36:14 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-85.dynamic.spd-mgts.ru. [109.252.193.85])
        by smtp.googlemail.com with ESMTPSA id f9sm2648610ljg.115.2021.04.07.14.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 14:36:13 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] ata: ahci_tegra: Add AHCI support for Tegra186
To:     Sowjanya Komatineni <skomatineni@nvidia.com>, axboe@kernel.dk,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org
Cc:     pchandru@nvidia.com, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
 <1617758731-12380-4-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <594c622e-4505-3448-1c7b-eae8f36cbad8@gmail.com>
Date:   Thu, 8 Apr 2021 00:36:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1617758731-12380-4-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

07.04.2021 04:25, Sowjanya Komatineni пишет:
> +	if (!tegra->pdev->dev.pm_domain) {
> +		ret = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_SATA,
> +							tegra->sata_clk,
> +							tegra->sata_rst);
> +		if (ret)
> +			goto disable_regulators;
> +	}
>  

Hi,

Why you haven't added condition for tegra_powergate_power_off()? I think
it should break GENPD and legacy PD API isn't not supported by T186 at all.

I'm also not sure whether the power up/down sequence is correct using GENPD.

Moreover the driver doesn't support runtime PM, so GENPD should be
always off?
