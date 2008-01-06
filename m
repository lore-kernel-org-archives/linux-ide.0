From: George Kibardin <george-kibardin@yandex.ru>
Subject: Re: 80 wire cable detection patch
Date: Sun, 06 Jan 2008 22:00:36 +0300
Message-ID: <47812554.4060606@yandex.ru>
References: <477D0BDF.6020801@yandex.ru> <200801051921.45084.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp10.yandex.ru ([213.180.223.92]:41864 "EHLO smtp10.yandex.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753852AbYAFTfU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Jan 2008 14:35:20 -0500
Received: from [85.30.241.83] ([85.30.241.83]:6149 "EHLO [192.168.74.75]"
        smtp-auth: "george-kibardin" TLS-CIPHER: <none> TLS-PEER-CN1: <none>)
        by mail.yandex.ru with ESMTP id S5865601AbYAFTAk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2008 22:00:40 +0300
In-Reply-To: <200801051921.45084.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Signed-off-by: George Kibardin <george-kibardin@yandex.ru>

--- drivers/ide/ide-iops.c.orig 2008-01-03 18:35:23.000000000 +0300
+++ drivers/ide/ide-iops.c      2008-01-03 18:12:29.000000000 +0300
@@ -612,12 +612,12 @@
               printk(KERN_DEBUG "%s: skipping word 93 validity check\n",
                                 drive->name);

-       if (hwif->cbl != ATA_CBL_PATA80 && !ivb)
-               goto no_80w;
-
       if (ide_dev_is_sata(id) && !ivb)
               return 1;

+       if (hwif->cbl != ATA_CBL_PATA80 && !ivb)
+               goto no_80w;
+
       /*
        * FIXME:
        * - change master/slave IDENTIFY order

Best,
George


> Hi,
>
> On Thursday 03 January 2008, George Kibardin wrote:
>   
>> Hi Bartlomiej,
>>
>> I hope that you are the right person to look at my proposal.
>> I use 2.6.23-gentoo-r3 kernel on VIA Epia EX motherboard with WD SATA 
>> HDD connected to it. (I don't understand exactly why, but kernel thinks 
>> that this is not SATA HDD. It assigns name hda to it, there is no words 
>> SATA in logs, loading via_sata modules doesn't change situation, 
>> via82cxxx module detect this chipset correctly, there is no word SATA in 
>> BIOS etc.). During boot I get:
>>     
>
> There is probably PATA->SATA bridge on the motherboard.
>
>   
>> host side 80-wire cable detection failed, limiting max speed to UDMA33
>>
>> (of course it is true - I don't have even 40 wires :-)
>> Digging the code I've figured out that for some reason checking that 
>> there is 80 wire cable connected happens before checking that drive is 
>> SATA. I've changed the order and this fixed my problem. Unfortunately, I 
>> have not enough hardware to test this. The only thing I'm wondering - is 
>> this bug or feature? Maybe you know the reason why sata check should go 
>> almost last?
>>     
>
> Your fix looks fine and is similar to how libata handles PATA->SATA bridges.
>
> Please add "Signed-off-by:" line,
>
>   
>> --- drivers/ide/ide-iops.c.orig 2008-01-03 18:35:23.000000000 +0300
>> +++ drivers/ide/ide-iops.c      2008-01-03 18:12:29.000000000 +0300
>> @@ -612,12 +612,12 @@
>>                 printk(KERN_DEBUG "%s: skipping word 93 validity check\n",
>>                                   drive->name);
>>
>> -       if (hwif->cbl != ATA_CBL_PATA80 && !ivb)
>> -               goto no_80w;
>> -
>>         if (ide_dev_is_sata(id))
>>                 return 1;
>>     
>
> change it to 'if (ide_dev_is_sata(id) && !ivb)' (some ATAPI devices needing
> IVB quirk like to identify themselves like SATA ones, but they aren't),
>
>   
>> +       if (hwif->cbl != ATA_CBL_PATA80 && !ivb)
>> +               goto no_80w;
>> +
>>         /*
>>          * FIXME:
>>          * - change master/slave IDENTIFY order
>>
>>     
>
> and resubmit (cc:ing linux-ide@vger.kernel.org mailing list).
>
> Thanks,
> Bart
>
>   

