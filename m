Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37554C433B4
	for <linux-ide@archiver.kernel.org>; Mon, 17 May 2021 16:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D71A60FD9
	for <linux-ide@archiver.kernel.org>; Mon, 17 May 2021 16:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344157AbhEQQ3v (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 May 2021 12:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343896AbhEQQ3j (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2021 12:29:39 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B21C06135C
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2021 08:11:23 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id c10so2026354iob.1
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2021 08:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pRAUC9+v8Sk7C/Q47QOkwMnbAOUM4aEvDCG5vpHsgkY=;
        b=HCxWhnJ9ud2KBmbrMOkNzjZG0sJg0mOQ2jQ+rCqiEOBP1st3vQ+EMlf+dDVgb5uvC3
         lqMP4gf1pb0tPwgGS2QnXf4155czubLcO2MNaXyWctIl+mV1ObziIEhJ82Lr2r/3qO4C
         JkPZJxbr7cLXeYrKtazPL0PdZCouhfuA2zFKJn9dF1txDtbsyJuekgaHGwsPrGngA64/
         GNc67pEXc0QPhWWR2UquS5xrJI2wsE33QhhwzFCwsMmECUbVjyiGE1FoIrMt2Gu7qohE
         V6jeTX9YrsS5uJGSDKbcTSQHPbRxF4XHC6CWdhM+EGdzBNQLiriuK4FJC7FcLpTnXlXK
         jFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pRAUC9+v8Sk7C/Q47QOkwMnbAOUM4aEvDCG5vpHsgkY=;
        b=Jpmkcrxq6MSCcgYE++547hqrHwqRL5l8khluvp0mi1t0moqXdP9s2aSukNpfCsOHXI
         3vRbsC3ClY3KLsVmjZ7P6N3FJD95vTCqx32lyGHGz7Q45wCWvyZmWgtojC5+89vMtQoh
         Wli9Zu+mkqKW0crF+hPcEDMguVTeHZM7ibZYb2CECNyRHJDDF/nLG+iOmOhZS+hKXeeJ
         kUXhI/2OEY193O8nnaavXf40RG1MFfzdTNsOGVntHkZoOYt5BM3eb5LVxDMKJLLz1kRY
         VZT/DTs0KFEj38ZjRk6MDm7tmHPY3hWkgA4MfD7TY51PfMWY26AoMnsule/y0T+5voov
         V1Iw==
X-Gm-Message-State: AOAM532SPM8wzUNHYvuL7O2C4c9PDBdMRZOsMEin4MD1bxyrkV1rM0Nd
        8FoUpCIA7YKcjMrbObLCINd8PQ==
X-Google-Smtp-Source: ABdhPJw7UfVtSZD3LtGR1uZsCCQkhkJidWk6T7HZibxYOhhEOufvtrVP08oorLUpFso4Z4YiRjSZPg==
X-Received: by 2002:a05:6602:70d:: with SMTP id f13mr433102iox.16.1621264283368;
        Mon, 17 May 2021 08:11:23 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s14sm8357313ilj.14.2021.05.17.08.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 08:11:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] ata: Replace inclusion of kernel.h by bits.h in
 the header
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210409153456.87798-1-andriy.shevchenko@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b450b216-256b-a327-e363-93ec67da4b37@kernel.dk>
Date:   Mon, 17 May 2021 09:11:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210409153456.87798-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/9/21 9:34 AM, Andy Shevchenko wrote:
> ata.h uses BIT() macro, hence bits.h must be included. Otherwise
> there is no need to have kernel.h included, I do not see any
> direct users of it in ata.h. Hence replace inclusion of kernel.h.

Applied, thanks.

-- 
Jens Axboe

