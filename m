From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/8] ide: add ide_set_irq() inline helper
Date: Tue, 08 Jul 2008 13:10:13 +0400
Message-ID: <48732EF5.6080302@ru.mvista.com>
References: <200711290104.21376.bzolnier@gmail.com> <48723A9B.6030309@ru.mvista.com> <200807072000.26380.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5702 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750823AbYGHJKM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Jul 2008 05:10:12 -0400
In-Reply-To: <200807072000.26380.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikhail Cherkashin <mcherkashin@ru.mvista.com>

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Hmm, this patch already went in on Jan 26
> (commit 81ca691981da718727281238b435dcf1528d2fda).

    I know. :-)

>>    We're getting "ide0: unexpected interrupt, status=0x58, count=1" with 
>>palm_bk3710 driver when running hdparm with option -X. That interrupt has 
>>beenidentidied to occur while ide_driveid_update() waits for non-BSY status 
>>polling the alt. status reg.  After looking at the code there, I couldn't help 
>>wondering why I never saw that before with any other controller since the code 
>>looked like it was bound to produce the unexpected interrupts -- unless I'm 
>>missing something?..

> You are right, I've also noticed this old bug while working on the patch
> but I didn't have time to deal with it yet (it was kind of low-prio since
> it doesn't affect IDE PCI controllers and has been there for a long time).

    Really long time. :-)

> [ BTW I would _strongly_ prefer to discuss the old bugs under new threads
>   instead of replying to unrelated patches which just happen to be touching
>   the buggy code (like my patch which didn't cause any funtionality changes
>   and was just a preparation for adding struct ide_tp_ops). ]

    Sorry about it. I'm doing all things in a hurry now... should have at 
least changed the subject.

>>>Index: b/drivers/ide/ide-iops.c
>>>===================================================================
>>>--- a/drivers/ide/ide-iops.c
>>>+++ b/drivers/ide/ide-iops.c
>>>@@ -688,8 +688,7 @@ int ide_driveid_update(ide_drive_t *driv
>>> 	 */
>>> 
>>> 	SELECT_MASK(drive, 1);
>>>-	if (IDE_CONTROL_REG)
>>>-		hwif->OUTB(drive->ctl,IDE_CONTROL_REG);
>>>+	ide_set_irq(drive, 1);

>>    If we're going to execute the command using polling, isn't it logical to 
>>*disable* drive's interrupt instead of enabling it which this code is 
>>currently doing?  This looks like it might work only for the drivers having 
>>the maskproc() method (of which hpt366.c is the only one that I've ever dealt 
>>with).

> Yes, this needs fixing.

    But should we honor drive->quirk_list here? What its different values 
mean? I'm seeing either 1 or 2 is used to decide whether to set nIEN or not...

>>>        local_irq_enable();
>>>        local_irq_restore(flags);

>>    What's interesting, ide_config_drive_speed() code looks sane in this respect:

>>>@@ -769,13 +768,12 @@ int ide_config_drive_speed(ide_drive_t *
>>> 	SELECT_DRIVE(drive);
>>> 	SELECT_MASK(drive, 0);
>>> 	udelay(1);
>>>-	if (IDE_CONTROL_REG)
>>>-		hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
>>>+	ide_set_irq(drive, 0);

>>    This correctly sets nIEN... The code als calls disable_irq_nosync() which 
>>might be an overkill

    Or not -- since nIEN can be later cleared.

>>> 	hwif->OUTB(speed, IDE_NSECTOR_REG);
>>> 	hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
>>> 	hwif->OUTBSYNC(drive, WIN_SETFEATURES, IDE_COMMAND_REG);
>>>-	if ((IDE_CONTROL_REG) && (drive->quirk_list == 2))
>>>-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
>>>+	if (drive->quirk_list == 2)
>>>+		ide_set_irq(drive, 1);

>>    I'm just not sure why set nIEN on the quirky drives at all...

> Agreed (however deserves a separate patch just in case we're wrong).

    Of course.

> Since you have both the affected hardware and needed expertise
> I assume that you'll take care fixing ide_driveid_update()?

    Mikhail will submit the fix, and we'll see about cleanups later...

> Thanks,
> Bart

MBR, Sergei
