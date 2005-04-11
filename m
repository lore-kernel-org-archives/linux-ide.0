From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/4] libata-dev-2.6: pdc2027x add ata_scsi_ioctl
Date: Mon, 11 Apr 2005 18:02:09 +0800
Message-ID: <425A4B21.8040603@tw.ibm.com>
References: <425A49F6.3040904@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040106070506080709060009"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:26595 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261751AbVDKKDT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Apr 2005 06:03:19 -0400
In-Reply-To: <425A49F6.3040904@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040106070506080709060009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Change:
    pdc2027x: add ata_scsi_ioctl.

Attached please find the patch 1/4 against the libata-dev-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------040106070506080709060009
Content-Type: text/plain;
 name="pdc_058.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdc_058.diff"

--- libata-dev-2.6/drivers/scsi/pata_pdc2027x.c	2005-04-11 09:45:37.000000000 +0800
+++ libata-dev-2.6-058/drivers/scsi/pata_pdc2027x.c	2005-04-11 09:41:50.000000000 +0800
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.57"
+#define DRV_VERSION	"0.58"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -115,6 +115,7 @@
 static Scsi_Host_Template pdc2027x_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
 	.queuecommand		= ata_scsi_queuecmd,
 	.eh_strategy_handler	= ata_scsi_error,
 	.can_queue		= ATA_DEF_QUEUE,
@@ -450,6 +451,7 @@
 	if (cmd->request_bufflen % 256)
 		rc = 1;
 
+	PDPRINTK("request_bufflen %d, rc %d\n", cmd->request_bufflen, rc);
 	return rc;
 }
 

--------------040106070506080709060009--


