Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744CCC433F5
	for <linux-ide@archiver.kernel.org>; Sat, 19 Mar 2022 00:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbiCSAFr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbiCSAFr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2022 20:05:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B982C2747
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 17:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647648265; x=1679184265;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gyst/MxobX4sePrl1SJ89loLD2mTJRPNCyXbgPfeeHU=;
  b=Psxmbn7oK8O9uPqC+D0Fb5ToZUJAs/3sPd3x6kH/k96J3H2VO43F1A91
   QjZmnWqbUtD8VvmDKpVinsKIf16W/pfkbcWsGs5S7qKdyuj9NSp1yUlqI
   YX18G58NjUpncl6YuAiZsIMrFC1TXI2v9CZ+ywgStx5g5c7nQwIYC0EXN
   BlEW1apHuq+XD42rArdizd52QJaVN+wZKMhTpfHPDL1f9UBRzk9oKwdcF
   YdBTzBiDAp5+yqqOtkWW6uZ8x/fwVufFYOyjMCjtiC7uDECiTl/0T3l9x
   FgHyI75r2pXC3hoXVFlzm0Q2qWzJf8As2XpD/j+IBSHDHlwZnR9sPyG3r
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,192,1643644800"; 
   d="scan'208";a="195739263"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2022 08:04:24 +0800
IronPort-SDR: B7I2z5TD3Qwa/znzBq028j8oaINsEdDnK3bC+0awSQJa/gYN8sJ+csoaCA060P4gTUFM3J4jtE
 Punbrnd5NFi7UmItdz/Fn/pNLjPGGEO9Xx5aFKG2k7+uYmKb4dIlcr43nvnyNHz//mtmK/nDQ+
 PG2k+noD7Cosd6ZoQ2mHU4sMWYzAy/M0Yx2nCn08en9tfmlGOH+Si59p9UgulbY1Ot7mFhMZ0P
 qgIkjL1bozMST5LWIWkNk/tkCnryyBalmMoztjZ5ZwdPuYqmqPH73OT3DVsMfOsldTEplwLPjU
 o+2KXaW7wY7EzYhDIKg1+Mx4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 16:36:26 -0700
IronPort-SDR: 2r1rJpfLRHP5fvgLpEK5gGTwJ10NM0IFahzAL1WieQuk6HfQe4ywwZp/Fmtwwz+7nO+uE2scWH
 /SgsikBM4QBtSfDOwHbA3gD2jj7TcePidK0nDagVGworPvLIiPtW7qG135KuoD/mfr9KHEN9vL
 3LpixqgpHNJOfP1nJfxL+Bjt3b6wMgYcgLP/k8AnZzW2Bv+mAGaO0N1Yiq5owFJtyypnTEUaXI
 nWz116KpTEKZxEM9UI/1vgSsAGJYUKdcQuT/PgbGa1kDu9UlNbowQudp5c42Qcvl60/L1qDvBN
 TXg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 17:04:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KL1MY4lsLz1SHwl
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 17:04:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647648264; x=1650240265; bh=gyst/MxobX4sePrl1SJ89loLD2mTJRPNCyX
        bgPfeeHU=; b=h7O9N+buLMGnwdTBIjnwaqBgqPVfIvAgf8DzOfIZEHwubY3uaEi
        2Bo+F3ScTMlEBlbRuQPTfe0nAD0PO0azFHKACM/5nYrvOQnfPc+0wHYAVoMTWcN+
        R+Z0w7uGY2NeQkRdX5S6WsvDHpOKWMtNlQOGWivvIMRdBuymtzLJ48fcfDcTammR
        SHH52VX33eKNZ29jzkhWUYaQTB3rl9jo4EpjazeAPDZE3JAxZeN+HnCX2WRUorwx
        1lrrBsu8CRNkqJ9aF6pBzQuzxSOoJMXzJ3xp5N75aXowTPZWQwjw1SI6RPb+YJVt
        yjsD8KPt3iQiKsRNEM6mKgYwwQen/zWOEew==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ppy1RRkwLFf3 for <linux-ide@vger.kernel.org>;
        Fri, 18 Mar 2022 17:04:24 -0700 (PDT)
Received: from [10.225.163.109] (unknown [10.225.163.109])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KL1MW4jRbz1Rvlx;
        Fri, 18 Mar 2022 17:04:23 -0700 (PDT)
Message-ID: <adc467c7-6207-e2cf-e7cd-90f4593a88c6@opensource.wdc.com>
Date:   Sat, 19 Mar 2022 09:04:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 1/2] ata: sata_dwc_460ex: Fix crash due to OOB write
Content-Language: en-US
To:     Christian Lamparter <chunkeey@gmail.com>, linux-ide@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <ba068938e629eb1a8b423a54405233e685cedb78.1647594132.git.chunkeey@gmail.com>
 <92c30932-3c4c-108e-1a84-26258a3c9d04@opensource.wdc.com>
 <de54369f-9512-a9b6-65d2-f853701faf5c@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <de54369f-9512-a9b6-65d2-f853701faf5c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/18/22 20:43, Christian Lamparter wrote:
> On 18/03/2022 10:34, Damien Le Moal wrote:
>> On 3/18/22 18:03, Christian Lamparter wrote:
>>> the driver uses libata's "tag" values from in various arrays.
>>> Since the mentioned patch bumped the ATA_TAG_INTERNAL to 32,
>>> the value of the SATA_DWC_QCMD_MAX needs to be bumped to 33.
>>>
>>> Otherwise ATA_TAG_INTERNAL cause a crash like this:
>>>
>>> | BUG: Kernel NULL pointer dereference at 0x00000000
>>> | Faulting instruction address: 0xc03ed4b8
>>> | Oops: Kernel access of bad area, sig: 11 [#1]
>>> | BE PAGE_SIZE=4K PowerPC 44x Platform
>>> | CPU: 0 PID: 362 Comm: scsi_eh_1 Not tainted 5.4.163 #0
>>> | NIP:  c03ed4b8 LR: c03d27e8 CTR: c03ed36c
>>> | REGS: cfa59950 TRAP: 0300   Not tainted  (5.4.163)
>>> | MSR:  00021000 <CE,ME>  CR: 42000222  XER: 00000000
>>> | DEAR: 00000000 ESR: 00000000
>>> | GPR00: c03d27e8 cfa59a08 cfa55fe0 00000000 0fa46bc0 [...]
>>> | [..]
>>> | NIP [c03ed4b8] sata_dwc_qc_issue+0x14c/0x254
>>> | LR [c03d27e8] ata_qc_issue+0x1c8/0x2dc
>>> | Call Trace:
>>> | [cfa59a08] [c003f4e0] __cancel_work_timer+0x124/0x194 (unreliable)
>>> | [cfa59a78] [c03d27e8] ata_qc_issue+0x1c8/0x2dc
>>> | [cfa59a98] [c03d2b3c] ata_exec_internal_sg+0x240/0x524
>>> | [cfa59b08] [c03d2e98] ata_exec_internal+0x78/0xe0
>>> | [cfa59b58] [c03d30fc] ata_read_log_page.part.38+0x1dc/0x204
>>> | [cfa59bc8] [c03d324c] ata_identify_page_supported+0x68/0x130
>>> | [...]
>>>
>>> this is because sata_dwc_dma_xfer_complete() NULLs the
>>> dma_pending's next neighbour "chan" (a *dma_chan struct) in
>>> this '32' case right here (line ~735):
>>>> hsdevp->dma_pending[tag] = SATA_DWC_DMA_PENDING_NONE;
>>>
>>> Then the next time, a dma gets issued; dma_dwc_xfer_setup() passes
>>> the NULL'd hsdevp->chan to the dmaengine_slave_config() which then
>>> causes the crash.
>>>
>>> Reported-by: ticerex (OpenWrt Forum)
>>
>> I would remove this since you have the link to the bug report below.
>> Without a real name & email, this does not make much sense.
> Ok.
> 
>>
>>> Fixes: 28361c403683c ("libata: add extra internal command")
>>> Cc: stable@kernel.org # 4.18+
>>> Link: https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464
>>> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>>> ---
>>> ticerex said when I've asked him about his real name+email for the patches:
>>> "Please use my forum nick."
>>> <https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464/14>
>>> (I know checkpatch.pl complains about that. But what can you do?)
>>> ---
>>>   drivers/ata/sata_dwc_460ex.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
>>> index bec33d781ae0..061b27584667 100644
>>> --- a/drivers/ata/sata_dwc_460ex.c
>>> +++ b/drivers/ata/sata_dwc_460ex.c
>>> @@ -137,7 +137,7 @@ struct sata_dwc_device {
>>>   #endif
>>>   };
>>>   
>>> -#define SATA_DWC_QCMD_MAX	32
>>> +#define SATA_DWC_QCMD_MAX	33
>>
>> This is really ugly, but I do not see a better way to do it simply.
>> But at least, let's do something like this to avoid confusion and to show
>> that this driver is not doing some black magic with ATA drives:
>>
>> /*
>>   * Allow one extra special slot for commands and DMA management to
>>   * account for libata internal commands.
>>   */
>> #define SATA_DWC_QCMD_MAX	(ATA_MAX_QUEUE + 1)
>>
>> Thoughts ?
> 
> Yes, this works. That ATA_TAG_INTERNAL value has remained unchanged
> since Jens' change from 2018. How do you want to proceed?
> 
> Should I make a v2, or do you update the patch locally?

Please send a v2. Or send another patch properly fixing the driver tag
handling as explained in my previous email.

> 
> The way I understand it. this ATA_TAG_INTERNAL has the special MAGIC
> value so DMA "qc issues" do not interfere with possibly concurrent NCQ
> "qc issues" on the involved controllers.
> 
> sata_dwc_460ex's NCQ is disabled/gimped by line 1093:
> | /* .can_queue           = ATA_MAX_QUEUE, */)
> 
> Reassiging the ATA_TAG_INTERNAL could have been done.
> But just increasing the arrays worked :-).

No ! changing can_queue to something > 32 would be very wrong ! This
really defines the number of tags that can be used, so the device maximum
queue depth. And ATA maximum queue depth is 32 with NCQ commands. It
cannot be anything larger than 32.

> 
> Cheers,
> Christian


-- 
Damien Le Moal
Western Digital Research
