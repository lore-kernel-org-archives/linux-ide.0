From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI work in progress
Date: 15 May 2004 07:49:38 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084628978.5082.7.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455  
	9	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com><1084578453.534
	 3.	26.camel@patibmrh9> <1084579362.3271.5.camel@patibmrh9><40A5669B.608010
	8@pobox.com>  <1084626376.3079.8.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=-I+EIFWKBHidN12AgqXrd"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:14060 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262459AbUEONuD
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 09:50:03 -0400
In-Reply-To: <1084626376.3079.8.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


--=-I+EIFWKBHidN12AgqXrd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> I doubt I can use this patch as is.  I believe, because I assembled my
> drive from components myself, its op xA1 Identify data has not changed,
> so I will see a misleading 0 False at:
> 
> #define ata_id_use_dmadir(dev) ((dev)->id[62] & (1 << 15))

Theory confirmed!

> ...

Specifically I saw:

kernel: ata_dump_id: 88==0x203f  93==0x404f
kernel: Assertion failed! dev->class == ATA_DEV_ATA,drivers/scsi/libata-core.c,ata_dev_parse_strings,line=867
kernel: ata2: dev 0 ATA ata_id_use_dmadir
kernel: ata2: dev 0 ATA 'word' 62 = x0000
kernel: ata2: dev 0 ATAPI, max UDMA/100
kernel: ata_dev_identify: EXIT, drv_stat = 0x50

reported by the following experimental pel.patch.7x, applied after
patch.[1234567] from Jeff G.

Pat LaVarre

--- o/drivers/scsi/libata-core.c	2004-05-15 07:31:49.000000000 -0600
+++ linux-2.6.6-bk1/drivers/scsi/libata-core.c	2004-05-15 07:39:24.737046832 -0600
@@ -1168,8 +1168,16 @@ retry:
 		if (ata_id_is_ata(dev))		/* sanity check */
 			goto err_out_nosup;
 
+		printk(KERN_INFO "ata%u: dev %u ATA ata_id_use_dmadir\n",
+			ap->id, device);
 		if (ata_id_use_dmadir(dev))
 			dev->flags |= ATA_DFLAG_DMADIR;
+		else {
+			dev->flags |= ATA_DFLAG_DMADIR;
+			printk(KERN_INFO "ata%u: dev %u ATA"
+				"'word' 62 = x%04X\n",
+				ap->id, device, (dev)->id[62]);
+		}
 
 		/* see if 16-byte commands supported */
 		tmp = dev->id[0] & 0x3;




--=-I+EIFWKBHidN12AgqXrd
Content-Disposition: attachment; filename=pel.patch.7x
Content-Type: text/x-troff-man; name=pel.patch.7x; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- o/drivers/scsi/libata-core.c	2004-05-15 07:31:49.000000000 -0600
+++ linux-2.6.6-bk1/drivers/scsi/libata-core.c	2004-05-15 07:39:24.737046832 -0600
@@ -1168,8 +1168,16 @@ retry:
 		if (ata_id_is_ata(dev))		/* sanity check */
 			goto err_out_nosup;
 
+		printk(KERN_INFO "ata%u: dev %u ATA ata_id_use_dmadir\n",
+			ap->id, device);
 		if (ata_id_use_dmadir(dev))
 			dev->flags |= ATA_DFLAG_DMADIR;
+		else {
+			dev->flags |= ATA_DFLAG_DMADIR;
+			printk(KERN_INFO "ata%u: dev %u ATA"
+				"'word' 62 = x%04X\n",
+				ap->id, device, (dev)->id[62]);
+		}
 
 		/* see if 16-byte commands supported */
 		tmp = dev->id[0] & 0x3;

--=-I+EIFWKBHidN12AgqXrd--

