From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH libata-dev-2.6 1/2] ata_dev_identify() check status fix
Date: Fri, 01 Apr 2005 13:46:36 +0800
Message-ID: <424CE03C.7020903@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050408050801030203040802"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:38881 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262618AbVDAFrM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Apr 2005 00:47:12 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------050408050801030203040802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

    In the ata_dev_identify() function, ata_chk_status() is used to check whether an error has occurred.
However, in some error situation, the device's status register always reads 0x0. (Please see attached dmesg below.)
And the error found by the state machine is not seen by ata_dev_identify().

Changes:
- use qc->private_data to carry the drv_stat returned from the state machine.
- ata_qc_complete_noop() saves the drv_stat to *(qc->private_data).
- ata_dev_identify() use the status returned from ata_qc_complete_noop(), instead of ata_chk_status().
- noisy PIO error printk() changed to DPRINTK()

Attached please find the patch 1/2 against the libata-dev-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---------------------------------------
dmesg:
libata version 1.10 loaded.
pata_pdc2027x version 0.58
pata_pdc2027x: PLL input clock 32783 kHz
ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt c0000001ded82000, dma 19ae0000
ata1: PATA max UDMA/133 cmd 0xDE400 ctl 0xDDC02 bmdma 0xDEC00 irq 134
ata_host_add: ENTER
ata_port_start: prd alloc, virt c0000001de8c6000, dma 19af0000
ata2: PATA max UDMA/133 cmd 0xDE800 ctl 0xDE002 bmdma 0xDEC08 irq 134
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata_bus_reset: ENTER, host 1, port 0
   ata_pio_devchk: dev check found dev 0
   ata_pio_devchk: dev check found dev 1       ==> Phantom dev 1 passed ata_devchk()
   ata_bus_softreset: ata1: bus reset via SRST
   ata_dev_classify: found ATAPI device by sig
   ata_dev_classify: found ATAPI device by sig ==> Phantom dev 1 passed the EDD signature check
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 1, dev 0
   ata_dev_select: ENTER, ata1: device 0, wait 1
   ata_dev_identify: do ATAPI identify
     ata_dev_select: ENTER, ata1: device 0, wait 1
     ata_exec_command_pio: ata1: cmd 0xA1
     ata_pio_sector: data read
     ata_qc_complete: EXIT
       ata1: dev 0 cfg 49:0f00 82:4210 83:4000 84:4000 85:0000 86:0000 87:0000 88:0407
       ata_dump_id: 49==0x0f00  53==0x0006  63==0x0007  64==0x0003  75==0x0000
       ata_dump_id: 80==0x0078  81==0x0000  82==0x4210  83==0x4000  84==0x4000
       ata_dump_id: 88==0x0407  93==0x4000
     ata1: dev 0 ATAPI, max UDMA/33
ata_dev_identify: EXIT, drv_stat = 0x50

ata_dev_identify: ENTER, host 1, dev 1
   ata_dev_select: ENTER, ata1: device 1, wait 1
   ata_dev_identify: do ATAPI identify
     ata_dev_select: ENTER, ata1: device 1, wait 1
     ata_exec_command_pio: ata1: cmd 0xA1
     ata1: PIO error, drv_stat 0x0  ==> error. Phantom dev 1 not responding to the IDENTIFY PACKET DEVICE command
     ata_qc_complete: EXIT          ==> drv_stat 0x0, error not seen by ata_dev_identify().
     ata1: dev 1 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
       ata1: no dma/lba   ==> incorrect dev->id[] dumped by ata_dev_identify()
     ata1: dev 1 not supported, ignoring
ata_dev_identify: EXIT, err

---------------------------------------

--- libata-dev-2.6/drivers/scsi/libata-core.c	2005-03-31 21:20:17.000000000 +0800
+++ libata-dev-2.6-mod/drivers/scsi/libata-core.c	2005-04-01 11:21:22.000000000 +0800
@@ -952,7 +952,7 @@
  	unsigned int major_version;
  	u16 tmp;
  	unsigned long xfer_modes;
-	u8 status;
+	u8 status = 0;
  	unsigned int using_edd;
  	DECLARE_COMPLETION(wait);
  	struct ata_queued_cmd *qc;
@@ -995,6 +995,7 @@
  	}

  	qc->waiting = &wait;
+	qc->private_data = &status;
  	qc->complete_fn = ata_qc_complete_noop;

  	spin_lock_irqsave(&ap->host_set->lock, flags);
@@ -1006,7 +1007,6 @@
  	else
  		wait_for_completion(&wait);

-	status = ata_chk_status(ap);
  	if (status & ATA_ERR) {
  		/*
  		 * arg!  EDD works for all test cases, but seems to return
@@ -2496,8 +2496,7 @@
  	assert(qc != NULL);

  	drv_stat = ata_chk_status(ap);
-	printk(KERN_WARNING "ata%u: PIO error, drv_stat 0x%x\n",
-	       ap->id, drv_stat);
+	DPRINTK("ata%u: PIO error, drv_stat 0x%x\n", ap->id, drv_stat);

  	ap->pio_task_state = PIO_ST_IDLE;

@@ -2770,6 +2769,7 @@

  static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
  {
+	*((u8*)qc->private_data) = drv_stat;
  	return 0;
  }



--------------050408050801030203040802
Content-Type: text/plain;
 name="id_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="id_fix.diff"

--- libata-dev-2.6/drivers/scsi/libata-core.c	2005-03-31 21:20:17.000000000 +0800
+++ libata-dev-2.6-mod/drivers/scsi/libata-core.c	2005-04-01 11:21:22.000000000 +0800
@@ -952,7 +952,7 @@
 	unsigned int major_version;
 	u16 tmp;
 	unsigned long xfer_modes;
-	u8 status;
+	u8 status = 0;
 	unsigned int using_edd;
 	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
@@ -995,6 +995,7 @@
 	}
 
 	qc->waiting = &wait;
+	qc->private_data = &status;
 	qc->complete_fn = ata_qc_complete_noop;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
@@ -1006,7 +1007,6 @@
 	else
 		wait_for_completion(&wait);
 
-	status = ata_chk_status(ap);
 	if (status & ATA_ERR) {
 		/*
 		 * arg!  EDD works for all test cases, but seems to return
@@ -2496,8 +2496,7 @@
 	assert(qc != NULL);
 
 	drv_stat = ata_chk_status(ap);
-	printk(KERN_WARNING "ata%u: PIO error, drv_stat 0x%x\n",
-	       ap->id, drv_stat);
+	DPRINTK("ata%u: PIO error, drv_stat 0x%x\n", ap->id, drv_stat);
 
 	ap->pio_task_state = PIO_ST_IDLE;
 
@@ -2770,6 +2769,7 @@
 
 static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
 {
+	*((u8*)qc->private_data) = drv_stat;
 	return 0;
 }
 

--------------050408050801030203040802--


