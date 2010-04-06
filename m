From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] fix BUG with IDE taskfile ioctl and cfq
Date: Tue, 6 Apr 2010 19:29:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.1004061924430.27367@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2668 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757706Ab0DFXaM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Apr 2010 19:30:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org

Hi

This fixes a crash when using hdparm --security-* on IDE devices with CFQ 
scheduler.

BTW. I found out that it's impossible to use these security commands on 
sparc64 because of 64-bit kernel, 32-bit userspace and a lack of ioctl 
emulation (I succeeded when I recompiled hdparm on my own in 64-bit mode). 
What do you think is the best fix for it? Put it to fs/compat_ioctl.c 
(like SG_IO)? Or make a compat_ioctl method in IDE? Or don't fix it and 
persuade distros to compile hdparm as 64-bit?

Mikulas

---

Fix IDE taskfile with cfq scheduler

When ide taskfile access is being used (for example with hdparm --security
commands) and cfq scheduler is selected, the scheduler crashes on BUG in
cfq_put_request.

The reason is that the cfq scheduler is tracking counts of read and write
requests separately; the ide-taskfile subsystem allocates a read request and
then flips the flag to make it a write request. The counters in cfq will
mismatch.

This patch changes ide-taskfile to allocate the READ or WRITE request as
required and don't change the flag later.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/ide/ide-taskfile.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-2.6.34-rc2-fast/drivers/ide/ide-taskfile.c
===================================================================
--- linux-2.6.34-rc2-fast.orig/drivers/ide/ide-taskfile.c	2010-03-29 21:44:59.000000000 +0200
+++ linux-2.6.34-rc2-fast/drivers/ide/ide-taskfile.c	2010-03-29 21:52:04.000000000 +0200
@@ -428,13 +428,11 @@ int ide_raw_taskfile(ide_drive_t *drive,
 {
 	struct request *rq;
 	int error;
+	int rw = !(cmd->tf_flags & IDE_TFLAG_WRITE) ? READ : WRITE;
 
-	rq = blk_get_request(drive->queue, READ, __GFP_WAIT);
+	rq = blk_get_request(drive->queue, rw, __GFP_WAIT);
 	rq->cmd_type = REQ_TYPE_ATA_TASKFILE;
 
-	if (cmd->tf_flags & IDE_TFLAG_WRITE)
-		rq->cmd_flags |= REQ_RW;
-
 	/*
 	 * (ks) We transfer currently only whole sectors.
 	 * This is suffient for now.  But, it would be great,
