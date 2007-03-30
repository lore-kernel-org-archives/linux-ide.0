From: Mark Lord <mlord@pobox.com>
Subject: libata bugfix: preserve LBA bit for HDIO_DRIVE_TASK
Date: Fri, 30 Mar 2007 17:45:52 -0400
Message-ID: <460D8510.1050102@pobox.com>
References: <20070330205938.984247529@mini.kroah.org> <20070330210659.GK29450@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gretel.pobox.com ([208.58.1.197]:34284 "EHLO gretel.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701AbXC3Wpo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Mar 2007 18:45:44 -0400
In-Reply-To: <20070330210659.GK29450@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Ideally, this would go into linux-2.6.21.

Preserve the LBA bit in the DevSel/Head register for HDIO_DRIVE_TASK.

Signed-off-by:  Mark Lord <mlord@pobox.com>
---
--- linux/drivers/ata/libata-scsi.c.orig	2007-03-21 13:35:02.000000000 -0400
+++ linux/drivers/ata/libata-scsi.c	2007-03-30 17:40:58.000000000 -0400
@@ -333,7 +333,7 @@
 	scsi_cmd[8]  = args[3];
 	scsi_cmd[10] = args[4];
 	scsi_cmd[12] = args[5];
-	scsi_cmd[13] = args[6] & 0x0f;
+	scsi_cmd[13] = args[6] & 0x4f;
 	scsi_cmd[14] = args[0];
 
 	/* Good values for timeout and retries?  Values below
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
