Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80002C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 18 Mar 2022 11:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiCRLoa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Mar 2022 07:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiCRLo1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2022 07:44:27 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E3024F284
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 04:43:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bg10so16504224ejb.4
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bDQ6LFp1lI6JPUliyaBa2iA/moO1KrcduCZUCP1XvLk=;
        b=FUsGzwZVH1167th+J3gGXUU93jxXF9raSbG1PM+98pILMBQ0LHzE0DDjLs4aEkCdWL
         f1rxI089i9v1iEMQBvi9Y00I/Bc0ZRWv0BKYORqPv41VZw1FF5rUVxwe3ssg5xItJb+w
         uiBBg0g1qDx7/a1D5nZXIMCEQxcGPrf4jg9eZpeAuemkRDgmnvbCRUUlAvNUIg3NrIYH
         rNSMQoKDiUp1Z235gRQWE+UYQp1ko6piw/+OMq+WBroVHCPsPKO9wKE3JVjsAjezIKDW
         JzehxHqHbz24eiQlm7sg7LM7i/puRlZ0eb+L+eWmwMFDhSWzbt4bthh3lQZkIbFyqM14
         OR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bDQ6LFp1lI6JPUliyaBa2iA/moO1KrcduCZUCP1XvLk=;
        b=CV+zrm4RMCdi8e9/KnBw8L564vJhJV8GY5hws5pSit5HFPwKgvH8Tn4GXRDZEgLcRw
         QIl4/NEN3tvARxr2pAmYuWx43MOeenqaP9nEylfr4kb2mkzr/pUNtJsgOFYdbFom9bbp
         /1c9GC+GeSU80qCh5mnXcT22CnnSkxbvseBDGpSf+tNPD+KmaQkXZxjoNPlnsfP3QTJo
         YJtCEvW6cDf1fBCsTZmD7f0olWzdgahBvGosNThgGRoX47uQep5oNK0G6YkYOowqcpQ9
         BvKK8Lfjm5ma2wEerpvIkt3cvoOuI2bYlcthwniPBjYw/wbGTD/cTiCVBASsrtwudPF5
         0r2w==
X-Gm-Message-State: AOAM532ULoj1iOGWdA7G9GVXOVgEZMFyYN6AEd2WWasLwbL6pKc1329g
        9aLvZbOk1taTMQ6xvnqnZyw=
X-Google-Smtp-Source: ABdhPJyCF57UPhFJGWjppbF/mCIvvJOSWBrOaGN8QQknqpkxhFFxeXsFvAvHFDbLJNzfV4q2/rY99w==
X-Received: by 2002:a17:907:2d20:b0:6df:8c3f:730a with SMTP id gs32-20020a1709072d2000b006df8c3f730amr7771735ejc.725.1647603783014;
        Fri, 18 Mar 2022 04:43:03 -0700 (PDT)
Received: from debian64.daheim (p5b0d7e2a.dip0.t-ipconnect.de. [91.13.126.42])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b006cee1bceddasm3576071ejn.130.2022.03.18.04.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 04:43:02 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by debian64.daheim with esmtp (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nVA39-0006LW-6d;
        Fri, 18 Mar 2022 12:43:02 +0100
Message-ID: <de54369f-9512-a9b6-65d2-f853701faf5c@gmail.com>
Date:   Fri, 18 Mar 2022 12:43:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 1/2] ata: sata_dwc_460ex: Fix crash due to OOB write
Content-Language: de-DE
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <ba068938e629eb1a8b423a54405233e685cedb78.1647594132.git.chunkeey@gmail.com>
 <92c30932-3c4c-108e-1a84-26258a3c9d04@opensource.wdc.com>
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <92c30932-3c4c-108e-1a84-26258a3c9d04@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 18/03/2022 10:34, Damien Le Moal wrote:
> On 3/18/22 18:03, Christian Lamparter wrote:
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
>>
>> Reported-by: ticerex (OpenWrt Forum)
> 
> I would remove this since you have the link to the bug report below.
> Without a real name & email, this does not make much sense.
Ok.

> 
>> Fixes: 28361c403683c ("libata: add extra internal command")
>> Cc: stable@kernel.org # 4.18+
>> Link: https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464
>> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>> ---
>> ticerex said when I've asked him about his real name+email for the patches:
>> "Please use my forum nick."
>> <https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464/14>
>> (I know checkpatch.pl complains about that. But what can you do?)
>> ---
>>   drivers/ata/sata_dwc_460ex.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
>> index bec33d781ae0..061b27584667 100644
>> --- a/drivers/ata/sata_dwc_460ex.c
>> +++ b/drivers/ata/sata_dwc_460ex.c
>> @@ -137,7 +137,7 @@ struct sata_dwc_device {
>>   #endif
>>   };
>>   
>> -#define SATA_DWC_QCMD_MAX	32
>> +#define SATA_DWC_QCMD_MAX	33
> 
> This is really ugly, but I do not see a better way to do it simply.
> But at least, let's do something like this to avoid confusion and to show
> that this driver is not doing some black magic with ATA drives:
> 
> /*
>   * Allow one extra special slot for commands and DMA management to
>   * account for libata internal commands.
>   */
> #define SATA_DWC_QCMD_MAX	(ATA_MAX_QUEUE + 1)
> 
> Thoughts ?

Yes, this works. That ATA_TAG_INTERNAL value has remained unchanged
since Jens' change from 2018. How do you want to proceed?

Should I make a v2, or do you update the patch locally?

The way I understand it. this ATA_TAG_INTERNAL has the special MAGIC
value so DMA "qc issues" do not interfere with possibly concurrent NCQ
"qc issues" on the involved controllers.

sata_dwc_460ex's NCQ is disabled/gimped by line 1093:
| /* .can_queue           = ATA_MAX_QUEUE, */)

Reassiging the ATA_TAG_INTERNAL could have been done.
But just increasing the arrays worked :-).

Cheers,
Christian
