From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] libata-scsi:  be tolerant of 12-byte ATAPI commands in 16-byte
 CDBs
Date: Wed, 14 Nov 2007 12:44:23 -0500
Message-ID: <473B33F7.7030708@rtr.ca>
References: <20071113164323.GA5252@section-eight> <20071113212230.77cadecd@the-village.bc.nu> <20071113232859.GA4681@section-eight> <473B0FA2.5000102@rtr.ca> <20071114153852.GA9019@section-eight> <473B1B83.9020103@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1216 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756984AbXKNRoY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Nov 2007 12:44:24 -0500
In-Reply-To: <473B1B83.9020103@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Sebastian Kemper <sebastian_ml@gmx.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>

Sebastian Kemper reported that issuing CD/DVD commands under libata
is not fully compatible with ide-scsi.  In particular, the GPCMD_SET_STREAMING
was being rejected at the host level in some instances.

The reason is that libata-scsi insists upon the cmd_len field exactly matching
the SCSI opcode being issued, whereas ide-scsi tolerates 12-byte commands
contained within a 16-byte (cmd_len) CDB.

There doesn't seem to be a good reason for us to not be compatible there,
so here is a patch to fix libata-scsi to permit SCSI opcodes so long as
they fit within whatever size CDB is provided.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

Patch is against 2.6.24-rc2-git4.
Sebastian, could you please re-test with this patch
and let us know that it works for you (or not).

--- old/drivers/ata/libata-scsi.c	2007-11-13 23:25:15.000000000 -0500
+++ linux/drivers/ata/libata-scsi.c	2007-11-14 12:32:16.000000000 -0500
@@ -2869,7 +2869,8 @@
 		xlat_func = NULL;
 		if (likely((scsi_op != ATA_16) || !atapi_passthru16)) {
 			/* relay SCSI command to ATAPI device */
-			if (unlikely(scmd->cmd_len > dev->cdb_len))
+			int len = COMMAND_SIZE(scsi_op);
+			if (unlikely(len > scmd->cmd_len || len > dev->cdb_len))
 				goto bad_cdb_len;
 
 			xlat_func = atapi_xlat;
