Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86E6C433F5
	for <linux-ide@archiver.kernel.org>; Sat, 19 Mar 2022 00:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241588AbiCSACS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiCSACR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2022 20:02:17 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AD62993C4
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647648054; x=1679184054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JTE2RHGJIVHnU6qk1IIGRq+eytWMgbtBq5nED8OQPu8=;
  b=Hf1vs/SZVjvygrTXsZruZ3vIRDf29Y92dGMIUnSK733ZmmmtCJUUBPjj
   pdKGh2yNlzHX9aNdDABwRXCqaUaTpHkTu9IWxPIQyO2gowmbeep0fqNVt
   9JnUZxGH+HWCjSBCiHUM7rEqhVZm5rIt0PajWdDEvKkBzH33eyKAnL49Z
   iog1d41F+nJsiLOylUIqiRdvdf00EHQ5yUBiQgUfaOsi+S4W4esJwTWDq
   9nPXcRYZ2l3IUJ6Mm4l60hz+XT5XD1JNQ3x9MHNnyF6nNAhzixR8TXn85
   DaagR2Aq/0vUq9RlwdupbKYO3CpxPYzNYqJ7X++hH7SFL9Zxj5t+4YCvt
   w==;
X-IronPort-AV: E=Sophos;i="5.90,192,1643644800"; 
   d="scan'208";a="195738930"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2022 08:00:53 +0800
IronPort-SDR: wqCBBilsMRNzSypGVeQ7/pceljoYxzpQ6CLEWNoth+1Tt1mBpAMtZKXLvj/v5Ye33QeiyV90UG
 DfUrkBEqDBQrLjhOL7ovKUz5sbLQ7twp0+FDeX5OL48B/2tAfyjQrOVqJwISQ+aaHSo5R9yYES
 7f6ZdN7sh7jxcmBR0dOqPZANWfpQY1gfI+73XPGn+IFfBK/Fc1Ug54tUhfnvoXpLvIjY2nHuVU
 bWIwWsV5EzNNTI6BheytEYyQrypiwSHs0IdhQXOwqTkBQREpuHfzzzxUIyI4TdZw0Mns9sbIls
 1PgRu/IcjpjB53t1x3fa+0vy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 16:32:55 -0700
IronPort-SDR: TJy92P+ouJz5WyZ4IE2JJ9W3PRcvHMTuZeRSRwIXgQd6tKGAroosrFRRKAs5oCXRvcpoho4tAf
 cH4D7B80aXc3sig5c7LQB01zvMbwt26PNjXplglgRPnOfxHMCprgZUVRBBAuf26DgnyipiW4e3
 L6XhBovs/fYYXLAJS7Vyu1Y1vlHb2HLuFpJkctFSEF1N5JKXV42BpLOj9PKgcaRwzoWWaQtL1g
 U+XQp6Y7n3TIXY1QpdHt5QtPUy7dnJIJVYdf2rXDrwQXJWmPRfO+DezqMCDXlw1s80wsSIDOV0
 52Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 17:00:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KL1HW2cJbz1SVp0
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 17:00:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647648054; x=1650240055; bh=JTE2RHGJIVHnU6qk1IIGRq+eytWMgbtBq5n
        ED8OQPu8=; b=amWsFyvh5NF5znKeCEX22QXN5eE0v806JccpvSfLfbu3VdPOt2F
        sBH53z/vfumAtYYMQ9JUxYwvvxWc4/tF3UK/K6IhnAz9ixcrSaYKOeFnkoHKk5rq
        WQg+mVnMnV04lMTz6odakrpJt1U7Z4CYOc9rhnWm3NjbWnukbmlpUDG8bw5br1xv
        WmsKhTlWsdIjwHOD5OB8nhkF55msyayrS6EaQqc/QQbtlT4HGE4OT7ocYZpLfoW7
        OxBE2+bTbjnoqCPrZ8DZhUQT7U+R2FykV7pohlrVEK9DKBEA4cv5YuBJseZicrn5
        VauwDyg4WwKgo8oVwJ4LPam8qUBbgs/GcyA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sDSfdN4A2cP5 for <linux-ide@vger.kernel.org>;
        Fri, 18 Mar 2022 17:00:54 -0700 (PDT)
Received: from [10.225.163.109] (unknown [10.225.163.109])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KL1HT493Mz1Rvlx;
        Fri, 18 Mar 2022 17:00:53 -0700 (PDT)
Message-ID: <ee093d08-8d65-41d9-00c5-5e4881b5731b@opensource.wdc.com>
Date:   Sat, 19 Mar 2022 09:00:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 1/2] ata: sata_dwc_460ex: Fix crash due to OOB write
Content-Language: en-US
To:     Christian Lamparter <chunkeey@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>
References: <ba068938e629eb1a8b423a54405233e685cedb78.1647594132.git.chunkeey@gmail.com>
 <YjSUSJV2FZy1yjN3@smile.fi.intel.com>
 <774b3210-7705-6cf7-2ec1-9eee7c66c838@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <774b3210-7705-6cf7-2ec1-9eee7c66c838@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/19/22 03:06, Christian Lamparter wrote:
> On 18/03/2022 15:16, Andy Shevchenko wrote:
>> On Fri, Mar 18, 2022 at 10:03:11AM +0100, Christian Lamparter wrote:
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
>>
>> ...
>>
>>> ticerex said when I've asked him about his real name+email for the patches:
>>> "Please use my forum nick."
>>> <https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464/14>
>>> (I know checkpatch.pl complains about that. But what can you do?)
>>
>> I think Reported-by: is fine to have any kind of reference to the reporter.
>> I can consider it false positive.
>>
>> ...
> 
> K, I've reported this back to the reporter ;).
> 
> Documentation/process/maintainer-tip.rst and process/5.Posting.rst
> provided some hints:
> 
> "Please note that if the bug was reported in private, then ask for
> permission first before using the Reported-by tag."
> 
> and maintainer-tip.rst, the format should be:
> ``Reported-by: ``Reporter <reporter@mail>``
> 
> (My goal here is to get "a fix" merged, so conformance is key. ;-))
> 
>>> -#define SATA_DWC_QCMD_MAX	32
>>> +#define SATA_DWC_QCMD_MAX	33
>>
>> Can't we use
>>
>> #define SATA_DWC_QCMD_MAX	(ATA_TAG_INTERNAL + 1)
>>
> 
> I've looked around a bit.
> 
> include/linux/libata.h itself has the following related definitions:
> 
> | enum {
> |        ATA_MAX_QUEUE           = 32,
> |        ATA_TAG_INTERNAL        = ATA_MAX_QUEUE,
> | [..]
> 
> | struct ata_port {
> |	[...]
> | 	struct ata_queued_cmd   qcmd[ATA_MAX_QUEUE + 1];
> |
> | }
> 
> ATA_MAX_QUEUE seems to be the "size" value. Whereas ATA_TAG_INTERNAL
> is used as (tag == ATA_TAG_INTERNAL) more often.
> 
> 
> I came up with a viable compromise:
> 
> Would it be "OK" to define a "new" ATA_MAX_TAG?
> 
> This could be either set ATA_MAX_TAG = ATA_MAX_QUEUE + 1

That will be confusing !

ATA physically allows only up to 32 tags (0 to 31) because the command tag
field is only 5 bits. So we should not define anything like this defining
a tag value that is invalid.

ATA_TAG_INTERNAL is special and used only to identify that the command is
a libata internal command, either for device scan/revalidate or for error
handling. This value is *never* used as a tag for an NCQ command because
*all* internal commands are in fact not NCQ ! The internal commands from
libata are all non queueable commands. Meaning that if a device driver
sees a qc with its tag set to ATA_TAG_INTERNAL, it means that there are no
other commands on-going and all tags should be unused in the driver.

In the case of the dw driver, it means that we could arbitrarily use any
of the valid tag values for managing that internal command without any
issue. But having looked at the driver, as I said, it is a bigger change
than just faking a 33rd "tag" that is in fact not a command tag at all.

For these reasons, I really prefer defining SATA_DWC_QCMD_MAX as
(ATA_MAX_QUEUE + 1) with the comment above it clarifying why it is defined
like that.

> 
> or let it be assigned automatically, if it's placed after ATA_TAG_INTERNAL
> in the libata.h's enum like this: (I prefer this, but it being "33" is not
> obvious if you don't dabble in C all the time)
> 
> | enum {
> |	[...]
> |       ATA_MAX_QUEUE           = 32,
> |       ATA_TAG_INTERNAL        = ATA_MAX_QUEUE,
> |	/*
> |	 * ATA_MAX_TAG accounts for ATA_MAX_QUEUE TAGs + 1 special TAG/slot
> |	 * for ATA_TAG_INTERNAL (libata's internal commands/DMA management).
> |	 * This needs to be it in this location.
> |	 */
> |	ATA_MAX_TAG,
> |       [...]
> 
> This ATA_MAX_TAG could then be used for ata_port's qcmd (from above) and
> sata_dwc_460ex's SATA_DWC_QCMD_MAX.

I understand your point. But again, given that ATA_TAG_INTERNAL is only a
special tag value for libata and cannot be used by devices, I would rather
not define this ATA_MAX_TAG macro, to avoid confusions.

> 
> For good measure:
> 
> BUILD_BUG_ON(ATA_TAG_INTERNAL >= ATA_MAX_TAG);
> 
> could be added into libata.h's __ata_qc_from_tag().
> It access the qcmd array, so anyone using libata's accessors will catch
> future updates.
> 
> Is this fine or getting to close to being overbuild?

Not overbuilt, but not fine either. In my opinion, the root cause of the
issue is that the DW driver blindly uses the qc->tag value regardless of
if the command is NCQ or not. For non-ncq commands, tag 0 could be used
always for the command management arrays index, as by definition, non NCQ
commands imply QD=1 operation.

As I mentioned, this is a slightly bigger fix though. So I am OK with
simply changing the macro definition to have the +1 for now. But I am
certainly not against getting this driver correctly fixed to properly
handle command types and tags :)


-- 
Damien Le Moal
Western Digital Research
