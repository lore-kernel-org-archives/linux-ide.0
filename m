Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AF9C433F5
	for <linux-ide@archiver.kernel.org>; Sat,  4 Sep 2021 21:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7FF6023B
	for <linux-ide@archiver.kernel.org>; Sat,  4 Sep 2021 21:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhIDV0e (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 4 Sep 2021 17:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhIDV0e (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 4 Sep 2021 17:26:34 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EED2C061575
        for <linux-ide@vger.kernel.org>; Sat,  4 Sep 2021 14:25:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q3so1642508plx.4
        for <linux-ide@vger.kernel.org>; Sat, 04 Sep 2021 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/TVMYZSKch9fQft/G3rH1av2JDS8NJZ9OCzdFozi52g=;
        b=A/r6PWfQt1mnuA/gdtiCKKZzgEQLNBUW3TIr2ZmERJq9rdiXDUTWy1tlHSxmOGr1/3
         oxi9clB9GhOXgjx7jAwphieUrCvHKbH/kxrLMxEvnM4lz6zVPZglS7tQu8v6H+a9OYix
         jx3GoLxqO+cJWuv2/yxlPGyx2vb2NbJpfjl9bnzkhTQoQL8sLxloFClMhV4XUcN5yP93
         zEkjA9uofI5OwsNKUY2p0W7nXXPp/cB1DkO9pkuDDUBEKqbDCmsI6L83BozM0ZqR/aRn
         IPNrWL+Fkkdrcxzv3FH3dvYHhyJjowzmdhwSK58mOhWoXBZ7lR2EltSz7ygsCdv1cpey
         qOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/TVMYZSKch9fQft/G3rH1av2JDS8NJZ9OCzdFozi52g=;
        b=ptKgwwsJkNF+OrUXavH8712ypgKYM6URX6oCIsPDF5SIAA910LFVaepGuLvFmdqdXi
         4R4wbOhMq9x/Kf5IMbbZAuIPNKaaH4IOwM+rLtMuND/RYvCPxgKG3dnO+OxvoOZwDk9z
         FEvr6CQcQBkkK7aPH6vCc9uvJWEr72pLrLrLoELaUTYTNyLUm65KSryzcG2cZcY/cJxF
         UdnaB40jhnUzdSDHRFBCx04NOnJt9/PgLUKZKmE3d8NYMqdxu+TXlpO9zUCxraOVVMGJ
         y6/0fcBiGFhRP9/kXXc6n+J5AgOgn2lb8HD+cS2kXBII2bGco8VSiZe6iulD+I1LbE+m
         jjIg==
X-Gm-Message-State: AOAM53333VLnkG4RRC60VKSh708Pqk8sKimBwYIda1LgCxVI3qmA3vuT
        pTR5kZmsEoMZmTZINSHOwF0WSw==
X-Google-Smtp-Source: ABdhPJy8ZNsWBo65e3zM/6bKgQ7xAgZQymu7lsqBymp/h96vfn+9dg2zeEEdYY70GPPjJF9gLB82WQ==
X-Received: by 2002:a17:90b:3a8e:: with SMTP id om14mr5918990pjb.192.1630790731419;
        Sat, 04 Sep 2021 14:25:31 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id h8sm3147596pfr.219.2021.09.04.14.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 14:25:30 -0700 (PDT)
Subject: Re: [PATCH 0/4] Explicitly deny IRQ0 in the libata drivers
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        linux-ide@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
References: <2e552c36-84a5-a642-a8f0-1395f77a1a6a@omprussia.ru>
 <e167d421-1456-9211-86ff-979792245b48@omp.ru>
 <86087864-2023-890b-5e9e-f229aa4b9db6@omp.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <63a4cec1-26e7-2f95-1de6-6ba5adb013f9@kernel.dk>
Date:   Sat, 4 Sep 2021 15:25:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <86087864-2023-890b-5e9e-f229aa4b9db6@omp.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/4/21 12:57 PM, Sergey Shtylyov wrote:
> On 5/10/21 11:48 PM, Sergey Shtylyov wrote:
> 
>> Hello!
>>
>>    What about this series?
>>    I got no feedback whatsoever -- it seems to have been lost.
> 
>    Almost 4 months have paseed from this reminder. Still no commnets whatsoever...

You did get a review almost immediately, but it wasn't responded to.

-- 
Jens Axboe

