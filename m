From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix ata_xfer_tbl termination
Date: Fri, 31 Mar 2006 22:48:52 +0900
Message-ID: <20060331134852.GF13172@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:40852 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751118AbWCaNs5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 08:48:57 -0500
Received: by zproxy.gmail.com with SMTP id o37so882399nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 05:48:57 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

ata_xfer_tbl is terminated by entry with -1 as ->shift.  However,
->shift was unsigned int making the termination condition bogus.  This
patch converts ->shift and ->bits to int.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2006-03-31 22:45:13.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2006-03-31 22:45:57.000000000 +0900
@@ -278,7 +278,7 @@ static void ata_unpack_xfermask(unsigned
 }
 
 static const struct ata_xfer_ent {
-	unsigned int shift, bits;
+	int shift, bits;
 	u8 base;
 } ata_xfer_tbl[] = {
 	{ ATA_SHIFT_PIO, ATA_BITS_PIO, XFER_PIO_0 },
