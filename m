From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date: Sun, 21 Sep 2008 13:21:19 +0400
Message-ID: <48D6120F.5000802@ru.mvista.com>
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp> <48D57245.8060606@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:52317 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750733AbYIUJV0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Sep 2008 05:21:26 -0400
In-Reply-To: <48D57245.8060606@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

Hello, I wrote:

>> This controller has standard ATA taskfile registers and DMA
>> command/status registers, but the register layout is swapped on big
>> endian.  There are some other endian issue and some special registers
>> which requires many custom dma_ops/port_ops routines.
>>
>> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>>   
>
>   I thought that I'd only have the stylyistic comments and ACK the 
> patch but it shouldn't even compile... :-/

   Hm, it should compile in the context of linux-next tree..

>> +static void tx4939ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
>> +{
>> +    ide_hwif_t *hwif = HWIF(drive);
>> +    int is_slave = drive->dn & 1;
>> +    u32 mask, val;
>> +    u8 safe = pio;
>> +    ide_drive_t *pair;
>> +
>> +    pair = ide_get_pair_dev(drive);
>>   
>
>   Wait, have you tried to compile this driver? The function is called 
> ide_get_paired_drive() -- and I did name it correctly in my previous 
> review.

   I didn't realize that Bart has renamed the function in one of the 
pending patches...

MBR, Sergei


