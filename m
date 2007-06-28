From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2.6.22-rc6] libata: remove reading alt_status from ata_hsm_qc_complete()
Date: Thu, 28 Jun 2007 10:05:31 +0800
Message-ID: <4683176B.3060605@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:53268 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbXF1CFn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jun 2007 22:05:43 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5S25gbp018448
	for <linux-ide@vger.kernel.org>; Wed, 27 Jun 2007 22:05:42 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5S25glb259250
	for <linux-ide@vger.kernel.org>; Wed, 27 Jun 2007 20:05:42 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5S25fRg017683
	for <linux-ide@vger.kernel.org>; Wed, 27 Jun 2007 20:05:42 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>

In ata_hsm_qc_complete():
Calling ata_altstatus() after the qc is completed might race with next qc. Remove it.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Jeff,

(Sorry for re-submitting this patch so late.)
The unneeded reading of alt_status might cause trouble when another command doing activity like pio data xfer.
After checking, the flush here is leftover/merge damage of ata_pio_block( ) in 2.6.17-rc5:
http://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git;a=commitdiff;h=bb31a8faa270beafcc51a65880c5564c6b718bd6
We can safely remove it.

--- linux-2.6.22-rc6/drivers/ata/libata-core.c.ori	2007-06-28 09:47:31.000000000 +0800
+++ linux-2.6.22-rc6/drivers/ata/libata-core.c	2007-06-28 09:49:26.000000000 +0800
@@ -4799,8 +4799,6 @@ static void ata_hsm_qc_complete(struct a
 		} else
 			ata_qc_complete(qc);
 	}
-
-	ata_altstatus(ap); /* flush */
 }
 
 /**

