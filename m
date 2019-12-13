Return-Path: <SRS0=ypzH=2D=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F81DC43603
	for <linux-ide@archiver.kernel.org>; Fri, 13 Dec 2019 09:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F92A206C3
	for <linux-ide@archiver.kernel.org>; Fri, 13 Dec 2019 09:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="1wUco8N7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfLMJDV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:03:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41761 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMJDU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Dec 2019 04:03:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so1375430lfp.8
        for <linux-ide@vger.kernel.org>; Fri, 13 Dec 2019 01:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WNQacd3jC8prvy0Uu2whCMqD4GZhmP37LktdrjbFaKw=;
        b=1wUco8N7hm56/yJ5GHX1TJGe2vcjPawnvly2nGrQ6JpRXMbm9OPS0SRbDCnqxr6WyE
         OcT+Pk0Gg4JogLGV9SQtQ6idlluJstixdLqgqkpwawQS2c4fSNSGR1B5HyhfPkIcl8yj
         bWKsLaNil6mJTOD2KaKwzhgU42Mt6DE9hUVGMsRtZwWL68eSufY/CtuW+kyI3vRzTmxv
         ifnvQcDNxUM+HlxyTRJUTC7tO85eVYDOQJsgs0nlwYQrfyQubNfWKjL19kZUtHmgY6iC
         49WdXOcPDDaUPm6cacd5JY72lNpDCg+U4vYCLBeLQoKCGiXL/yIkAurksSXHUBuFB9qj
         Y4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WNQacd3jC8prvy0Uu2whCMqD4GZhmP37LktdrjbFaKw=;
        b=Lxf0tFpRNxex9u+NSPts8SR4qnwZUwAqVtak0lJml9EJ6jC1d4So8sEEz/mLyBel4o
         ouJrZIbGmN8vywxuExiv8WGlmbrCfzTg6t7n5jKpMtRf3uh4H6iw3OQklvM3JH8iIbHN
         ukNdftHfdbb0ixJw7NRtR2d9LIbPtNQPIxz0BR7I1cHb1oJm7vBXNic7ZXc0G1M6ut2l
         Uv0mQH+W88xOuy30oSJo3ochmjFxet7JP/roSWtHhN1DrTEpg40bJ2t5oOeKAzRoesQR
         W5yRvVsNX41bz9sNneWJnK0jY5ADbmrqNhkV5htlV5IkvdrGCi1tsdq5r2h7VRVYfJqX
         /sxQ==
X-Gm-Message-State: APjAAAUsVvwoQbQ7owyoeS0Y1QLm4p2Fzx/IQ0RZ4VZpr1SZCIjvrT0/
        bEcfyzbjNFOZ5yVvHB3C/v1bO1UACNdlYw==
X-Google-Smtp-Source: APXvYqy1eU+oP86R3R2avt+tKiV20r7pR2mpA/5GlhJbsJr6FJMa6MjK0UaY2KmRdoU4vLIejcrfrw==
X-Received: by 2002:ac2:4884:: with SMTP id x4mr8063017lfc.92.1576227798628;
        Fri, 13 Dec 2019 01:03:18 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:440f:b14e:3839:7397:c89d:7851? ([2a00:1fa0:440f:b14e:3839:7397:c89d:7851])
        by smtp.gmail.com with ESMTPSA id z13sm4456601ljh.21.2019.12.13.01.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 01:03:17 -0800 (PST)
Subject: Re: [PATCH] ata: acard-ahci: removeset but not used variable 'n_elem'
To:     Hongbo Yao <yaohongbo@huawei.com>, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <20191213031157.52115-1-yaohongbo@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <68c9f17f-5e48-9c81-7933-ed0ffc4963e4@cogentembedded.com>
Date:   Fri, 13 Dec 2019 12:03:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191213031157.52115-1-yaohongbo@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 13.12.2019 6:11, Hongbo Yao wrote:

    Space missing in the subject...

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/ata/acard-ahci.c: In function acard_ahci_qc_prep:
> drivers/ata/acard-ahci.c:268:15: warning: variable n_elem set but not
> used [-Wunused-but-set-variable]
> 
> It is never used so can be removed. acard_ahci_fill_sg() is called only
> in one place, use 'void' instead of 'int'.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
[...]

MBR, Sergei
