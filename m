From: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 17/29] ide: flagged_taskfile() tf_out_flags.b.select check
Date: Wed, 2 Feb 2005 12:01:55 +0900
Message-ID: <20050202030155.GB1187@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from [211.58.254.17] ([211.58.254.17]:44938 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262243AbVBBDB5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Feb 2005 22:01:57 -0500
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> 17_ide_flagged_taskfile_select_check.patch
> 
> 	In flagged_taskfile(), tf_out_flags.b.select should be checked
> 	before using bits inside taskfile->device_head.  When user
> 	haven't specified the select register, the default
> 	drive->select.all value should be used.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.273190003 +0900
+++ linux-ide-export/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.463159181 +0900
@@ -858,8 +858,12 @@ ide_startstop_t flagged_taskfile (ide_dr
 	 * select bit (master/slave) in the drive_head register. We must make
 	 * sure that the desired drive is selected.
 	 */
-	hwif->OUTB((taskfile->device_head & ~0x10) | drive->select.all,
-		   IDE_SELECT_REG);
+	if (task->tf_out_flags.b.select)
+		hwif->OUTB((taskfile->device_head & ~0x10) | drive->select.all,
+			   IDE_SELECT_REG);
+	else
+		hwif->OUTB(drive->select.all, IDE_SELECT_REG);
+ 
 	switch(task->data_phase) {
 
    	        case TASKFILE_OUT_DMAQ:
