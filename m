Return-Path: <SRS0=R/8C=W2=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522C3C3A59B
	for <linux-ide@archiver.kernel.org>; Fri, 30 Aug 2019 20:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AE72342E
	for <linux-ide@archiver.kernel.org>; Fri, 30 Aug 2019 20:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="srxXErUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfH3U02 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:26:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36643 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfH3U02 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Aug 2019 16:26:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id w2so5341677pfi.3
        for <linux-ide@vger.kernel.org>; Fri, 30 Aug 2019 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iIIskhaqEKfh/HRB4yBq2WDy6v4Ph+jgnR6iPGJXHsQ=;
        b=srxXErUhH5ILDsZj+NdfHqeJT9DKZXlXYUDH6dDqrwO8scgOKWJ2FHrRR/dAIgubII
         +D/0vPYrqXWgmN8on16mDk/GTueMFgvv7uXETtPygVZKJiET0trcBW+BuqIfP9N4hbh3
         py4DZsT3sguDssxvraOgx3riF5L8k85I3Xoabm2E/qQFevODldUrWGNuMQOnOIodoHYA
         NnYc644xJINtiV+JY2hrpiXPMutnxx7m6Uvqm3XcK6s0s4YO1bB5mHtzwZalefv2vwvh
         nJ+lMUHvADS23acSOO0BT1USS8kT+/LA5/yBqk/V6IkXwmvEdDW+PS+qYDOPBgsiWSx4
         HjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iIIskhaqEKfh/HRB4yBq2WDy6v4Ph+jgnR6iPGJXHsQ=;
        b=mkiTBE/+vmcvILV63WlqSUJHdwI0gPksaIw1MzH6FVNaXtucZDVcR4yIPa2ZKtEGJG
         i7KfKdil2KudgEBuYh2WhEDrMflIXxvlY6QwV4FwVE7CZOENt4DGdWRp/jE2cPU91tMd
         /NZN/8fduscvTSYgVy00962/yHiOTGoWu1t5Bqe0G2Ce3GJ36YbcJMc7S74nCTp1ehLg
         fDxDdB1XIAJIoUDL1tspXTLoqnlDbkOfeSPA57yXJNj4MKd4gREst9hG7jIikZoqSn+c
         EhjgmmObdVlOwi0JDW2olmJkxZ4muQNAxhg0xN1yA1mYuvDU58Pn1FiO7/+EKvCYF6Ee
         jNyg==
X-Gm-Message-State: APjAAAV/LAbfarqTVrbpFVxnZCakc62NScwV+rQt3mpVOtlWx4FYn0tj
        xVptrInSViiS2H9ZFrGKItL31g==
X-Google-Smtp-Source: APXvYqze7cGDwL8Y6Ty1UGnMAlUH8jEYU616/pZNV97iIw+5uNPo24kDUYn6QOBtRsSSb+0zYrtUhw==
X-Received: by 2002:a17:90a:37a7:: with SMTP id v36mr368563pjb.3.1567196787807;
        Fri, 30 Aug 2019 13:26:27 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id d3sm5173507pjz.31.2019.08.30.13.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 13:26:27 -0700 (PDT)
Subject: Re: [PATCH v1] ahci: Do not export local variable ahci_em_messages
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org
Cc:     Chuansheng Liu <chuansheng.liu@intel.com>
References: <20190830194255.878-1-andriy.shevchenko@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <65481074-5107-14d0-af7a-ec571a13d28c@kernel.dk>
Date:   Fri, 30 Aug 2019 14:26:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830194255.878-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/30/19 1:42 PM, Andy Shevchenko wrote:
> The commit ed08d40cdec4
>    ("ahci: Changing two module params with static and __read_mostly")
> moved ahci_em_messages to be static while missing the fact of exporting it.
> 
> WARNING: "ahci_em_messages" [vmlinux] is a static EXPORT_SYMBOL_GPL
> 
> Drop export for the local variable ahci_em_messages.

Applied, thanks.

-- 
Jens Axboe

