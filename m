Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1B9C43334
	for <linux-ide@archiver.kernel.org>; Fri, 10 Jun 2022 20:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347329AbiFJUTY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Jun 2022 16:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350528AbiFJUTU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2022 16:19:20 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81DB286832
        for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2022 13:19:15 -0700 (PDT)
Received: from [192.168.1.103] (31.173.80.9) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Fri, 10 Jun
 2022 23:19:07 +0300
Subject: Re: [PATCH 1/3] ata: make packed transfer mode masks *unsigned int*
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20220508204139.4961-1-s.shtylyov@omp.ru>
 <20220508204139.4961-2-s.shtylyov@omp.ru>
 <1e32829d-382a-c9c6-a24a-3b3524886700@opensource.wdc.com>
 <97ef20ab-ec3d-d2cb-e90d-645ba3c9dbc9@omp.ru>
 <b8611310-c0f6-5252-f58e-09270e5a4f01@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <0dcf280d-24b6-913c-49cb-b2ae8bd047b4@omp.ru>
Date:   Fri, 10 Jun 2022 23:19:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b8611310-c0f6-5252-f58e-09270e5a4f01@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.80.9]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/10/2022 19:09:52
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 171067 [Jun 10 2022]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 489 489 b67d2e276d358fa514f5991440453e6a402e3a26
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.9 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;31.173.80.9:7.7.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.80.9
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/10/2022 19:11:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/10/2022 6:32:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/20/22 6:37 AM, Damien Le Moal wrote:

>>>> The packed transfer mode masks are declared as *unsigned long* (which is
>>>> a 64-bit type on 64-bit architectures), however the actual mask occupies
>>>> only 20 bits (7 PIO modes, 5 MWDMA modes, and 8 UDMA modes), so we can
>>>> safely use 32-bit *unsigned int* variables instead.  Convert all libata
>>>> functions taking as a parameter or returning a packed transfer mode mask.
>>>> This saves 470 bytes of object code in libata-core.o alone...
>>>>
>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> [...]
>>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>>> index 732de9014626..1429b7012ae8 100644
>>>> --- a/include/linux/libata.h
>>>> +++ b/include/linux/libata.h
>> [...]
>>>> @@ -1103,16 +1100,18 @@ extern void ata_msleep(struct ata_port *ap, unsigned int msecs);
>>>>  extern u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask,
>>>>  			u32 val, unsigned long interval, unsigned long timeout);
>>>>  extern int atapi_cmd_type(u8 opcode);
>>>> -extern unsigned long ata_pack_xfermask(unsigned long pio_mask,
>>>> -			unsigned long mwdma_mask, unsigned long udma_mask);
>>>> -extern void ata_unpack_xfermask(unsigned long xfer_mask,
>>>> -			unsigned long *pio_mask, unsigned long *mwdma_mask,
>>>> -			unsigned long *udma_mask);
>>>> -extern u8 ata_xfer_mask2mode(unsigned long xfer_mask);
>>>> -extern unsigned long ata_xfer_mode2mask(u8 xfer_mode);
>>>> +extern unsigned int ata_pack_xfermask(unsigned long pio_mask,
>>>> +				      unsigned long mwdma_mask,
>>>> +				      unsigned long udma_mask);
>>>> +extern void ata_unpack_xfermask(unsigned int xfer_mask,
>>>> +				unsigned long *pio_mask,
>>>> +				unsigned long *mwdma_mask,
>>>> +				unsigned long *udma_mask);
>>>
>>> Why not change all of these to unsigned int too ?
>>
>>    Done in the 2nd patch.
>>
>>> They are defined as "1LU << shift" but everything actually fits within 32 bits
>>
>>    No, they are #define'd as *int* masks in ata.h, not as *unsigned long* in libata.h...
> 
> I meant the mask macro values used to set these fields are all defined as
> unsigned long with "1LU << shift" defines. See enum ata_xfer_mask in libata.h.

   What does it have to do with {pio|mwdma|udma}_mask? These *enum*s values are
used solely for the packed mask...

MBR, Sergey
