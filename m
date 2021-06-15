Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEDCC48BDF
	for <linux-ide@archiver.kernel.org>; Tue, 15 Jun 2021 21:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5503610A2
	for <linux-ide@archiver.kernel.org>; Tue, 15 Jun 2021 21:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhFOVqP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 15 Jun 2021 17:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFOVqO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jun 2021 17:46:14 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF076C061574
        for <linux-ide@vger.kernel.org>; Tue, 15 Jun 2021 14:44:09 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id m137so144029oig.6
        for <linux-ide@vger.kernel.org>; Tue, 15 Jun 2021 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z7mRpBzFdnQCaCrfPhVICMA8c7CWmCOOWBIEO4Thj1o=;
        b=jnU/IPybuYUuMniEdO7xkHWWTBlULC1p7adEnBhu0zaVEqDnUcOEj/sbBbLdkGVHrv
         pwD798JsGpDAlxoegAzrNM78aMBJMOlKE6tP/8fLV2A5qEfSzuTEBFy3fXrV0RjR7686
         L4sWHgunD0/sTkV+6odOdTTNMAFD5ieE53+1Ankg/4Ro4hLlQL8rP0f2GtEdMtsjCo19
         fjDpWox5OzTKv0UARXui0TG4PncIRSuJfVxH/KHX092HwQ71PrGnA6iEwBf+AyrlpQiW
         hZVQBX3ohhci5o9aTW5CaTS6cY0VFlgVn3JqQ/OC8HON6ApYD37pBfeL66YF2K5TPxcy
         L+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z7mRpBzFdnQCaCrfPhVICMA8c7CWmCOOWBIEO4Thj1o=;
        b=Zpg6oBvDtEI2NAviv1yP41Q5LK4d7EVSDACUc8Ezy8doejfH/eKC3lE1GPFZQvzivi
         206PI4WTNybZ/BKEgyW1mT+FnndxJPs2NaGPOdK+uQ45VHEcTBSEOQTHotFt1jVZ588V
         X0FJf+EHDVTxDdy3Cni3TdpAoPyJqoDu28fN+b/dRHtyqx5dIk0M+3TDOgx3o8NSfnuT
         p11yzKB5ltmyN9E53lJnwljWTup4d/os7kScc7bqjzovWaPOzHupQMmcDbZoNaQzxdu9
         qy5u0Y7R/8XShcZQ92fSCtOL60dCENGV3FDV3Cj/rsGsDgSEyKMK1JjjsGv4B6zhoJbL
         5cfA==
X-Gm-Message-State: AOAM530vpAZwHhhvNeLGuuI7nMCFoSwT09FOExi3e/RIv+eF/VxGCu0U
        SEiOMO3snHwjYodLAjxuSd1L/w==
X-Google-Smtp-Source: ABdhPJzPoBe66rI/WZmn7o9MJ8jdcr5Daw5tl6xI6BLUpxST0QTgi+/csCYVhzcJBcFy5eK4czzZtA==
X-Received: by 2002:aca:d545:: with SMTP id m66mr801711oig.27.1623793449388;
        Tue, 15 Jun 2021 14:44:09 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id l2sm49843otn.32.2021.06.15.14.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 14:44:09 -0700 (PDT)
Subject: Re: [PATCH] ahci: Add support for Dell S140 and later controllers
To:     Charles Rose <charles.rose@dell.com>, linux-ide@vger.kernel.org,
        hdegoede@redhat.com
Cc:     Mika Westerberg <mika.westerberg@intel.com>
References: <20210615190801.1744466-1-charles.rose@dell.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4a1aee88-7d42-028b-baed-e15ff542f1f5@kernel.dk>
Date:   Tue, 15 Jun 2021 15:44:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210615190801.1744466-1-charles.rose@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/15/21 1:08 PM, Charles Rose wrote:
> This patch enables support for Dell S140 and later controllers
> that use Intel's PCHs configured as PCI_CLASS_STORAGE_RAID.

Applied, thanks.

-- 
Jens Axboe

