Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D897C47082
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 21:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B6C613AE
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 21:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhFHVwX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Jun 2021 17:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbhFHVwT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jun 2021 17:52:19 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC941C061574;
        Tue,  8 Jun 2021 14:50:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h12so82530plf.4;
        Tue, 08 Jun 2021 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1PmZ9kz58nKHjfIBFsO+WAO9mwq+ME6l/h6YokFSMjw=;
        b=paF71qvFbJ82VzJaJwbX5OnOp/m2MWuS0qVF5WcsfYH9E/3XtcV6uvSnMR1hJlIb7E
         1qOu5c3dI1kMb/tHM+BfsRa8EjotdVb412Wpsp51fdXWLMym+71B7otdFG4Vd3/pDva7
         3C1u4itQDeyYVj7jSmDNE8xgb5rgs1SWrgMFzUezZ+mHDtz/r3WoMqH72c9Tvh/u/A9U
         ySiiuvfxszw00b09ERRhk4U7/N2owCI2paB72hwDP2r+o4IwX/ISWjBFEQFYXJiCNhzL
         5bB3VvXf+tExgxkEbdkIUUyw80flCq5teum7bUD9wepfVw8tG/+L8kEotqFz/t/e2gcA
         BrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1PmZ9kz58nKHjfIBFsO+WAO9mwq+ME6l/h6YokFSMjw=;
        b=OzidN+Q3oXnk63wck6gpCi7BxD8X596q8GagsWiGVqBqU84V8faCj1YN5JyEkqwxa/
         ACM3pkAmEzc28rA66Ws+6RIGae9IkaCtAsQHRrVRK6REu5dODGagQu7NJHgD+Wb6FC8z
         m65vxm1R/RACAvXedf5RuiNeJJN1si236vJcKr9ErgKughez4CMW/JzK+TZxNMvz4S3n
         xzr+HAD9o5n52aXkawCZku6RCuKRn4zZBq1ebWCimz5hwjmprVnY16A2Nfwi+zSy8ZQF
         B+TSqb8cZIcdLPSNCrxM/pP3posL0BJzxrhxgB/iBgLZs01O3vt2vOLc5D7n7Rn3FhNf
         yWAg==
X-Gm-Message-State: AOAM531NY6or5E92n3iKYteio8sM7sD6xkdWzCPRyofbf+xHwW7wZ1+e
        39ZVE95SrxDi3DGcjj9k5jbwPj6HOxF6Vw==
X-Google-Smtp-Source: ABdhPJz3vVrf5bzZXhMEvKhAbBLqVoo6j5WxNhEJxPxzZHuEjLBdv0kHNrPya/F/HsqmtF/a09QJlA==
X-Received: by 2002:a17:902:c784:b029:104:9a21:262a with SMTP id w4-20020a170902c784b02901049a21262amr1808434pla.21.1623189010218;
        Tue, 08 Jun 2021 14:50:10 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:6c1b:b1ca:5501:207d? ([2001:df0:0:200c:6c1b:b1ca:5501:207d])
        by smtp.gmail.com with ESMTPSA id q23sm8861482pff.175.2021.06.08.14.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 14:50:09 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Use libata platform drivers to replace deprecated
 m68k IDE drivers
To:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Finn Thain <fthain@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        Joshua Thompson <funaho@jurai.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Richard Zidlicky <rz@linux-m68k.org>
References: <cover.1623131194.git.fthain@linux-m68k.org>
 <YL+AqIEPjMgG519L@infradead.org>
 <d3c70f7a-368a-ad9a-6575-8289234b0ce0@kernel.dk>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <36f7519d-698f-1284-551a-0dbd82e2a0d8@gmail.com>
Date:   Wed, 9 Jun 2021 09:50:03 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d3c70f7a-368a-ad9a-6575-8289234b0ce0@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Jens,

please note that Finn's patch depends on one of mine currently under 
review. Without that one, Q40 support may break in certain cases.

Cheers,

     Michael Schmitz

On 9/06/21 9:04 am, Jens Axboe wrote:
> On 6/8/21 8:37 AM, Christoph Hellwig wrote:
>> On Tue, Jun 08, 2021 at 03:46:34PM +1000, Finn Thain wrote:
>>> This patch series allows m68k platforms to switch from deprecated IDE
>>> drivers to libata drivers.
>> Thanks, this looks good to me:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> Jens, any chance you could pick this up quickly to prepare for the
>> legacy IDE removal series?
> I can, but had assumed it'd go through the IDE tree. But not that
> important I guess. I've queued it up for now.
>
