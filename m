From: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 16/29] ide: flagged_taskfile select register dev bit masking
Date: Wed, 2 Feb 2005 12:00:47 +0900
Message-ID: <20050202030047.GA1187@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> 16_ide_flagged_taskfile_select_dev_bit_masking.patch
> 
> 	In flagged_taskfile(), make off DEV bit before OR'ing it with
> 	drive->select.all when writing to IDE_SELECT_REG.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.093219204 +0900
+++ linux-ide-export/drivers/ide/ide-taskfile.c	2005-02-02 10:28:05.273190003 +0900
@@ -858,7 +858,8 @@ ide_startstop_t flagged_taskfile (ide_dr
 	 * select bit (master/slave) in the drive_head register. We must make
 	 * sure that the desired drive is selected.
 	 */
-	hwif->OUTB(taskfile->device_head | drive->select.all, IDE_SELECT_REG);
+	hwif->OUTB((taskfile->device_head & ~0x10) | drive->select.all,
+		   IDE_SELECT_REG);
 	switch(task->data_phase) {
 
    	        case TASKFILE_OUT_DMAQ:
