From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata-dev: add flush task to ata_exec_internal()
Date: Tue, 14 Mar 2006 11:19:04 +0800
Message-ID: <44163628.2000001@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:32413 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751793AbWCNDTW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Mar 2006 22:19:22 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2E3JG0r011648
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 22:19:16 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2E3MAbx157340
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 20:22:10 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2E3JDw5005853
	for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 20:19:14 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE Linux <linux-ide@vger.kernel.org>

Add ata_port_flush_task() to ata_exec_internal().

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

It seems we also need ata_port_flush_task() in ata_exec_internal().

Patch against the upstream branch
(fb21f0d0ec7e31cc814165e1a9d2662d9c9dd980).

For your review, thanks,

Albert

--- upstream0/drivers/scsi/libata-core.c	2006-03-14 10:31:01.000000000 +0800
+++ exec_internal/drivers/scsi/libata-core.c	2006-03-14 10:55:24.000000000 +0800
@@ -962,6 +962,8 @@ ata_exec_internal(struct ata_port *ap, s
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	if (!wait_for_completion_timeout(&wait, ATA_TMOUT_INTERNAL)) {
+		ata_port_flush_task(ap);
+
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 
 		/* We're racing with irq here.  If we lose, the

