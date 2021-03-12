Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF4FC433E0
	for <linux-ide@archiver.kernel.org>; Fri, 12 Mar 2021 17:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFCE64E90
	for <linux-ide@archiver.kernel.org>; Fri, 12 Mar 2021 17:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhCLRo6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 12 Mar 2021 12:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhCLRob (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 12 Mar 2021 12:44:31 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97CEC061574;
        Fri, 12 Mar 2021 09:44:30 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m22so47022477lfg.5;
        Fri, 12 Mar 2021 09:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9p+6crPVTKO5jDdgUnEeHwgSoJZRdqpk/Rdx9Jyzecw=;
        b=hm9wUkGCRfeBjFDsWqqXKrTp3zexm2+Zhxyz9WwPuMMMU7FzJai/9bL9H1vWDa3rZh
         2AJUkwOW0D3thImZvYWjWijjFrQwezTS+HcH6zX6PBnKRfkyNiKeVXXTujOIfuehoUeS
         fP9iTqUcVSNNoGyyPUb57Hw22kq34TgCSWr2mmWTgZE7QE0ThAzEB1SCZz96AtOX7ell
         q4x17OydoGah42Qhj4/SZ2+UcLAJfoEWovCd882U8/dZdEZqxZb+R1e6ymJokS+sU73A
         T3p8xsKNrsz/dN+vP6bf4yzLxbCIc40sEsvzfoayGEatbmxMsl9vmFTqfkRDlfH9fPHJ
         Pwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9p+6crPVTKO5jDdgUnEeHwgSoJZRdqpk/Rdx9Jyzecw=;
        b=JYEVv6w/EWwDesREHdFU6j0qhMwos08kpMY27FwEcasslJOKOtLowrsyLIu6VQtsEv
         122/ikACU3LaIESgQvQHn/xX+kWdjn1qsHVMqffqJ2vBcvFYXYZorWykqyEML1/MQKMc
         6zdpCDZcpQEtVCgbnIR89XcHDE+/9xCEpVwKX3C7UbVc/cSBP6VxPJkpxSmlMUrJUJgD
         ODQVDERHZxNJFM8Nh7rcf1wsvxgXed/CVxmjz1MQYS0k9zrwoJGVnsC63Mq+ZQAhyBkT
         LoHvRuCAYmzVYYmoPYS4TBeCdtSrk1v/2/tDFzPVJYTMJyCID9zwoD/EZGuaayNUTkyl
         1j5A==
X-Gm-Message-State: AOAM532Uw3Wn5ja78RmiNAEuzaJ8JKHCeU4ToDSmpeAE3zCyYQ3d/oGG
        AHnRAkh+hSw9MHm4AT6J6hsSiaNvv5A=
X-Google-Smtp-Source: ABdhPJzOq5SbUGlDSp7tr+cAKpAc2Lsm7ce41JR8dpgaidBVQmtnVnTq2ItOQVlwGsx7wtL0R8H5PA==
X-Received: by 2002:a05:6512:118f:: with SMTP id g15mr223051lfr.274.1615571069192;
        Fri, 12 Mar 2021 09:44:29 -0800 (PST)
Received: from [192.168.1.101] ([178.176.79.22])
        by smtp.gmail.com with ESMTPSA id r23sm1813573lfm.73.2021.03.12.09.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 09:44:28 -0800 (PST)
Subject: Re: [PATCH] ata: Trivial spelling fixes in the file pata_ns87415.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, axboe@kernel.dk,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210312085738.9372-1-unixbhaskar@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <47afbdf4-4e74-15e6-0a53-8a01b6f1ed2a@gmail.com>
Date:   Fri, 12 Mar 2021 20:44:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210312085738.9372-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

   For the future, the driver name should go instead (or after) the "ata: ", like this:
"pata_ns87415: Trivial spelling fixes".

MBR, Sergei
