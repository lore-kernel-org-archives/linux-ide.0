From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 25/29] ide: convert REQ_DRIVE_CMD to REQ_DRIVE_TASKFILE
Date: Fri, 4 Feb 2005 02:40:02 +0100
Message-ID: <58cb370e0502031740141468d4@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202031559.GP1187@htj.dyndns.org>
	 <58cb370e05020309464a106816@mail.gmail.com>
	 <4202CA95.6030801@home-tj.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.207]:21706 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262558AbVBDBkn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 20:40:43 -0500
Received: by wproxy.gmail.com with SMTP id 67so395158wri
        for <linux-ide@vger.kernel.org>; Thu, 03 Feb 2005 17:40:39 -0800 (PST)
In-Reply-To: <4202CA95.6030801@home-tj.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, 04 Feb 2005 10:06:29 +0900, Tejun Heo <tj@home-tj.org> wrote:
> Hello,
> 
> Bartlomiej Zolnierkiewicz wrote:
> > On Wed, 2 Feb 2005 12:15:59 +0900, Tejun Heo <tj@home-tj.org> wrote:
> >
> >>>25_ide_taskfile_cmd.patch
> >>>
> >>>      All in-kernel REQ_DRIVE_CMD users except for ide_cmd_ioctl()
> >>>      converted to use REQ_DRIVE_TASKFILE.
> >>
> >>Signed-off-by: Tejun Heo <tj@home-tj.org>
> >>
> >>Index: linux-ide-export/drivers/ide/ide-disk.c
> >>===================================================================
> >>--- linux-ide-export.orig/drivers/ide/ide-disk.c        2005-02-02 10:28:06.527986413 +0900
> >>+++ linux-ide-export/drivers/ide/ide-disk.c     2005-02-02 10:28:07.204876587 +0900
> >>@@ -750,7 +750,7 @@ static int set_multcount(ide_drive_t *dr
> >>        if (drive->special.b.set_multmode)
> >>                return -EBUSY;
> >>        ide_init_drive_cmd (&rq);
> >>-       rq.flags = REQ_DRIVE_CMD;
> >>+       rq.flags = REQ_DRIVE_TASKFILE;
> >
> >
> > Please instead fix ide_init_drive_cmd() to set REQ_DRIVE_TASKFILE
> > and add set REQ_DRIVE_CMD only in ide_cmd_ioctl().
> >
> 
> This is done in patch #28.  If you don't like the ordering of the
> patches, I can change the orders but I don't think that improves
> anything.  This order is as good as the other order.

Actually no - if you change this then patch #28 becomes NOP.

So please do it, thanks.
