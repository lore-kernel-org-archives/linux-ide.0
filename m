Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127A5C433FE
	for <linux-ide@archiver.kernel.org>; Thu, 19 May 2022 20:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbiESUUI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 19 May 2022 16:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241256AbiESUUH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 May 2022 16:20:07 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65585954B3
        for <linux-ide@vger.kernel.org>; Thu, 19 May 2022 13:20:03 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 51621209A645
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 1/3] ata: make packed transfer mode masks *unsigned int*
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <20220508204139.4961-1-s.shtylyov@omp.ru>
 <20220508204139.4961-2-s.shtylyov@omp.ru>
 <1e32829d-382a-c9c6-a24a-3b3524886700@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <97ef20ab-ec3d-d2cb-e90d-645ba3c9dbc9@omp.ru>
Date:   Thu, 19 May 2022 23:19:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1e32829d-382a-c9c6-a24a-3b3524886700@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 5/16/22 2:17 PM, Damien Le Moal wrote:

>> The packed transfer mode masks are declared as *unsigned long* (which is
>> a 64-bit type on 64-bit architectures), however the actual mask occupies
>> only 20 bits (7 PIO modes, 5 MWDMA modes, and 8 UDMA modes), so we can
>> safely use 32-bit *unsigned int* variables instead.  Convert all libata
>> functions taking as a parameter or returning a packed transfer mode mask.
>> This saves 470 bytes of object code in libata-core.o alone...
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
[...]
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 732de9014626..1429b7012ae8 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
[...]
>> @@ -1103,16 +1100,18 @@ extern void ata_msleep(struct ata_port *ap, unsigned int msecs);
>>  extern u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask,
>>  			u32 val, unsigned long interval, unsigned long timeout);
>>  extern int atapi_cmd_type(u8 opcode);
>> -extern unsigned long ata_pack_xfermask(unsigned long pio_mask,
>> -			unsigned long mwdma_mask, unsigned long udma_mask);
>> -extern void ata_unpack_xfermask(unsigned long xfer_mask,
>> -			unsigned long *pio_mask, unsigned long *mwdma_mask,
>> -			unsigned long *udma_mask);
>> -extern u8 ata_xfer_mask2mode(unsigned long xfer_mask);
>> -extern unsigned long ata_xfer_mode2mask(u8 xfer_mode);
>> +extern unsigned int ata_pack_xfermask(unsigned long pio_mask,
>> +				      unsigned long mwdma_mask,
>> +				      unsigned long udma_mask);
>> +extern void ata_unpack_xfermask(unsigned int xfer_mask,
>> +				unsigned long *pio_mask,
>> +				unsigned long *mwdma_mask,
>> +				unsigned long *udma_mask);
> 
> Why not change all of these to unsigned int too ?

   Done in the 2nd patch.

> They are defined as "1LU << shift" but everything actually fits within 32 bits

   No, they are #define'd as *int* masks in ata.h, not as *unsigned long* in libata.h...

[...]

MBR, Sergey
