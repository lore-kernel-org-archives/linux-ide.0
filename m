From: Albert Lee <albertcc@tw.ibm.com>
Subject: PATCH/RFC libata-2.6 5/5] Odd request buffer length handling in __atapi_pio_bytes()
Date: Fri, 18 Mar 2005 16:25:03 +0800
Message-ID: <423A905F.1030400@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030109090106070905090204"
Received: from bluehawaii.tikira.net ([61.62.22.51]:55268 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261497AbVCRIZ2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Mar 2005 03:25:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030109090106070905090204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Problem:
   When testing the k3b CD burning program, k3b issued a request (read TOC) with 81 bytes of buff length.
The CD-RW device didn't like it and returned 82 bytes of data. Detailed log below:

Mar 17 02:18:56 plinuxt01 kernel: ata_scsi_dump_cdb: CDB (1:0,0,0) 43 00 02 00 00 00 01 00 51
Mar 17 02:18:56 plinuxt01 kernel: ata_scsi_translate: ENTER
Mar 17 02:18:56 plinuxt01 kernel: ata_sg_init: Enter
Mar 17 02:18:56 plinuxt01 kernel: ata_sg_init: Exit
Mar 17 02:18:56 plinuxt01 kernel: ata_dev_select: ENTER, ata1: device 0, wait 1
Mar 17 02:18:56 plinuxt01 kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
Mar 17 02:18:56 plinuxt01 kernel: ata_tf_load_pio: device 0xA0
Mar 17 02:18:56 plinuxt01 kernel: ata_exec_command_pio: ata1: cmd 0xA0
Mar 17 02:18:56 plinuxt01 kernel: ata_scsi_translate: EXIT
Mar 17 02:18:56 plinuxt01 kernel: atapi_packet_task: busy wait
Mar 17 02:18:56 plinuxt01 kernel: atapi_packet_task: send cdb
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: qc->curbytes 0, qc->nbytes 81 bytes 82
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: qc->cursg [0]
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: page virtual 13835058055344004696, sgoff 0 offset 0
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: page virtual 13835058055344004696, sgoff 0 offset 0
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: sg_dma_len(sg) [0] sg->length[81]
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: count 81
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: count 81, PAGE_SIZE - offset [4096]
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: 81 bytes data read
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: goto next sg
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: qc->cursg [1]  => Oops, invalid sg get written.
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: page virtual 13835058055344704864, sgoff 0 offset 0
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: page virtual 13835058055344704864, sgoff 0 offset 0
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: sg_dma_len(sg) [4096] sg->length[4096]
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: count 1
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: count 1, PAGE_SIZE - offset [4096]
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: 1 bytes data read
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: qc->curbytes 82, qc->nbytes 81 bytes 82
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: qc->cursg [1]
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: page virtual 13835058055344704864, sgoff 0 offset 1
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: page virtual 13835058055344704864, sgoff 0 offset 1
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: sg_dma_len(sg) [4096] sg->length[4096]
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: count 82
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: count 82, PAGE_SIZE - offset [4095]
Mar 17 02:18:56 plinuxt01 kernel: __atapi_pio_bytes: 82 bytes data read
Mar 17 02:18:56 plinuxt01 kernel: ata_qc_complete: EXIT

Changes:
- When an odd-lengthed buffer is seen, round it to the next even length.
   As atapi_input_bytes() does in the ide-iops.

   I am not sure whether this is the correct. It will overrun the buffer by one byte.
I've tested it on ppc64 without problem. Need comments on this.
Attached please find the patch against the libata-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---------------------------------------
--- libata-2.6-extrabytes/drivers/scsi/libata-core.c	2005-03-18 14:00:34.000000000 +0800
+++ libata-2.6-odd/drivers/scsi/libata-core.c	2005-03-18 14:39:24.000000000 +0800
@@ -2361,6 +2361,13 @@
  	/* don't cross page boundaries */
  	count = min(count, (unsigned int)PAGE_SIZE - offset);

+	/* handle the odd condition */
+	if (unlikely(count & 0x01)) {
+		printk(KERN_WARNING "ata%u: odd count %u rounded: qc->nbytes %u, bytes %u\n",
+		       ap->id, count, qc->nbytes, bytes);
+		count++;
+	}
+
  	buf = kmap(page) + offset;

  	qc->curbytes += count;


--------------030109090106070905090204
Content-Type: text/plain;
 name="oddbuffer.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oddbuffer.diff"

--- libata-2.6-extrabytes/drivers/scsi/libata-core.c	2005-03-18 14:00:34.000000000 +0800
+++ libata-2.6-odd/drivers/scsi/libata-core.c	2005-03-18 14:39:24.000000000 +0800
@@ -2361,6 +2361,13 @@
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);
 
+	/* handle the odd condition */
+	if (unlikely(count & 0x01)) {
+		printk(KERN_WARNING "ata%u: odd count %u rounded: qc->nbytes %u, bytes %u\n", 
+		       ap->id, count, qc->nbytes, bytes);
+		count++;
+	}
+
 	buf = kmap(page) + offset;
 
 	qc->curbytes += count;

--------------030109090106070905090204--


