Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97C1C433E6
	for <linux-ide@archiver.kernel.org>; Fri, 12 Mar 2021 14:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C91E64FB2
	for <linux-ide@archiver.kernel.org>; Fri, 12 Mar 2021 14:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhCLO3K (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 12 Mar 2021 09:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhCLO2x (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 12 Mar 2021 09:28:53 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3BDC061761
        for <linux-ide@vger.kernel.org>; Fri, 12 Mar 2021 06:28:53 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id g27so25925367iox.2
        for <linux-ide@vger.kernel.org>; Fri, 12 Mar 2021 06:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/fiZTQtq9gTeTOjOSp4jyAv3E49NXWqKgxF4Ys8Usr4=;
        b=PgJtrn3JkigDnDD0ot0BbvuTVDrk5Lepcl8hTKF3jWiagWQxwxsceDj36pIquQPQ8X
         u/PGP2RRMFeeICcZ6S8qP3TdzvbGb1m/npFKCk1xFU5+cBovfKn1LiXJ66ODJZz7dnpg
         mJw8oFWKr75opaIQcb/JuhsBT5/fNf2PpK/Ant9yDt38S6caFC1rpgCaoMyaIqbIDKZn
         bxP0bddKF+BJUvHuYRFAXhWN28I++8N3A4ppYjTPrCjMrkJ11/EO+vM4i547t1oxw5Pq
         bei2y8Cm6VU8e2Cta9U+NT8INCE7mONklBzBn5Yscz4g+K4kDHdxwMHh3kb6Zg54FDGW
         iAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/fiZTQtq9gTeTOjOSp4jyAv3E49NXWqKgxF4Ys8Usr4=;
        b=eb+pb2u4eEb4cH6kLqCvNckLGOfABxCJ7A1uMpy7ka6kSrgFb5NqyeJ/sEpQKgaJy5
         +TfHyG680rhr9HBYsGjSpsHUfW/jQ0d3hPoCrDBZmlytU9vFQayKuwm0LFjADpi5TQIy
         rbZGmzLn7fIjLQyf6ir5CwLQxgjYm6wOpXcYM0OR7YGIhHXt585jpj0dt8fI/vpMjkWr
         szeQ1An+5ScDc30eqtYyDyKxACuSLzYqGs0o3R3PK+PBd20l/3wsvnSEc3aqzCTMU8mP
         KWPR2/CsS5bPK0krBwmddgqBM/T6sYCYA8URCkyq+lZQ36qzyDZd0O/uQpUYq/iqSqJ6
         FsiQ==
X-Gm-Message-State: AOAM530zcAn9oWHgo/J9x4reIlEnw9wt45+06zWtKlXG9Atp7VD/11V5
        ZPtbgoDp2NsziN06M6OansOLnQ==
X-Google-Smtp-Source: ABdhPJzHEHp2ymeNqkXcdjnzjDXZiTHChh+B+IS1iFuYGH/vKFf+b1FIO7ooqyN87D4H2n6FzQFZtQ==
X-Received: by 2002:a5e:840a:: with SMTP id h10mr10261346ioj.206.1615559332769;
        Fri, 12 Mar 2021 06:28:52 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f3sm2985001ilk.74.2021.03.12.06.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 06:28:52 -0800 (PST)
Subject: Re: [PATCH] ata: Trivial spelling fixes in the file pata_ns87415.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210312085738.9372-1-unixbhaskar@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5cc49738-0778-1574-2f4b-9bd179436e8e@kernel.dk>
Date:   Fri, 12 Mar 2021 07:28:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210312085738.9372-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/12/21 1:57 AM, Bhaskar Chowdhury wrote:
> 
> Trivial spelling fixes.

Applied, thanks.

-- 
Jens Axboe

