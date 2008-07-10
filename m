From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Dubious IRQ masking in ide_config_drive_speed()
Date: Thu, 10 Jul 2008 16:11:15 +0400
Message-ID: <4875FC63.7040309@ru.mvista.com>
References: <200711290104.21376.bzolnier@gmail.com> <48723A9B.6030309@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:45914 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753753AbYGJMLQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jul 2008 08:11:16 -0400
In-Reply-To: <48723A9B.6030309@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Mikhail Cherkashin <mcherkashin@ru.mvista.com>

Hello, I wrote:

>> Index: b/drivers/ide/ide-iops.c
>> ===================================================================
>> --- a/drivers/ide/ide-iops.c
>> +++ b/drivers/ide/ide-iops.c
[...]

>    What's interesting, ide_config_drive_speed() code looks sane in this 
> respect:

    ... except one thing:

>> @@ -769,13 +768,12 @@ int ide_config_drive_speed(ide_drive_t *
>>      SELECT_DRIVE(drive);
>>      SELECT_MASK(drive, 0);

    We've called disable_irq_nosync() before that, so it's not clear why we're 
calling the driver's maskproc() method with 0 -- which unmasks interrupt in 
the IDE chip.

>>      udelay(1);
>> -    if (IDE_CONTROL_REG)
>> -        hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
>> +    ide_set_irq(drive, 0);
>>      hwif->OUTB(speed, IDE_NSECTOR_REG);
>>      hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
>>      hwif->OUTBSYNC(drive, WIN_SETFEATURES, IDE_COMMAND_REG);
>> -    if ((IDE_CONTROL_REG) && (drive->quirk_list == 2))
>> -        hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
>> +    if (drive->quirk_list == 2)
>> +        ide_set_irq(drive, 1);
>>      error = __ide_wait_stat(drive, drive->ready_stat,
>>                  BUSY_STAT|DRQ_STAT|ERR_STAT,

    Another SELECT_MASK(drive, 0) call follows which just doesn't make any 
sense since the interrupt has been already unmasked by the first call.

MBR, Sergei
