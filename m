Return-Path: <SRS0=dJ96=4I=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2751C11D00
	for <linux-ide@archiver.kernel.org>; Thu, 20 Feb 2020 08:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F8824654
	for <linux-ide@archiver.kernel.org>; Thu, 20 Feb 2020 08:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgBTIIQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:08:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35762 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgBTIIP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Feb 2020 03:08:15 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j4gsX-0001GU-N0
        for linux-ide@vger.kernel.org; Thu, 20 Feb 2020 08:08:13 +0000
Received: by mail-pf1-f198.google.com with SMTP id v14so1955888pfm.21
        for <linux-ide@vger.kernel.org>; Thu, 20 Feb 2020 00:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ap9U+phFzhqWDo4fgbwK0bHCPUbHZGx2Chn9f/utSqE=;
        b=H5wLorUZh9SLNDwQTUqsv6/FpG/lVuqp0YfjbrvcqYUaJaIDNRt2sYsvBm2qp5oEDg
         SMfVqbWNEgHTQJknBvDWkhLYUkiDEiF3++u7MTNTuAa6JIGEG5htIJL3/BRCk2yS+REu
         cY8Ono08xw2/IPZ2j+yte8l2ey8OBvnRd84LUOaMVJZSNZQyldtnL8trG50wYBNHM6Vj
         p1WwoYYMKGeti5yxLycqcDFsxA8c0G6iU78AEXdYjWAmvzhhE6fANTrViW2SGlImg2O+
         gTLSsPu5uNpen5SFGg8lPC6CDc6c6I6xT4kYoEtk5e8Ziz1anocHbRwYqoIofkT8j6C2
         IJmA==
X-Gm-Message-State: APjAAAWTnIfYBCHd7qujQ31rJ/595BGa364/IiK+DobiUR5YRwG/zBO7
        7OXtE5FTvghalHHDLoOZsOHPFuaSL6XiLjl6BkjW7FoEBPcBKA13Y4pKVsx/nUHSEen2TbAFQT4
        tPo3qutxSal4ie3V/dQX3Ex2aL1j9Sa65xHtPlQ==
X-Received: by 2002:a63:3f85:: with SMTP id m127mr32163668pga.15.1582186092303;
        Thu, 20 Feb 2020 00:08:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqw5CB2MYi46pbLazZTtP3PKhLmyTFeQsVGMXYGM8GaSr/DT/ckFZWcNpfje4HaQNdbg8P3+gw==
X-Received: by 2002:a63:3f85:: with SMTP id m127mr32163647pga.15.1582186092011;
        Thu, 20 Feb 2020 00:08:12 -0800 (PST)
Received: from 2001-b011-380f-3214-b828-48d4-ee3d-9937.dynamic-ip6.hinet.net (2001-b011-380f-3214-b828-48d4-ee3d-9937.dynamic-ip6.hinet.net. [2001:b011:380f:3214:b828:48d4:ee3d:9937])
        by smtp.gmail.com with ESMTPSA id w11sm2415060pgh.5.2020.02.20.00.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 00:08:08 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Hard Disk consumes lots of power in s2idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <a9fd25cd0a151d20e975ce79ab70197e39ef01e1.camel@linux.intel.com>
Date:   Thu, 20 Feb 2020 16:08:06 +0800
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-ide@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Kent Lin <kent.lin@canonical.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <235CF4F8-19BF-4B00-8C92-E59CB2D476A7@canonical.com>
References: <0955D72C-D24D-402E-884F-C706578BF477@canonical.com>
 <a9fd25cd0a151d20e975ce79ab70197e39ef01e1.camel@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Srinivas,

> On Feb 20, 2020, at 02:36, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> Hi Kai,
> 
> On Wed, 2020-02-19 at 22:22 +0800, Kai-Heng Feng wrote:
>> Hi Srinivas,
>> 
>> Your previous work to support DEVSLP works well on SATA SSDs, so I am
>> asking you the issue I am facing:
>> Once a laptop has a HDD installed, the power consumption during
>> S2Idle increases ~0.4W, which is quite a lot.
>> However, HDDs don't seem to support DEVSLP, so I wonder if you know
>> to do proper power management for HDDs?
> What is the default here
> cat /sys/power/mem_sleep
> s2idle or deep?

It defaults to s2idle.

> 
> Please follow debug steps here:
> https://01.org/blogs/qwang59/2018/how-achieve-s0ix-states-linux
> 
> We need to check whether you get any PC10 residency or not.

Yes it reaches PC10. It doesn't reach SLP_S0 though.
The real number on S2Idle power consumption:
No HDD: ~1.4W
One HDD: ~1.8W

If the SoC doesn't hit PC10 the number should be significantly higher.
That's why I think the issue is the power management on HDD itself.

Kai-Heng

> 
> Thanks,
> Srinivas
> 
> 
>> 
>> Kai-Heng
> 

