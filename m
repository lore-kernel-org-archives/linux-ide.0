Return-Path: <SRS0=f0ic=5K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C64C1975A
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 14:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8A4208E0
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 14:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sLOwBdUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgCYOlS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:41:18 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:39278 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgCYOlR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Mar 2020 10:41:17 -0400
Received: by mail-pg1-f171.google.com with SMTP id b22so1233025pgb.6
        for <linux-ide@vger.kernel.org>; Wed, 25 Mar 2020 07:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v+3itCJ9bych8vu3A097nZpMTXiJvo3X8hBc0deIt6w=;
        b=sLOwBdUOdH1gwBYqv8FTv8Xh0go5Jfc3StSpjhANRSbTxPFWUTjC83M25NsrV/P2VQ
         gomKSBRvm7wdS9AGCA21Ycxw2O5bVTqfnBCs1ZKpz/t8TRi6q8kAFwJ4g3xqXVi2HdYG
         IIPTk/LxOGBC5++p7yHSII5XgLu058uMyH48UL/OeIyebi16dNrUhxzKCKNzzcgCIShQ
         eQDQTQ42cGvmRN9ap3XeNxBuNdDa5bevi6mWqjq898jBxxRUp38WAlyc9IYdTBLh831T
         EcPNMxoZqkB1/XP5eCteWC0dLmLfhyRK8dQIbZrCFhKyzEEahYDa4/YQy5IgijOq2gn4
         Ax+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v+3itCJ9bych8vu3A097nZpMTXiJvo3X8hBc0deIt6w=;
        b=SZxKORuwoRaHtUD9yfvYeAcxuUi493jn7tCuyAIXDKqEddx8R8jX54LG6bv4sQEzlz
         YLT/mRdFVY9Hj2x/ZEBBOFvvKeWsFzcu5/2/UGPzexNNz+wujzlpGO6TDDH+vRanRQ58
         /R9XiQ8mWlLE9Pf5GbjPcKQVvnn/n089vOmdLNky3PkGa7M1ake7HGdJOuV66KtyqLf8
         wvVhDOXxa3tJ9YRkAGXqTcMmxYdIyytBqXVmjN6vFFyWV9I+W9u20nDDG4MrZR4LXc2B
         /M3LsFakxAD/NBH4k5NETdVvVTPx9XKkbP/+sTjIGB36UEhkkAna0PhVHpj8lTxU9ViB
         ZJCQ==
X-Gm-Message-State: ANhLgQ3bJeh6y2S+VoTgIqTvH95VDo6HccmOQSNhDP0g0WHj75A0I8jO
        POTfOmI+row5hVHAFBw05Hf6Vp2YrawGUg==
X-Google-Smtp-Source: ADFU+vvdUsU32pqyACzHxNffWttjGNLPiRci3G9gJR1X6o6qJzfaPR9icC5VdjYGFl66bs/Tobfg6A==
X-Received: by 2002:a63:ed13:: with SMTP id d19mr3486679pgi.49.1585147274542;
        Wed, 25 Mar 2020 07:41:14 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id w27sm18674383pfq.211.2020.03.25.07.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 07:41:13 -0700 (PDT)
Subject: Re: [PATCH] ahci: Add Intel Comet Lake PCH-H PCI ID
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-ide@vger.kernel.org
References: <20200227143259.67172-1-mika.westerberg@linux.intel.com>
 <20200325100854.GS2564@lahna.fi.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <04321ace-0aa2-a0c0-aea8-f5d96bd9f4dd@kernel.dk>
Date:   Wed, 25 Mar 2020 08:41:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325100854.GS2564@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/25/20 4:08 AM, Mika Westerberg wrote:
> Hi Jens,
> 
> On Thu, Feb 27, 2020 at 05:32:59PM +0300, Mika Westerberg wrote:
>> Add Intel Comet Lake PCH-H PCI ID to the list of supported controllers.
>>
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Any comments regarding this?

Sorry, I was blind, I had already picked up one but didn't realize we
had a couple of them. Applied this one and the PCH-V as well.

-- 
Jens Axboe

