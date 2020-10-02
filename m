Return-Path: <SRS0=wLrF=DJ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7BDC4363D
	for <linux-ide@archiver.kernel.org>; Fri,  2 Oct 2020 20:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7152065D
	for <linux-ide@archiver.kernel.org>; Fri,  2 Oct 2020 20:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="z14sUQRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgJBUx0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 2 Oct 2020 16:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBUxX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Oct 2020 16:53:23 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E23CC0613D0
        for <linux-ide@vger.kernel.org>; Fri,  2 Oct 2020 13:53:21 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id j13so2478326ilc.4
        for <linux-ide@vger.kernel.org>; Fri, 02 Oct 2020 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wHq6QcELskmqQRbbU4Ez9UDNOIMAxI4Z5sj87N48/Fw=;
        b=z14sUQRsQEbcJRMRplX/SB/Ow/6qIPls8y6yDJzR/FwPuwWmFNRGds+el15H0RGFzO
         jP43lWR+p5I7KG3G+ykDaNPYi0NhybSEys6KL11wzljEV9sMGvj1+B6Tya8yS/yOJL5y
         Et4LyH0jPCD0bkzdUxLZ6fIZbufd7XiJH1dMYDHxjVI409VP+02GJ3jLIhpktz1tAQNP
         PtPOPdsBwSmjqfJuZdJ6TT7Z0ka3S0bKEPK5MBdihkh2aJZkgF9bjVBS4OchCPv8BBHz
         tYMdziLTfSAkllmIkzMadb8ty757m8uSCpjv2/d3++0qguU6qjQALNx3XSfmOympLcQH
         Ji7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wHq6QcELskmqQRbbU4Ez9UDNOIMAxI4Z5sj87N48/Fw=;
        b=QfCFJE2zSfvequDj30ShC4FC+Q1UW9823jKMDXYETcdmptGVjfDiMUsS11+OGBfXsq
         xLYUMsbkfN482GkeYg9UrM3VCxYQyE9VzxHsXTpqANUWjKzWwYcCQcNGWPGYCK3Iz5c6
         hrcuIoCmTKDFK6mFywREChyMRn9JaShmqnOyKajOu1UnWxYqax58k0gXzVcD6CROmODA
         4gNYMoTO8lB93p6ZJi7HGyrrPcoFM93/OftVMlWu2w3W+cKph4zp1F9rnWIrsnHbTVgu
         I5Qb+s33pEb7J5c+/ss5yDREu09a/Yx3sR0ugicoFFp7Ia3ap6wIyeYY1HFsjsPp7jPR
         /0Ig==
X-Gm-Message-State: AOAM533C1Gs2AESQE1pZ/HQZSyOX6BkO7dHPy9Atz0rQsDgMwA7SRCS+
        QTNFBwSxpTzKduohiwPzBl7POA==
X-Google-Smtp-Source: ABdhPJy9gj0Vn/6u+oU0soLG1bBBgGtK/ALilnTiu7tfBCDQ/q7rkmoX8MaVq5GEPkRsft6i7ujlGg==
X-Received: by 2002:a05:6e02:1085:: with SMTP id r5mr3184792ilj.44.1601672000703;
        Fri, 02 Oct 2020 13:53:20 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v15sm1341214iln.83.2020.10.02.13.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 13:53:19 -0700 (PDT)
Subject: Re: [PATCH -next] sata, highbank: simplify the return expression of
 ahci_highbank_suspend
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200921082451.2592033-1-liushixin2@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <908d3f35-3243-2f7a-edb2-5bcc5e9348de@kernel.dk>
Date:   Fri, 2 Oct 2020 14:53:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921082451.2592033-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/21/20 2:24 AM, Liu Shixin wrote:
> Simplify the return expression.

Applied, thanks.

-- 
Jens Axboe

