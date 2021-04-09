Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E211CC433ED
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 14:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A483161165
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 14:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhDIOB3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Apr 2021 10:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbhDIOB0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2021 10:01:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A6CC061760
        for <linux-ide@vger.kernel.org>; Fri,  9 Apr 2021 07:01:13 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y32so3952334pga.11
        for <linux-ide@vger.kernel.org>; Fri, 09 Apr 2021 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6eCIOZtRskFd5iRZl3iLyX27/3QMWpN7siJJcos95N4=;
        b=o3gxix8Uk8CY+/8UAMDuUSsRxf+63cR1Vmx6mChO/Mq3XMk8NtMKzJ2SXX12mcRn12
         qjsSbp0a3jeZZCKplrzaN04O/ObIyn2LjGYbAIzg4bD8PMeXRT26lBN10ynxandU4xGe
         hNFoX3qupZWBjNzF2oZdx4Gg7k2qLOQa4DomFGvz2reginXttxo8elg8uMbu37YmZCsM
         T2+nj323H9lmUuJLEPs7xolii/0EeFnGD5vCQzYe+FfXXxtASu/N6ZqDgwiLpqTCwAnX
         j6UG6apDPX/nAGshHbFFujCbt27HmzYsU38LiU6Pq5ZginzsKVW89M4CJX/Cz5SyiFVF
         yKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6eCIOZtRskFd5iRZl3iLyX27/3QMWpN7siJJcos95N4=;
        b=ntysrTFDMjwDPug/aqS82J07W32fER3vfQ3yAFmQ5PMbRAWhECSmnfSdxlyrIgRkvm
         2F4cx8iLf5KbPT3IpHMIZiuYLkF7lRambOum+rCPUr1aah+ycx2ljpgL1nBnFiWAnPI7
         zHutOMRQl52BFNBXtTbddFQ8EnWLalN1FVO8rE4i7J4a7zX/GpkoAEjNU0+d0+wGpSFt
         sVwGxdiF9beKjbZNXe9BBlpcHKFDK1Lm0XNNQVKTCqAeRnWBx4dq6cmA9a6+8ypBI1rD
         G3iEv6M6nqL+hiAKDUzF+gjNmItfDgKiU9TEo1Y7DJftgaW1xBR1mVJVEt0lsXTGzeML
         +mIg==
X-Gm-Message-State: AOAM530EcwkJfxHOTIz0776tc1NWlP1hk3FefUVi/PsdiOoAWd4DKwdR
        bIbIMuibzL7BsmSw9I61XAafcw==
X-Google-Smtp-Source: ABdhPJy/2ByF3EcSkPJZxhmKSWKRQXNCBWC/tLgJexjTC89PuC14Kd11uQuIc0y8x2ivfSr+f94ZtQ==
X-Received: by 2002:a63:cb44:: with SMTP id m4mr13402369pgi.4.1617976873031;
        Fri, 09 Apr 2021 07:01:13 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id t184sm2862124pgt.32.2021.04.09.07.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 07:01:12 -0700 (PDT)
Subject: Re: [PATCH v2] ata: ahci_tegra: call tegra_powergate_power_off only
 when PM domain is not present
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, digetx@gmail.com
Cc:     jonathanh@nvidia.com, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1617915315-13639-1-git-send-email-skomatineni@nvidia.com>
 <1617915315-13639-2-git-send-email-skomatineni@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6dc52280-03fd-f9f9-5fab-6683dbcaf256@kernel.dk>
Date:   Fri, 9 Apr 2021 08:01:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617915315-13639-2-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/8/21 2:55 PM, Sowjanya Komatineni wrote:
> This patch adds check to call legacy power domain API
> tegra_powergate_power_off() only when PM domain is not present.

Applied, and added a Fixes line.

-- 
Jens Axboe

