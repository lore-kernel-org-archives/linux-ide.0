From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: [PATCH libata-dev-2.6 1/3] Add CHS support
Date: Sun, 6 Feb 2005 14:02:51 +0800
Message-ID: <006d01c50c11$81003920$a801a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_006A_01C50C54.8BF088B0"
Received: from bluehawaii.tikira.net ([61.62.22.51]:39917 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S272197AbVBFGDS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Feb 2005 01:03:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.

------=_NextPart_000_006A_01C50C54.8BF088B0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

Hi Jeff,

  These are the patches for libata CHS support. Tested OK with my old 1994 ST-5850A hardddisk.

Changes:
1. Add the flags, utility function and CHS fields to the <linux/ata.h> and <linux/libata.h> headers.

2. ata_dev_identify() pathed to report and initialize CHS fields in ata_device.
    ata_qc_new_init() patched to initialize the ATA_TFLAG_LBA to the ata_taskfile.

3. ata_scsi_verify_xlat(), ata_scsi_rw_xlat() patched to support CHS translation.
    ata_scsiop_read_cap() patched to report capacity for CHS-only drives.

  Attached please find the patch 1/3 against the libata-dev-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
----------------------------------------------------------------------------------------------
diff -Nru libata-dev-2.6/include/linux/ata.h libata-dev-2.6-mod/include/linux/ata.h
--- libata-dev-2.6/include/linux/ata.h 2005-02-05 10:42:06.000000000 +0800
+++ libata-dev-2.6-mod/include/linux/ata.h 2005-02-05 11:04:33.000000000 +0800
@@ -172,6 +172,7 @@
  ATA_TFLAG_ISADDR = (1 << 1), /* enable r/w to nsect/lba regs */
  ATA_TFLAG_DEVICE = (1 << 2), /* enable r/w to device reg */
  ATA_TFLAG_WRITE  = (1 << 3), /* data dir: host->dev==1 (write) */
+ ATA_TFLAG_LBA  = (1 << 4), /* enable LBA */
 };
 
 enum ata_tf_protocols {
@@ -241,6 +242,18 @@
    ((u64) (id)[(n) + 1] << 16) | \
    ((u64) (id)[(n) + 0]) )
 
+static inline int ata_id_current_chs_valid(u16 *id)
+{
+ /* For ATA-1 devices, if the INITIALIZE DEVICE PARAMETERS command 
+    has not been issued to the device then the values of 
+    id[54] to id[56] are vendor specific. */
+ return (id[53] & 0x01) && /* Current translation valid */
+  id[54] &&  /* cylinders in current translation */
+  id[55] &&  /* heads in current translation */
+  id[55] <= 16 &&
+  id[56];    /* sectors in current translation */
+}
+
 static inline int atapi_cdb_len(u16 *dev_id)
 {
  u16 tmp = dev_id[0] & 0x3;
diff -Nru libata-dev-2.6/include/linux/libata.h libata-dev-2.6-mod/include/linux/libata.h
--- libata-dev-2.6/include/linux/libata.h 2005-02-05 10:42:07.000000000 +0800
+++ libata-dev-2.6-mod/include/linux/libata.h 2005-02-05 11:05:58.000000000 +0800
@@ -95,6 +95,7 @@
  ATA_DFLAG_LBA48  = (1 << 0), /* device supports LBA48 */
  ATA_DFLAG_PIO  = (1 << 1), /* device currently in PIO mode */
  ATA_DFLAG_LOCK_SECTORS = (1 << 2), /* don't adjust max_sectors */
+ ATA_DFLAG_LBA  = (1 << 3), /* device supports LBA */
 
  ATA_DEV_UNKNOWN  = 0, /* unknown device */
  ATA_DEV_ATA  = 1, /* ATA device */
@@ -279,6 +280,11 @@
  u8   xfer_protocol; /* taskfile xfer protocol */
  u8   read_cmd; /* opcode to use on read */
  u8   write_cmd; /* opcode to use on write */
+
+ /* for CHS addressing */
+ u16   cylinders; /* Number of cylinders */
+ u16   heads;  /* Number of heads */
+ u16   sectors; /* Number of sectors per track */
 };
 
 struct ata_port {

------=_NextPart_000_006A_01C50C54.8BF088B0
Content-Type: application/octet-stream;
	name="chs1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="chs1.diff"

diff -Nru libata-dev-2.6/include/linux/ata.h =
libata-dev-2.6-mod/include/linux/ata.h=0A=
--- libata-dev-2.6/include/linux/ata.h	2005-02-05 10:42:06.000000000 =
+0800=0A=
+++ libata-dev-2.6-mod/include/linux/ata.h	2005-02-05 11:04:33.000000000 =
+0800=0A=
@@ -172,6 +172,7 @@=0A=
 	ATA_TFLAG_ISADDR	=3D (1 << 1), /* enable r/w to nsect/lba regs */=0A=
 	ATA_TFLAG_DEVICE	=3D (1 << 2), /* enable r/w to device reg */=0A=
 	ATA_TFLAG_WRITE		=3D (1 << 3), /* data dir: host->dev=3D=3D1 (write) */=0A=
+	ATA_TFLAG_LBA		=3D (1 << 4), /* enable LBA */=0A=
 };=0A=
 =0A=
 enum ata_tf_protocols {=0A=
@@ -241,6 +242,18 @@=0A=
 	  ((u64) (id)[(n) + 1] << 16) |	\=0A=
 	  ((u64) (id)[(n) + 0]) )=0A=
 =0A=
+static inline int ata_id_current_chs_valid(u16 *id)=0A=
+{=0A=
+	/* For ATA-1 devices, if the INITIALIZE DEVICE PARAMETERS command =0A=
+	   has not been issued to the device then the values of =0A=
+	   id[54] to id[56] are vendor specific. */=0A=
+	return (id[53] & 0x01) && /* Current translation valid */=0A=
+		id[54] &&  /* cylinders in current translation */=0A=
+		id[55] &&  /* heads in current translation */=0A=
+		id[55] <=3D 16 &&=0A=
+		id[56];    /* sectors in current translation */=0A=
+}=0A=
+=0A=
 static inline int atapi_cdb_len(u16 *dev_id)=0A=
 {=0A=
 	u16 tmp =3D dev_id[0] & 0x3;=0A=
diff -Nru libata-dev-2.6/include/linux/libata.h =
libata-dev-2.6-mod/include/linux/libata.h=0A=
--- libata-dev-2.6/include/linux/libata.h	2005-02-05 10:42:07.000000000 =
+0800=0A=
+++ libata-dev-2.6-mod/include/linux/libata.h	2005-02-05 =
11:05:58.000000000 +0800=0A=
@@ -95,6 +95,7 @@=0A=
 	ATA_DFLAG_LBA48		=3D (1 << 0), /* device supports LBA48 */=0A=
 	ATA_DFLAG_PIO		=3D (1 << 1), /* device currently in PIO mode */=0A=
 	ATA_DFLAG_LOCK_SECTORS	=3D (1 << 2), /* don't adjust max_sectors */=0A=
+	ATA_DFLAG_LBA		=3D (1 << 3), /* device supports LBA */=0A=
 =0A=
 	ATA_DEV_UNKNOWN		=3D 0,	/* unknown device */=0A=
 	ATA_DEV_ATA		=3D 1,	/* ATA device */=0A=
@@ -279,6 +280,11 @@=0A=
 	u8			xfer_protocol;	/* taskfile xfer protocol */=0A=
 	u8			read_cmd;	/* opcode to use on read */=0A=
 	u8			write_cmd;	/* opcode to use on write */=0A=
+=0A=
+	/* for CHS addressing */=0A=
+	u16			cylinders;	/* Number of cylinders */=0A=
+	u16			heads;		/* Number of heads */=0A=
+	u16			sectors;	/* Number of sectors per track */=0A=
 };=0A=
 =0A=
 struct ata_port {=0A=

------=_NextPart_000_006A_01C50C54.8BF088B0--


