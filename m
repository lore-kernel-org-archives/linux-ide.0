From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/6] ide: set IDE_AFLAG_DRQ_INTERRUPT in do_identify()
Date: Fri, 22 Aug 2008 14:41:44 +0400
Message-ID: <48AE97E8.6050707@ru.mvista.com>
References: <20080819183934.16469.69799.sendpatchset@localhost.localdomain> <48AE92F8.8020704@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:16271 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752651AbYHVKlu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 06:41:50 -0400
In-Reply-To: <48AE92F8.8020704@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, linux-kernel@vger.kernel.org

Hello, I wrote:

>> Set IDE_AFLAG_DRQ_INTERRUPT in do_identify() instead of ATAPI
>> device drivers *_setup() methods.
>>
>> While at it:
>> - use ata_id_cdb_intr()
>>
>> There should be no functional changes caused by this patch.
>>
>> Cc: Borislav Petkov <petkovbb@gmail.com>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>   
> [...]
>> Index: b/drivers/ide/ide-cd.c
>> ===================================================================
>> --- a/drivers/ide/ide-cd.c
>> +++ b/drivers/ide/ide-cd.c
>> @@ -1887,9 +1887,6 @@ static int ide_cdrom_setup(ide_drive_t *
>>      drive->atapi_flags = IDE_AFLAG_MEDIA_CHANGED | IDE_AFLAG_NO_EJECT |
>>                 ide_cd_flags(id);
>>  
>> -    if ((id[ATA_ID_CONFIG] & 0x0060) == 0x20)
>> -        drive->atapi_flags |= IDE_AFLAG_DRQ_INTERRUPT;
>> -
>>   
>
>   Wait, this needs to be fixed first -- 0x20 does *not* mean CDB INTRQ!

   Ignore me -- it's not my day. :-]

WBR, Sergei



