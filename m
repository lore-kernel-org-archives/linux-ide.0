From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: Failed to set xfermode on LITE-ON  LTR-40125S
Date: Fri, 26 Jan 2007 11:50:11 +0800
Message-ID: <45B97A73.6050703@tw.ibm.com>
References: <20070125201750.2adbd57c@buffy.scoobygang>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:55909 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030735AbXAZDuU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 22:50:20 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0Q3oH5l012779
	for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 22:50:17 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0Q3oHTY548030
	for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 20:50:17 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0Q3oHYs028300
	for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 20:50:17 -0700
In-Reply-To: <20070125201750.2adbd57c@buffy.scoobygang>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Williams <john@pond-weed.com>
Cc: linux-ide@vger.kernel.org

John Williams wrote:
> Hello,
> 
> I just tried the libata support for PATA in kernel 2.6.20-rc5 and I got
> this:
> 
> scsi1 : pata_sis
> ata2.00: ATAPI, max UDMA/66
> ata2.01: ATAPI, max UDMA/33
> ata2.00: configured for UDMA/33
> ata2.01: qc timeout (cmd 0xef)
> ata2.01: failed to set xfermode (err_mask=0x4)
> ata2.01: limiting speed to UDMA/25
> ata2: failed to recover some devices, retrying in 5 secs
> ata2.00: configured for UDMA/33
> ata2.01: qc timeout (cmd 0xef)
> ata2.01: failed to set xfermode (err_mask=0x4)
> ata2.01: limiting speed to PIO0
> ata2: failed to recover some devices, retrying in 5 secs
> ata2.00: configured for UDMA/33
> ata2.01: qc timeout (cmd 0xef)
> ata2.01: failed to set xfermode (err_mask=0x4)
> ata2.01: disabled
> ata2: failed to recover some devices, retrying in 5 secs
> ata2.00: failed to set xfermode (err_mask=0x40)
> ata2.00: limiting speed to UDMA/25
> ata2: failed to recover some devices, retrying in 5 secs
> ata2.00: configured for UDMA/25
> 
> The offending device is a LITE-ON LTR-40125S CDRW attached to SIS 513
> IDE (rev d0)
> 
> I found a patch here:
> http://readlist.com/lists/vger.kernel.org/linux-kernel/45/228948.html
> which cures the problem for me. Is this the recommended patch for this
> problem? If not, I would be happy to test alternative solutions.
> 

Tejun fixed the problem by ATA_FLAG_SETXFER_POLLING for pata_via.
Maybe the same fix works for pata_sis.

Could you please try the attached patch, thanks.
--
albert

--- linux-2.6.20-rc5-mod/drivers/ata/pata_sis.c~	2007-01-23 11:47:40.000000000 +0800
+++ linux-2.6.20-rc5-mod/drivers/ata/pata_sis.c	2007-01-26 11:43:54.000000000 +0800
@@ -718,7 +718,7 @@ static const struct ata_port_operations 
 
 static struct ata_port_info sis_info = {
 	.sht		= &sis_sht,
-	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_SETXFER_POLLING,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.mwdma_mask	= 0x07,
 	.udma_mask	= 0,
@@ -726,7 +726,7 @@ static struct ata_port_info sis_info = {
 };
 static struct ata_port_info sis_info33 = {
 	.sht		= &sis_sht,
-	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_SETXFER_POLLING,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.mwdma_mask	= 0x07,
 	.udma_mask	= ATA_UDMA2,	/* UDMA 33 */
@@ -734,35 +734,35 @@ static struct ata_port_info sis_info33 =
 };
 static struct ata_port_info sis_info66 = {
 	.sht		= &sis_sht,
-	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_SETXFER_POLLING,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA4,	/* UDMA 66 */
 	.port_ops	= &sis_66_ops,
 };
 static struct ata_port_info sis_info100 = {
 	.sht		= &sis_sht,
-	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_SETXFER_POLLING,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA5,
 	.port_ops	= &sis_100_ops,
 };
 static struct ata_port_info sis_info100_early = {
 	.sht		= &sis_sht,
-	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_SETXFER_POLLING,
 	.udma_mask	= ATA_UDMA5,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.port_ops	= &sis_66_ops,
 };
 static struct ata_port_info sis_info133 = {
 	.sht		= &sis_sht,
-	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_SETXFER_POLLING,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &sis_133_ops,
 };
 static struct ata_port_info sis_info133_early = {
 	.sht		= &sis_sht,
-	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_SETXFER_POLLING,
 	.pio_mask	= 0x1f,	/* pio0-4 */
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &sis_133_early_ops,





