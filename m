Return-Path: <SRS0=wLrF=DJ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A17AC4363D
	for <linux-ide@archiver.kernel.org>; Fri,  2 Oct 2020 20:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7712065D
	for <linux-ide@archiver.kernel.org>; Fri,  2 Oct 2020 20:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lK+TuASA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgJBUxw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 2 Oct 2020 16:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBUxu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Oct 2020 16:53:50 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14593C0613E2
        for <linux-ide@vger.kernel.org>; Fri,  2 Oct 2020 13:53:49 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v8so2989994iom.6
        for <linux-ide@vger.kernel.org>; Fri, 02 Oct 2020 13:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EMlZtDSCazODTZpCvnwVrtAIuDpmFexo2dGZiSThtRQ=;
        b=lK+TuASA8wS5wwFzSWB1/JFG8CsKbIAC0qL9RnpN50/8XpsmayepLgunk/nsufbMVs
         nQbNfvLEA3QqNMX5WAqDXI0KlioBkePEoapSAQNNPOEs4cMxD0MlEm9AnvdY3PvSK7gG
         FVC5lIoFlKj3a6zpBwZ83LKJiwdk2eoKGb1dMPiDbWMHbnPnK85kUGHSyYbPudAin6FH
         YlDp+j10jB7Vc3lIzWpe4ZCDySruK91nlaDgn1HJJ7rNBicBx/exwNq6yJee94P3jSrF
         x+NUyoJQprpAQXa4BLTp/jLWYyqBOp5mbU5x7VqmRr/ebGPNWA7mE96kGt8yomKYF6ry
         38vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EMlZtDSCazODTZpCvnwVrtAIuDpmFexo2dGZiSThtRQ=;
        b=bUr2MQaNFlAf/oFXLcjtvuYrsFePO7Tg5q2c6Yz4MPNTF3uY8onvSISUlJFTJcP9z1
         l7pUscwjPDhdJ3uI1Ey/X2j3YgAMUETRNvN0oQuVfX6cvIO+uiCsgZEWwyfhW875y2jg
         887tzUzc/j6WuSDtqljpIDdxwX9u4vjkuxvGJ90hCQH2TjcOjpaX7vmoAYvUgJmsbsh+
         gqCxSujyUZP1zulcagFWtwCsmSIdalydM9yfO0HIus4WuCGaOXRGjLtCxi0V70v/UkzP
         h5lCmMfwEyqdPO5H1/T4vp17G7qRJ+yrExaydz7jq+IjowHB7hOLdNWAkO/Cfl1KUTaO
         ATFQ==
X-Gm-Message-State: AOAM531daaqGuwURjUbV2OjezIfHC8Z+xfqZpaOwFlHOytEC9GNS28VA
        VFEWdQmyCFep78zyXloYXXLjUg==
X-Google-Smtp-Source: ABdhPJyKFIG6LsYP9hYPo5YmGLJdHj7QUoUTE4D7yEHwDg/QE078YislAC1NdnVmn9Wjpevy/TpbvQ==
X-Received: by 2002:a5d:8e14:: with SMTP id e20mr3269850iod.119.1601672028385;
        Fri, 02 Oct 2020 13:53:48 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c4sm1380949ilg.25.2020.10.02.13.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 13:53:47 -0700 (PDT)
Subject: Re: [PATCH] ahci: qoriq: enable acpi support in qoriq ahci driver
To:     andy.tang@nxp.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Udit Kumar <udit.kumar@nxp.com>
References: <20200817082204.13523-1-andy.tang@nxp.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <79f76fbe-4b64-bef2-fcb4-45f9f14570ae@kernel.dk>
Date:   Fri, 2 Oct 2020 14:53:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817082204.13523-1-andy.tang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/17/20 2:22 AM, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> This patch enables ACPI support in qoriq ahci driver.

Applied, thanks.

-- 
Jens Axboe

