From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: [PATCH 2/3] libata - PIO error handling fix
Date: Wed, 15 Dec 2004 17:50:59 +0800
Message-ID: <003901c4e28b$95c00f20$f17a4109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0036_01C4E2CE.A2AE9FB0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:26351 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262317AbULOJvC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Dec 2004 04:51:02 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.

------=_NextPart_000_0036_01C4E2CE.A2AE9FB0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

Hi, Jeff:

  Tested burning CD-RW with libata-dev-2.6 and cdrecord:
1. ATAPI DMA mode - tested OK
2. ATAPI PIO mode - test failed when cdrecord finishes burning and issues MODE_SELECT to the device.

  After checking the log, it showed that MODE_SELECT caused ata_pio_complete() to return error.
However, the error is not handled by ata_pio_task().

Attached please find the patch for ata_pio_task() error handling for your review.
(The patch is against the libata-dev-2.6 tree. )

Changes in the patch:
1. End the PIO task when PIO_ST_IDLE state is entered
2. End the PIO task after PIO_ST_TMOUT and PIO_ST_ERR state handled by ata_pio_error()
3. Remove the first "if" statement to handle the error condition returned from 
  ata_pio_block(), ata_pio_complete() and ata_pio_poll().

  Change #2  is not so necessary since ata_pio_error() will put the cmd to  PIO_ST_IDLE state
after the error condition is handled. The change just saves a function call to queue_work().

Tested OK on on my machine with pdc20275 and ASUS CD-RW drive.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
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

------=_NextPart_000_0036_01C4E2CE.A2AE9FB0
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

------=_NextPart_000_0036_01C4E2CE.A2AE9FB0--

