Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AC3C433ED
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 15:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D521C61284
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 15:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhDGPmy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhDGPmy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2021 11:42:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65767C061756
        for <linux-ide@vger.kernel.org>; Wed,  7 Apr 2021 08:42:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so1537013pjv.1
        for <linux-ide@vger.kernel.org>; Wed, 07 Apr 2021 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sT8AkdrBBL3YKvJU3fz3EtmsSiuHjn1hvxcUtZSjTJY=;
        b=wB3SEgQ9G1vOUGBjoretSKVRkZ7dYZ/hrWRXP79u5w+2SM6hK1pCkk43wDs0Zemtzg
         AcRZDUTMIro0fLswe2qrzMMhgq0Y9szQT24OcYc6uGVzDR9sIO79NAe80ZqpdhFk2H+x
         JwCFJI3lw4aKmzYEX74erpJYtYyAR/sKAeVNvUl+NOOw4RgzoEoeM1LkUaM3VQWwHN9r
         x6mUwGHiHB4BUTId9oy/vuP7OflE1Mzm2U5Wv6Yq2MW+MolX5u5vKNJQryR8VqfvEsfO
         h8ucHCUdmFI2hmkLWE5h/OWUew7xuzc45YHmjPXafmeTknykMLPJS6X4zWa80ptUFpjM
         H/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sT8AkdrBBL3YKvJU3fz3EtmsSiuHjn1hvxcUtZSjTJY=;
        b=g1pM7IUrJwWTFXVQiCLVus5wHZp+8q8sZ4grJDifCYeH7Z7/sr67qZM6WkoZltTuPZ
         spWj64bLoybBpZ8fCit7fAIk/6i4fEu17NZ9a9jbYvTCJAt1o5a6wdHw9vy0P77OFv4v
         /BnkxUdLai9RJWrSw15H8/3SUJm1lcOgmaTLQlIr6drvNEwCp7lYwz9e1AXp0j71Vj5o
         2MZNd8+M0IkMusFZC9qcjCRRl6s7/yywC/7CyqNdLNb+QuhMzgnDakOFtbmcu2lBXwEU
         0xuDhWYyfureqvHZ9I0z4kf7hwtd/XJcHrbR34J4maw6AjBBDhPEcVoVscVVMwXSwMMw
         h6TQ==
X-Gm-Message-State: AOAM533cEz0V21HHJChDkBLaCuVBRBAcY2nML85GhXMsix9P42brVmPr
        2LuRw7MBrnAOiylCRhOw3VW2fw==
X-Google-Smtp-Source: ABdhPJyhuMuW5sXWyB8gxG9izmfPwY64ukKz7MYoMuXgygt4AxfMqJoNs3toOIL2AkDwWW+6I2GvXw==
X-Received: by 2002:a17:902:a513:b029:e5:d91c:2ede with SMTP id s19-20020a170902a513b02900e5d91c2edemr3586490plq.65.1617810162901;
        Wed, 07 Apr 2021 08:42:42 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id em16sm5865370pjb.43.2021.04.07.08.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 08:42:42 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] ata: Drop unneeded inclusion of kernel.h in the
 header
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210407134706.81383-1-andriy.shevchenko@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <49f72504-2a25-fc11-cb0c-6bf726773cc2@kernel.dk>
Date:   Wed, 7 Apr 2021 09:42:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210407134706.81383-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/7/21 7:47 AM, Andy Shevchenko wrote:
> There is no need to have kernel.h included, I do not see any
> direct users of it in ata.h. Drop unneeded inclusion of kernel.h.

Applied, thanks.

-- 
Jens Axboe

