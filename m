From: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 03/09] ide: ide_diag_taskfile() rq initialization fix
Date: Sat,  5 Feb 2005 19:28:43 +0900 (KST)
Message-ID: <20050205102843.4FA131326FC@htj.dyndns.org>
References: <42049F20.7020706@home-tj.org>
In-Reply-To: <42049F20.7020706@home-tj.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


03_ide_diag_taskfile_use_init_drive_cmd.patch

	In ide_diag_taskfile(), when initializing taskfile rq,
	ref_count wasn't initialized properly.  Modified to use
	ide_init_drive_cmd().  This doesn't really change any behavior
	as the request isn't managed via the block layer.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-series2-export/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide-series2-export.orig/drivers/ide/ide-taskfile.c	2005-02-05 19:27:08.308610336 +0900
+++ linux-ide-series2-export/drivers/ide/ide-taskfile.c	2005-02-05 19:27:08.533573794 +0900
@@ -471,8 +471,7 @@ static int ide_diag_taskfile(ide_drive_t
 {
 	struct request rq;
 
-	memset(&rq, 0, sizeof(rq));
-	rq.flags = REQ_DRIVE_TASKFILE;
+	ide_init_drive_cmd(&rq);
 	rq.buffer = buf;
 
 	/*
