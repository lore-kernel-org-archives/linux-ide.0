From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 04/08] ide: remove unused fields ide_drive_t->rq and ide_task_t->special
Date: Sat,  5 Mar 2005 10:48:18 +0900 (KST)
Message-ID: <20050305014813.00CE05B7@htj.dyndns.org>
References: <20050305014758.4EDB4992@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <20050305014758.4EDB4992@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org


04_ide_remove_unused_fields.patch

	Remove unused fields ide_drive_t->rq and ide_task_t->special

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/ide/ide-tape.c |    1 -
 include/linux/ide.h    |    2 --
 2 files changed, 3 deletions(-)

Index: linux-taskfile-ng/drivers/ide/ide-tape.c
===================================================================
--- linux-taskfile-ng.orig/drivers/ide/ide-tape.c	2005-03-05 10:37:51.567375213 +0900
+++ linux-taskfile-ng/drivers/ide/ide-tape.c	2005-03-05 10:46:59.482894810 +0900
@@ -1733,7 +1733,6 @@ static int idetape_end_request(ide_drive
 	}
 	ide_end_drive_cmd(drive, 0, 0);
 //	blkdev_dequeue_request(rq);
-//	drive->rq = NULL;
 //	end_that_request_last(rq);
 
 	if (remove_stage)
Index: linux-taskfile-ng/include/linux/ide.h
===================================================================
--- linux-taskfile-ng.orig/include/linux/ide.h	2005-03-05 10:46:59.095955301 +0900
+++ linux-taskfile-ng/include/linux/ide.h	2005-03-05 10:46:59.483894654 +0900
@@ -660,7 +660,6 @@ typedef struct ide_drive_s {
 
 	request_queue_t		*queue;	/* request queue */
 
-	struct request		*rq;	/* current request */
 	struct ide_drive_s 	*next;	/* circular list of hwgroup drives */
 	struct ide_driver_s	*driver;/* (ide_driver_t *) */
 	void		*driver_data;	/* extra driver data */
@@ -934,7 +933,6 @@ typedef struct ide_task_s {
 	ide_pre_handler_t	*prehandler;
 	ide_handler_t		*handler;
 	struct request		*rq;		/* copy of request */
-	void			*special;	/* valid_t generally */
 } ide_task_t;
 
 typedef struct hwgroup_s {
