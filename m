Return-Path: <SRS0=rcVg=B3=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209DDC433E1
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 03:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9682072E
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 03:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vs8KGi9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHQDpy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 16 Aug 2020 23:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgHQDpx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 16 Aug 2020 23:45:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76C2C061388
        for <linux-ide@vger.kernel.org>; Sun, 16 Aug 2020 20:45:51 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so6833182plr.7
        for <linux-ide@vger.kernel.org>; Sun, 16 Aug 2020 20:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MA/9gHI0V+yftTzDrDx3504zFpgx5aUeDq1OIejihpQ=;
        b=vs8KGi9WejCWcKWcxD6bsXKCrIcM0+m4Bw8FfFf3Og83i3+KSRNNLWCD4ty/tof3Nr
         4iKnYwHGhQzW/DLjCAlrjRt/VjAL+bRx0t7QGSPZMmnAXHZOjye2Zh5oghknrvL2Juco
         gLVkZFd1cJAMCWC0w9qW8GeKTVfXiaxcIGi98sOYGm5cyiAGdgVeSkRwWjbVZjQsubmy
         yheIf4xhYRDJCIa8y8TNxAB6L0U8GwS+VMZV2+VtMq95iBnPmBxmt91jPbSaizfLN4uY
         Guo9phQx+7+J6PPgpTaUcKFvTetyfEm652SAIY3I5MsWNCtyDZDR4wIPrnloFWg9Y8gS
         xnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MA/9gHI0V+yftTzDrDx3504zFpgx5aUeDq1OIejihpQ=;
        b=IJBp5zOmCVMcI3cvjZIEqxTD+2/i+ue/KJiE7CfH9M7K5G5hwPSeFYXyt/Ocjc1bU/
         gZLdm5iYoeQlYhMSdr28SqMIOIwHBeYEc2l5paFUud8w9CI4SRAJJ3rva5EDviKVpbo+
         0UdHC6cptvQXojyC0zjYUwwoxoRvFp2Dkg0u7uqxgr1VeTzpS4+VwAokCldrnM55aIWx
         MATrhy9PkMwQe50p1JWe1vgveYN61S50OqxkUFNQMlVhKY15CX0tiz0hsEb92bhBwCDC
         s5HhB1M+HR55TeUsrag6dDYTcD7z7QM6Exd48VQfCkyVA/WdV7CTClNCsX+2pX57JWWt
         pr+w==
X-Gm-Message-State: AOAM531fB2ShKt99MN8mr4WRXDh4kl+RGntkVDzynXcGxS2/6ZeiAChQ
        BYCConvAWZml10Jng8Be6MaWChAZqSAKxg==
X-Google-Smtp-Source: ABdhPJziFq7DHhuHPYkQ5rKF4HfMbh/cUrsPSHGpavzCqwuHvA591aVIa0+v1ku33lFfVV8TOVUIXQ==
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr11493068pjb.170.1597635951325;
        Sun, 16 Aug 2020 20:45:51 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ea1b:63b0:364:3a3b? ([2605:e000:100e:8c61:ea1b:63b0:364:3a3b])
        by smtp.gmail.com with ESMTPSA id s24sm15332095pjp.1.2020.08.16.20.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2020 20:45:50 -0700 (PDT)
Subject: Re: [PATCH] ata: ahci: use ata_link_info() instead of
 ata_link_printk()
To:     Xu Wang <vulab@iscas.ac.cn>, linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200817032913.10173-1-vulab@iscas.ac.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <de66f1e7-9ac6-b8be-a243-0fe68419bc24@kernel.dk>
Date:   Sun, 16 Aug 2020 20:45:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817032913.10173-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/16/20 8:29 PM, Xu Wang wrote:
> Using ata_link_info() instead of ata_link_printk().

Applied, thanks.

-- 
Jens Axboe

