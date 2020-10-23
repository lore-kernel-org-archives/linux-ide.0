Return-Path: <SRS0=RTe6=D6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE28C388F9
	for <linux-ide@archiver.kernel.org>; Fri, 23 Oct 2020 18:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EAAC22254
	for <linux-ide@archiver.kernel.org>; Fri, 23 Oct 2020 18:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rAbqxPC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750799AbgJWSVD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750665AbgJWSVD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2020 14:21:03 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827E2C0613CE
        for <linux-ide@vger.kernel.org>; Fri, 23 Oct 2020 11:21:02 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u62so2911860iod.8
        for <linux-ide@vger.kernel.org>; Fri, 23 Oct 2020 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P1VAgbL5Nu9xQpoma8IOMEGFKLYoq5WVSujqi1jyKgY=;
        b=rAbqxPC2VQNEYRxnvNmkLskSPPyOEPbWivfmxBlTPA3qayf89gJOsA67iWwnyVmZly
         YmyvWuRLcSU+rxm9DNZqJoJ7Dmg13gk7ZnGbnHxnq6WAJED74sQ/atQtQorP1Saeqvuh
         GUS+1r/fHdngbqyNCRuFFdrnYcGJl2TYKvlwIni/wlCcNWHIkInPmjNOqzX7hob/sT6x
         zmRDCzq1tBW4IYNHWMwuRLzaR0bDp/MWwj0A9PH4/zcs6kiwUki7NazXwgkdtph/M/RQ
         6Ms22QS//vHIcFOBMrJa0BLEHlrkMhMSRn8uHWU5Zf9jD67kjdrku8pKDA6HNGFueQ2j
         WaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P1VAgbL5Nu9xQpoma8IOMEGFKLYoq5WVSujqi1jyKgY=;
        b=mPmG7KkSPu4OI/XQv/f+qIdC7V/yAEmV0kYdGh4pvM+7GW2m+oQq1quCU2StF6mdnc
         rIdtT9s0FF73GwtYq2eL4I3LJP8LejDYD8OHgZuO3yYrAnx3WbX32n+IRo4PKGdYnST1
         EWkRMIVsUjHmGjNtw3XZ/kgbsduEkMIfxdwqbSsB74+56d4CuibrN06uM5WGAh2BJwkm
         UuiP3qIohdY9pDqGAvTtd5wrszaWBC+x5ze8MUDAykFfoAFIYbgGvecg3fdUIlvznqPG
         cnIiJO/XiE25gn08OYG+8Gr1pYY0xnv448bPbZb47AOZTlhaguPAeH8O3TVUxmPcF/Dp
         TB4A==
X-Gm-Message-State: AOAM5312uhlqvSjW7mgaZb2xpSUNq60hJZNKzd3s8E46uFiqVIRf6JFu
        BT0qNd7oGVUCvFqXtkYPhfkp3g==
X-Google-Smtp-Source: ABdhPJx8qoQk7VQ7uKvt2wBD9BQFogJlh+zzJNIe/v80ZeH6np9XqS2RoBJfDU8kUNV1urnbNmbYTA==
X-Received: by 2002:a05:6602:20c4:: with SMTP id 4mr2611908ioz.149.1603477261961;
        Fri, 23 Oct 2020 11:21:01 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c2sm1099963iot.52.2020.10.23.11.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 11:21:01 -0700 (PDT)
Subject: Re: [PATCH v3 08/56] ata: fix some kernel-doc markups
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <a7e159be08bcb0c42aa219cf99c2adfd4db0a9d9.1603469755.git.mchehab+huawei@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <25423969-161c-f471-2968-df4f3f9fd319@kernel.dk>
Date:   Fri, 23 Oct 2020 12:21:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a7e159be08bcb0c42aa219cf99c2adfd4db0a9d9.1603469755.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/23/20 10:32 AM, Mauro Carvalho Chehab wrote:
> Some functions have different names between their prototypes
> and the kernel-doc markup.

Applied, thanks.


-- 
Jens Axboe

