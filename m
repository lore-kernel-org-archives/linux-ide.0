From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 10/12] sata_mv libata: export ata_eh_analyze_ncq_error
Date: Fri, 02 May 2008 02:14:53 -0400
Message-ID: <481AB15D.5020201@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca> <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca> <481AB03A.60808@rtr.ca> <481AB070.9050707@rtr.ca> <481AB0A1.3040009@rtr.ca> <481AB0D2.3070103@rtr.ca> <481AB107.701@rtr.ca> <481AB12A.3030102@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3615 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757630AbYEBGOy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 02:14:54 -0400
In-Reply-To: <481AB12A.3030102@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Export ata_eh_analyze_ncq_error() for subsequent use by sata_mv,
as suggested by Tejun.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
checkpatch.pl complains about the new EXPORT not following the function,
but it is done here the same as for all other libata-eh functions.

--- old/drivers/ata/libata-core.c	2008-05-01 15:37:20.000000000 -0400
+++ linux/drivers/ata/libata-core.c	2008-05-01 18:57:09.000000000 -0400
@@ -6292,6 +6292,7 @@
 EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
+EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);
 EXPORT_SYMBOL_GPL(ata_do_eh);
 EXPORT_SYMBOL_GPL(ata_std_error_handler);
 
--- old/drivers/ata/libata-eh.c	2008-04-29 11:04:16.000000000 -0400
+++ linux/drivers/ata/libata-eh.c	2008-05-01 18:56:42.000000000 -0400
@@ -1357,7 +1357,7 @@
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-static void ata_eh_analyze_ncq_error(struct ata_link *link)
+void ata_eh_analyze_ncq_error(struct ata_link *link)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
--- old/include/linux/libata.h	2008-05-01 15:37:21.000000000 -0400
+++ linux/include/linux/libata.h	2008-05-01 18:57:36.000000000 -0400
@@ -1039,6 +1039,7 @@
 
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
+extern void ata_eh_analyze_ncq_error(struct ata_link *link);
 
 extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 		      ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
