Return-Path: <SRS0=uzjf=BG=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A10C433EC
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jul 2020 17:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360922075A
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jul 2020 17:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="r0nWfJei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbgG0Rmy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbgG0Rmy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jul 2020 13:42:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D888BC061794
        for <linux-ide@vger.kernel.org>; Mon, 27 Jul 2020 10:42:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f185so4546300pfg.10
        for <linux-ide@vger.kernel.org>; Mon, 27 Jul 2020 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lsbka09HUg/6AnqlzwCmUEpN5zjWnvzDu4J8ThOF1eI=;
        b=r0nWfJeixf6Lj+km7L3Pz6DT4+fYo1qxHNgUPJGoxKo++zwulrc9YaIPT3UXHuIFUL
         pyAFnxAqlRTX2/FXo5stzuidX1UmOct461dBiSxciWndxFchoDGsjWuSL3RacmTZ4A1C
         6IslrowS3wNyVTSWlpn83eYTjMZvfSvVpyldJWR8cHvzAP5CFInMEvpxNP1fE0p5FWpK
         nJ9mU7a7pBJcjLWs68/tAzSTfjNM0MtxYc0csTehZE+6SHYk3k/2uUgOaDWgGSk4unAA
         Bm9OpajN3Jl44obCfwbnB0mAR4jnTreXXynFQwJMnlTsof78GjRoscNpCiKEZu0PyLGF
         griw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lsbka09HUg/6AnqlzwCmUEpN5zjWnvzDu4J8ThOF1eI=;
        b=U/mvi70EFepsgIpahkZLL05tuw3Vrruyrh6RwuaBgxT/49+WGVD1NxWp/Vx+COA2zz
         0Q3vauPoYXJ+gXAtiPBo6MfXO/i7p7uKvscuKrTAJdMAnepq4wjULOfH/QD584Js5KgM
         5uJkImjWtJKpkBJePREJAUuLljZmOxnwDdMhHq4GU3kZCnt0cUucZBofMwezQqQ1RUWq
         YwbBCk/TOza11GKlZgsjcVGn8qSmVJkYexL5ET64zRXMaw5tSv3tfkKrSqqqFJ3I8F8g
         Pp/3r18vzUSE0g++p6rNXs/29+A7ILDxbEGEH5ZxoFPacbZDR2FQzb02gpWQAjGXGr/a
         EJFQ==
X-Gm-Message-State: AOAM531AMM6wNa9fFmdh8D3kGESs6PCbfV396kjWzUBjurpB4jh/o+M1
        qgPG4d78wllqDCVFVbtGUsae6w==
X-Google-Smtp-Source: ABdhPJxtBjozrrmTF4k4W+BHFQLbRoB8W6XPzUk4V7UxSjHortXTE1AqQ3bjd1AMkeifgNSJklFueg==
X-Received: by 2002:a63:9dcd:: with SMTP id i196mr20321294pgd.378.1595871773315;
        Mon, 27 Jul 2020 10:42:53 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b22sm218988pju.26.2020.07.27.10.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 10:42:52 -0700 (PDT)
Subject: Re: [PATCH v2] ata: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200727173923.694872-1-vaibhavgupta40@gmail.com>
 <20200727174012.GA696265@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b4738b0-5c2c-8ee2-83f9-10b961a5d0d3@kernel.dk>
Date:   Mon, 27 Jul 2020 11:42:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727174012.GA696265@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/27/20 11:40 AM, Vaibhav Gupta wrote:
> The patch is compile-tested only.

Please test and verify actual functionality, if you're serious about
potentially getting this into the kernel.

-- 
Jens Axboe

