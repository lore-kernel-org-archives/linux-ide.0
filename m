From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Subject: [PATCH] pdc_adma: Last Patch to pdc_adma breaks debug compile[Scanned]
Date: Mon, 13 Feb 2006 09:33:40 +0100
Message-ID: <43F04464.3020300@bfh.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------060809010609000906000704"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.hkb.bfh.ch ([147.87.184.39]:5767 "EHLO hkbsrv07.hkb.bfh.ch")
	by vger.kernel.org with ESMTP id S1751241AbWBMIeA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Feb 2006 03:34:00 -0500
Content-Class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

--------------060809010609000906000704
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit


The Last Patch (5. Nov. 05) to the sata pdc_adma driver removed nelem
from adma_fill_sg and introduced ata_for_each_sg.

The Problem is that nelem was forgot to be removed from the contained
VPRINTK too. The attached patch fixes this.

Patch applies against 2.6.15.1

Signed-Off-By: Seewer Philippe <philippe.seewer@bfh.ch>
---

--- linux-2.6.15.1/drivers/scsi/pdc_adma.c.orig 2006-02-08
09:03:15.000000000 +0100
+++ linux-2.6.15.1/drivers/scsi/pdc_adma.c      2006-02-08
09:04:32.000000000 +0100
@@ -322,8 +322,8 @@ static int adma_fill_sg(struct ata_queue
                        = (pFLAGS & pEND) ? 0 : cpu_to_le32(pp->pkt_dma
+ i + 4);
                i += 4;

-               VPRINTK("PRD[%u] = (0x%lX, 0x%X)\n", nelem
-                                       (unsigned long)addr, len);
+               VPRINTK("Current PRD = (0x%lX, 0x%X)\n",
+                       (unsigned long)addr, len);
        }
        return i;
 }


--------------060809010609000906000704
Content-Type: text/x-patch;
	name="pdc_adma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="pdc_adma.patch"

--- linux-2.6.15.1/drivers/scsi/pdc_adma.c.orig	2006-02-08 09:03:15.000000000 +0100
+++ linux-2.6.15.1/drivers/scsi/pdc_adma.c	2006-02-08 09:04:32.000000000 +0100
@@ -322,8 +322,8 @@ static int adma_fill_sg(struct ata_queue
 			= (pFLAGS & pEND) ? 0 : cpu_to_le32(pp->pkt_dma + i + 4);
 		i += 4;
 
-		VPRINTK("PRD[%u] = (0x%lX, 0x%X)\n", nelem
-					(unsigned long)addr, len);
+		VPRINTK("Current PRD = (0x%lX, 0x%X)\n",
+			(unsigned long)addr, len);
 	}
 	return i;
 }


--------------060809010609000906000704--
