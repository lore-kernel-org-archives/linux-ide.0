Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C63EC433E6
	for <linux-ide@archiver.kernel.org>; Thu,  4 Mar 2021 01:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB8B64F39
	for <linux-ide@archiver.kernel.org>; Thu,  4 Mar 2021 01:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbhCDBMD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453036AbhCDAmh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 3 Mar 2021 19:42:37 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2B1C061756
        for <linux-ide@vger.kernel.org>; Wed,  3 Mar 2021 16:41:57 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id j12so17535214pfj.12
        for <linux-ide@vger.kernel.org>; Wed, 03 Mar 2021 16:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tFv08AbuAbe3jKr7mEHbvIFM4gHAs0G2cR8M3WVE7oU=;
        b=oPJ82WXi4oso8CTu9jJVromgLEPEV+9C+4QX9nI9WIl28beU4eRYKdz2LWHQuJu7tM
         rGwaGEm0RSwfkDksmaYzRNv1NTc5leLuNlP4nDs11ocqW+OEPNLkXChKVIlhpedvjItq
         0mqvjr23EaiRW3BjMeBJwHIy88b6NVQ1zhowzo5ZFJtfN9aJkzl4PuPTB600FQxKthA0
         QWw4dhw3oGN13RtZEeTHxOkl+mdsJXIU+86I5BmSawInWBeiDPwccmNk8ZnMDku4drGZ
         64Gilv0Sf+BMFlugA17g8PzbigrvVrvgDGfvvJiqJxMlCp5ULqc/vE2tz3qxXFKxuh08
         kipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tFv08AbuAbe3jKr7mEHbvIFM4gHAs0G2cR8M3WVE7oU=;
        b=OM0J8sZA5p+TNk486hC5fUoaJH3iBY6/1Q3fUALNbaBT7ByuvVdDX0UETEKUfO8UVx
         yoKZ7qyNPCLBMk+Jq+KKYqonrJm1QimKjCBHm5+1PvUnqURXS3Q4+n1i3sO6c2xv71nR
         vEkKtQtn8jDbQn3Mgp3Am+0yNnSfkrYGN4tgJ3h3voblxOQCEqSUCeKbwKILEd9651b/
         weN/Jo1TbjcwkEpJ0GTWg6Gfhl7GIBmOL+rgSydGWXcJR3CN+UWrkMtS3pSV7DhpmASq
         9mxvqMC8DVIZ0GQFUqSmMANLihOqP17C7VMciTfNl+ch5T0Ug7wAVCKJY1oPnbZBFO8V
         FCUA==
X-Gm-Message-State: AOAM530FnI09tdexcBTizw+51Urc5Zy5YvV8D5v7lKrqb+V/YqabGqYx
        8zIxd1geaisye8bqRB+AxerRmEPCUdog0RYl
X-Google-Smtp-Source: ABdhPJzlo2AoA2G6B3wfK7vW365vGZPnIFiwp4sYNQ5XX9zccNuwBUY1Ab2dielycYpQAW6JQCHFNw==
X-Received: by 2002:a63:4808:: with SMTP id v8mr1326821pga.381.1614818516590;
        Wed, 03 Mar 2021 16:41:56 -0800 (PST)
Received: from ?IPv6:2600:380:7540:52b5:3f01:150c:3b2:bf47? ([2600:380:7540:52b5:3f01:150c:3b2:bf47])
        by smtp.gmail.com with ESMTPSA id k64sm8251970pga.52.2021.03.03.16.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 16:41:56 -0800 (PST)
Subject: Re: [PATCH v2 00/20] [Set 1] Rid W=1 warnings from ATA
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
        Albert Lee <albertcc@tw.ibm.com>,
        Alessandro Zummo <alessandro.zummo@towertech.it>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        and cc <htejun@gmail.com>, Andre Hedrick <andre@linux-ide.org>,
        ATI Inc <hyu@ati.com>, CJ <cjtsai@ali.com.tw>,
        Clear Zhang <Clear.Zhang@ali.com.tw>,
        Frank Tiernan <frankt@promise.com>, Loc Ho <lho@apm.com>,
        Mark Lord <mlord@pobox.com>,
        Suman Tripathi <stripathi@apm.com>, Tejun Heo <teheo@suse.de>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Tuan Phan <tphan@apm.com>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0975bce4-8e69-2aa4-3ad1-5ce3b4215126@kernel.dk>
Date:   Wed, 3 Mar 2021 17:41:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/1/21 7:39 AM, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> This is set 1 out of 2 sets required.

Queued up for 5.13, thanks.

-- 
Jens Axboe

