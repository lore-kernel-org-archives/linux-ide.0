From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 3/4] ide: call {in|out}put_data() methods from tf_{read|load}() methods (take 3)
Date: Tue, 31 Mar 2009 22:24:14 +0400
Message-ID: <200903312224.15089.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:24675 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755902AbZCaSXp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Mar 2009 14:23:45 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Handle IDE_FTFLAG_{IN|OUT}_DATA flags in tf_{read|load}() methods by calling
{in|out}put_data() methods to transfer 2 bytes -- this will allow us to move
that handling out of those methods altogether...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Changes since take 2:
- removed no longer used mm_{inw|outw}() from ide-h8300.c...

 drivers/ide/at91_ide.c   |   13 +++++++------
 drivers/ide/ide-h8300.c  |   37 ++++++++++---------------------------
 drivers/ide/ide-io-std.c |   18 ++++++------------
 drivers/ide/ns87415.c    |    8 +++++---
 drivers/ide/scc_pata.c   |   16 ++++++++++------
 drivers/ide/tx4938ide.c  |   15 +++++++--------
 drivers/ide/tx4939ide.c  |   15 +++++++--------
 7 files changed, 52 insertions(+), 70 deletions(-)

Index: linux-2.6/drivers/ide/at91_ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/at91_ide.c
+++ linux-2.6/drivers/ide/at91_ide.c
@@ -196,9 +196,9 @@ static void at91_ide_tf_load(ide_drive_t
 		HIHI = 0xFF;
 
 	if (cmd->tf_flags & IDE_FTFLAG_OUT_DATA) {
-		u16 data = (tf->hob_data << 8) | tf->data;
+		u8 data[2] = { tf->data, tf->hob_data };
 
-		at91_ide_output_data(drive, NULL, &data, 2);
+		at91_ide_output_data(drive, cmd, data, 2);
 	}
 
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
@@ -234,11 +234,12 @@ static void at91_ide_tf_read(ide_drive_t
 	struct ide_taskfile *tf = &cmd->tf;
 
 	if (cmd->tf_flags & IDE_FTFLAG_IN_DATA) {
-		u16 data;
+		u8 data[2];
 
-		at91_ide_input_data(drive, NULL, &data, 2);
-		tf->data = data & 0xff;
-		tf->hob_data = (data >> 8) & 0xff;
+		at91_ide_input_data(drive, cmd, data, 2);
+
+		tf->data = data[0];
+		tf->hob_data = data[1];
 	}
 
 	/* be sure we're looking at the low order bits */
Index: linux-2.6/drivers/ide/ide-h8300.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-h8300.c
+++ linux-2.6/drivers/ide/ide-h8300.c
@@ -22,28 +22,6 @@
 	(r);				\
 })
 
-static void mm_outw(u16 d, unsigned long a)
-{
-	__asm__("mov.b %w0,r2h\n\t"
-		"mov.b %x0,r2l\n\t"
-		"mov.w r2,@%1"
-		:
-		:"r"(d),"r"(a)
-		:"er2");
-}
-
-static u16 mm_inw(unsigned long a)
-{
-	register u16 r __asm__("er0");
-	__asm__("mov.w @%1,r2\n\t"
-		"mov.b r2l,%x0\n\t"
-		"mov.b r2h,%w0"
-		:"=r"(r)
-		:"r"(a)
-		:"er2");
-	return r;
-}
-
 static void h8300_tf_load(ide_drive_t *drive, struct ide_cmd *cmd)
 {
 	ide_hwif_t *hwif = drive->hwif;
@@ -54,8 +32,11 @@ static void h8300_tf_load(ide_drive_t *d
 	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
-	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA)
-		mm_outw((tf->hob_data << 8) | tf->data, io_ports->data_addr);
+	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
+		u8 data[2] = { tf->data, tf->hob_data };
+
+		h8300_output_data(drive, cmd, data, 2);
+	}
 
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
 		outb(tf->hob_feature, io_ports->feature_addr);
@@ -91,10 +72,12 @@ static void h8300_tf_read(ide_drive_t *d
 	struct ide_taskfile *tf = &cmd->tf;
 
 	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
-		u16 data = mm_inw(io_ports->data_addr);
+		u8 data[2];
+
+		h8300_input_data(drive, cmd, data, 2);
 
-		tf->data = data & 0xff;
-		tf->hob_data = (data >> 8) & 0xff;
+		tf->data = data[0];
+		tf->hob_data = data[1];
 	}
 
 	/* be sure we're looking at the low order bits */
Index: linux-2.6/drivers/ide/ide-io-std.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io-std.c
+++ linux-2.6/drivers/ide/ide-io-std.c
@@ -91,12 +91,9 @@ void ide_tf_load(ide_drive_t *drive, str
 		HIHI = 0xFF;
 
 	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
-		u16 data = (tf->hob_data << 8) | tf->data;
+		u8 data[2] = { tf->data, tf->hob_data };
 
-		if (mmio)
-			writew(data, (void __iomem *)io_ports->data_addr);
-		else
-			outw(data, io_ports->data_addr);
+		ide_output_data(drive, cmd, data, 2);
 	}
 
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
@@ -145,15 +142,12 @@ void ide_tf_read(ide_drive_t *drive, str
 	}
 
 	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
-		u16 data;
+		u8 data[2];
 
-		if (mmio)
-			data = readw((void __iomem *)io_ports->data_addr);
-		else
-			data = inw(io_ports->data_addr);
+		ide_input_data(drive, cmd, data, 2);
 
-		tf->data = data & 0xff;
-		tf->hob_data = (data >> 8) & 0xff;
+		tf->data = data[0];
+		tf->hob_data = data[1];
 	}
 
 	/* be sure we're looking at the low order bits */
Index: linux-2.6/drivers/ide/ns87415.c
===================================================================
--- linux-2.6.orig/drivers/ide/ns87415.c
+++ linux-2.6/drivers/ide/ns87415.c
@@ -67,10 +67,12 @@ static void superio_tf_read(ide_drive_t 
 	struct ide_taskfile *tf = &cmd->tf;
 
 	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
-		u16 data = inw(io_ports->data_addr);
+		u8 data[2];
 
-		tf->data = data & 0xff;
-		tf->hob_data = (data >> 8) & 0xff;
+		ide_input_data(drive, cmd, data, 2);
+
+		tf->data = data[0];
+		tf->hob_data = data[1];
 	}
 
 	/* be sure we're looking at the low order bits */
Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -656,9 +656,11 @@ static void scc_tf_load(ide_drive_t *dri
 	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
-	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA)
-		out_be32((void *)io_ports->data_addr,
-			 (tf->hob_data << 8) | tf->data);
+	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
+		u8 data[2] = { tf->data, tf->hob_data };
+
+		scc_output_data(drive, NULL, data, 2);
+	}
 
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
 		scc_ide_outb(tf->hob_feature, io_ports->feature_addr);
@@ -693,10 +695,12 @@ static void scc_tf_read(ide_drive_t *dri
 	struct ide_taskfile *tf = &cmd->tf;
 
 	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
-		u16 data = (u16)in_be32((void *)io_ports->data_addr);
+		u8 data[2];
+
+		scc_input_data(drive, cmd, data, 2);
 
-		tf->data = data & 0xff;
-		tf->hob_data = (data >> 8) & 0xff;
+		tf->data = data[0];
+		tf->hob_data = data[1];
 	}
 
 	/* be sure we're looking at the low order bits */
Index: linux-2.6/drivers/ide/tx4938ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4938ide.c
+++ linux-2.6/drivers/ide/tx4938ide.c
@@ -93,10 +93,9 @@ static void tx4938ide_tf_load(ide_drive_
 		HIHI = 0xFF;
 
 	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
-		u16 data = (tf->hob_data << 8) | tf->data;
+		u8 data[2] = { tf->data, tf->hob_data };
 
-		/* no endian swap */
-		__raw_writew(data, (void __iomem *)io_ports->data_addr);
+		hwif->tp_ops->output_data(drive, cmd, data, 2);
 	}
 
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
@@ -133,12 +132,12 @@ static void tx4938ide_tf_read(ide_drive_
 	struct ide_taskfile *tf = &cmd->tf;
 
 	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
-		u16 data;
+		u8 data[2];
 
-		/* no endian swap */
-		data = __raw_readw((void __iomem *)io_ports->data_addr);
-		tf->data = data & 0xff;
-		tf->hob_data = (data >> 8) & 0xff;
+		hwif->tp_ops->input_data(drive, cmd, data, 2);
+
+		tf->data = data[0];
+		tf->hob_data = data[1];
 	}
 
 	/* be sure we're looking at the low order bits */
Index: linux-2.6/drivers/ide/tx4939ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4939ide.c
+++ linux-2.6/drivers/ide/tx4939ide.c
@@ -458,10 +458,9 @@ static void tx4939ide_tf_load(ide_drive_
 		HIHI = 0xFF;
 
 	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
-		u16 data = (tf->hob_data << 8) | tf->data;
+		u8 data[2] = { tf->data, tf->hob_data };
 
-		/* no endian swap */
-		__raw_writew(data, (void __iomem *)io_ports->data_addr);
+		hwif->tp_ops->output_data(drive, cmd, data, 2);
 	}
 
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
@@ -500,12 +499,12 @@ static void tx4939ide_tf_read(ide_drive_
 	struct ide_taskfile *tf = &cmd->tf;
 
 	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
-		u16 data;
+		u8 data[2];
 
-		/* no endian swap */
-		data = __raw_readw((void __iomem *)io_ports->data_addr);
-		tf->data = data & 0xff;
-		tf->hob_data = (data >> 8) & 0xff;
+		hwif->tp_ops->input_data(drive, cmd, data, 2);
+
+		tf->data = data[0];
+		tf->hob_data = data[1];
 	}
 
 	/* be sure we're looking at the low order bits */

