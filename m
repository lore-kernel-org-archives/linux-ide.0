From: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 25/29] ide: convert REQ_DRIVE_CMD to REQ_DRIVE_TASKFILE
Date: Fri, 04 Feb 2005 10:06:29 +0900
Message-ID: <4202CA95.6030801@home-tj.org>
References: <20050202024017.GA621@htj.dyndns.org>	 <20050202031559.GP1187@htj.dyndns.org> <58cb370e05020309464a106816@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Received: from [211.58.254.17] ([211.58.254.17]:56451 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263113AbVBDBGc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 20:06:32 -0500
In-Reply-To: <58cb370e05020309464a106816@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

Bartlomiej Zolnierkiewicz wrote:
> On Wed, 2 Feb 2005 12:15:59 +0900, Tejun Heo <tj@home-tj.org> wrote:
> 
>>>25_ide_taskfile_cmd.patch
>>>
>>>      All in-kernel REQ_DRIVE_CMD users except for ide_cmd_ioctl()
>>>      converted to use REQ_DRIVE_TASKFILE.
>>
>>Signed-off-by: Tejun Heo <tj@home-tj.org>
>>
>>Index: linux-ide-export/drivers/ide/ide-disk.c
>>===================================================================
>>--- linux-ide-export.orig/drivers/ide/ide-disk.c        2005-02-02 10:28:06.527986413 +0900
>>+++ linux-ide-export/drivers/ide/ide-disk.c     2005-02-02 10:28:07.204876587 +0900
>>@@ -750,7 +750,7 @@ static int set_multcount(ide_drive_t *dr
>>        if (drive->special.b.set_multmode)
>>                return -EBUSY;
>>        ide_init_drive_cmd (&rq);
>>-       rq.flags = REQ_DRIVE_CMD;
>>+       rq.flags = REQ_DRIVE_TASKFILE;
> 
> 
> Please instead fix ide_init_drive_cmd() to set REQ_DRIVE_TASKFILE
> and add set REQ_DRIVE_CMD only in ide_cmd_ioctl().
>

This is done in patch #28.  If you don't like the ordering of the 
patches, I can change the orders but I don't think that improves 
anything.  This order is as good as the other order.

> 
>>        drive->mult_req = arg;
>>        drive->special.b.set_multmode = 1;
>>        (void) ide_do_drive_cmd (drive, &rq, ide_wait);
>>Index: linux-ide-export/drivers/ide/ide.c
>>===================================================================
>>--- linux-ide-export.orig/drivers/ide/ide.c     2005-02-02 10:27:14.652402828 +0900
>>+++ linux-ide-export/drivers/ide/ide.c  2005-02-02 10:28:07.205876425 +0900
>>@@ -1255,6 +1255,7 @@ static int set_pio_mode (ide_drive_t *dr
>>        if (drive->special.b.set_tune)
>>                return -EBUSY;
>>        ide_init_drive_cmd(&rq);
>>+       rq.flags = REQ_DRIVE_TASKFILE;
>>        drive->tune_req = (u8) arg;
>>        drive->special.b.set_tune = 1;
>>        (void) ide_do_drive_cmd(drive, &rq, ide_wait);

Thanks.

-- 
tejun

