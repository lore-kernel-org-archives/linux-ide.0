From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 1/4] libata: indent and whitespace change
Date: Tue, 27 Sep 2005 17:34:38 +0800
Message-ID: <4339122E.3040200@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com> <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com> <4339116D.30908@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090803090204090106050904"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:64151 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964880AbVI0Jeo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Sep 2005 05:34:44 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8R9XTVn020981
	for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 05:33:29 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8R9ZFHU549532
	for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 03:35:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j8R9Yb9g018253
	for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 03:34:38 -0600
In-Reply-To: <4339116D.30908@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

This is a multi-part message in MIME format.
--------------090803090204090106050904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 1/4: indent and white space change

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------090803090204090106050904
Content-Type: text/plain;
 name="idpio1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="idpio1.diff"

--- linux/drivers/scsi/libata-core.c	2005-09-20 17:18:00.000000000 +0800
+++ id1/drivers/scsi/libata-core.c	2005-09-26 14:11:03.000000000 +0800
@@ -3586,7 +3586,7 @@ u8 ata_bmdma_status(struct ata_port *ap)
 		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 		host_stat = readb(mmio + ATA_DMA_STATUS);
 	} else
-	host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 	return host_stat;
 }
 
--- linux/drivers/scsi/sata_promise.c	2005-09-20 17:18:01.000000000 +0800
+++ id1/drivers/scsi/sata_promise.c	2005-09-26 14:36:51.000000000 +0800
@@ -438,11 +438,11 @@ static inline unsigned int pdc_host_intr
 		break;
 
         default:
-                ap->stats.idle_irq++;
-                break;
+		ap->stats.idle_irq++;
+		break;
         }
 
-        return handled;
+	return handled;
 }
 
 static void pdc_irq_clear(struct ata_port *ap)

--------------090803090204090106050904--

