From: Dirk Behme <dirk.behme@gmail.com>
Subject: Re: [PATCH] libata-core: disable uninitialized var warning
Date: Thu, 20 Dec 2012 15:42:48 +0100
Message-ID: <50D323E8.8000004@gmail.com>
References: <1356012638-4942-1-git-send-email-dirk.behme@gmail.com> <50D31D54.2040907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:52168 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab2LTOmx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Dec 2012 09:42:53 -0500
Received: by mail-bk0-f44.google.com with SMTP id w11so1755833bku.31
        for <linux-ide@vger.kernel.org>; Thu, 20 Dec 2012 06:42:52 -0800 (PST)
In-Reply-To: <50D31D54.2040907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>

Am 20.12.2012 15:14, schrieb Dirk Behme:
> Am 20.12.2012 15:10, schrieb Dirk Behme:
>> Make GCC happy by disabling the warning
>>
>> drivers/ata/libata-core.c: In function 'ata_hpa_resize':
>> drivers/ata/libata-core.c:1394:3: warning: 'native_sectors' may be
>> used uninitialized in this function [-Wmaybe-uninitialized]
>>
>> Looking on the code, 'native_sectors' is always initialized by calling
>> ata_read_native_max_address(dev, &native_sectors).
>>
>> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>> CC: Jeff Garzik <jgarzik@pobox.com>
>
> Ah, sorry, just saw that there is already a similar discussion from
> today. Seems this didn't make it to Google, yet ;)

Btw, regarding the "better to file a gcc bug report" in the previous 
thread:

Yes, agreed.

But looking at

http://lwn.net/Articles/529963/

there seem to be ~185 places in the kernel which don't want to wait 
for the GCC to be fixed.

Best regards

Dirk

>> ---
>>   drivers/ata/libata-core.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 9e8b99a..21623cf 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -1324,7 +1324,7 @@ static int ata_hpa_resize(struct ata_device *dev)
>>       int print_info = ehc->i.flags & ATA_EHI_PRINTINFO;
>>       bool unlock_hpa = ata_ignore_hpa || dev->flags &
>> ATA_DFLAG_UNLOCK_HPA;
>>       u64 sectors = ata_id_n_sectors(dev->id);
>> -    u64 native_sectors;
>> +    u64 native_sectors = 0 /* GCC */;
>>       int rc;
>>
>>       /* do we need to do it? */
>>
>

