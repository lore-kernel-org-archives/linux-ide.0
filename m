From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 02/11] ide: ide_init_drive_cmd() now defaults to REQ_DRIVE_TASKFILE
Date: Thu, 10 Feb 2005 17:38:19 +0900 (KST)
Message-ID: <20050210083814.50C25F82@htj.dyndns.org>
References: <20050210083808.48E9DD1A@htj.dyndns.org>
In-Reply-To: <20050210083808.48E9DD1A@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org


02_ide_taskfile_init_drive_cmd.patch

	ide_init_drive_cmd() now initializes rq->flags to
	REQ_DRIVE_TASKFILE instead of REQ_DRIVE_CMD.  This is
	preparation for removal of REQ_DRIVE_CMD.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ide-io.c       |    4 ++--
 ide-taskfile.c |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-ide/drivers/ide/ide-io.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-io.c	2005-02-10 17:31:48.835669731 +0900
+++ linux-ide/drivers/ide/ide-io.c	2005-02-10 17:38:00.436024471 +0900
@@ -64,7 +64,7 @@ static void ide_fill_flush_cmd(ide_drive
 	 */
 	memset(buf, 0, sizeof(rq->cmd));
 
-	rq->flags |= REQ_DRIVE_TASK | REQ_STARTED;
+	rq->flags = REQ_DRIVE_TASK | REQ_STARTED;
 	rq->buffer = buf;
 	rq->buffer[0] = WIN_FLUSH_CACHE;
 
@@ -1738,7 +1738,7 @@ irqreturn_t ide_intr (int irq, void *dev
 void ide_init_drive_cmd (struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
-	rq->flags = REQ_DRIVE_CMD;
+	rq->flags = REQ_DRIVE_TASKFILE;
 	rq->ref_count = 1;
 }
 
Index: linux-ide/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-taskfile.c	2005-02-10 17:38:00.042090547 +0900
+++ linux-ide/drivers/ide/ide-taskfile.c	2005-02-10 17:38:00.437024304 +0900
@@ -668,6 +668,7 @@ int ide_wait_cmd (ide_drive_t *drive, u8
 		buf = buffer;
 	memset(buf, 0, 4 + SECTOR_WORDS * 4 * sectors);
 	ide_init_drive_cmd(&rq);
+	rq.flags = REQ_DRIVE_CMD;
 	rq.buffer = buf;
 	*buf++ = cmd;
 	*buf++ = nsect;
