Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380BEC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 18 Mar 2022 18:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbiCRSHc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Mar 2022 14:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbiCRSHb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2022 14:07:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2151B2F09D9
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 11:06:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a8so18522562ejc.8
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=X2wsBzTREF/yMbZD/33fCcARdfRBnnQfY36UMmd5eEg=;
        b=UbBwrDdgw24eGyI8+0gG+jqtYxOC0PSGD7SnIbP6M++olkL3W6hEDz5ww/KG85JpBv
         XiH2Acmqtqcz9KCwerFi3X9cg6Qj3I1MvcTIUO489rGX5OshUrrqo8o8Gkr6jbf+O/Dn
         A3v8jJA2UzBZ/a1ULAxYux2reRYByTiOYXnXY22B2wS7ByaaB4wCTnAh2+yJuD3eidqW
         sKo1qVfzEwLx/a2HYKiCnhbsOhyz4LK/4KzbjfCDPIBtGpmbM5wpms53uzFhVUjVVQTz
         VMtAS4uRw/KGFjKaBkMQKT8U4Jf2+tw31VYU8e2ljf1JmdXV7azeplEJxAT2WtVHIT2o
         9LfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X2wsBzTREF/yMbZD/33fCcARdfRBnnQfY36UMmd5eEg=;
        b=SG+ivTU4HeCri1F+q1vW891WLj5CbVnlvIdL/4+78EjAnmS7b91AHAQCjEn6WSLR1A
         m0TPe2dIJWs5IMD35SxUtgPq0FbP2qm9exbrpNkRWgzD671GP228lsxQRm078WBW0Ptw
         AXFQyukTEz2+ZcLBx7lZq/XXZuOkU5+esr3LgvjFW8l9krN+mDPd8D5rZgLsEwXMi4NB
         9Tuan963UyfpNnOa3TMuN3fMgCbDG9ymUtry6PB0AvyAb/LmD5FmQgBzx9XPnDJpMHER
         qSxk9xulWqS0/xOoMGn5t0GWRzRPQF7VT+c5B6GZSrZjY611TX4XNdY+8716JgVFWVDt
         mcmg==
X-Gm-Message-State: AOAM531OITpgzpv5BDbyicBYoYU3B4VP0JWGlT0HPQvvwhNiJQdIo/ik
        iFVOF6Pe+5f9seVHS6SJgRZPIi9V3g0=
X-Google-Smtp-Source: ABdhPJze7YlSv+8hVL8gaP3QvPt4CgWR/kvS1Rb1qz2S1qHiCyYxVSurC+aedAu5U0RQyUxQNTMm8Q==
X-Received: by 2002:a17:907:2d90:b0:6db:729e:7f25 with SMTP id gt16-20020a1709072d9000b006db729e7f25mr10018522ejc.203.1647626770410;
        Fri, 18 Mar 2022 11:06:10 -0700 (PDT)
Received: from debian64.daheim (p5b0d7e2a.dip0.t-ipconnect.de. [91.13.126.42])
        by smtp.gmail.com with ESMTPSA id kb28-20020a1709070f9c00b006d5d8bf1b72sm3914144ejc.78.2022.03.18.11.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 11:06:09 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by debian64.daheim with esmtp (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nVG1u-000CKD-HB;
        Fri, 18 Mar 2022 19:06:09 +0100
Message-ID: <774b3210-7705-6cf7-2ec1-9eee7c66c838@gmail.com>
Date:   Fri, 18 Mar 2022 19:06:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 1/2] ata: sata_dwc_460ex: Fix crash due to OOB write
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
References: <ba068938e629eb1a8b423a54405233e685cedb78.1647594132.git.chunkeey@gmail.com>
 <YjSUSJV2FZy1yjN3@smile.fi.intel.com>
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <YjSUSJV2FZy1yjN3@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 18/03/2022 15:16, Andy Shevchenko wrote:
> On Fri, Mar 18, 2022 at 10:03:11AM +0100, Christian Lamparter wrote:
>> the driver uses libata's "tag" values from in various arrays.
>> Since the mentioned patch bumped the ATA_TAG_INTERNAL to 32,
>> the value of the SATA_DWC_QCMD_MAX needs to be bumped to 33.
>>
>> Otherwise ATA_TAG_INTERNAL cause a crash like this:
>>
>> | BUG: Kernel NULL pointer dereference at 0x00000000
>> | Faulting instruction address: 0xc03ed4b8
>> | Oops: Kernel access of bad area, sig: 11 [#1]
>> | BE PAGE_SIZE=4K PowerPC 44x Platform
>> | CPU: 0 PID: 362 Comm: scsi_eh_1 Not tainted 5.4.163 #0
>> | NIP:  c03ed4b8 LR: c03d27e8 CTR: c03ed36c
>> | REGS: cfa59950 TRAP: 0300   Not tainted  (5.4.163)
>> | MSR:  00021000 <CE,ME>  CR: 42000222  XER: 00000000
>> | DEAR: 00000000 ESR: 00000000
>> | GPR00: c03d27e8 cfa59a08 cfa55fe0 00000000 0fa46bc0 [...]
>> | [..]
>> | NIP [c03ed4b8] sata_dwc_qc_issue+0x14c/0x254
>> | LR [c03d27e8] ata_qc_issue+0x1c8/0x2dc
>> | Call Trace:
>> | [cfa59a08] [c003f4e0] __cancel_work_timer+0x124/0x194 (unreliable)
>> | [cfa59a78] [c03d27e8] ata_qc_issue+0x1c8/0x2dc
>> | [cfa59a98] [c03d2b3c] ata_exec_internal_sg+0x240/0x524
>> | [cfa59b08] [c03d2e98] ata_exec_internal+0x78/0xe0
>> | [cfa59b58] [c03d30fc] ata_read_log_page.part.38+0x1dc/0x204
>> | [cfa59bc8] [c03d324c] ata_identify_page_supported+0x68/0x130
>> | [...]
>>
>> this is because sata_dwc_dma_xfer_complete() NULLs the
>> dma_pending's next neighbour "chan" (a *dma_chan struct) in
>> this '32' case right here (line ~735):
>>> hsdevp->dma_pending[tag] = SATA_DWC_DMA_PENDING_NONE;
>>
>> Then the next time, a dma gets issued; dma_dwc_xfer_setup() passes
>> the NULL'd hsdevp->chan to the dmaengine_slave_config() which then
>> causes the crash.
> 
> ...
> 
>> ticerex said when I've asked him about his real name+email for the patches:
>> "Please use my forum nick."
>> <https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464/14>
>> (I know checkpatch.pl complains about that. But what can you do?)
> 
> I think Reported-by: is fine to have any kind of reference to the reporter.
> I can consider it false positive.
> 
> ...

K, I've reported this back to the reporter ;).

Documentation/process/maintainer-tip.rst and process/5.Posting.rst
provided some hints:

"Please note that if the bug was reported in private, then ask for
permission first before using the Reported-by tag."

and maintainer-tip.rst, the format should be:
``Reported-by: ``Reporter <reporter@mail>``

(My goal here is to get "a fix" merged, so conformance is key. ;-))

>> -#define SATA_DWC_QCMD_MAX	32
>> +#define SATA_DWC_QCMD_MAX	33
> 
> Can't we use
> 
> #define SATA_DWC_QCMD_MAX	(ATA_TAG_INTERNAL + 1)
> 

I've looked around a bit.

include/linux/libata.h itself has the following related definitions:

| enum {
|        ATA_MAX_QUEUE           = 32,
|        ATA_TAG_INTERNAL        = ATA_MAX_QUEUE,
| [..]

| struct ata_port {
|	[...]
| 	struct ata_queued_cmd   qcmd[ATA_MAX_QUEUE + 1];
|
| }

ATA_MAX_QUEUE seems to be the "size" value. Whereas ATA_TAG_INTERNAL
is used as (tag == ATA_TAG_INTERNAL) more often.


I came up with a viable compromise:

Would it be "OK" to define a "new" ATA_MAX_TAG?

This could be either set ATA_MAX_TAG = ATA_MAX_QUEUE + 1

or let it be assigned automatically, if it's placed after ATA_TAG_INTERNAL
in the libata.h's enum like this: (I prefer this, but it being "33" is not
obvious if you don't dabble in C all the time)

| enum {
|	[...]
|       ATA_MAX_QUEUE           = 32,
|       ATA_TAG_INTERNAL        = ATA_MAX_QUEUE,
|	/*
|	 * ATA_MAX_TAG accounts for ATA_MAX_QUEUE TAGs + 1 special TAG/slot
|	 * for ATA_TAG_INTERNAL (libata's internal commands/DMA management).
|	 * This needs to be it in this location.
|	 */
|	ATA_MAX_TAG,
|       [...]

This ATA_MAX_TAG could then be used for ata_port's qcmd (from above) and
sata_dwc_460ex's SATA_DWC_QCMD_MAX.

For good measure:

BUILD_BUG_ON(ATA_TAG_INTERNAL >= ATA_MAX_TAG);

could be added into libata.h's __ata_qc_from_tag().
It access the qcmd array, so anyone using libata's accessors will catch
future updates.

Is this fine or getting to close to being overbuild?

Thank you both for your insights,
Christian
