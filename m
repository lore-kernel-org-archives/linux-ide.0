Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42761C48BCF
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 15:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B4D613BC
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 15:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhFIP0D (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbhFIPZz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 11:25:55 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32070C06175F
        for <linux-ide@vger.kernel.org>; Wed,  9 Jun 2021 08:24:00 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p13so9072869pfw.0
        for <linux-ide@vger.kernel.org>; Wed, 09 Jun 2021 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cr+10Kcfl8befxhqRoI8l0gcA3LyZMDypV8e112mfEc=;
        b=AH3D/1geZxNQ9z7YrsuVfHmFRcc4zb4CpT+zCT2VTLWK7G9ov5dEiDrmCxGSG8WNEI
         CPKRyZAnTx5UhqiHuh9oP61Lf2HYLn1vfm7NAqmkXes4zrBEooiVkMIT7VCxU+tBdrvp
         472ChJEtwnijTmR8BIU2Yqnlb+yIvnzCH5gU2ECzmgNPbuxMeMj0agfTrNQIktqBoh5g
         SU+2uO640bMJwQ31gultXLG2asZrqrBzEoxRuE5a/swDwHss9x3BfPTGaSnItw4Taz+P
         TslHN48bkywfy31FZUQY9o18326L4QmCwCFfwOjgDdPmU7zA9qKvwg2uTR5kEIw9RdmL
         szkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cr+10Kcfl8befxhqRoI8l0gcA3LyZMDypV8e112mfEc=;
        b=UBEK5t14nTpneDBSd+eaFC24CucxxZ2mKZsX6MePKMDZb7R3xGsGcksgGd5O+cV0WP
         Lc9udTJ9L34N1K+RNchGj8toUxgH4bLunysAaNi/415UKYpYmJYrR9G4Je+kuVfG/3JH
         hnLaUXHTPszlXddQPb5zKbmmwj7RZBU/sVHaECburCG4ZVtUIEHCOXlqtKjNqG9IZ0Ar
         GBvStWIFJBMPJRWAOyWbc+ZLmHYIqix6iSnnL7kMTsXZHlDV1lAxreb/2nLMD0mb8ux9
         XnCbElV4AMa4HJvgOxgVjAGEYQoxT/3qWqcT2U4XAKh6sCQ3GLp3SZWMOPqjqdwsaWIj
         VXjA==
X-Gm-Message-State: AOAM533gPJAl23b29PJ5OrZ72zeF/06SlzX9aFu1MYd5IPs3uWvBkUpH
        LxHpPWVbEph5D2j667g+uDrDzA==
X-Google-Smtp-Source: ABdhPJz4JFxHF5HT/Sf/16gK3QpUtzsWvDwelmezplwVTNeYf4CgjXeF5D6OGEv3bKFwzB3+WtKvdA==
X-Received: by 2002:a05:6a00:b8a:b029:2ec:761e:33e3 with SMTP id g10-20020a056a000b8ab02902ec761e33e3mr375293pfj.35.1623252239567;
        Wed, 09 Jun 2021 08:23:59 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id k7sm5424258pjj.46.2021.06.09.08.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:23:59 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Use libata platform drivers to replace deprecated
 m68k IDE drivers
To:     Michael Schmitz <schmitzmic@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Finn Thain <fthain@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        Joshua Thompson <funaho@jurai.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Richard Zidlicky <rz@linux-m68k.org>
References: <cover.1623131194.git.fthain@linux-m68k.org>
 <YL+AqIEPjMgG519L@infradead.org>
 <d3c70f7a-368a-ad9a-6575-8289234b0ce0@kernel.dk>
 <36f7519d-698f-1284-551a-0dbd82e2a0d8@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aca5ed6b-f54d-1a3e-b905-920be85d51d8@kernel.dk>
Date:   Wed, 9 Jun 2021 09:23:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <36f7519d-698f-1284-551a-0dbd82e2a0d8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/8/21 3:50 PM, Michael Schmitz wrote:
> Hi Jens,
> 
> please note that Finn's patch depends on one of mine currently under 
> review. Without that one, Q40 support may break in certain cases.

Can you point me at it?

-- 
Jens Axboe

