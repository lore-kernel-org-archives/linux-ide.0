Return-Path: <SRS0=i9Gt=YS=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E33CA9EA0
	for <linux-ide@archiver.kernel.org>; Fri, 25 Oct 2019 20:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D068521D81
	for <linux-ide@archiver.kernel.org>; Fri, 25 Oct 2019 20:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OYoaCbIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfJYUXV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:23:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34957 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbfJYUXV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Oct 2019 16:23:21 -0400
Received: by mail-io1-f66.google.com with SMTP id h9so3886453ioh.2
        for <linux-ide@vger.kernel.org>; Fri, 25 Oct 2019 13:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6ZSx0Dz2zxPmSlh1DHo5dPWMxFlSt9fANGSCDCttJEI=;
        b=OYoaCbIQkCs1SRKzOVcyC0NdH6THKQNvvM7+yO/VkXaQiBpVyReLMkirCVNdwUost2
         WvNLBw36zS9qa0IaNcsHQPM7rg8QqQ2izeUazXOf9u17jPxb8iFN9g6/EP0IIam7Plk8
         WVgVShsHvaneQxekiNW6ptQNN7BT7CCGjovuLiTc2PFDUVduSq/QWr0cbEyRZHtDD07F
         zBaFrUPpm1cr8lp93JxChOIdBEo4wDe8moZTUr2SybzA8Aol5E4R7oy+nky6u8AISWQt
         BnqMfSpvaCrgxg2Qd1xrIZhHVn3OxF+JuaKhURGRJbtCBPjw0fe5lh1PnLuoZlEKsf2V
         JsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6ZSx0Dz2zxPmSlh1DHo5dPWMxFlSt9fANGSCDCttJEI=;
        b=YNjp/xUWr3pecF9BeNMyWLDdFJu3pDc+4zd8DE5Wj2GMKbETlG6id5XUnRzf6A+IyF
         ZvYQvocYR0yXbwyziOHQKEo9YQfhxPzTPZaVIOj1a7grE7q4/EajHnifbTEeK5Y2710c
         BYP+8//9Gi714VT4QZAoeSmWcsx3j98C44kCxIBVk4E7Fo3qf9UrRmn7LL6aOQzZoG/7
         P1VEMfCHQ0Rd9Hxk5kGjlXaf7NYu+pPypJiWyorhhhui+a9w0Yki+0YKG4twABZ6gXLi
         kw9VstRT3qopLh3i1jA3lRzurcFqvvuZjfQTUWxlWxGNOtu9vI9WspmXaFHIGIqOMrup
         +uhg==
X-Gm-Message-State: APjAAAXtcOooVCNX3yjsj9nu4npvVsjHEK8psM0ZZMrNo3vYBPCkoCL8
        51z9yR/NmelzBHJgHFffJMfdrA==
X-Google-Smtp-Source: APXvYqz5NSg+s+lf8sSldRMQM17WAY8T49V3XHaalkD+2ksQTleWfUTwww3GR9Nf3DX6JAsg5TTWDw==
X-Received: by 2002:a6b:e615:: with SMTP id g21mr5680657ioh.56.1572035000519;
        Fri, 25 Oct 2019 13:23:20 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r1sm177258iod.69.2019.10.25.13.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 13:23:19 -0700 (PDT)
Subject: Re: [PATCH 1/1] ahci: Add support for Amazon's Annapurna Labs SATA
 controller
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com
References: <20191017144653.3429-1-hhhawa@amazon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0097f9a1-76b3-b713-dfc3-eb7ff4ed6d82@kernel.dk>
Date:   Fri, 25 Oct 2019 14:23:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017144653.3429-1-hhhawa@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/17/19 8:46 AM, Hanna Hawa wrote:
> This patch adds basic support for Amazon's Annapurna Labs SATA
> controller.

Applied for 5.5, thanks.

-- 
Jens Axboe

