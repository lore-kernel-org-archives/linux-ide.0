From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: [PATCH] libata: Use ATAPI PIO mode for specific request buffer sizes
Date: Tue, 30 Nov 2004 16:44:31 +0800
Message-ID: <00ce01c4d6b8$d222d080$bc604109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00CB_01C4D6FB.DD5F6B50"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:34287 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262017AbUK3Io6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Nov 2004 03:44:58 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.

------=_NextPart_000_00CB_01C4D6FB.DD5F6B50
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

Hi, Jeff:

  After some testing, it seems that some PATA host adapter (ex. pdc20275) cannot 
work reliably with specific request buffer sizes under ATAPI DMA mode.

Detailed test result:
4096, 2048, 1024, 512, 256: OK
384, 257, 255, 128, 96, 64, 32:  failed (irq lost)

  It seems multiple of 256 bytes are the safe ATAPI DMA buffer sizes to use.

Attached please find the patch against libata-dev-2.6 for your review.
Two changes:
1. Use ATAPI PIO mode for ATAPI REQUEST_SENSE
2. Use ATAPI PIO mode for specific SCSI commands issued to ATAPI device that
    buffer_size % 256 != 0.

  Since for most commands, buffer_size % 256 is 0,  this patch
won't introduce big impact to the performance of libata (hopefully).
  
  Tested OK on on my machine with pdc20275 and ASUS CD-RW drive.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---------------------------------------------------------------------
diff -Nru libata-dev-2.6-ori/drivers/scsi/libata-core.c libata-dev-2.6/drivers/scsi/libata-core.c
--- libata-dev-2.6-ori/drivers/scsi/libata-core.c 2004-11-30 12:52:28.000000000 +0800
+++ libata-dev-2.6/drivers/scsi/libata-core.c 2004-11-30 13:49:36.000000000 +0800
@@ -2435,7 +2435,6 @@
  DECLARE_COMPLETION(wait);
  struct ata_queued_cmd *qc;
  unsigned long flags;
- int using_pio = dev->flags & ATA_DFLAG_PIO;
  int rc;
 
  DPRINTK("ATAPI request sense\n");
@@ -2456,16 +2455,10 @@
  qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
  qc->tf.command = ATA_CMD_PACKET;
 
- if (using_pio) {
-  qc->tf.protocol = ATA_PROT_ATAPI;
-  qc->tf.lbam = (8 * 1024) & 0xff;
-  qc->tf.lbah = (8 * 1024) >> 8;
-
-  qc->nbytes = SCSI_SENSE_BUFFERSIZE;
- } else {
-  qc->tf.protocol = ATA_PROT_ATAPI_DMA;
-  qc->tf.feature |= ATAPI_PKT_DMA;
- }
+ qc->tf.protocol = ATA_PROT_ATAPI;
+ qc->tf.lbam = (8 * 1024) & 0xff;
+ qc->tf.lbah = (8 * 1024) >> 8;
+ qc->nbytes = SCSI_SENSE_BUFFERSIZE;
 
  qc->waiting = &wait;
  qc->complete_fn = ata_qc_complete_noop;
diff -Nru libata-dev-2.6-ori/drivers/scsi/libata-scsi.c libata-dev-2.6/drivers/scsi/libata-scsi.c
--- libata-dev-2.6-ori/drivers/scsi/libata-scsi.c 2004-11-30 12:52:28.000000000 +0800
+++ libata-dev-2.6/drivers/scsi/libata-scsi.c 2004-11-30 15:37:38.584941309 +0800
@@ -1558,6 +1558,10 @@
  int using_pio = (dev->flags & ATA_DFLAG_PIO);
  int nodata = (cmd->sc_data_direction == SCSI_DATA_NONE);
 
+ /* Use ATAPI PIO for specific buffer sizes */
+ if (cmd->request_bufflen % 256)
+  using_pio = 1;
+
  memcpy(&qc->cdb, scsicmd, qc->ap->cdb_len);
 
  qc->complete_fn = atapi_qc_complete;

----- Original Message ----- 
From: "Albert Lee" <albertcc@tw.ibm.com>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>; "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Doug Maxey" <dwm@maxeymade.com>; "IDE Linux" <linux-ide@vger.kernel.org>
Sent: Tuesday, November 16, 2004 5:03 PM
Subject: libata-dev-2.6 ATAPI interrupt lost problem with pdc2027x under UDMA mode


> Hi,
>   I am testing ATAPI device with libata-dev.2.6 code and the pdc2027x driver.
> 
> Environment:
> - pdc20275 on the MSI P4HS-4 mainboard
> - Maxtor 6Y080L0 as primary dev0
> - Seagate ST380011A as primary dev1
> - Asus CRW-5232AS as secondard dev0
> 
> The following are the results:
> 
> 1. All the harddisk drives works fine with either PIO or DMA
> 2. For the ATAPI device, READ and other commands works fine with ATAPI UDMA protocol.
>    However, when REQUEST_SENSE / MODE_SENSE is issued to the CD-RW drive with
>    ATAPI DMA protocol, the interrupt is lost. 
> 3. All commands, including REQUEST_SENSE/MODE_SENSE, work fine with ATAPI PIO protocol.
> 4. PIIX and the same Asus drive work fine, both UDMA and PIO.
> 
> For the problem of lost interrupt, I've checked the pdc2027x global control register (which shows 
> the status of INTRQ and DMARQ directly), the Asus drive already report INTRQ and 
> said UDMA completed.  However, pdc20275 does not report interrupt and said DMA on going.
> 
> Any clue or idea for this problem? Thanks.
> Albert
> =============================================================
> (dmesg log attached)
> ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 60 00 20 00 00
> atapi_xlat: nodata[0]
> ata_sg_setup_one: mapped buffer of 96 bytes for read
> ata_exec_command_pio: ata2: cmd 0xA0
> atapi_packet_task: busy wait
> atapi_packet_task: send cdb
> ata_host_intr: ata2: protocol 7 (dev_stat 0x50)        => "inquiry" is successful
> ata_sg_clean: unmapping 1 sg elements
>   Vendor: ASUS      Model: CRW-5232AS        Rev: 1.02
>   Type:   CD-ROM                             ANSI SCSI revision: 05
> ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
> ata_exec_command_pio: ata2: cmd 0xA0
> atapi_packet_task: busy wait
> atapi_packet_task: send cdb
> ata_host_intr: ata2: protocol 6 (dev_stat 0x50)   => "test unit ready" is successful
> ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 2a 00 00 00 00 00 80  => "mode sense" fails 
> atapi_xlat: nodata[0]
> ata_sg_setup_one: mapped buffer of 128 bytes for read
> ata_exec_command_pio: ata2: cmd 0xA0
> atapi_packet_task: busy wait
> atapi_packet_task: send cdb
> ata_scsi_error: ENTER                 => Promise pdc2027x timeout here. Interrupt lost. (PIIX works.)
> ata_eng_timeout: ENTER
> ata_qc_timeout: ENTER
> ata2: command 0xa0 timeout, stat 0x50 host_stat 0x1  => Device: OK, host: DMA on going.
> ata_sg_clean: unmapping 1 sg elements
> ata_qc_timeout: EXIT
> ata_eng_timeout: EXIT
> ata_scsi_error: EXIT
> sr0: scsi3-mmc drive: 0x/0x caddy 
> => should be   sr0: scsi3-mmc drive: 52x/52x writer cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.20
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
------=_NextPart_000_00CB_01C4D6FB.DD5F6B50
Content-Type: application/octet-stream;
	name="atapi_dma.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="atapi_dma.patch"

diff -Nru libata-dev-2.6-ori/drivers/scsi/libata-core.c =
libata-dev-2.6/drivers/scsi/libata-core.c=0A=
--- libata-dev-2.6-ori/drivers/scsi/libata-core.c	2004-11-30 =
12:52:28.000000000 +0800=0A=
+++ libata-dev-2.6/drivers/scsi/libata-core.c	2004-11-30 =
13:49:36.000000000 +0800=0A=
@@ -2435,7 +2435,6 @@=0A=
 	DECLARE_COMPLETION(wait);=0A=
 	struct ata_queued_cmd *qc;=0A=
 	unsigned long flags;=0A=
-	int using_pio =3D dev->flags & ATA_DFLAG_PIO;=0A=
 	int rc;=0A=
 =0A=
 	DPRINTK("ATAPI request sense\n");=0A=
@@ -2456,16 +2455,10 @@=0A=
 	qc->tf.flags |=3D ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;=0A=
 	qc->tf.command =3D ATA_CMD_PACKET;=0A=
 =0A=
-	if (using_pio) {=0A=
-		qc->tf.protocol =3D ATA_PROT_ATAPI;=0A=
-		qc->tf.lbam =3D (8 * 1024) & 0xff;=0A=
-		qc->tf.lbah =3D (8 * 1024) >> 8;=0A=
-=0A=
-		qc->nbytes =3D SCSI_SENSE_BUFFERSIZE;=0A=
-	} else {=0A=
-		qc->tf.protocol =3D ATA_PROT_ATAPI_DMA;=0A=
-		qc->tf.feature |=3D ATAPI_PKT_DMA;=0A=
-	}=0A=
+	qc->tf.protocol =3D ATA_PROT_ATAPI;=0A=
+	qc->tf.lbam =3D (8 * 1024) & 0xff;=0A=
+	qc->tf.lbah =3D (8 * 1024) >> 8;=0A=
+	qc->nbytes =3D SCSI_SENSE_BUFFERSIZE;=0A=
 =0A=
 	qc->waiting =3D &wait;=0A=
 	qc->complete_fn =3D ata_qc_complete_noop;=0A=
diff -Nru libata-dev-2.6-ori/drivers/scsi/libata-scsi.c =
libata-dev-2.6/drivers/scsi/libata-scsi.c=0A=
--- libata-dev-2.6-ori/drivers/scsi/libata-scsi.c	2004-11-30 =
12:52:28.000000000 +0800=0A=
+++ libata-dev-2.6/drivers/scsi/libata-scsi.c	2004-11-30 =
15:37:38.584941309 +0800=0A=
@@ -1558,6 +1558,10 @@=0A=
 	int using_pio =3D (dev->flags & ATA_DFLAG_PIO);=0A=
 	int nodata =3D (cmd->sc_data_direction =3D=3D SCSI_DATA_NONE);=0A=
 =0A=
+	/* Use ATAPI PIO for specific buffer sizes */=0A=
+	if (cmd->request_bufflen % 256)=0A=
+		using_pio =3D 1;=0A=
+=0A=
 	memcpy(&qc->cdb, scsicmd, qc->ap->cdb_len);=0A=
 =0A=
 	qc->complete_fn =3D atapi_qc_complete;=0A=

------=_NextPart_000_00CB_01C4D6FB.DD5F6B50--

