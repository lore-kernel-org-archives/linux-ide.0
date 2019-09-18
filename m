Return-Path: <SRS0=NLwT=XN=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4B1C4CEC4
	for <linux-ide@archiver.kernel.org>; Wed, 18 Sep 2019 20:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94AF21927
	for <linux-ide@archiver.kernel.org>; Wed, 18 Sep 2019 20:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DfqrCjY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbfIRUIp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:08:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35872 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390532AbfIRUIp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 18 Sep 2019 16:08:45 -0400
Received: by mail-io1-f67.google.com with SMTP id b136so2241545iof.3
        for <linux-ide@vger.kernel.org>; Wed, 18 Sep 2019 13:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/tirIKQwqPi5b7L0wgzdi+w4/XVdukjfcgtLLjEguwI=;
        b=DfqrCjY/L+ncH827dgVkK47JxDWYDq8n1Gr+IjrtakEagsw0/tnUlUGJXScHyD4s6N
         mSmIB7G2/5J6eid16zBuRBzXZ//jVAF561Ju849aXVesApT36gPfhX0QT8nYhw+JEfYu
         R2XHwS+ADhbrl+Z9r8PJQjhjZg8WeZQEnBkpDO0w8LiHDmMyTBk1UQtauLtqn9OAIOTa
         tZn9VVoqW2LEbN203rLKhsfLG7utSqDM4lD7TAmkalCcQyFE0h+hpVWdNGiesLv3kE+K
         zeDkosvPACEMW5xdSBFjXQKgG24/H2ExH0uRE+b5gd8MQ/ZroY5XVKeZuBTc/DJ0b+La
         zlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/tirIKQwqPi5b7L0wgzdi+w4/XVdukjfcgtLLjEguwI=;
        b=NGfQ0Un2y1Aa0r44Sn6/s+QcyMM3Xb+ptvz9dF6ux+yJXcFcA67TOLyapnFlUcXAuy
         GcnMyhbZKFCNQ9hAWd5BAsyEzgDE0+QAnE4LRKXmMqtlegD1lNl8X4N/HNaM5/ZpfpuZ
         5iHOeBqIuPWJMew0aecbzBqqCIPaDJRdMyEgKu06nzs1j/0vUmkS11QqyMnZ46IzmM+i
         Q18HmekIYEIozpS4ClVuG0Bi0kn3Tw81e3+joJlmBDsv2DChnIcA/cKrqM7SNchMBpyO
         mXNtRMPP7tYVbYz2CjVsfKzc60n0hkwQXRzCQ6hxRp74COda9BdDutDTNgK2tuCgtqT0
         pljw==
X-Gm-Message-State: APjAAAXUjysk3lbPDeqTcivcZOl2cOsrnr4RbEBlBcbjwyWX7lXCG9wk
        49huaOWqjM9wyy3cKTkxRPyD4g==
X-Google-Smtp-Source: APXvYqxqyIESBbs5UNuARsPiCqsoNXJY06TIV1cftP2bVGya9UvnKZSogfqsdXBIH00g/Ko6QmyX9A==
X-Received: by 2002:a5e:8218:: with SMTP id l24mr1950526iom.56.1568837323239;
        Wed, 18 Sep 2019 13:08:43 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b24sm5310567iob.2.2019.09.18.13.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 13:08:42 -0700 (PDT)
Subject: Re: [PATCH] ahci: stop exporting ahci_em_messages
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Liu, Chuansheng" <chuansheng.liu@intel.com>,
        Tejun Heo <tj@kernel.org>, Steve Winslow <swinslow@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190918200028.2247535-1-arnd@arndb.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd65486c-b5c1-63d4-ea73-1d16e123aa41@kernel.dk>
Date:   Wed, 18 Sep 2019 14:08:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918200028.2247535-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/18/19 2:00 PM, Arnd Bergmann wrote:
> The symbol is now static and not used elswhere, which
> leads to a warning message:
> 
> WARNING: "ahci_em_messages" [vmlinux] is a static EXPORT_SYMBOL_GPL

If you look at master, this was fixed in this merge window:

commit 60fc35f327e0a9e60b955c0f3c3ed623608d1baa
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Fri Aug 30 22:42:55 2019 +0300

    ahci: Do not export local variable ahci_em_messages

-- 
Jens Axboe

