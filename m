From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 03/11] ide: ide_diag_taskfile() rq initialization fix
Date: Thu, 10 Feb 2005 17:38:24 +0900 (KST)
Message-ID: <20050210083819.A2B6B4F7@htj.dyndns.org>
References: <20050210083808.48E9DD1A@htj.dyndns.org>
In-Reply-To: <20050210083808.48E9DD1A@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org


03_ide_diag_taskfile_use_init_drive_cmd.patch

	In ide_diag_taskfile(), taskfile rq was initialized using
	memset().  Use init_drive_cmd() instead.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ide-taskfile.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: linux-ide/drivers/ide/ide-taskfile.c
===================================================================
--- linux-ide.orig/drivers/ide/ide-taskfile.c	2005-02-10 17:38:00.437024304 +0900
+++ linux-ide/drivers/ide/ide-taskfile.c	2005-02-10 17:38:00.832957893 +0900
@@ -469,8 +469,7 @@ static int ide_diag_taskfile(ide_drive_t
 {
 	struct request rq;
 
-	memset(&rq, 0, sizeof(rq));
-	rq.flags = REQ_DRIVE_TASKFILE;
+	ide_init_drive_cmd(&rq);
 	rq.buffer = buf;
 
 	/*
