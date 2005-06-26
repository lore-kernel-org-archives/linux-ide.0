From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH Linux 2.6.12 04/09] NCQ: export scsi_retry_command
Date: Mon, 27 Jun 2005 00:21:27 +0900 (KST)
Message-ID: <20050626152105.DA40FAC0@htj.dyndns.org>
References: <20050626152105.D86561FB@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:15388 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261310AbVFZPVh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 11:21:37 -0400
Received: by wproxy.gmail.com with SMTP id 57so220760wri
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 08:21:37 -0700 (PDT)
In-Reply-To: <20050626152105.D86561FB@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, linux-ide@vger.kernel.org

04_NCQ_export-scsi_retry_command.patch

	Export scsi_retry_command

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/scsi.c      |    1 +
 include/scsi/scsi_cmnd.h |    1 +
 2 files changed, 2 insertions(+)

Index: work/drivers/scsi/scsi.c
===================================================================
--- work.orig/drivers/scsi/scsi.c	2005-06-26 23:55:32.000000000 +0900
+++ work/drivers/scsi/scsi.c	2005-06-27 00:20:30.000000000 +0900
@@ -849,6 +849,7 @@ int scsi_retry_command(struct scsi_cmnd 
 
 	return scsi_queue_insert(cmd, SCSI_MLQUEUE_EH_RETRY);
 }
+EXPORT_SYMBOL(scsi_retry_command);
 
 /*
  * Function:    scsi_finish_command
Index: work/include/scsi/scsi_cmnd.h
===================================================================
--- work.orig/include/scsi/scsi_cmnd.h	2005-06-26 23:55:32.000000000 +0900
+++ work/include/scsi/scsi_cmnd.h	2005-06-27 00:20:30.000000000 +0900
@@ -151,5 +151,6 @@ extern struct scsi_cmnd *scsi_get_comman
 extern void scsi_put_command(struct scsi_cmnd *);
 extern void scsi_io_completion(struct scsi_cmnd *, unsigned int, unsigned int);
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
+extern int scsi_retry_command(struct scsi_cmnd *cmd);
 
 #endif /* _SCSI_SCSI_CMND_H */

