From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH -resend] libata: fix kernel-doc params notation
Date: Mon, 19 May 2008 16:18:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805191617160.20279@shark.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:47425 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754043AbYESXTA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 May 2008 19:19:00 -0400
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 16:18:54 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix libata-scsi kernel-doc notation:

Warning(linux-2.6.25-git15//drivers/ata/libata-scsi.c:1659): No description found for parameter 'cmd'
Warning(linux-2.6.25-git15//drivers/ata/libata-scsi.c:1971): No description found for parameter 'buf'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/ata/libata-scsi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- lin2626-rc3.orig/drivers/ata/libata-scsi.c
+++ lin2626-rc3/drivers/ata/libata-scsi.c
@@ -1643,6 +1643,7 @@ defer:
 
 /**
  *	ata_scsi_rbuf_get - Map response buffer.
+ *	@cmd: SCSI command containing buffer to be mapped.
  *	@flags: unsigned long variable to store irq enable status
  *	@copy_in: copy in from user buffer
  *
@@ -1960,7 +1961,7 @@ static unsigned int ata_msense_ctl_mode(
 
 /**
  *	ata_msense_rw_recovery - Simulate MODE SENSE r/w error recovery page
- *	@bufp: output buffer
+ *	@buf: output buffer
  *
  *	Generate a generic MODE SENSE r/w error recovery page.
  *
