From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
Date: Sun, 08 Feb 2009 14:52:48 +0300
Message-ID: <498EC790.9070403@ru.mvista.com>
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp> <498EC5BA.4080002@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:50741 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752541AbZBHLw7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Feb 2009 06:52:59 -0500
In-Reply-To: <498EC5BA.4080002@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org

Hello, I wrote:

>> This is the driver for the Toshiba TX4938 SoC EBUS controller ATA mode.
>> It has custom set_pio_mode and some hacks for big endian.
>>
>> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>>   
> [...]
>> +static void tx4938ide_input_data_swap(ide_drive_t *drive, struct 
>> request *rq,
>> +                void *buf, unsigned int len)
>> +{
>> +    unsigned long port = drive->hwif->io_ports.data_addr;
>> +    unsigned short *ptr = buf;
>> +    unsigned int count = (len + 1) / 2;
>> +
>> +    while (count--)
>> +        *ptr++ = cpu_to_le16(__raw_readw((void __iomem *)port));
>> +    __ide_flush_dcache_range((unsigned long)buf, count * 2);
>> +}
>> +
>> +static void tx4938ide_output_data_swap(ide_drive_t *drive, struct 
>> request *rq,
>> +                void *buf, unsigned int len)
>> +{
>> +    unsigned long port = drive->hwif->io_ports.data_addr;
>> +    unsigned short *ptr = buf;
>> +    unsigned int count = (len + 1) / 2;
>> +
>> +    while (count--) {
>> +        __raw_writew(le16_to_cpu(*ptr), (void __iomem *)port);
>> +        ptr++;
>> +    }
>> +    __ide_flush_dcache_range((unsigned long)buf, count * 2);
>> +}
>
>   Atsushi, does TX49 really suffer from the issue that these flushes 
> are trying to address?

   Well, looking thru the TX4939 thread, it appears that I've asked this 
question already. Isn't this related to VIVT caches?

MBR, Sergei


