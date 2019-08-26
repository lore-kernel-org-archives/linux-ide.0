Return-Path: <SRS0=SK3w=WW=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE894C3A59F
	for <linux-ide@archiver.kernel.org>; Mon, 26 Aug 2019 19:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDEE206E0
	for <linux-ide@archiver.kernel.org>; Mon, 26 Aug 2019 19:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a54pyK5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbfHZT7X (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:59:23 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:40008 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387913AbfHZT7W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Aug 2019 15:59:22 -0400
Received: by mail-io1-f42.google.com with SMTP id t6so40371684ios.7
        for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2019 12:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yVQUZwCErKo1qRXVJkK0km2S1GcwweyUETWMbB/lSlY=;
        b=a54pyK5YvrRocvkiebBbUcZfBqWm02yFcTXOCobDgmnPK8/nzQjqYRXmI9ld3BpeRn
         yIdfEltGm38KF0MaPsf0+ptSaRqYNHoj75yi/F7L7ROitb5m8cjDLmWTC/pa5FpW4ctU
         D1oUg7mMyf7yF5ioLAOLerC5ZjcaLizVqWPIpb6tRqQBh+jP4pTX5GtzqWhFqd+9dreM
         2P277XsSOOKeaq7RGowhPxQmr64AXQRSGUyRitLr+SY2s42XfQ0KqFZo27EMdRLpmoUt
         Kbr3/03ViGTOniEyxEZtB6lrhf1Ky4o9CSqiXwnTmXjX79vonxCdsiv+EUw2ceqQSe1T
         r95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yVQUZwCErKo1qRXVJkK0km2S1GcwweyUETWMbB/lSlY=;
        b=Pd4O+coifGVySQND7RyuwEWM+WxfqV5nyTlU79UsXKl3fnOuJAn1C42RuLhp4ThR1Z
         oAc0oaK3nxaYWFdzs9vH+96wRusJcZfuVndRoEYq8GYl8k96fLtOA5r0VQwk1s8j8ug0
         HNz5BOtlKuIV9P/fYN6P6+a0cjZukPZek4boWrjxWLp0r9YnT7+Zuair3dKbyAp897ql
         i3NQW5W1nnRekadGeT3v45vOolEeaqyd/osFWK+EkZ+EnF3/ej91qvrw06iFhw5JNfc9
         javtwkcd65ButZlnjUWfKv8J8blAqR9ghABkNqlqg7GheKEQ9W7sGgCfAwrpkv/9IwhR
         jmhQ==
X-Gm-Message-State: APjAAAULTIMZ/2AzZaVeG4wpxZ1zwp8+opSh1Y+O3f/CXD84ciLzrMOv
        /xJ0D+3IwuRdIkELU7ejVrMp+CcEP/dzfA==
X-Google-Smtp-Source: APXvYqy6F5qY4JuFBA8egT55bGQDwUvLXLX1QHf08dZ4x79elEcKXd5lw8h6wc/nY+tAk7/6bx21+A==
X-Received: by 2002:a02:c992:: with SMTP id b18mr19286352jap.128.1566849561223;
        Mon, 26 Aug 2019 12:59:21 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d6sm17081845iod.17.2019.08.26.12.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 12:59:20 -0700 (PDT)
Subject: Re: libata dma_set_mask cleanups (resend)
To:     Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     linux-ide@vger.kernel.org
References: <20190826105725.19405-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f69c23ad-942b-e535-b91b-960f95c7335a@kernel.dk>
Date:   Mon, 26 Aug 2019 13:59:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826105725.19405-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/26/19 4:57 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series makes use of the fact that dma_set_mask now never fails
> for a larger than necessary DMA mask, and cleans up various other bits
> around dma mask setting.

Applied for 5.4, thanks.

-- 
Jens Axboe

