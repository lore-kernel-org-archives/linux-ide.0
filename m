Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB83C433ED
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 15:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D696113E
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 15:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353712AbhDGPpM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 11:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353688AbhDGPpK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2021 11:45:10 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36123C06175F
        for <linux-ide@vger.kernel.org>; Wed,  7 Apr 2021 08:45:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t22so6216616pgu.0
        for <linux-ide@vger.kernel.org>; Wed, 07 Apr 2021 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+qfQCQqId0WTspRAj4kz6DuPB09HIJxxoSgf5ROVgtM=;
        b=zmWDPmjOJmFr7kDuBGoTtaYx65S49XI98JpsvFJrN+najC/kfuYlju+4YXn2rnHmUi
         hKq9yUAR5Hwnc9WnhI7+GZ3iJQCBlLZ8HXqvdrIg96e3uB0ancsgISylaUSWqVmXEpU4
         hh10dqyrwlEo9q/hJ0S7WdeynSlbcT2CA5aM0AlXyPP2nRHf79TDkn3djBC6sPIriyWO
         xrkkUgoxRlKNfEAXyKMfeSTntfwt27rm61Xb7lqMuTAgs3EZ3ON8UuXiLye6oHU22zxl
         Ne7ffG+3Xzb+BEyrXLheNR++l2nfE82BE3WWePEyL/TJz2GW8N0cfxJZK6jZAQxeXFnt
         nXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+qfQCQqId0WTspRAj4kz6DuPB09HIJxxoSgf5ROVgtM=;
        b=TsuM1t41pLMLYjHv5HKW8K3iLqdmtoX1O/9sAONDF8L0STT/5vx/1PAjgzsrz7dr+S
         rD6w+Qk+NHeS/cYh+4qAqcpLf9slmoXbyk2oPaTuSJy8zW3XIWbUZghmuYXofzzeQ8Gv
         +RELqijGtRHavDoUpP8msozW7akLHqnvAAB23ECQUUvxSeV0o2G5lVF5bTLbZlZGDoKP
         dghQW0FuKXqbxxUXez8iw84jyyJhlfkB5nSFNpHUF7lZiTORVabO8GokURJMcvWI5gCc
         RSMLyzB7rh5iw8jTr0UCH4uLKDaEXg7r++2Z46/ATAJuu6zDRnnVKF2BMPeNbnikMMuJ
         RD8w==
X-Gm-Message-State: AOAM532TcjZs8k62YBX91NwragGi57vzb3f6QV+m3N+sgOfFzP16Uj8R
        hINeo7Nk2LqOEiP30uV/Dz262w==
X-Google-Smtp-Source: ABdhPJzuYOTIM+pn84VM/EafCuxxJjRcVVjW6OOlNG5TbX/HcZet0ywbD5ohAK0Cux12gVhNKEUXuA==
X-Received: by 2002:a63:770e:: with SMTP id s14mr3749330pgc.377.1617810299745;
        Wed, 07 Apr 2021 08:44:59 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id x1sm21865932pfj.209.2021.04.07.08.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 08:44:58 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] Add AHCI support for Tegra186
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org
Cc:     pchandru@nvidia.com, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2cf9a0ee-034c-7d31-1fa4-66e6ad3ceb43@kernel.dk>
Date:   Wed, 7 Apr 2021 09:44:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/6/21 7:25 PM, Sowjanya Komatineni wrote:
> Re-sending dt-binding and ahci_tegra driver patches as v4 as device
> tree patches from v3 are merged but not the AHCI Tegra driver.
> 
> Missed to add Jens Axboe to mailing list in v3. Adding for v4.
> 
> This series adds support for AHCI-compliant SATA to Tegra186 SoC.
> 
> This series includes patches for
> - Converting text based dt-binding document to YAML.
> - Adding dt-bindings for Tegra186.
> - Adding Tegra186 support to Tegra AHCI driver.
> 
> Delta between patch versions:
> [v4]:	Same as v3 except removed device tree patches as they are
> 	merged.
> [v3]:	fixed yaml example to pass dt_binding_check
> [v2]:	v1 feedback related to yaml dt-binding.
> 	Removed conditional reset order in yaml and updated dts files
> 	to maintain same order for commonly available resets across
> 	Tegra124 thru Tegra186.

Assuming the libata tree is the best way for this to go in, so I applied
it for 5.13.

-- 
Jens Axboe

