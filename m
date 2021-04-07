Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A70CC433B4
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 16:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01F161279
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 16:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354057AbhDGQFE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 12:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354077AbhDGQFE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Apr 2021 12:05:04 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16132C061756
        for <linux-ide@vger.kernel.org>; Wed,  7 Apr 2021 09:04:53 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q10so13418744pgj.2
        for <linux-ide@vger.kernel.org>; Wed, 07 Apr 2021 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FcJ28S0ovo6BtJGz/fpmjvkKUjvV8E2lcWibpPKseko=;
        b=vLzIrzOZwrbQb+XmH2+qRynZP4JyacNCcmSRRRB6xthR7ZSg8pwCGrUS1eanfwh6ns
         bk9WVxPUyGyB+ty+EvYzd2V6V/yul16OszooefcN+nOeUEwX6LnIotDOM6LiXlJfT7jC
         qUZ2Z2PrXePGK5YjOUnSXWSu+sWvIy4bZXTnJrUuxcdGS5Mr4l4oX8PhK2ZRi1/Cm7AU
         DKD2nRqNls9ouaI2w+PfgYo4KCdIh1CzzXdkSc4ZevXII/PMpJTY+5e1ppfHp119xWZy
         wNsLO1Lm1kSG/6n6IKVNpQEKr3GNUZemFRI6y9A2caWNN4+0qZGGUByLoqDcWMuBuTv/
         HUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FcJ28S0ovo6BtJGz/fpmjvkKUjvV8E2lcWibpPKseko=;
        b=XmQWL8tfpsOD3fhfeGqf0aiVAngXFfbAu7FreenXkeIvyWagqEJ8JtIsWulvM+J48H
         FiXqHQLlYLhGaHKlWIAuxhSt8+wUGq7QsmnlRJtign4RJr8jrvYoAGzwYjGQ8C2gueli
         2pxY0aCpUqPeeTUAUfEodRIZadbSB56eA2JX98BHRgS/Pcr3IVxfeDDMdbH7uP+l2+sN
         3WbCTgNzy2Q3V7K4YSYg3ecKgn85lNLdecIWDTku4gaS4mQ6vHtIp95LkUrETnWDsDzR
         t5xtiTqfNU1AyPzc4FsBhLxdRRmM+MWGgqnnLuw7jAiE3oQM/xe7C4Z0syPDlV0c/nOP
         bpMg==
X-Gm-Message-State: AOAM532E4NQSMYna63bzMkvCz6rYhy/vZfd24nGhp6z/B1QGtsx+p/zW
        agY9zPIayi3lab7q8IsVzJp7HQ==
X-Google-Smtp-Source: ABdhPJxa05rl1eZC8U+FSYTlP4fBwnnhI6BDIP6BLwyEV8PffLv1MO6aeXgs7kZJmx4DOnsp9KqnRg==
X-Received: by 2002:a63:1347:: with SMTP id 7mr707475pgt.112.1617811492389;
        Wed, 07 Apr 2021 09:04:52 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id o3sm6161239pjm.30.2021.04.07.09.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 09:04:51 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] ata: Drop unneeded inclusion of kernel.h in the
 header
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org
References: <20210407134706.81383-1-andriy.shevchenko@linux.intel.com>
 <202104072325.Zv0JLqbH-lkp@intel.com> <YG3X7ogK/Oq2Hv4J@smile.fi.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5111151e-35a5-0422-8414-7b900f01d316@kernel.dk>
Date:   Wed, 7 Apr 2021 10:04:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YG3X7ogK/Oq2Hv4J@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/7/21 10:03 AM, Andy Shevchenko wrote:
> On Wed, Apr 07, 2021 at 11:51:31PM +0800, kernel test robot wrote:
>> Hi Andy,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on block/for-next]
>> [also build test ERROR on v5.12-rc6 next-20210407]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/ata-Drop-unneeded-inclusion-of-kernel-h-in-the-header/20210407-214746
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
>> config: x86_64-randconfig-s021-20210407 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce:
>>         # apt-get install sparse
>>         # sparse version: v0.6.3-279-g6d5d9b42-dirty
>>         # https://github.com/0day-ci/linux/commit/d2574103b692b4fc73f1ed36ee9e4d3324902fd9
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review Andy-Shevchenko/ata-Drop-unneeded-inclusion-of-kernel-h-in-the-header/20210407-214746
>>         git checkout d2574103b692b4fc73f1ed36ee9e4d3324902fd9
>>         # save the attached .config to linux build tree
>>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
> 
> Thanks, we need to include bits.h.
> (It passed my simple build, but appears I have no such driver included)
> 
> Jens, I saw your message, should I send a follow up fix, or a v2?

Let's just drop it, not worth it for the risk imho.

-- 
Jens Axboe

