Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BA0C2B9F4
	for <linux-ide@archiver.kernel.org>; Mon, 14 Jun 2021 14:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E0761209
	for <linux-ide@archiver.kernel.org>; Mon, 14 Jun 2021 14:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbhFNO3L (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Jun 2021 10:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbhFNO3J (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jun 2021 10:29:09 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D86C061574
        for <linux-ide@vger.kernel.org>; Mon, 14 Jun 2021 07:27:06 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id s23so14551627oiw.9
        for <linux-ide@vger.kernel.org>; Mon, 14 Jun 2021 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cS1D61UWM7D7f9J7258UNtSJuuL2xJgwPnJmsK1CIKE=;
        b=Drq4euRexolAYmKsw5YnQsTY+Ac/Qk3DtXRFtHBS2i9AvbFlh2UncXnNxs//tB8OdG
         ZSeIEHyqDQdGg7U4fbjvSRz+XnA9w1bsdX2BIxzhiPbgWumFBjtoTxx99m1SNaHyVBTF
         OFW5ki9GHslxZBUTKuwX1FKmf5mElQfY29yNc59EwGAFK7Nx9nDJBBI19HrJrAe5+f3F
         /FK4zekhGvSs3dLferQ5veRiKFDjRQFeZ2Gr6JiJwjugnjWk7B8Nh+j0KEhwPCU7X/Rx
         t25ppOPClB8MCpzBH9fDz74VXG+JQp2XaGr2xbkPBYO41Wxd01wGnkF3YLXSRW1Mpv0V
         k4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cS1D61UWM7D7f9J7258UNtSJuuL2xJgwPnJmsK1CIKE=;
        b=Ejl7u0msNKwijLgSNwjjFy3fmS+bI0EobD9MCEK+TMCmOkSTfuCA7uR78qlB5iLgn3
         XFMbMIMJ+J7eqZS5q77XeVsN9ZjZ7ktxNvkGHYQ5wtU1o8jUDYxcKKRbhxdQcAtbgvHA
         qllSQzLwaenbHfMwuivn7Wqm0U2R4eJMjWf/DCav4sIZFhEgkp7p0D1gHGRq3eFwExD/
         huX397IEhyBgy+sUYmMep0aV8w8uuOkrhnRmjNq08vYTt4L6M2b63nfAGPxtF/3WWb0t
         RTqYnftRqpNOtTvVmcrPBJ18NjNfKYqbVlLtOOWNlbbfgLC1KKII9tIgMOe8j7kTJ7zP
         oZng==
X-Gm-Message-State: AOAM531ms8NF8Mz1ekrc7LRsr9y6I6PuHnWoSOVIRcaJGRiGM02qUxos
        bvyRh5o1OHtmidOzHg9Zw0nxzw==
X-Google-Smtp-Source: ABdhPJy3zOStR4414HcnVU/hu0fUTjtzRD0SvMKTxiAT0JtYMmXILVT3id2ffgfVSbs6vvST1aQoyA==
X-Received: by 2002:aca:b406:: with SMTP id d6mr10656391oif.71.1623680825976;
        Mon, 14 Jun 2021 07:27:05 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id x187sm2981180oia.17.2021.06.14.07.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 07:27:05 -0700 (PDT)
Subject: Re: [PATCH v2 RESEND] ata: ahci_sunxi: Disable DIPM
To:     Timo Sigurdsson <public_timo.s@silentcreek.de>, mripard@kernel.org,
        wens@csie.org, jernej.skrabec@siol.net, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     sergei.shtylyov@gmail.com, gregkh@linuxfoundation.org,
        oliver@schinagl.nl
References: <20210614072539.3307-1-public_timo.s@silentcreek.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c873409-db09-31ea-485e-daa0433c674b@kernel.dk>
Date:   Mon, 14 Jun 2021 08:27:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210614072539.3307-1-public_timo.s@silentcreek.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/14/21 1:25 AM, Timo Sigurdsson wrote:
> DIPM is unsupported or broken on sunxi. Trying to enable the power
> management policy med_power_with_dipm on an Allwinner A20 SoC based board
> leads to immediate I/O errors and the attached SATA disk disappears from
> the /dev filesystem. A reset (power cycle) is required to make the SATA
> controller or disk work again. The A10 and A20 SoC data sheets and manuals
> don't mention DIPM at all [1], so it's fair to assume that it's simply not
> supported. But even if it was, it should be considered broken and best be
> disabled in the ahci_sunxi driver.

Applied, thanks.

-- 
Jens Axboe

