Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5B1C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 15:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C27461502
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 15:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhKSPtm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhKSPtm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Nov 2021 10:49:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6B0C061574
        for <linux-ide@vger.kernel.org>; Fri, 19 Nov 2021 07:46:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id l22so45006834lfg.7
        for <linux-ide@vger.kernel.org>; Fri, 19 Nov 2021 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=el0wPWQ70k3YzSd0P00OifNH8CT9lhrA+2zZbiVZFz8=;
        b=LpxXiMa9j53v9kg00D72MFMmLUIyEJZOkv6cCR4VwXu3rCfugeDm5INg/Z7di/KK8r
         ZKgLGbWWLfTEl4MmmsQ7Aq+n61ZfajyqWW4vTM9Wt63z8ck7PRfZTcRTcFB5FPRBLYoF
         oSAWn8GBYUBSR//jiL32ceFkBDFZ5j0+A7wmxheZrqS+VMGqpGdl4yhApls+ClIx9BN7
         V3CBojO1PHqC+aN9oTvkI3pTlC4riySKWXJyKhFzULEAwvdGhp0c7M4x12V1B3tGdT+V
         dgvpRNFbViJcuTjHGLBjaqWWBzdxDI9Yy4tQjv8J0neCl3otRgkpzsqgbzguAaRUvSzj
         VkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=el0wPWQ70k3YzSd0P00OifNH8CT9lhrA+2zZbiVZFz8=;
        b=Mhy3AU9zxcINZb4NTdrrYNUPU0lRBXmmhk+RA0j2kbKVgqLTgpUxsu5Q5xxp4qO8mn
         n3Y7uvPqGXyiI6013NNExK/IL49SqyF+rgXu8JL625yGf9V4o1a8eM/7xT6k0mRTd9HW
         Jx7AwpNoMtBinDjTKDc0Kyr/yQIgZz3Ai+B+2pn2V13OTECzKrBjhbV+M6gAI3vxDizM
         CyjOyfF2bjo+3YSVbc4h62y921ht2oI/gFZ0bfCQYLN3xXiZC6rsUtGzHkgEqJ9XTsaj
         BuaI+YYhj2Y1FFcQaJmjgbua8kVKRCf2sR5zxLX/tbN5kdTgdTXg8iYdhM73WCELeBWn
         RE4g==
X-Gm-Message-State: AOAM533Fvado50BtmxycUlszM4ubD7TRCNcSDbPKd0EA0M+mBsj4ieOP
        ByUhfq8GppwrrPLWpxETRSP7Wbo9eTU=
X-Google-Smtp-Source: ABdhPJy6vtkSfeOCxre0xLHmvaiRju36O/qk13Aj89dbUPvJeyr5SEyM2fvL1ji7NMA+lqv6YsFTZg==
X-Received: by 2002:a2e:858f:: with SMTP id b15mr27056896lji.177.1637336797125;
        Fri, 19 Nov 2021 07:46:37 -0800 (PST)
Received: from [192.168.1.100] ([178.176.79.231])
        by smtp.gmail.com with ESMTPSA id j21sm17737lfu.151.2021.11.19.07.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 07:46:36 -0800 (PST)
Message-ID: <434d3413-2a58-2745-ae28-84ef3f9a7e7b@gmail.com>
Date:   Fri, 19 Nov 2021 18:46:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [GIT PULL] libata fixes for 5.16-rc2
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
References: <20211119084919.83906-1-damien.lemoal@opensource.wdc.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
In-Reply-To: <20211119084919.83906-1-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 19.11.2021 11:49, Damien Le Moal wrote:

> Linus,
> 
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>    Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>    ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/libata-5.16-rc2
> 
> for you to fetch changes up to 6873c30c1b797997f302fe1707bee9a7f247dfe2:
> 
>    sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl (2021-11-19 13:57:18 +0900)
> 
> ----------------------------------------------------------------
> libata fixes for 5.16-rc2
> 
> * Prevent accesses to unsupported log pages as that causes device scan
>    failures with LLDDs using libsas (from me).
> * A couple of fixes for AMD AHCI adapters handling of low power modes
>    and resume (from Mario).
> * Fix a compilation warning (from me).
> * Fix sata_fsl driver problems on PPC64 (from Baokun).
> 
> ----------------------------------------------------------------
> 
> Baokun Li (2):
>        sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
>        sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl

    At least this one needs fixing! You were too fast at merging... :-/
    Well, I guess this will need a follow-up fix now...

[...]

MBR, Sergey
