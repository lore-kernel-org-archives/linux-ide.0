Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DEBC4338F
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 01:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3642F60F41
	for <linux-ide@archiver.kernel.org>; Wed, 28 Jul 2021 01:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhG1Baj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 27 Jul 2021 21:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhG1Baj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jul 2021 21:30:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D12CC061757
        for <linux-ide@vger.kernel.org>; Tue, 27 Jul 2021 18:30:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ca5so2674504pjb.5
        for <linux-ide@vger.kernel.org>; Tue, 27 Jul 2021 18:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NEon500ynSMY4Nx1JkJ0WhIvnHZ2zrzoczFG2c6TlkE=;
        b=L1pTZHLWV9EUK/WKK2vzd1LrKbA0rKMC8b6f5MFCh/bnMJGMtfvMUJaLcwWWInVnK3
         5wyVMCQ97HCSv2rT4LfnbLrwDQciKneOVVWmgtZfh0KYG4WE+7hnUrHPMy8jGptHPl3t
         SwHM34ecuaBTo+1iymtZex9mDYZP46z51cyN0t+PSKpXDMWSY+VlIiVEWWTjAI32IOwX
         Z1cc4WxG4Pc+MhRzPo4jN2z9tEspHjhZ/R8fE+fi3ZZMVCJIgUVjajESOBxJrsp62Rf1
         nOflJAFb1gKHRJieBmNUznM5z5kXaYOvGzHaaOxEWN2p00c9UK0fFr9ZeP6YRGzVLdyv
         Ddmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NEon500ynSMY4Nx1JkJ0WhIvnHZ2zrzoczFG2c6TlkE=;
        b=Tc1TEZ47dSFbeJDZ5P46IvFhXLX/5LLn9drJ13EVYjNdcYBmfcqmUNKmjSJJL4Al1f
         43EvUiVZqL52bNQ7xLIwGs9CkIqIWO8Dw1jc3AeE3hSjhFcc6KzgbJtS6NXP1KiISPvN
         lz+SZc9RjXZz5NtLWmOAfe+0qgiVFpxhOzzAhVfRN+FmFSgdHHWMPXhx/jwdDSJwd9mr
         4Oo7MNytVnxZ7ChP1kW1uRqHohxRPCvpk8xzbPSsaUKNxyka7jNc547MtX0BJToLwPvz
         6XsuK5D7uh4buJ+WKYC78lVqNHb5oM9l70BsZCgpCXh2iJ8mU8rJTC4snmWNUqFXpMi6
         ZV1Q==
X-Gm-Message-State: AOAM532sqcRlWsXpB5JrKHDBiEF7QsN3D9HnYrb/AzjXwaiWmK57HAtz
        fDJiGMILViqsb1hdswKcTbkUBQ==
X-Google-Smtp-Source: ABdhPJyvMaCZv/e6Vz7urn/jIG/vOGcKtAoA+VK/OTA4np90BOzzU6+y9N4p8I0FLN2QoWpWq0AVdg==
X-Received: by 2002:a63:1621:: with SMTP id w33mr26091053pgl.291.1627435837707;
        Tue, 27 Jul 2021 18:30:37 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id s7sm4926070pfk.12.2021.07.27.18.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 18:30:37 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] ata: sata_dwc_460ex: No need to call phy_exit()
 befre phy_init()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210727125130.19977-1-andriy.shevchenko@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a16f1ce1-243b-e12b-3d48-01c2695234cf@kernel.dk>
Date:   Tue, 27 Jul 2021 19:30:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727125130.19977-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/27/21 6:51 AM, Andy Shevchenko wrote:
> Last change to device managed APIs cleaned up error path to simple phy_exit()
> call, which in some cases has been executed with NULL parameter. This per se
> is not a problem, but rather logical misconception: no need to free resource
> when it's for sure has not been allocated yet. Fix the driver accordingly.

Applied for 5.15, thanks.

-- 
Jens Axboe

