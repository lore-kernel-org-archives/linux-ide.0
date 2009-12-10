From: Christoph Hellwig <hch@lst.de>
Subject: libata: use the WRITE_SAME_16 define
Date: Thu, 10 Dec 2009 10:36:01 +0100
Message-ID: <20091210093601.GA30917@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:60115 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758659AbZLJJgF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Dec 2009 04:36:05 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Now that the scsi tree has hit mainline we can use the newly added WRITE_SAME_16
define.

Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/ata/libata-scsi.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-scsi.c	2009-12-10 10:21:05.735254334 +0100
+++ linux-2.6/drivers/ata/libata-scsi.c	2009-12-10 10:21:29.562255983 +0100
@@ -3022,7 +3022,7 @@ static inline ata_xlat_func_t ata_get_xl
 	case WRITE_16:
 		return ata_scsi_rw_xlat;
 
-	case 0x93 /*WRITE_SAME_16*/:
+	case WRITE_SAME_16:
 		return ata_scsi_write_same_xlat;
 
 	case SYNCHRONIZE_CACHE:
