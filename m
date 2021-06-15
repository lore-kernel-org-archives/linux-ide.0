Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C81C48BDF
	for <linux-ide@archiver.kernel.org>; Tue, 15 Jun 2021 21:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 705D860720
	for <linux-ide@archiver.kernel.org>; Tue, 15 Jun 2021 21:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFOVrl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 15 Jun 2021 17:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhFOVrk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jun 2021 17:47:40 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E51C06175F
        for <linux-ide@vger.kernel.org>; Tue, 15 Jun 2021 14:45:34 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso407494otj.4
        for <linux-ide@vger.kernel.org>; Tue, 15 Jun 2021 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5z1OJyGYVNhUMVsV/L9Wls14EjTqIU84oTFQp0rkHAc=;
        b=VkKU5yMDFq4US0C9KONfXVdRCtY0+kipg42sQcFeGsqacuY1j8e8tqQGqn4cmYNQp9
         KTULjm6g+fN/d2VxBcmbViu0T/pyX040MkLWgEZ9oirG21z3MYJYje+iahPKlQDLH/+r
         C9RvziKLOSsdVhkHo2GaI4lnGLd/xPLS4+1NdkdHMMJVujKYn0UdKsJrIICxxKgY/5Nv
         7VNVYTjpa09EnJzYJI+++fW43q/DUe5oLOJN7SBIk161z/06ib2z7iE7BhPUjOh5RK0H
         u5WjuL/Ynrtf+mt1QF4+dJicVxwoG6DvjW0CttG6EPpJmRl7BVYBSqlarF9wTzZVtg3j
         3qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5z1OJyGYVNhUMVsV/L9Wls14EjTqIU84oTFQp0rkHAc=;
        b=GDHZAF6wtjje2n/ghEc57BP/Dn+u6RCT7wjTYu+gbSaqOiC1+BF30tyBIv/ysduU0a
         RlQTn2xKX6r90McKs/2UbjVhIoagRg+nORz9YTkG62qIDwBHdQdDkS0zY3E0DLqBEtY0
         1exykz1Tpz5N6pzskcZ3YDrMETsruY5e7MZLRsU8MTGTYKHHu9aLSkE6K0yIwDqeZBSz
         qPVdyYhg0P45f3vhF+rQD74tt/OdVTbvAjZk71Fa55OFBxTdrSzthHfl0z7MEiFr/Ozl
         0PQldFDLgyAt7QPpjrKLe9IF/GMLLAyhXAU4PO3Sz5am0zRVEl1zNHCp0m4EHRgzxl6S
         qG4A==
X-Gm-Message-State: AOAM531hGlgTCCCayvSWWXcVMqacaxmmqe67lL1x17kmEEZ2IP4vkjaq
        EMG8/NF08bLMmNiPLIoOxFslaw==
X-Google-Smtp-Source: ABdhPJzZ0m5J5y9ayP1ilal9XmMwFN9BTPg0P9DMT3IMVEBW+f5P6hjCIzGH8NaOsG6QxJ1NDTOmlA==
X-Received: by 2002:a9d:1e4:: with SMTP id e91mr1033309ote.211.1623793534208;
        Tue, 15 Jun 2021 14:45:34 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id t18sm43054otl.80.2021.06.15.14.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 14:45:33 -0700 (PDT)
Subject: Re: [PATCH -next] ide-cd: fix warning: variable 'stat' set but not
 used
To:     Baokun Li <libaokun1@huawei.com>, davem@davemloft.net,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     weiyongjun1@huawei.com, yuehaibing@huawei.com,
        yangjihong1@huawei.com, yukuai3@huawei.com
References: <20210529061729.2824082-1-libaokun1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bba1a668-227d-7dd4-59b3-6a90a169f4da@kernel.dk>
Date:   Tue, 15 Jun 2021 15:45:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210529061729.2824082-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/29/21 12:17 AM, Baokun Li wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/ide/ide-cd_ioctl.c: In function 'ide_cdrom_select_speed':
> drivers/ide/ide-cd_ioctl.c:212:6: warning:
>  variable ‘stat’ set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction.

This code is being removed shortly, so better to just leave it alone.

-- 
Jens Axboe

