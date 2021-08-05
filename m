Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64D4C4320A
	for <linux-ide@archiver.kernel.org>; Thu,  5 Aug 2021 18:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6C860F02
	for <linux-ide@archiver.kernel.org>; Thu,  5 Aug 2021 18:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbhHES2l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 5 Aug 2021 14:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbhHES2f (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 5 Aug 2021 14:28:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82532C061765
        for <linux-ide@vger.kernel.org>; Thu,  5 Aug 2021 11:28:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n17so10222693lft.13
        for <linux-ide@vger.kernel.org>; Thu, 05 Aug 2021 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NKHL1Rhs0iD3v0X/cICFojIlp/sd2/66o9brH3stdig=;
        b=DIgtn/40sxZw2bwhiDs3qU6+YNDb8W6bXYm7R0toOFRter8PxNkK+6h+wV7bnuC414
         V0Ls6QASU3pSm1lJBFMK+BwdoFOyN3U1bByj5xru3wezXfAlFADHEfVyORiLYEl13G7c
         /RIx524UvwSf1T4nAv9BrGQG+kaAMRbUbay+CG9j2AMw+/j7/7cJaxp5qSNvnjYGj7rq
         Nq5yUSuw7TR90FProdhA1ppMNA3w2Kunte00aXNlssPPW5WAGVil3cjr9nSxUM150d1a
         z5qB5Qn44eNCyreuB3w+IIWZBXvGBlqC8cRDFVZUYk1DVtPwcPCJvIN/3tXax+oB9FOf
         9Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NKHL1Rhs0iD3v0X/cICFojIlp/sd2/66o9brH3stdig=;
        b=pZNbeeq8IvZV+8Oq9a2j1OlYAh2dQpU77i+mUvKwY5eI06My+qP9+ZKpdFtz0rmkyI
         3kb2oXvAGk2JJDiTKKuxT1d953VAGGa0SipGB3bmax4kmvJhVzA2RRnxbDSV8WH9eBSo
         SXbIM2s1wKCbc912cHyafvwupHVF4O1YYAlqZ0tt/wYZdHYAHqpB0zzR1BAimkyQYMxg
         Kx4Di34j60sJI6sUtBcF4tY8JXVRHP4PT2TG07LPdbZlSeHIB5A8k4XBFehaiorJYmrM
         e6Je/EWzpY3/hrJZPNMnIGZ9p907gUoEwAeDaT/TBxILEEjuZu9OvwmNWlhAXYFQWayh
         s5Yw==
X-Gm-Message-State: AOAM533MjH+lJCb/OQLZjNp8bwh8u3T6SU5TCuB8Tqm1j/ImCe6ST0Jd
        t/ZNLRzBsdmBGRSe2o8fAkI=
X-Google-Smtp-Source: ABdhPJxhErYbreid7keFvX3izIuhduno+R3LuMpSziY67NJV2Dj0hzFGloem6tr++WvesqmGMoKh+g==
X-Received: by 2002:a05:6512:2283:: with SMTP id f3mr4699494lfu.400.1628188097961;
        Thu, 05 Aug 2021 11:28:17 -0700 (PDT)
Received: from [192.168.1.102] ([178.176.79.25])
        by smtp.gmail.com with ESMTPSA id bq29sm583284lfb.137.2021.08.05.11.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 11:28:17 -0700 (PDT)
Subject: Re: [PATCH] libata: fix ata_pio_sector for CONFIG_HIGHMEM
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     torvalds@linux-foundation.org, linux-ide@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <20210709130237.3730959-1-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <27f1ac93-1a8b-0b90-7fe2-aeb19c91c8ce@gmail.com>
Date:   Thu, 5 Aug 2021 21:28:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210709130237.3730959-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 7/9/21 4:02 PM, Christoph Hellwig wrote:

> Data transfers are not required to be block aligned in memory, so they

> span two pages.  Fix this by splitting the call to >sff_data_xfer into
> two for that case.
> 
> This has been broken since the initial libata import before the damn
> of git, but was uncovered by the legacy ide driver removal.

   Damn of git, hehe... :-)

> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
[...]

MBR, Sergei
