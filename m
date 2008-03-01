From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 00/24] ide-tape: remove pipelined mode operation
Date: Sat, 1 Mar 2008 16:37:13 +0100
Message-ID: <20080301153713.GA30547@gollum.tnic>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com> <20080301102038.GC25835@cs181133002.pp.htv.fi>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:41402 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbYCAPhd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 10:37:33 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2718455nfb.21
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 07:37:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080301102038.GC25835@cs181133002.pp.htv.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Sat, Mar 01, 2008 at 12:20:38PM +0200, Adrian Bunk wrote:
> On Sat, Mar 01, 2008 at 09:58:24AM +0100, Borislav Petkov wrote:
> > Hi Bart,
> >=20
> > here's the 1st draft of the pipeline removal series. As the diffsta=
t below openly
> > states it, a lot of code got removed - even more than the cleanup s=
eries we did
> > earlier.
> >...
>=20
> After seeing commit d48567dd43868b3d2e1fcc33ee76dc2d38a1ddeb that=20
> schedules ide-tape for removal I'm wondering whether any cleanups of=20
> this driver make any sense at all:

Hi Adrian,

you're right and I'm expecting Bart's input on that. However, removing
tape support in ide altogether is probably not the right thing to do an=
d
Bart wanted to keep some kind of a basic, ide-tape "light" version in s=
o,
yes, the above commit is misleading.

Here's a fix, Bart please apply.

--
=46rom 11c41d7760dd0b8f4cd1ab3076c86a2c4beec4de Mon Sep 17 00:00:00 200=
1
=46rom: Borislav Petkov <petkovbb@gmail.com>
Date: Sat, 1 Mar 2008 16:31:17 +0100
Subject: [PATCH] ide-tape: keep a light version in ide tree

Keep a light version of the driver in for the
small amount of ide tape hardware still using it.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 Documentation/feature-removal-schedule.txt |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation=
/feature-removal-schedule.txt
index ba899ff..4d3aa51 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -172,16 +172,6 @@ Who:	Len Brown <len.brown@intel.com>
=20
 ---------------------------
=20
-What:	ide-tape driver
-When:	July 2008
-Files:	drivers/ide/ide-tape.c
-Why:	This driver might not have any users anymore and maintaining it f=
or no
-	reason is an effort no one wants to make.
-Who:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Borislav Petkov
-	<petkovbb@googlemail.com>
-
----------------------------
-
 What: libata spindown skipping and warning
 When: Dec 2008
 Why:  Some halt(8) implementations synchronize caches for and spin
--=20
1.5.4.1

--=20
Regards/Gru=DF,
    Boris.
