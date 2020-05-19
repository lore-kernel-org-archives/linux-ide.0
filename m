Return-Path: <SRS0=Ew3G=7B=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC6AC433DF
	for <linux-ide@archiver.kernel.org>; Tue, 19 May 2020 06:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F502070A
	for <linux-ide@archiver.kernel.org>; Tue, 19 May 2020 06:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgESGJl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 19 May 2020 02:09:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35112 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgESGJk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2020 02:09:40 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1javRa-00085d-0x
        for linux-ide@vger.kernel.org; Tue, 19 May 2020 06:09:38 +0000
Received: by mail-pg1-f198.google.com with SMTP id v1so9956372pgl.4
        for <linux-ide@vger.kernel.org>; Mon, 18 May 2020 23:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DcZBTzbzjTjp7Ciwf677pVVb0h46IoEGoPMmMlLbb5M=;
        b=tyRt9EpoYFOhRxm5JU9m8L5hDAcnUTAA7NHsukG3FkN9zP8uDPXmxaYmqaFGj2S7s3
         6UoSWoNqr+niMsdceEgL0m0fT5DtdBiHmxpxrJ0XMXmepUxqa2/IiEH9ovVzBkOKns+R
         g/EFiATg75HMGd7NYljduXLxIYht0XXw+SzyWyW30Cpe/ysW9vRQZNP6nBquhYyeEQjL
         ZqxxVZtxyuZc0yTtmBtuEDOw81fl4Ur8LwubbL6nV0lhqLA9HAD0AMDI4QDp3kALha0H
         N69q46fxZFYmkeEgOo+Nv0VHUoH5KqPTQFdU4RzSOk4h0h/41Kasot7C8lWBeyqnpVvT
         u/cQ==
X-Gm-Message-State: AOAM531UvFRkcBW+lzvDGvQwyFveLG2bHlz7nA+CgD3Qq9O7aqtR7gsY
        y1RSP0oa1V5XG0cZKbm2h18nINphsldvcZT696YYcnRLMxr5uX60HLLfjkdLVb/Rp3ewX6+nRcB
        GDRmRnTllHJXPxw7TJNyMU0besV2UMRCLiq69Pw==
X-Received: by 2002:a17:90a:ee91:: with SMTP id i17mr3044258pjz.45.1589868576729;
        Mon, 18 May 2020 23:09:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynoSVhg5x2eLcaVDrdt7BZjkwwAqw4hmDKS0ppPXDDJayTgx1/jvbxkou6+8x2E+ERpCT/xw==
X-Received: by 2002:a17:90a:ee91:: with SMTP id i17mr3044238pjz.45.1589868576382;
        Mon, 18 May 2020 23:09:36 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id z23sm3204439pga.86.2020.05.18.23.09.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 23:09:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] libata: Use per port sync for detach
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1470d3de-7785-9f05-2b12-9272ac0005b8@huawei.com>
Date:   Tue, 19 May 2020 14:09:33 +0800
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <826B8B0D-29EE-4C4F-BBD3-B6442144CA65@canonical.com>
References: <20200515110916.11556-1-kai.heng.feng@canonical.com>
 <555101fd-71bc-fa0b-98c2-69249bb3eda6@huawei.com>
 <15CFC20D-B8CB-43D7-8973-60E82DE6B894@canonical.com>
 <91334913-eac8-c8e0-ced6-f1bb8d8b2507@huawei.com>
 <1470d3de-7785-9f05-2b12-9272ac0005b8@huawei.com>
To:     John Garry <john.garry@huawei.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi John,

> On May 18, 2020, at 23:21, John Garry <john.garry@huawei.com> wrote:
> 
> On 18/05/2020 10:06, John Garry wrote:
>> On 15/05/2020 18:48, Kai-Heng Feng wrote:
>>>> 841]  ret_from_fork+0x10/0x1c
>>>> [   28.393400] ---[ end trace 9972785c7052048f ]---
>>>> [   28.435826] ahci 0000:b4:03.0: SSS flag set, parallel bus scan disabled
>>> Can you please test the following patch:
>>> 
>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>> index 474c6c34fe02..51ee0cc4d414 100644
>>> --- a/drivers/ata/libata-eh.c
>>> +++ b/drivers/ata/libata-eh.c
>>> @@ -3583,8 +3583,10 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
>>>          rc = 0;
>>>          /* if UNLOADING, finish immediately */
>>> -       if (ap->pflags & ATA_PFLAG_UNLOADING)
>>> +       if (ap->pflags & ATA_PFLAG_UNLOADING) {
>>> +               ap->pflags |= ATA_PFLAG_UNLOADED;
>>>                  goto out;
>>> +       }
>>> 
>>> It's only compile-tested, many drivers panic with CONFIG_DEBUG_TEST_DRIVER_REMOVE enabled, so the system I have can't even boot properly:(
> 
> According to the comment for async_synchronize_cookie(), we sync upto (but excluding) the cookie:
> 
> /**
> * async_synchronize_cookie - synchronize asynchronous function calls with cookie checkpointing
> *
> * This function waits until all asynchronous function calls prior to @cookie
> * have been done.
> 
> So maybe it should be:
> 
> +	for (i = 0; i < host->n_ports; i++)
> +		async_synchronize_cookie(host->ports[i]->cookie + 1);
> 
> That is how other callsites use this API, and that change resolves the WARN for me.

Thanks for catching this up!
Let me ask the user to test it, and I'll send v2 base on this.

Kai-Heng

> 
> Thanks,
> John

