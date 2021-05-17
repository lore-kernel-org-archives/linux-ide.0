Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16046C433B4
	for <linux-ide@archiver.kernel.org>; Mon, 17 May 2021 16:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E324060FD9
	for <linux-ide@archiver.kernel.org>; Mon, 17 May 2021 16:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344117AbhEQQbG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 May 2021 12:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241646AbhEQQaY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2021 12:30:24 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AF7C08EB0C
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2021 08:13:32 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e14so6349244ils.12
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2021 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lg1VKJckwYnokm5uoiiQMDXX9d4zV2ix7g7zD16xyec=;
        b=frpvvXYHM7/OMQjYL7goR3XKDMiY0WagKkC2wpJF66ObfJo5+LGtBPllazKfPJrTFj
         cSHrU0HPsx6rHy2kYBk1nHvaZH0LYdgM886FWVsFD+zsk8olHXM3UgBfLoorC6hc8+Qk
         Rh9HVXX5+ZxGbr6Tx1TJ9XiJohE9RZHqMpYEHDsRIRZPald0abWAL2tKnF9L0kYb8AJM
         mOYyARij30lb2SejvnNrw+SP/CNtOpjaHrAcHPX1MSa34v42dBCBLGqn5D6BjeVo0jMw
         5ny0ueYH/gLsllQiOyBgheuYX2nd+3NWwTXfaRkTdPBm68WmBlswbFFaVWaqdln5sGYB
         r0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lg1VKJckwYnokm5uoiiQMDXX9d4zV2ix7g7zD16xyec=;
        b=YSi7IHknJCJoy4BsStsbfa3AemJpQdITfapcqs/vJE1kXViicYicbUhqRHMKZpdkp8
         1Z2IRo+TENF4FAt0+0mAZ1G+c1+eL55mw7w1W6XfgzU/n5UbxDU7vhe11IrSV9lXa9m4
         IbIrhGL98C48dZvk+dfGewf3RFRrL1zcxllKTcAXUYhi+Iki0+UiqhdR0209sJBY7tRD
         SUAmqhyBMatZuFK/adi2hzUd5qx5+2V1rrDcWxyuh6ryxFrvTM/rUZzAg/k8sGm6KA9D
         1Ofhq+Z03B68tgpE0CEyyWF3Z/7hJ8+Rns4I2YdWD2TeXmvHIhPkHdaTW/vf0CtlQaVy
         aohw==
X-Gm-Message-State: AOAM531s3UMgPLdc4HW10YrRQStO3by4i60WTGPgFbr30wXBcDh+uY7W
        hbmgwSnehnev2HtPisGqBX3EEA==
X-Google-Smtp-Source: ABdhPJzt+Db1SD1ADYZuAd4Hifm/km+ol+JersJ4gCQ2NzQfI5o2RCG0VPN4K8TDun4TL6nvziAA+A==
X-Received: by 2002:a05:6e02:13e1:: with SMTP id w1mr151867ilj.181.1621264411815;
        Mon, 17 May 2021 08:13:31 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v16sm8447723ilq.45.2021.05.17.08.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 08:13:31 -0700 (PDT)
Subject: Re: [PATCH] sata: nv: fix debug format string mismatch
To:     Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210514140105.3080580-1-arnd@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f76e73e5-841e-fe3d-1e84-a259eff2e009@kernel.dk>
Date:   Mon, 17 May 2021 09:13:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210514140105.3080580-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/14/21 8:01 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Turning on debugging in this this driver reveals a type mismatch:
> 
> In file included from include/linux/kernel.h:17,
>                  from drivers/ata/sata_nv.c:23:
> drivers/ata/sata_nv.c: In function 'nv_swncq_sdbfis':
> drivers/ata/sata_nv.c:2121:10: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
>  2121 |  DPRINTK("id 0x%x QC: qc_active 0x%x,"
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ......
>  2124 |   ap->print_id, ap->qc_active, pp->qc_active,
>       |                 ~~~~~~~~~~~~~
>       |                   |
>       |                   u64 {aka long long unsigned int}
> include/linux/printk.h:142:10: note: in definition of macro 'no_printk'
>   142 |   printk(fmt, ##__VA_ARGS__);  \
>       |          ^~~
> drivers/ata/sata_nv.c:2121:2: note: in expansion of macro 'DPRINTK'
>  2121 |  DPRINTK("id 0x%x QC: qc_active 0x%x,"
>       |  ^~~~~~~
> drivers/ata/sata_nv.c:2121:36: note: format string is defined here
>  2121 |  DPRINTK("id 0x%x QC: qc_active 0x%x,"
>       |                                   ~^
>       |                                    |
>       |                                    unsigned int
>       |                                   %llx
> 
> Use the correct format string for the u64 type.

Applied, thanks.

-- 
Jens Axboe

