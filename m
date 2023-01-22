Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61B6C25B4E
	for <linux-ide@archiver.kernel.org>; Sun, 22 Jan 2023 18:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjAVSYi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 22 Jan 2023 13:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjAVSYg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2023 13:24:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E7B1F5D5
        for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2023 10:24:35 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id bj3so9865308pjb.0
        for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2023 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VYXT3cuwVqmhiU45SJkfbTJzA/k0OOoLR/Bulg+ymTg=;
        b=08GM/9QMyo0qGt5bdF5PtrKwclt3tL46D4ehwPduwqD5c7knUnuEsXaFM5wQP95kL/
         9GVOEI0R1jJWz1mxlhB6hxZPiDcXH895wniHo3crtloAsdYWTln2aFhIw0JIOIipSvQg
         WEOMxpWIN06OhzCHtYnbG/neRUEmPfZfu2MqvohI5SEMhJtYcjeg3+/0rkEYB5TXctdJ
         VRcBJmOTguYDVsUEgdFNhOHyBR2fYD42hDY+HvytP8MJt2A3VzirXclNaKaJBIXcnAdf
         p2TPK5H/vSs15KHr7Jd44EbvO5JWeWrkohgNwUUP424iy2cJCZ1Ce3dF0taAidUDLfrk
         2ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYXT3cuwVqmhiU45SJkfbTJzA/k0OOoLR/Bulg+ymTg=;
        b=WhldJjZu4nxdpaugC+xZKogNE5TSVl9V7L14vsKhZfbR6rRrS668ki+B7qzlD5W2M4
         fhx887/0E9VSHThl/Iw2VX/84Vv3yonu7KV+uXd5rLpUx2BraTVV5aQfHsxQ07xCjgRB
         07G64sv+rn/rRA3AXmizjrJlztu+8C8jMQjMC9XvhbruL1GttGMXaky2jSr2SLpMiwNQ
         ifTPy281D/1/QqcC7LZP/MoqyS/6Ff7uSM7CBitN8Jc7kMzaMTFDHM5hF6aeDhkLUkFC
         jKJwsZnWZswNUrQc1DgQLioJg4AlgfFOkhTpBVqoR2f0v0Zo5JidBq62Sizn7z0hnHYb
         YBjg==
X-Gm-Message-State: AFqh2koGSqVpgDHzrGEFp5JcjGhx9Zo/8LKO4GFX+txbusFBxs1pDu/y
        DlokoZX+9czQUcBJtoowfcL50frziE8hYvwy
X-Google-Smtp-Source: AMrXdXsHmIu3Q6R1sojtlTfOWWDxNNymStZpT7hHkJBKCU5SL6ZidTJS1aT9OVKdT+WjDQ1h5xFZGQ==
X-Received: by 2002:a17:90a:a581:b0:229:f6a3:4a9 with SMTP id b1-20020a17090aa58100b00229f6a304a9mr2875134pjq.0.1674411874665;
        Sun, 22 Jan 2023 10:24:34 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a6e0a00b0022bb223ffe9sm4694529pjk.36.2023.01.22.10.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 10:24:34 -0800 (PST)
Message-ID: <38af9155-b940-d4df-b6cd-7420d1183927@kernel.dk>
Date:   Sun, 22 Jan 2023 11:24:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Ondrej Zary <linux@zary.sk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230121225314.32459-1-linux@zary.sk>
 <20230122075710.GA4046@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230122075710.GA4046@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/22/23 12:57 AM, Christoph Hellwig wrote:
> I suspect a comment in the Kconfig for the old PARIDE code to point
> to this and maybe even a runtime warning when using the old paride
> code would be great.
> 
> But except for that the code looks awesome, so let's get it merged ASAP:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Since Ondrej is probably one of the few (maybe the only) user of this
code, why don't we just kill off the paride code in a separate patch
right after?

-- 
Jens Axboe


