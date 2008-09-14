From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Mon, 15 Sep 2008 00:55:11 +0400
Message-ID: <48CD7A2F.9020306@ru.mvista.com>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp> <48CC3516.9080404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34067 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753986AbYINUzU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Sep 2008 16:55:20 -0400
In-Reply-To: <48CC3516.9080404@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org

Hello, I wrote:

>> +static void mm_insw_swap(unsigned long port, void *addr, u32 count)
>> +{
>> +    unsigned short *ptr = addr;
>> +    unsigned long size = count * 2;
>> +    port &= ~1;
>> +    while (count--)
>> +        *ptr++ = le16_to_cpu(__raw_readw((void __iomem *)port));
>> +    __ide_flush_dcache_range((unsigned long)addr, size);
>> +}
>> +static void mm_outsw_swap(unsigned long port, void *addr, u32 count)
>> +{
>> +    unsigned short *ptr = addr;
>> +    unsigned long size = count * 2;
>> +    port &= ~1;
>> +    while (count--) {
>> +        __raw_writew(cpu_to_le16(*ptr), (void __iomem *)port);
>> +        ptr++;
>> +    }
>> +    __ide_flush_dcache_range((unsigned long)addr, size);
>> +}
>>   
>
>    Hum... but is it really correct to convert from/to LE order above? 
> I'm prett sure that data is expected in LE order -- look ar 
> ide_fix_driveid() for example...
>

   Assuming that the IDE data words' MSB appears at offset 6 and LSB at 
offset 7 (which would seem logical), the data is actually in BE (CPU) 
orger, so
mm_insw_swap() should use cpu_to_le16() and mm_outsw_swap() le16_to_cpu()...

MBR, Sergei


