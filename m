Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76857C433ED
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 14:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8C761108
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 14:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhDIOCy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Apr 2021 10:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhDIOCv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2021 10:02:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25F9C061761
        for <linux-ide@vger.kernel.org>; Fri,  9 Apr 2021 07:02:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y2so2805599plg.5
        for <linux-ide@vger.kernel.org>; Fri, 09 Apr 2021 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/hyU5Hg3QS5M0nJuXFPoAFAqRmr31/8ghnomOL7zLEY=;
        b=Zsb3DZ8DqONAYhLhPc/vlhQSj58YY3Fe1a9oTrZDOkvZzuwYD/e9iUvuMZs9we8qVs
         nFz7FPBTfST58+N+CGxGuFRm3FmlBOhakywuIziYORos1+2jE6eP+X4A2/MMMedujG7y
         25ZfNdLye5iCDf60PdPLnFvFWaMhxwx4VjcASlagPOsJwW7CnagVNzMtD8kOhXvsUSl1
         rLtLJrhRfAZmMvBtYwQXvkVk0JOPl3oJiBWdGwbNfYHGlXgZFv9MWbSoDO1l77VRdgiY
         GCinYA1wFcqpXb+6FdR9MASLP5QAl9JcGPFgU5rU8QjXgTcxOGv2+/z5GlcbG2eu+uJ7
         Rr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/hyU5Hg3QS5M0nJuXFPoAFAqRmr31/8ghnomOL7zLEY=;
        b=WFZle1+vtx66cvpJ/u7HxkOuIBQ3682tNL2WAKNDdnZPTy6NgTGJ0dAhHkQxaRbK/Y
         lHHqePojH6J3l0mEAC1vn2ubAQRIj6vjg6PBnuz2yBJ8j0ezZT0rvn/2gOS+CIGtBBkL
         UygrmcnXJ5XSVkh6jQG6D+D0Fm3b5z6CdXkUyhX4wNwm6eh738tljAg5IyWAlILG3Ejn
         IftiQNaACxNCvH0H6DU87teKVF2/fpbrBcefy6BGnC87NSu35DWYbyFrexv9YQdnE9wR
         MxfWz9unJHiPqoTpjspS6IhVJj9fLNOd5VqKqDLiZyDU5/w3rQetTlL26pHYYve7kk8m
         CQ2w==
X-Gm-Message-State: AOAM5311Mk5RrvNv4P1rfUqbhyXh+3NEzeJNb7UlmKrGoZlx73kwwVBp
        SOV6Db9GxcnSZNWQ00e5OLbTHx0vxzE6HQ==
X-Google-Smtp-Source: ABdhPJx0deSfTRg0UGucuEqeb9trWN/xZJxdFKHIBzE1YwduY5Vd/FXwOjQr3NETq0ZENtY8AsQWAA==
X-Received: by 2002:a17:90b:b09:: with SMTP id bf9mr13678508pjb.17.1617976958473;
        Fri, 09 Apr 2021 07:02:38 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id r22sm3100073pgu.81.2021.04.09.07.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 07:02:37 -0700 (PDT)
Subject: Re: [PATCH] pata_ipx4xx_cf: Fix unsigned comparison with less than
 zero
To:     angkery <angkery@163.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
References: <20210409135426.1773-1-angkery@163.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bf8a5938-eeff-5cae-8bb5-c3488d904980@kernel.dk>
Date:   Fri, 9 Apr 2021 08:02:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210409135426.1773-1-angkery@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/9/21 7:54 AM, angkery wrote:
> From: Junlin Yang <yangjunlin@yulong.com>
> 
> The return from the call to platform_get_irq() is int, it can be
> a negative error code, however this is being assigned to an unsigned
> int variable 'irq', so making 'irq' an int, and change the position to
> keep the code format.
> 
> ./drivers/ata/pata_ixp4xx_cf.c:168:5-8:
> WARNING: Unsigned expression compared with zero: irq > 0

Applied, thanks.

-- 
Jens Axboe

