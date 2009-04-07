From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] libata-eh: call freeze hook before port abort
Date: Tue, 07 Apr 2009 17:38:57 -0400
Message-ID: <49DBC7F1.3040801@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090409040109070601090808"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58431 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754615AbZDGVjA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Apr 2009 17:39:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090409040109070601090808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Tejun,

This patch looks like it might work for !PMP setups, but I am not so 
sure about PMP.

Any comments?  This should help begin addressing the problem where 
hardware needs the DMA engine turned off before accessing the taskfile 
registers -- something needed for ata_port_abort() via ata_qc_complete().

	Jeff





--------------090409040109070601090808
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0183131..0b7ed40 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1013,8 +1013,8 @@ int ata_port_freeze(struct ata_port *ap)
 
 	WARN_ON(!ap->ops->error_handler);
 
-	nr_aborted = ata_port_abort(ap);
 	__ata_port_freeze(ap);
+	nr_aborted = ata_port_abort(ap);
 
 	return nr_aborted;
 }

--------------090409040109070601090808--
