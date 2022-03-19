Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF4BC433EF
	for <linux-ide@archiver.kernel.org>; Sat, 19 Mar 2022 00:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbiCSAOn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiCSAOm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2022 20:14:42 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263382E9E2
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647648802; x=1679184802;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TT2mnF+QMgoy6OQL92iIFyR4Jkger6p1GMWcjXrWHyg=;
  b=WSyTzHUQzK9bC0/b1AU0/3TMOKI8F8T/OYXbIcRUrXgVtV0BodSwkqiy
   CXFmvi6x1RLyJmEx6J20sHRdlWpu+MiHNRz68ZkVv1oVQQs7m91LbJ2sf
   zzPYZXFJJQLRmqOLrLMcM8/5/h66JKJ9Uq1QkTQpI8tXs0iOL0RgdW6af
   hO8lqrhToa1EbR0EEz0tlyltSZ34svApka9ft0CdyHNutqELacCiE/4OJ
   BACbSybk8WH9e9/hxHBXYkZqH/qDeklbENJMbqh2x1cvu0tYS5jYbjN9O
   0KDNURDeAYrdLVXABAPBD0Y4TYqyjQL14gr621K1evsanR7j8Wh0iPZUq
   w==;
X-IronPort-AV: E=Sophos;i="5.90,192,1643644800"; 
   d="scan'208";a="307693946"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2022 08:13:21 +0800
IronPort-SDR: 76F+muIbFhh6RoFsE3VqjlSdKGxJaQ54wHo3rb/VrWpt5odNsa2pvay/Q/uYbrRzGZtoiwO1sl
 86uIAsn+bIEiUOr5naroI6CV3BxxPPnboZ3uVNXNR5Cq7B7YDtf1O114NV2iETepP5X1Gn4ut0
 W2/c2aC8nxeueSPJ6TAaI2DO7EzLgvlCAcJtCYYBa4sFiJ8uBhMoLshqZNAF7T3lZr1oNh59Pa
 BQ+IunuiMWeBwjucW8iQm6VmPxfnfOR8Lw956ffEuJGFGS1Qj1J/bE2KxD3vHWX5lzJmqDIHC1
 3S4QKv2ZG23I/cSjJnAJlwvg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 16:45:21 -0700
IronPort-SDR: 5Xz1UzJ20uG48Mw2I6nkd+GJtvQaYO3CaQkVTU9vCzNxbzZ3aoPYp3heAnl+oil0ge7fLsJbtd
 srNAGv1Lua1UD0ZA314lZrsR1FrMPI+DGKVGFr/6olk7NBrXMgIBw0xxeoQTA1DGb112kZf7lg
 RKbWeRCE3zRwUxwwulFpmNL0Ou4ApQULAx7w0ICPxDXsnZUcY2G+EZpLBnsuVUblh2ljaBEv+o
 gUV4KlJ2rtOUVldk/F3ow6PSHDqd0SHIvwnyo1/q10ladYWTrMRrVYhMAHxrBbM6E/00Css5DE
 XdQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 17:13:21 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KL1Yr5zMkz1SHwl
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 17:13:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647648800; x=1650240801; bh=TT2mnF+QMgoy6OQL92iIFyR4Jkger6p1GMW
        cjXrWHyg=; b=SRs/Ej6/oGXSgl/Ij3gQQ/li783Q8ID1FqGsfQSiyWr7S+8B4fL
        141UqEsHdn1g1SFhutqwcHpbbpWYJOis0hu1gfjRlK9OgH8m1sx3t3FQoj5iZjsK
        mheOV+tkXyrOEsvffRR0C0CO4HnE4wPTLJXyy4PmU7ryy3RVZcLUaqOGKnigsvbg
        +Z5Dj3X0But5SZPe34LiPhn8eOj8gCZIoyAgqfybetdy0sCb/B2A56EL6YVe9eN1
        EjxVJYSb6yJJIcGgZBs/1CnkmRgIFh2D1Lfi838xu/5Qsz8SOwEvG+oymbP14Mja
        Y0hdc+B2SLLfnaR4AG/RAWsih4bt91wfbkw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c0ObZJ3CJLNc for <linux-ide@vger.kernel.org>;
        Fri, 18 Mar 2022 17:13:20 -0700 (PDT)
Received: from [10.225.163.109] (unknown [10.225.163.109])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KL1Yq1m8pz1Rvlx;
        Fri, 18 Mar 2022 17:13:19 -0700 (PDT)
Message-ID: <949c88f1-0b7c-5d10-9b68-a9e5cc728f7a@opensource.wdc.com>
Date:   Sat, 19 Mar 2022 09:13:17 +0900
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

No worries, a fix will go in :)

Since the person did not want to give his/her/they real name & email, we
could consider this as that person not accepting to be mentioned in a
reported-by tag. So dropping the tag is I think preferred. Keeping it as
you had it is fine too. No big deal.

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
> 
> Thank you both for your insights,
> Christian


-- 
Damien Le Moal
Western Digital Research
