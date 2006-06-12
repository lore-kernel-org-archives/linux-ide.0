From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 2/n] libata.h redo dbg messages level order v0.2
Date: Mon, 12 Jun 2006 20:15:38 +0200
Message-ID: <20060612181538.GB20964@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp103.plus.mail.mud.yahoo.com ([68.142.206.236]:1139 "HELO
	smtp103.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932872AbWFMEit (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 00:38:49 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Consistent dbg message levels.

Signed-off-by: <petkov@math.uni-muenster.de>


--- libata-dev/include/linux/libata.h.orig	2006-06-12 19:47:49.000000000 +0200
+++ libata-dev/include/linux/libata.h	2006-06-12 19:48:51.000000000 +0200
@@ -66,14 +66,14 @@
 #define HAVE_LIBATA_MSG 1
 
 enum {
-	ATA_MSG_DRV	= 0x0001,
-	ATA_MSG_INFO	= 0x0002,
-	ATA_MSG_PROBE	= 0x0004,
-	ATA_MSG_WARN	= 0x0008,
-	ATA_MSG_MALLOC	= 0x0010,
-	ATA_MSG_CTL	= 0x0020,
-	ATA_MSG_INTR	= 0x0040,
-	ATA_MSG_ERR	= 0x0080,
+	ATA_MSG_ERR	= 0x0001,
+	ATA_MSG_WARN	= 0x0002,
+	ATA_MSG_DRV	= 0x0004,
+	ATA_MSG_INFO	= 0x0008,
+	ATA_MSG_PROBE	= 0x0010,
+	ATA_MSG_MALLOC	= 0x0020,
+	ATA_MSG_CTL	= 0x0040,
+	ATA_MSG_INTR	= 0x0080,
 };
 
 #define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

