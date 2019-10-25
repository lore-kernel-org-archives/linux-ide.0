Return-Path: <SRS0=i9Gt=YS=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9B4CA9EA0
	for <linux-ide@archiver.kernel.org>; Fri, 25 Oct 2019 20:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDF821872
	for <linux-ide@archiver.kernel.org>; Fri, 25 Oct 2019 20:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SSm31oGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfJYUdX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:33:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45299 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfJYUdX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Oct 2019 16:33:23 -0400
Received: by mail-io1-f66.google.com with SMTP id c25so3845284iot.12
        for <linux-ide@vger.kernel.org>; Fri, 25 Oct 2019 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PP+PlfZ4dT+9sk7iuXzO4Uyb+ZqNRDXomKw0WBHExLc=;
        b=SSm31oGv5i/zxtkLnyGI4XSLhh5I2k4gJRgCdQWG16+3AX/19ppIPgjk0ktfF8nOla
         nhwpAGy0VTKsHSocofC4K6xSrnhtfYEIDVmQf5QV57XIgJ57pV5kHNC9svdQjWu4iTa5
         naCvJYn690uEz86lrgVfvM0BE7nHMyvz4SrK30eeJfHSA0uJc/Sm/If6tWxinPtzOy4x
         gKDnCpazugG1papmJuLK1QByHANCRydqUPSUJbtVLwXZ7tBUBDOoFfL+G/IyjM8+r7l2
         MHL2XFb/HAAdkLavz4GarwNtpydgEFroSRb8makBZAe7DazJl1UflZSyK3BnZdeTKoxm
         SwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PP+PlfZ4dT+9sk7iuXzO4Uyb+ZqNRDXomKw0WBHExLc=;
        b=CsfCC0wHaB0fo/wsQtVasN2j8uiKHuxVQTTQ3LU7ik4A8PlV0/6QZ9++0Dr9pLUQ3h
         VEMtdWf2d1avNVRO99FjpEyKe6af1Fu/IrVWKGD2upyxhhs8J8qzneF+eXeWx8MBwWzb
         151hyseWcsTJqOUvwRyjS2bKRe1SR4qTn8y7im2FMZhO+oROLtaOAOezjh6/PYXSscJK
         mprWUvhbNFJDZt6N6SrZ7V8yTi7XU0CSJ3nTgh5Sbc7yFhHaw8++kJAVGMC++MapjT8c
         +GBp44jp1MSj6ZfkxEnzhUv17zJHd1t/xgR+Tn/nELm5MHqyUrpg90VBynJfkSXk0s6J
         UTmA==
X-Gm-Message-State: APjAAAV87DMuIvvrAgqPUf1dATF9h6a+bEevWlKNT0PdtqKlXIVZP0V0
        HQEC45OFWm/ykGBDvV2Iiyxy+T0kXGseHQ==
X-Google-Smtp-Source: APXvYqyq8H++eBr6G2Hfm2x7KlaOZIBtGQejm0N2txoL+90BlqRsGQMCaxCORp7wVSvo1YZIrZL0QA==
X-Received: by 2002:a02:920f:: with SMTP id x15mr5769616jag.57.1572035602496;
        Fri, 25 Oct 2019 13:33:22 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z22sm362079iol.75.2019.10.25.13.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 13:33:21 -0700 (PDT)
Subject: Re: [PATCH RESEND v2 0/2] Convert Atari Falcon IDE driver to platform
 device
To:     Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
        linux-ide@vger.kernel.org
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7bd80760-0d46-3b3d-16e7-41cbc9169822@kernel.dk>
Date:   Fri, 25 Oct 2019 14:33:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/25/19 9:54 PM, Michael Schmitz wrote:
> [Resend because linux-m68k was dropped from the recipient list ...]
> 
> As suggested by Geert, at least one of the drivers available for the Falcon
> IDE interface should be converted to a platform device driver (to enable
> module autoloading by the Debian installer).
> 
> Add platform device for Falcon IDE (patch 1), and rewrite the present
> libata driver to make use of that device (patch 2).
> 
> Changes from v1:
> 
> Incorporated review comments by Geert; corrected silly mismatch between
> platform device name and platform driver name that caused loading driver
> to fail locating the related resource; check return code of platform device
> register call.
> 
> Tested on ARAnyM with only the pata_falcon driver builtin.

Who's going to pick this one up? I can do it, but it'd be nice to have
m68k on patch 1 first.

-- 
Jens Axboe

