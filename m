From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ata kmap_atomic abuse
Date: Mon, 11 Dec 2006 11:07:06 -0500
Message-ID: <457D822A.9010600@garzik.org>
References: <20061211001314.9ecb17a2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060601040505080302000405"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47132 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936947AbWLKQHJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Dec 2006 11:07:09 -0500
In-Reply-To: <20061211001314.9ecb17a2.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060601040505080302000405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> [  231.948000] SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
> [  232.232000] ata1.00: configured for UDMA/33
> [  232.404000] WARNING (1) at arch/i386/mm/highmem.c:47 kmap_atomic()

> It's using KM_USER0 from softirq.

I thought that was OK if it was kmap_atomic().  Live and learn.

Checked in the attached.

	Jeff



--------------060601040505080302000405
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

commit 410228c04f8ee84ae6d07f63dec8df039c9bbd4c
Author: Jeff Garzik <jeff@garzik.org>
Date:   Mon Dec 11 11:05:53 2006 -0500

[libata] use kmap_atomic(KM_IRQ0) in SCSI simulator

We are inside spin_lock_irqsave().  quoth akpm's debug facility:

 [  231.948000] SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
 [  232.232000] ata1.00: configured for UDMA/33
 [  232.404000] WARNING (1) at arch/i386/mm/highmem.c:47 kmap_atomic()
 [  232.404000]  [<c01162e6>] kmap_atomic+0xa9/0x1ab
 [  232.404000]  [<c0242c81>] ata_scsi_rbuf_get+0x1c/0x30
 [  232.404000]  [<c0242caf>] ata_scsi_rbuf_fill+0x1a/0x87
 [  232.404000]  [<c0243ab2>] ata_scsiop_mode_sense+0x0/0x309
 [  232.404000]  [<c01729d5>] end_bio_bh_io_sync+0x0/0x37
 [  232.404000]  [<c02311c6>] scsi_done+0x0/0x16
 [  232.404000]  [<c02311c6>] scsi_done+0x0/0x16
 [  232.404000]  [<c0242dcc>] ata_scsi_simulate+0xb0/0x13f
[...]

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 664e137..a4790be 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1539,7 +1539,7 @@ static unsigned int ata_scsi_rbuf_get(st
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
-		buf = kmap_atomic(sg->page, KM_USER0) + sg->offset;
+		buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
 		buflen = sg->length;
 	} else {
 		buf = cmd->request_buffer;
@@ -1567,7 +1567,7 @@ static inline void ata_scsi_rbuf_put(str
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
-		kunmap_atomic(buf - sg->offset, KM_USER0);
+		kunmap_atomic(buf - sg->offset, KM_IRQ0);
 	}
 }
 

--------------060601040505080302000405--
