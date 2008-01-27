From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 5/32] ide-tape: remove IDETAPE_DEBUG_INFO
Date: Sun, 27 Jan 2008 09:41:25 +0100
Message-ID: <1201423312-2460-6-git-send-email-bbpetkov@yahoo.de>
References: <1201423312-2460-1-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp111.plus.mail.re1.yahoo.com ([69.147.102.74]:31697 "HELO
	smtp111.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756274AbYA0Imi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 03:42:38 -0500
In-Reply-To: <1201423312-2460-1-git-send-email-bbpetkov@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

The device capabilities are probed for during device initialization so this
info is available through proc/ioctl() und it is redundant here.

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-tape.c |   74 ------------------------------------------------
 1 files changed, 0 insertions(+), 74 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 0542b07..dbececc 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -106,7 +106,6 @@ typedef struct os_dat_s {
 /*
  *	The following are used to debug the driver:
  *
- *	Setting IDETAPE_DEBUG_INFO to 1 will report device capabilities.
  *	Setting IDETAPE_DEBUG_LOG to 1 will log driver flow control.
  *	Setting IDETAPE_DEBUG_BUGS to 1 will enable self-sanity checks in
  *	some places.
@@ -121,7 +120,6 @@ typedef struct os_dat_s {
  *	is verified to be stable enough. This will make it much more
  *	esthetic.
  */
-#define IDETAPE_DEBUG_INFO		0
 #define IDETAPE_DEBUG_LOG		0
 #define IDETAPE_DEBUG_BUGS		1
 
@@ -3817,41 +3815,6 @@ static int idetape_identify_device (ide_drive_t *drive)
 
 	*((unsigned short *) &gcw) = id->config;
 
-#if IDETAPE_DEBUG_INFO
-	printk(KERN_INFO "ide-tape: Dumping ATAPI Identify Device tape parameters\n");
-	printk(KERN_INFO "ide-tape: Protocol Type: ");
-	switch (gcw.protocol) {
-		case 0: case 1: printk("ATA\n");break;
-		case 2:	printk("ATAPI\n");break;
-		case 3: printk("Reserved (Unknown to ide-tape)\n");break;
-	}
-	printk(KERN_INFO "ide-tape: Device Type: %x - ",gcw.device_type);	
-	switch (gcw.device_type) {
-		case 0: printk("Direct-access Device\n");break;
-		case 1: printk("Streaming Tape Device\n");break;
-		case 2: case 3: case 4: printk("Reserved\n");break;
-		case 5: printk("CD-ROM Device\n");break;
-		case 6: printk("Reserved\n");
-		case 7: printk("Optical memory Device\n");break;
-		case 0x1f: printk("Unknown or no Device type\n");break;
-		default: printk("Reserved\n");
-	}
-	printk(KERN_INFO "ide-tape: Removable: %s",gcw.removable ? "Yes\n":"No\n");	
-	printk(KERN_INFO "ide-tape: Command Packet DRQ Type: ");
-	switch (gcw.drq_type) {
-		case 0: printk("Microprocessor DRQ\n");break;
-		case 1: printk("Interrupt DRQ\n");break;
-		case 2: printk("Accelerated DRQ\n");break;
-		case 3: printk("Reserved\n");break;
-	}
-	printk(KERN_INFO "ide-tape: Command Packet Size: ");
-	switch (gcw.packet_size) {
-		case 0: printk("12 bytes\n");break;
-		case 1: printk("16 bytes\n");break;
-		default: printk("Reserved\n");break;
-	}
-#endif /* IDETAPE_DEBUG_INFO */
-
 	/* Check that we can support this device */
 
 	if (gcw.protocol !=2 )
@@ -3939,39 +3902,6 @@ static void idetape_get_mode_sense_results (ide_drive_t *drive)
 		tape->tape_block_size = 512;
 	else if (capabilities->blk1024)
 		tape->tape_block_size = 1024;
-
-#if IDETAPE_DEBUG_INFO
-	printk(KERN_INFO "ide-tape: Dumping the results of the MODE SENSE packet command\n");
-	printk(KERN_INFO "ide-tape: Mode Parameter Header:\n");
-	printk(KERN_INFO "ide-tape: Mode Data Length - %d\n", pc.buffer[0]);
-	printk(KERN_INFO "ide-tape: Medium Type - %d\n", pc.buffer[1]);
-	printk(KERN_INFO "ide-tape: Device Specific Parameter - %d\n",
-			pc.buffer[2]);
-	printk(KERN_INFO "ide-tape: Block Descriptor Length - %d\n",
-			pc.buffer[3]);
-
-	printk(KERN_INFO "ide-tape: Capabilities and Mechanical Status Page:\n");
-	printk(KERN_INFO "ide-tape: Page code - %d\n",capabilities->page_code);
-	printk(KERN_INFO "ide-tape: Page length - %d\n",capabilities->page_length);
-	printk(KERN_INFO "ide-tape: Read only - %s\n",capabilities->ro ? "Yes":"No");
-	printk(KERN_INFO "ide-tape: Supports reverse space - %s\n",capabilities->sprev ? "Yes":"No");
-	printk(KERN_INFO "ide-tape: Supports erase initiated formatting - %s\n",capabilities->efmt ? "Yes":"No");
-	printk(KERN_INFO "ide-tape: Supports QFA two Partition format - %s\n",capabilities->qfa ? "Yes":"No");
-	printk(KERN_INFO "ide-tape: Supports locking the medium - %s\n",capabilities->lock ? "Yes":"No");
-	printk(KERN_INFO "ide-tape: The volume is currently locked - %s\n",capabilities->locked ? "Yes":"No");
-	printk(KERN_INFO "ide-tape: The device defaults in the prevent state - %s\n",capabilities->prevent ? "Yes":"No");
-	printk(KERN_INFO "ide-tape: Supports ejecting the medium - %s\n",capabilities->eject ? "Yes":"No");
-	printk(KERN_INFO "ide-tape: Supports error correction - %s\n",capabilities->ecc ? "Yes":"No");
-	printk(KERN_INFO "ide-tape: Supports data compression - %s\n",capabilities->cmprs ? "Yes":"No");
-	printk(KERN_INFO "ide-tape: Supports 512 bytes block size - %s\n",capabilities->blk512 ? "Yes":"No");
-	printk(KERN_INFO "ide-tape: Supports 1024 bytes block size - %s\n",capabilities->blk1024 ? "Yes":"No");
-	printk(KERN_INFO "ide-tape: Supports 32768 bytes block size / Restricted byte count for PIO transfers - %s\n",capabilities->blk32768 ? "Yes":"No");
-	printk(KERN_INFO "ide-tape: Maximum supported speed in KBps - %d\n",capabilities->max_speed);
-	printk(KERN_INFO "ide-tape: Continuous transfer limits in blocks - %d\n",capabilities->ctl);
-	printk(KERN_INFO "ide-tape: Current speed in KBps - %d\n",
-			capabilities->speed);
-	printk(KERN_INFO "ide-tape: Buffer size - %d\n",capabilities->buffer_size*512);
-#endif /* IDETAPE_DEBUG_INFO */
 }
 
 /*
@@ -3997,10 +3927,6 @@ static void idetape_get_blocksize_from_block_descriptor(ide_drive_t *drive)
 	block_descrp = (idetape_parameter_block_descriptor_t *) pc.buffer + 4;
 	tape->tape_block_size =( block_descrp->length[0]<<16) + (block_descrp->length[1]<<8) + block_descrp->length[2];
 	tape->drv_write_prot = (pc.buffer[2] & 0x80) >> 7;
-
-#if IDETAPE_DEBUG_INFO
-	printk(KERN_INFO "ide-tape: Adjusted block size - %d\n", tape->tape_block_size);
-#endif /* IDETAPE_DEBUG_INFO */
 }
 
 #ifdef CONFIG_IDE_PROC_FS
-- 
1.5.3.7

