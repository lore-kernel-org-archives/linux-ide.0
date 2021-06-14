Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42436C48BE6
	for <linux-ide@archiver.kernel.org>; Mon, 14 Jun 2021 09:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B146128B
	for <linux-ide@archiver.kernel.org>; Mon, 14 Jun 2021 09:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhFNJOs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Jun 2021 05:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNJOs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jun 2021 05:14:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C594AC061787
        for <linux-ide@vger.kernel.org>; Mon, 14 Jun 2021 02:12:32 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso12492366wmh.4
        for <linux-ide@vger.kernel.org>; Mon, 14 Jun 2021 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rE75OEJmRkiphAQgbNylsb5lS5RCqZ1mYOeIVhrqISM=;
        b=WJ3tpnBEfeWF0/kH/8/+lrientdHvkK3PS68x9IVO1JQSI80J/yHCOlh0IsPbvC/8I
         H0oKk58f/d6u3mGdZ2I/4JFU3VQ2jKNlcURVirhImT8qQwO27j7UMg7n5cRpDhbFAsyQ
         WBz2vIXdJr/L4A2hYljUyPHoDdib7yk46Od391zO0go6EhSbJu3Y6C4IzuOvABo9TAbI
         /83Z3taXs2o1IXw819dLQ/mlByGgjGKTGFkeSdOU3y2TKYg9IZzZCsM1JN/W82BQ1B1f
         6OiNDqPfBkF6xDlf64u8nG44qMNItoXaIvR5myFDxxc3/D1ojcgDLFi3DMjLazEXA89W
         1llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rE75OEJmRkiphAQgbNylsb5lS5RCqZ1mYOeIVhrqISM=;
        b=R4Nwn2Nu1HcV0RxWHhq+3oHjEQv7xWgUshPR+Yf290eGwCgSN9c/0b5LQwDHZz6+Ia
         bQScErZo/WpCMcgumS6EitZWmATN4OKZU4+p1i+teSqqzfobAEVSXXAsYUG/V/MWORex
         P+XfRCnWK3t/bxBgBg/V9Rp2AYBZcTsTqj8JmyCULgT6k3Ftlfa2ROC0CRZWcSZ1wraH
         pZMSJHxLLfRxy9AjhP5X/3OrmC8GpxocklhQbfpOFpAq4/PtPoWIBTl4cIaHvAkcMcRB
         5s97p9vkR25n/rgEnEMZfDMgqvy0REDZX8U8tF8ZEHB8XbNfBDOXRDyogIcnX8mwTAbh
         ymQA==
X-Gm-Message-State: AOAM531vPcwB5fAsDg+cD2CUx35GWDpS0g/GjQW9+/A5GlPgsjb+sdgo
        3zROsmn3yeIQOfGIJEeVDezmNA==
X-Google-Smtp-Source: ABdhPJxMA2/SLYA8c9iSQV5GCW8IQfyxI5XFtS2VihpYEMDIJhKH2AYMV290kDl3xx9dJ+TgccNGSg==
X-Received: by 2002:a1c:dcc3:: with SMTP id t186mr15902760wmg.23.1623661951291;
        Mon, 14 Jun 2021 02:12:31 -0700 (PDT)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id k16sm12442514wmr.42.2021.06.14.02.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 02:12:30 -0700 (PDT)
Date:   Mon, 14 Jun 2021 10:12:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Adrian Sun <a.sun@sun.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andre Hedrick <andre@linux-ide.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Benoit Poulot-Cazajous <poulot@chorus.fr>,
        Christian Brunner <chb@muc.de>,
        "Christopher J. Reimer" <reimer@doe.carleton.ca>,
        CJ <cjtsai@ali.com.tw>, Clear Zhang <Clear.Zhang@ali.com.tw>,
        "David S. Miller" <davem@davemloft.net>,
        Duncan Laurie <void@sun.com>,
        Erik Andersen <andersee@debian.org>,
        Frank Tiernan <frankt@promise.com>,
        Gadi Oxman <gadio@netvision.net.il>,
        Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Mark Lord <mlord@pobox.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Waychison <crlf@sun.com>, or <source@mvista.com>,
        Paul Mackerras <paulus@samba.org>,
        Robert Bringman <rob@mars.trion.com>,
        Scott Snyder <snyder@fnald0.fnal.gov>,
        Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        Tim Hockin <thockin@sun.com>
Subject: Re: [PATCH 00/21] Rid W=1 warnings from IDE
Message-ID: <20210614091228.GB5285@dell>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
 <YL3YMGl9kmtv55B/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YL3YMGl9kmtv55B/@infradead.org>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, 07 Jun 2021, Christoph Hellwig wrote:

> Please don't touch this code as it is about to be removed entirely.

Do you have an ETA for this work?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
