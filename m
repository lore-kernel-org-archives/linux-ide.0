From: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 01/09] ide: kill unused pkt_task_t
Date: Sat,  5 Feb 2005 19:28:42 +0900 (KST)
Message-ID: <20050205102842.4BC941326FA@htj.dyndns.org>
References: <42049F20.7020706@home-tj.org>
Received: from [211.58.254.17] ([211.58.254.17]:32657 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S266440AbVBEK2o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Feb 2005 05:28:44 -0500
In-Reply-To: <42049F20.7020706@home-tj.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


01_ide_kill_pkt_task_t.patch

	Remove unused pkt_task_t definition from ide.h.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-ide-series2-export/include/linux/ide.h
===================================================================
--- linux-ide-series2-export.orig/include/linux/ide.h	2005-02-05 19:26:51.369361863 +0900
+++ linux-ide-series2-export/include/linux/ide.h	2005-02-05 19:27:08.104643467 +0900
@@ -1279,20 +1279,6 @@ typedef struct ide_task_s {
 	void			*special;	/* valid_t generally */
 } ide_task_t;
 
-typedef struct pkt_task_s {
-/*
- *	struct hd_drive_task_hdr	pktf;
- *	task_struct_t		pktf;
- *	u8			pkcdb[12];
- */
-	task_ioreg_t		tfRegister[8];
-	int			data_phase;
-	int			command_type;
-	ide_handler_t		*handler;
-	struct request		*rq;		/* copy of request */
-	void			*special;
-} pkt_task_t;
-
 extern u32 ide_read_24(ide_drive_t *);
 
 extern void SELECT_DRIVE(ide_drive_t *);
