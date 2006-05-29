From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH] libata debugging: set initial dbg value
Date: Mon, 29 May 2006 06:53:02 +0200
Message-ID: <20060529045302.GA4680@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp106.plus.mail.re2.yahoo.com ([206.190.53.31]:32897 "HELO
	smtp106.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751174AbWE2ExG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 00:53:06 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

This patch sets the prerequisites for the new debugging scheme that more or
less resembles Donald Becker's net driver example. This one liner doesn't
change any functionality beside setting the appropriate debug level for the
msg_enable control in the ata_port struct, which will be later used by the 
ata_msg_* macros to control the amount of debug information sent to printk.

Signed-off-by: <petkov@uni-muenster.de>


--- drivers/scsi/libata-core.c.orig	2006-05-28 10:09:48.000000000 +0200
+++ drivers/scsi/libata-core.c	2006-05-28 10:10:19.000000000 +0200
@@ -4456,6 +4456,7 @@ static void ata_host_init(struct ata_por
 	ap->cbl = ATA_CBL_NONE;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
+	ap->msg_enable = ATA_MSG_DRV;
 
 	INIT_WORK(&ap->port_task, NULL, NULL);
 	INIT_LIST_HEAD(&ap->eh_done_q);

	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

