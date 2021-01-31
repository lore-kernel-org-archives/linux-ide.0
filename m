Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B8FC433E0
	for <linux-ide@archiver.kernel.org>; Sun, 31 Jan 2021 15:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA7064E24
	for <linux-ide@archiver.kernel.org>; Sun, 31 Jan 2021 15:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhAaPQb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 31 Jan 2021 10:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhAaPGw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 31 Jan 2021 10:06:52 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF28C061574
        for <linux-ide@vger.kernel.org>; Sun, 31 Jan 2021 07:06:05 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y205so9832829pfc.5
        for <linux-ide@vger.kernel.org>; Sun, 31 Jan 2021 07:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EOdQu8R2fot/gp5Ae6HSeBVIkzrM0gQFsbLsSFMQobU=;
        b=lf1ichlOzDlmK5NBztXD3cxB3cmRPaMi21O/wA/ZnS49a0HR0kXmuTzan1KAKyP1V1
         NcwYBAFkWQym4kJFWS0EDfJfHYck9MxLnvvZ1FI86oGoi3QXbWp6qXIeBd4OC4BuAohP
         lWLyITWVErKWExTEIrfeuosVXqs3/rCjXU79IYbiOrG0bY4LUd8dK/tyBhV8N6PJOmFT
         xOIAj+QlRPFWf+Qx1tvIZ1h+ufGfZ+2Es/PThsxTrROoJDMhHYDKKBhpZOc3HbF82iZT
         VpnaBKowxfVK5CLVBSPnomJk1zRnlDRiCB/pwrSYvtcWXt8pOve4GcjBsZIxpUdJvUTD
         vhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EOdQu8R2fot/gp5Ae6HSeBVIkzrM0gQFsbLsSFMQobU=;
        b=APaS8BJKb2obA3YJCARhh5iO/hgHbqegBDWhLi+WsDT2fNPTuCG1WEMhh5izZTSa1F
         Y4hZylc7A45neQa5AqKUb77v8wc0dceUiIEWzxpWwNuQHxqo/355X0jFDwMjPuSKJ6Up
         bdSKTDpltYwOf/+9TyK8el2ktlWuMHW6oANgseL3OYgGiipUo2DEYCTKdrZ+lWMNNOMs
         IDLTz/LNtRzwNLJPx8QBcIcEXjuD0VmcYq7g/enSkipTiMBZOAuIvKrUcw4eKVvtNel4
         9JNoVsOLdpQb7+Lf8HUteiogBGbVqaaxBaVmSUHOjH/yJRpntbBeCNKrGKF6fUvRXbzF
         834w==
X-Gm-Message-State: AOAM531vjm2/OUZikVEXM/N9TiZ0RFtGfB2HEdeXff6mNDi66Bp/eqZe
        1JC4Iu07scdvmGnDw8Nsk7JMSA==
X-Google-Smtp-Source: ABdhPJwKrPeAj1uarbZ2u2NbLVs/aKaffadRPNV8uqGTBXDsrJCFeUsqtkDVw36S8rdnVhc6Itn+5w==
X-Received: by 2002:a62:2ac3:0:b029:1bc:4287:c0b3 with SMTP id q186-20020a622ac30000b02901bc4287c0b3mr12021723pfq.26.1612105564903;
        Sun, 31 Jan 2021 07:06:04 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id c4sm13466537pfd.160.2021.01.31.07.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 07:06:04 -0800 (PST)
Subject: Re: [PATCH 05/29] ata: Avoid comma separated statements
To:     Joe Perches <joe@perches.com>, Jiri Kosina <trivial@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1598331148.git.joe@perches.com>
 <2a3979b0eab31224e53553ca01759eb072790a65.1598331148.git.joe@perches.com>
 <e65adfa0d8a74e06edda822ac42f7c62c8e0af90.camel@perches.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <33b209ae-14d6-477f-19a4-2a94b5adc6f3@kernel.dk>
Date:   Sun, 31 Jan 2021 08:06:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e65adfa0d8a74e06edda822ac42f7c62c8e0af90.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/30/21 11:56 AM, Joe Perches wrote:
> On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
>> Use semicolons and braces.
> 
> ping?

Queued for 5.12.

-- 
Jens Axboe

