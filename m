From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 3/3] ide-{cd,floppy}: do not map all cmds to an sg
Date: Sun, 8 Mar 2009 08:53:38 +0100
Message-ID: <20090308075338.GB4078@liondog.tnic>
References: <1236158216-23052-1-git-send-email-petkovbb@gmail.com> <200903051549.22518.bzolnier@gmail.com> <9ea470500903050719m7952f84ct56475c6445846eeb@mail.gmail.com> <200903051752.41611.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f178.google.com ([209.85.218.178]:35551 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbZCHHxp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Mar 2009 03:53:45 -0400
Content-Disposition: inline
In-Reply-To: <200903051752.41611.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 05, 2009 at 05:52:41PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 05 March 2009, Borislav Petkov wrote:
> > Hi,
> > 
> > > Unrelated to the original issue that the patch tries to fix
> > > (sg mapping no data commands which OOPS-es w/ DEBUG_VIRTUAL=y):
> > > - moving ide_init_sg_cmd()+ide_map_sg() to ide_issue_pc()
> > > - converting the code to use blk_rq_bytes()
> > 
> > aah, ok, now I could get exactly what you meant :). However, (!) ide-floppy is
> > potentially broken in the same way for data-less cmds since we unconditionally
> 
> Indeed, you are right but it seems that this is not a new problem.
> 
> Wait... it makes things "worse" as there should have been 3 patches:
> (IOW _three_ patchpoints! ;):
> 
> - ide-cd fix for problematic patch

see below

> - ide-floppy fix for mainline

ide-floppy is still royally broken when reading the partition
information - I've been staring at traces for a while yesterday and
it looks pretty hairy. What is more, it needs that same fix for
DEBUG_VIRTUAL as ide-cd since I could reproduce it yesterday. Do you
still want that for the merge window or you wanna wait until its
properly fixed?

> - ide-atapi cleanup for pata tree

postponed for now.

--
From: Borislav Petkov <petkovbb@gmail.com>
Date: Fri, 6 Mar 2009 09:35:54 +0100
Subject: [PATCH] ide-cd: do not map dataless cmds to an sg

since it oopses on the virt_to_page() translation check when
DEBUG_VIRTUAL is enabled.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 091d414..35729a4 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -916,9 +916,11 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 
 	cmd.rq = rq;
 
-	ide_init_sg_cmd(&cmd,
-		blk_fs_request(rq) ? (rq->nr_sectors << 9) : rq->data_len);
-	ide_map_sg(drive, &cmd);
+	if (blk_fs_request(rq) || rq->data_len) {
+		ide_init_sg_cmd(&cmd, blk_fs_request(rq) ? (rq->nr_sectors << 9)
+							 : rq->data_len);
+		ide_map_sg(drive, &cmd);
+	}
 
 	return ide_issue_pc(drive, &cmd);
 out_end:
-- 
1.6.1.3


-- 
Regards/Gruss,
    Boris.
