From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 00/24] ide-tape: remove pipelined mode operation
Date: Sat, 22 Mar 2008 17:09:05 +0100
Message-ID: <200803221709.05323.bzolnier@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com> <20080301102038.GC25835@cs181133002.pp.htv.fi> <20080301153713.GA30547@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:2696 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbYCVPz0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Mar 2008 11:55:26 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1935283fgb.17
        for <linux-ide@vger.kernel.org>; Sat, 22 Mar 2008 08:55:23 -0700 (PDT)
In-Reply-To: <20080301153713.GA30547@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Adrian Bunk <bunk@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Saturday 01 March 2008, Borislav Petkov wrote:
> On Sat, Mar 01, 2008 at 12:20:38PM +0200, Adrian Bunk wrote:
> > On Sat, Mar 01, 2008 at 09:58:24AM +0100, Borislav Petkov wrote:
> > > Hi Bart,
> > > 
> > > here's the 1st draft of the pipeline removal series. As the diffstat below openly
> > > states it, a lot of code got removed - even more than the cleanup series we did
> > > earlier.
> > >...
> > 
> > After seeing commit d48567dd43868b3d2e1fcc33ee76dc2d38a1ddeb that 
> > schedules ide-tape for removal I'm wondering whether any cleanups of 
> > this driver make any sense at all:
> 
> Hi Adrian,
> 
> you're right and I'm expecting Bart's input on that. However, removing
> tape support in ide altogether is probably not the right thing to do and
> Bart wanted to keep some kind of a basic, ide-tape "light" version in so,
> yes, the above commit is misleading.
> 
> Here's a fix, Bart please apply.
> 
> --
> From 11c41d7760dd0b8f4cd1ab3076c86a2c4beec4de Mon Sep 17 00:00:00 2001
> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Sat, 1 Mar 2008 16:31:17 +0100
> Subject: [PATCH] ide-tape: keep a light version in ide tree
> 
> Keep a light version of the driver in for the
> small amount of ide tape hardware still using it.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  Documentation/feature-removal-schedule.txt |   10 ----------
>  1 files changed, 0 insertions(+), 10 deletions(-)

Since there was also an warning in the driver I reverted the original
commit instead.

>From ca4e2ab5b2764562fe3d41b95b27e6bbd4733d66 Mon Sep 17 00:00:00 2001
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Sat, 22 Mar 2008 16:44:27 +0100
Subject: [PATCH] Revert "ide-tape: schedule driver for removal after 6 months"

This reverts commit d48567dd43868b3d2e1fcc33ee76dc2d38a1ddeb.

Borislav is working on ide-tape "light" version instead.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 Documentation/feature-removal-schedule.txt |   10 ----------
 drivers/ide/ide-tape.c                     |    5 -----
 2 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index c1d1fd0..bf0e3df 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -172,16 +172,6 @@ Who:	Len Brown <len.brown@intel.com>
 
 ---------------------------
 
-What:	ide-tape driver
-When:	July 2008
-Files:	drivers/ide/ide-tape.c
-Why:	This driver might not have any users anymore and maintaining it for no
-	reason is an effort no one wants to make.
-Who:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Borislav Petkov
-	<petkovbb@googlemail.com>
-
----------------------------
-
 What: libata spindown skipping and warning
 When: Dec 2008
 Why:  Some halt(8) implementations synchronize caches for and spin
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 43e0e05..0598ecf 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -3765,11 +3765,6 @@ static int ide_tape_probe(ide_drive_t *drive)
 	g->fops = &idetape_block_ops;
 	ide_register_region(g);
 
-	printk(KERN_WARNING "It is possible that this driver does not have any"
-		" users anymore and, as a result, it will be REMOVED soon."
-		" Please notify Bart <bzolnier@gmail.com> or Boris"
-		" <petkovbb@gmail.com> in case you still need it.\n");
-
 	return 0;
 
 out_free_tape:
-- 
1.5.3.3
