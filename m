From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: [PATCH] libata PIO error handling fix
Date: Mon, 6 Dec 2004 16:46:05 +0800
Message-ID: <00bc01c4db70$07599cf0$a3564109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00B9_01C4DBB3.13E043F0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:48875 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261400AbULFIqR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Dec 2004 03:46:17 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.

------=_NextPart_000_00B9_01C4DBB3.13E043F0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

Hi, Jeff:

  I tried to burn CD-RW with libata-dev-2.6 and cdrecord:
1. ATAPI DMA mode - test OK
2. ATAPI PIO mode - test failed when cdrecord finishes burning and issues MODE_SELECT to the device.

  After checking the log, it shows that MODE_SELECT causes ata_pio_complete() to return error.
However, the error is not handled by ata_pio_task().

Attached please find the patch for ata_pio_task() error handling for your review.
(The patch is against the libata-dev-2.6 tree. )

Changes in the patch:
1. End the PIO task when PIO_ST_IDLE state is entered
2. End the PIO task after PIO_ST_TMOUT and PIO_ST_ERR state handled by ata_pio_error()
3. Remove the first "if" statement to handle the error condition returned from 
  ata_pio_block(), ata_pio_complete() and ata_pio_poll().

  Change #2  is not necessary since ata_pio_error() will put the cmd to  PIO_ST_IDLE state
after the error condition is handled. The change just saves a function call to queue_work().

Tested OK on on my machine with pdc20275 and ASUS CD-RW drive.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
------------------------------------------------------------------------------------
diff -Nru libata-dev-2.6-ori/drivers/scsi/libata-core.c libata-dev-2.6/drivers/scsi/libata-core.c
--- libata-dev-2.6-ori/drivers/scsi/libata-core.c 2004-11-30 12:52:28.000000000 +0800
+++ libata-dev-2.6/drivers/scsi/libata-core.c 2004-12-02 18:57:48.719220063 +0800
@@ -2399,6 +2399,9 @@
  unsigned long timeout = 0;
 
  switch (ap->pio_task_state) {
+ case PIO_ST_IDLE:
+  return;
+
  case PIO_ST:
   ata_pio_block(ap);
   break;
@@ -2415,18 +2418,14 @@
  case PIO_ST_TMOUT:
  case PIO_ST_ERR:
   ata_pio_error(ap);
-  break;
+  return;
  }
 
- if ((ap->pio_task_state != PIO_ST_IDLE) &&
-     (ap->pio_task_state != PIO_ST_TMOUT) &&
-     (ap->pio_task_state != PIO_ST_ERR)) {
-  if (timeout)
-   queue_delayed_work(ata_wq, &ap->pio_task,
-        timeout);
-  else
-   queue_work(ata_wq, &ap->pio_task);
- }
+ if (timeout)
+  queue_delayed_work(ata_wq, &ap->pio_task,
+       timeout);
+ else
+  queue_work(ata_wq, &ap->pio_task);
 }
 
 static void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
------=_NextPart_000_00B9_01C4DBB3.13E043F0
Content-Type: application/octet-stream;
	name="ata_pio_task.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ata_pio_task.patch"

diff -Nru libata-dev-2.6-ori/drivers/scsi/libata-core.c =
libata-dev-2.6/drivers/scsi/libata-core.c=0A=
--- libata-dev-2.6-ori/drivers/scsi/libata-core.c	2004-11-30 =
12:52:28.000000000 +0800=0A=
+++ libata-dev-2.6/drivers/scsi/libata-core.c	2004-12-02 =
18:57:48.719220063 +0800=0A=
@@ -2399,6 +2399,9 @@=0A=
 	unsigned long timeout =3D 0;=0A=
 =0A=
 	switch (ap->pio_task_state) {=0A=
+	case PIO_ST_IDLE:=0A=
+		return;=0A=
+=0A=
 	case PIO_ST:=0A=
 		ata_pio_block(ap);=0A=
 		break;=0A=
@@ -2415,18 +2418,14 @@=0A=
 	case PIO_ST_TMOUT:=0A=
 	case PIO_ST_ERR:=0A=
 		ata_pio_error(ap);=0A=
-		break;=0A=
+		return;=0A=
 	}=0A=
 =0A=
-	if ((ap->pio_task_state !=3D PIO_ST_IDLE) &&=0A=
-	    (ap->pio_task_state !=3D PIO_ST_TMOUT) &&=0A=
-	    (ap->pio_task_state !=3D PIO_ST_ERR)) {=0A=
-		if (timeout)=0A=
-			queue_delayed_work(ata_wq, &ap->pio_task,=0A=
-					   timeout);=0A=
-		else=0A=
-			queue_work(ata_wq, &ap->pio_task);=0A=
-	}=0A=
+	if (timeout)=0A=
+		queue_delayed_work(ata_wq, &ap->pio_task,=0A=
+				   timeout);=0A=
+	else=0A=
+		queue_work(ata_wq, &ap->pio_task);=0A=
 }=0A=
 =0A=
 static void atapi_request_sense(struct ata_port *ap, struct ata_device =
*dev,=0A=

------=_NextPart_000_00B9_01C4DBB3.13E043F0
Content-Type: application/octet-stream;
	name="ata_pio_complete.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ata_pio_complete.log"

Dec  2 15:42:54 p4ht-s kernel: ata_scsi_dump_cdb: CDB (1:0,0,0) 35 00 00 =
00 00 00 00 00 00=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_scsi_translate: ENTER=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_dev_select: ENTER, ata1: device 0, =
wait 1=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba =
0x0 0x0 0x20=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_tf_load_pio: device 0xA0=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_exec_command_pio: ata1: cmd 0xA0=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_scsi_translate: EXIT=0A=
Dec  2 15:42:54 p4ht-s kernel: atapi_packet_task: busy wait=0A=
Dec  2 15:42:54 p4ht-s kernel: atapi_packet_task: send cdb=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_host_intr: ata1: protocol 6 (dev_stat =
0x50)=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_qc_complete: EXIT=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 =
00 00 00 00 00 00=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_scsi_translate: ENTER=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_dev_select: ENTER, ata1: device 0, =
wait 1=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba =
0x0 0x0 0x20=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_tf_load_pio: device 0xA0=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_exec_command_pio: ata1: cmd 0xA0=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_scsi_translate: EXIT=0A=
Dec  2 15:42:54 p4ht-s kernel: atapi_packet_task: busy wait=0A=
Dec  2 15:42:54 p4ht-s kernel: atapi_packet_task: send cdb=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_host_intr: ata1: protocol 6 (dev_stat =
0x50)=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_qc_complete: EXIT=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_scsi_dump_cdb: CDB (1:0,0,0) 55 10 00 =
00 00 00 00 00 10=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_scsi_translate: ENTER=0A=
Dec  2 15:42:54 p4ht-s kernel: atapi_xlat: direction: write=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_sg_setup: ENTER, ata1=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_sg_setup: 1 sg elements mapped=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_fill_sg: PRD[0] =3D (0x10922000, 0x10)=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_dev_select: ENTER, ata1: device 0, =
wait 1=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba =
0x0 0x0 0x20=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_tf_load_pio: device 0xA0=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_exec_command_pio: ata1: cmd 0xA0=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_scsi_translate: EXIT=0A=
Dec  2 15:42:54 p4ht-s kernel: atapi_packet_task: busy wait=0A=
Dec  2 15:42:54 p4ht-s kernel: atapi_packet_task: send cdb=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_pio_task: pio_task_state: 4=0A=
Dec  2 15:42:54 p4ht-s kernel: __atapi_pio_bytes: 16 bytes data write=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_pio_task: Exit=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_pio_task: pio_task_state: 5=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_pio_complete: Enter=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_pio_complete: Exit with dev error, =
drv_stat [51] =0A=
                               <=3D ata_pio_task exits without handling =
error from ata_pio_complete=0A=
Dec  2 15:42:54 p4ht-s kernel: ata_pio_task: Exit   =0A=
 =0A=

------=_NextPart_000_00B9_01C4DBB3.13E043F0--

