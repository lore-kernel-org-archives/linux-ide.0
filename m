Return-Path: <SRS0=1hKS=ED=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA646C55179
	for <linux-ide@archiver.kernel.org>; Wed, 28 Oct 2020 23:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE80207BC
	for <linux-ide@archiver.kernel.org>; Wed, 28 Oct 2020 23:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yyA9cidd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbgJ1XnN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387442AbgJ1Wvz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 28 Oct 2020 18:51:55 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51EDC0613CF
        for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2020 15:51:54 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z23so1320421oic.1
        for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2020 15:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ioYs1BJonmJO6vYXpRm8U4hKxcd63wE2JMeNCJc2SKE=;
        b=yyA9cidd2yR2QAwgyVQBCxpDNBHcJXbWBEvLGlPrYuRB6ZAh1BVaBBJACY89jTImZM
         o30WxWefxQTEpY1PIjcwxO1lb3HUu98mnV7AEdpALvJHUTsMzHkUS0/8FCYyL1QmIiAc
         9LIdZE5qmuNg8v2kGv/4GhFh9GJ3eJDE4pR98/OQM4jTbKMwUpI8gB6uB5kMKatX5jHy
         TW582ksVh1npdMR8sdSdaKbcgKel5WRNwQXrZ4cPvk59XWT3T9VMtZv2MoFb4F2Gl2/9
         HOzSV7ff7UBEjvHD2w3V4HzxoIlR89rKkFvKbkqWyG13QeuAnPenua2W9Yb0eyBSXqlm
         QDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ioYs1BJonmJO6vYXpRm8U4hKxcd63wE2JMeNCJc2SKE=;
        b=PyZ/o0zaTwwzgaeJ6s+oadsEevA/AjL8mDSpec+FWBXjjZJwXYkaldqQVRrJUyNN7O
         a+sHOPIcg7Q9Chk0lxuOcYo8/xrQKKrC/1NGdYgm7tOx28Hkhd84BnjktlZna09BmFdw
         9JBaDK75mJ89HRFblnuLuDf6yebYL5JgO0WbTeggI95biFTsJhVi/jzDy5BMzMIM4Nes
         MyoEbCMcycxdLxPZ122Yh+g/zvgUGnEJCxQIXaU84V2VjnEYj2vsZL0shMmFHE990bIi
         hemE+dpr7/G0+KhR9Ih55qdmZdnAbCYK17SXyioMYfJTweDx3BJtOMVIfo8rFycrnTcX
         +I3w==
X-Gm-Message-State: AOAM531WMdN5lBDmWoybGcq+W6qjumK74g7Kifpfz4+dnWG2b0gVhM/5
        ocvw8Xe/0FkHMxq3Xs8qXFCkBnq94wOc7A==
X-Google-Smtp-Source: ABdhPJzD/aMxkb8rpZsPVNj3h9iHyLztP+XLxtCaIuQf8c84XQ8Q1470cVwEj94jjzOvVHHCdwA/zQ==
X-Received: by 2002:a17:90a:d489:: with SMTP id s9mr7374800pju.50.1603893519337;
        Wed, 28 Oct 2020 06:58:39 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c8::1268? ([2620:10d:c090:400::4:c0d3])
        by smtp.gmail.com with ESMTPSA id s23sm5710056pgl.47.2020.10.28.06.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 06:58:38 -0700 (PDT)
Subject: Re: [PATCH v2] libata: Fix retrieving of active qcs
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20191213080408.27032-1-s.hauer@pengutronix.de>
 <20191225181840.ooo6mw5rffghbmu2@pali>
 <20200106081605.ffjz7xy6e24rfcgx@pengutronix.de>
 <20200127111630.bqqzhj57tzt7geds@pali>
 <20200127112428.sdfxvlqdox5efzcb@pengutronix.de>
 <20200503214627.gerb3ipcwek2h3h7@pali> <20200508054644.GJ5877@pengutronix.de>
 <20201028135514.r2m3kxchbg6nljht@pali>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ad0bb9e-1bdd-719d-633c-8a18a3b2bf14@kernel.dk>
Date:   Wed, 28 Oct 2020 07:58:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028135514.r2m3kxchbg6nljht@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/28/20 7:55 AM, Pali Rohár wrote:
> On Friday 08 May 2020 07:46:44 Sascha Hauer wrote:
>> From fcdcfa9e7a4ee4faf411de1df4f3c4e12c78545c Mon Sep 17 00:00:00 2001
>> From: Sascha Hauer <s.hauer@pengutronix.de>
>> Date: Fri, 8 May 2020 07:28:19 +0200
>> Subject: [PATCH] ata: sata_nv: Fix retrieving of active qcs
>>
>> ata_qc_complete_multiple() has to be called with the tags physically
>> active, that is the hw tag is at bit 0. ap->qc_active has the same tag
>> at bit ATA_TAG_INTERNAL instead, so call ata_qc_get_active() to fix that
>> up. This is done in the vein of 8385d756e114 ("libata: Fix retrieving of
>> active qcs").
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> I tested this second change on nforce4 box with sata_nv controllers:
> 
>   00:07.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA Controller [10de:0054] (rev f3)
>   00:08.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA Controller [10de:0055] (rev f3)
> 
> Both disks are working fine, I do not see any regression or change, so
> you can add my:
> 
> Tested-by: Pali Rohár <pali@kernel.org>
> 
> Ideally add also Fixes line:
> 
> Fixes: 28361c403683 ("libata: add extra internal command")
> 
> Jens, do you need something more from me? Some special tests, etc?

Thanks, I'll queue this up.

-- 
Jens Axboe

