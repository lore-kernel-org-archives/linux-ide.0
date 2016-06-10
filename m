From: Brian King <brking@linux.vnet.ibm.com>
Subject: [RFC] [PATCH 2/3] scsi: Export SCSI EH commands
Date: Fri, 10 Jun 2016 16:37:53 -0500
Message-ID: <575B3331.6030707@linux.vnet.ibm.com>
References: <CAOS58YO65A8TpH22tEdM4SUcn8ncpY1f_YFMzomCN09OvhoRaQ@mail.gmail.com>
 <57470450.3070000@linux.vnet.ibm.com> <575B3215.5070602@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3970 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753111AbcFJVh7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2016 17:37:59 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5ALXi59145367
	for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2016 17:37:58 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23g1e6wtk7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-ide@vger.kernel.org>; Fri, 10 Jun 2016 17:37:58 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-ide@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
	Fri, 10 Jun 2016 15:37:57 -0600
In-Reply-To: <575B3215.5070602@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>


Export the following EH commands so that ipr can be converted to
use libata's new EH.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 drivers/scsi/scsi_error.c |    5 +++--
 include/scsi/scsi_eh.h    |    5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff -puN drivers/scsi/scsi_error.c~scsi_eh_export_scsi_eh_abort_cmds drivers/scsi/scsi_error.c
--- linux-2.6.git/drivers/scsi/scsi_error.c~scsi_eh_export_scsi_eh_abort_cmds	2016-06-10 15:50:03.191155441 -0500
+++ linux-2.6.git-bjking1/drivers/scsi/scsi_error.c	2016-06-10 15:50:03.201155322 -0500
@@ -1320,8 +1320,8 @@ static int scsi_eh_test_devices(struct l
  *    no sense to try and abort the command, since as far as the shost
  *    adapter is concerned, it isn't running.
  */
-static int scsi_eh_abort_cmds(struct list_head *work_q,
-			      struct list_head *done_q)
+int scsi_eh_abort_cmds(struct list_head *work_q,
+		       struct list_head *done_q)
 {
 	struct scsi_cmnd *scmd, *next;
 	LIST_HEAD(check_list);
@@ -1361,6 +1361,7 @@ static int scsi_eh_abort_cmds(struct lis
 
 	return scsi_eh_test_devices(&check_list, work_q, done_q, 0);
 }
+EXPORT_SYMBOL_GPL(scsi_eh_abort_cmds);
 
 /**
  * scsi_eh_try_stu - Send START_UNIT to device.
diff -puN include/scsi/scsi_eh.h~scsi_eh_export_scsi_eh_abort_cmds include/scsi/scsi_eh.h
--- linux-2.6.git/include/scsi/scsi_eh.h~scsi_eh_export_scsi_eh_abort_cmds	2016-06-10 15:50:03.195155394 -0500
+++ linux-2.6.git-bjking1/include/scsi/scsi_eh.h	2016-06-10 15:50:03.201155322 -0500
@@ -17,6 +17,11 @@ extern int scsi_block_when_processing_er
 extern bool scsi_command_normalize_sense(const struct scsi_cmnd *cmd,
 					 struct scsi_sense_hdr *sshdr);
 extern int scsi_check_sense(struct scsi_cmnd *);
+extern int scsi_eh_abort_cmds(struct list_head *work_q,
+			      struct list_head *done_q);
+extern void scsi_eh_ready_devs(struct Scsi_Host *shost,
+			       struct list_head *work_q,
+			       struct list_head *done_q);
 
 static inline bool scsi_sense_is_deferred(const struct scsi_sense_hdr *sshdr)
 {
_

