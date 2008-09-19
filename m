From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 3/4 v2] ide: Implement disk shock protection support
Date: Fri, 19 Sep 2008 02:28:05 +0200
Message-ID: <87d4j17ze2.fsf@denkblock.local>
References: <87d4j2n3dn.fsf@denkblock.local>
	<20080917163144.9870.59732.stgit@denkblock.local>
	<200809181624.54248.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:42467 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755825AbYISA22 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Sep 2008 20:28:28 -0400
In-Reply-To: <200809181624.54248.bzolnier@gmail.com> (Bartlomiej
	Zolnierkiewicz's message of "Thu, 18 Sep 2008 16:24:53 -0700")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On Wednesday 17 September 2008 09:38:37 Elias Oltmanns wrote:
>> On user request (through sysfs), the IDLE IMMEDIATE command with UNLOAD
>
>> FEATURE as specified in ATA-7 is issued to the device and processing of
>> the request queue is stopped thereafter until the specified timeout
>> expires or user space asks to resume normal operation. This is supposed
>> to prevent the heads of a hard drive from accidentally crashing onto the
>> platter when a heavy shock is anticipated (like a falling laptop expected
>> to hit the floor). Port resets are deferred whenever a device on that
>> port is in the parked state.
>> 
>> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
>
> applied

I'm very sorry for responding so late to Tejun's concerns but I got
bitten by the uaccess bug in recent linux-next discussed on LKML.

@Bart, one isue raised by Tejun actually applies to this ide patch as
well. Even though the problem is considerably more complex in the libata
case than I had bargained for, we are lucky in the ide case. Still, we
need to move prepar_to_wait() to the top of the while loop. Can you
please include the following interdiff? It also gets rid of a
superfluous variable.

Thanks,

Elias


---
diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index 7e7a1f0..0eb6284 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -1115,11 +1115,11 @@ static ide_startstop_t do_reset1 (ide_drive_t *drive, int do_not_try_atapi)
 	/* We must not disturb devices in the IDE_DFLAG_PARKED state. */
 	do {
 		unsigned long now;
-		int i;
 
+		prepare_to_wait(&ide_park_wq, &wait, TASK_UNINTERRUPTIBLE);
 		timeout = jiffies;
-		for (i = 0; i < MAX_DRIVES; i++) {
-			ide_drive_t *tdrive = &hwif->drives[i];
+		for (unit = 0; unit < MAX_DRIVES; unit++) {
+			ide_drive_t *tdrive = &hwif->drives[unit];
 
 			if (tdrive->dev_flags & IDE_DFLAG_PRESENT &&
 			    tdrive->dev_flags & IDE_DFLAG_PARKED &&
@@ -1132,7 +1132,6 @@ static ide_startstop_t do_reset1 (ide_drive_t *drive, int do_not_try_atapi)
 			break;
 
 		spin_unlock_irqrestore(&ide_lock, flags);
-		prepare_to_wait(&ide_park_wq, &wait, TASK_UNINTERRUPTIBLE);
 		timeout = schedule_timeout_uninterruptible(timeout - now);
 		spin_lock_irqsave(&ide_lock, flags);
 	} while (timeout);
