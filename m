Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8F6C49EA5
	for <linux-ide@archiver.kernel.org>; Fri, 25 Jun 2021 00:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1510B6137D
	for <linux-ide@archiver.kernel.org>; Fri, 25 Jun 2021 00:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhFYAvq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Jun 2021 20:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFYAvq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jun 2021 20:51:46 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36011C061574
        for <linux-ide@vger.kernel.org>; Thu, 24 Jun 2021 17:49:26 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v3so10567026ioq.9
        for <linux-ide@vger.kernel.org>; Thu, 24 Jun 2021 17:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3PR/UUWyRo3W86jHkTCrMGfl2K4mSiZxkeLBFZAP1Fk=;
        b=zp1bHW9KUWJi4ZFV5WTYC81AR3omUkBmmTvp02R4K5SuzzL9ksQP/V2cIMR8kZVb6s
         D1mYoyckpBqtKh7OAa0aniIP0CzD1qKNjmt/LusyOXdHyD2jjQhCOPnoXpAPnr8N2dSI
         NqlYnAm/pSqaFCjQlVXQN2vZBEdI0UJ1i3WNpKmM4z/fdM+HV69bQTmo3VpbNBaocFfq
         BiKSIq5wpFEb8w3aSeLguSW8mhc4vV5UBXeNYT7N7/0oRrPFpMYP3GALhw5gElYAH1pZ
         rxqEqIVu3lzPOTNSAyBjKP3X9nelKqfUV7w820XEvJ7mRDR6qiyJhjbzzdshQztlfxWq
         Cmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3PR/UUWyRo3W86jHkTCrMGfl2K4mSiZxkeLBFZAP1Fk=;
        b=H/UsgauwZUnUkXaS+CjA75q3ioejB/3AUeVCxECURjuKQX70Y9VZYBFEOBcDmXnLyW
         31jWHseGpwyP65FUp4j49/lS+AJnzByOMKe4J65u4kkSDmndcpvFEGesVmJfJkTOvN9L
         c52+qY74LceQnQbpv0zuNrqTE9S9jOcDPIQ/RJQxUoyNXm19X/zzBas+g8lSTFlZhHzC
         QOeH9LdWHVtUlb6HIrpNpfcGGoPzXKJ+IiIv/dculi6LoLAdhbXK4fMjfg/QIgIUIxE/
         OuQ36C6oqhC32Kvz3Tx37Vs6BARHXhw9mbCUHs7zqdrimwCqunYmBaQuIwnfqoDPMgkn
         CCsg==
X-Gm-Message-State: AOAM53238YSOQTT5P9JzzEo5G40b977fkAwj3+NYtZVGmzqy3H4CHyyP
        AKtLayDUFiamA02q+FB7EabP3Q==
X-Google-Smtp-Source: ABdhPJzl3Ao3+69Nt+XJsgbEnmxvRKyJfWDOB6efG73px9/nSiJE70wm/ddnuIFkkRoTTREqJA1ejA==
X-Received: by 2002:a05:6602:12:: with SMTP id b18mr6007226ioa.115.1624582165656;
        Thu, 24 Jun 2021 17:49:25 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id h18sm2595750ilr.86.2021.06.24.17.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 17:49:25 -0700 (PDT)
Subject: Re: [PATCH] ata: rb532_cf: remove redundant codes
To:     13145886936@163.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
References: <20210622115507.359017-1-13145886936@163.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d69296c5-faf3-24f7-bf3a-faede4ed79e5@kernel.dk>
Date:   Thu, 24 Jun 2021 18:49:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210622115507.359017-1-13145886936@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/22/21 5:55 AM, 13145886936@163.com wrote:
> From: gushengxian <gushengxian@yulong.com>
> 
> The codes "dev_err(&pdev->dev, "no IRQ resource found\n");" is
> redundant because platform_get_irq() already prints an error.

Applied, thanks.

-- 
Jens Axboe

