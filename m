From: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 10/29] ide: __ide_do_rw_disk() return value fix
Date: Wed, 2 Feb 2005 11:52:48 +0900
Message-ID: <20050202025248.GK621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> 10_ide_do_rw_disk_pre_task_out_intr_return_fix.patch
> 
> 	In __ide_do_rw_disk(), ide_started used to be returned blindly
> 	after issusing PIO write.  This can cause hang if
> 	pre_task_out_intr() returns ide_stopped due to failed
> 	ide_wait_stat() test.  Fixed to pass the return value of
> 	pre_task_out_intr().


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-export/drivers/ide/ide-disk.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-disk.c	2005-02-02 10:28:03.898413061 +0900
+++ linux-ide-export/drivers/ide/ide-disk.c	2005-02-02 10:28:04.080383536 +0900
@@ -253,8 +253,7 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 		/* FIXME: ->OUTBSYNC ? */
 		hwif->OUTB(command, IDE_COMMAND_REG);
 
-		pre_task_out_intr(drive, rq);
-		return ide_started;
+		return pre_task_out_intr(drive, rq);
 	}
 }
 EXPORT_SYMBOL_GPL(__ide_do_rw_disk);
