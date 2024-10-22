Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A3C2C8
	for <linux-ide@vger.kernel.org>; Tue, 22 Oct 2024 02:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729565144; cv=none; b=CElLh3IYiDc3e/7/DK2aSOxMITy3sDHrHZmoFgwtmFs/HVxzJpk+Tz98URiFAszD1xDobjq8vzXMYc6+muoRaK5D7FwSACYsquBLqkwAM7k4e6aW/1dGRL5qTLdbmhJC4eiDleqdIOGU6N5mq7rXHOI2YFxweTrf8AYAzx9/FCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729565144; c=relaxed/simple;
	bh=fK5CAIwc9XbxEPI3s8K2Bb586R9KKhpi+LehwGW0tc8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfyI7G1Ugc/1Ln5/wQ/i0B2O1VUAapHglbp0EAdpGe6U1zMQ2hsvoD80VbqiXtBOvHMrmcMIExnEUZ/X+zgI4v+mFwsJGj3dtl6EPoFhjXfeJRdsOD9VZZ1aw1CY2WGYdLzAyEomi5czIJKQk1t25QGoSP0ntUipROsZG+J4gTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWBDZGQh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWBDZGQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF69C4CEC3;
	Tue, 22 Oct 2024 02:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729565143;
	bh=fK5CAIwc9XbxEPI3s8K2Bb586R9KKhpi+LehwGW0tc8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hWBDZGQhcVvzZtCYPXoY77K6UUpkY+g5tWo+Bf05ig6jxY9HM2qaJ5vFxaCdV5k4j
	 snN2trpa+6hFGmL38U10Tttm4ZuyXImswHiA9VFzwGcfJXf4LDKgtKuPteJ1E7ECU6
	 b3CzBPgdAiCeXJZpT9PLuoKqMm1pKzRNy2USvwmvmVWflYFxkqTd4pMZp+M4GNWjG0
	 O/4ZsG2cukXupnSwswbtjr3DaJD4gHlJgaSaGlIS16sTkdDseSQ7vEv0I3kkI5LEok
	 3GBZRl8FlfMztqrCQAhmF4WiPsImhwVI2kaCwERq5kl2JH+AnbMLVSUHK+51FrEBj9
	 H8qOwUBCU5WBA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 5/6] ata: libata-scsi: Remove struct ata_scsi_args
Date: Tue, 22 Oct 2024 11:45:36 +0900
Message-ID: <20241022024537.251905-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022024537.251905-1-dlemoal@kernel.org>
References: <20241022024537.251905-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The data structure struct ata_scsi_args is used to pass the target ATA
device, the SCSI command to simulate and the device identification data
to ata_scsi_rbuf_fill() and to its actor function. This method of
passing information does not improve the code in any way and in fact
increases the number of pointer dereferences for no gains.

Drop this data structure by modifying the interface of
ata_scsi_rbuf_fill() and its actor function to take an ATA device and a
SCSI command as argument.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 241 ++++++++++++++++++++------------------
 1 file changed, 127 insertions(+), 114 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 880a1e20a8dd..4593258d2b6a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1772,15 +1772,10 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 		return SCSI_MLQUEUE_HOST_BUSY;
 }
 
-struct ata_scsi_args {
-	struct ata_device	*dev;
-	u16			*id;
-	struct scsi_cmnd	*cmd;
-};
-
 /**
  *	ata_scsi_rbuf_fill - wrapper for SCSI command simulators
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@actor: Callback hook for desired SCSI command simulator
  *
  *	Takes care of the hard work of simulating a SCSI command...
@@ -1793,30 +1788,30 @@ struct ata_scsi_args {
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
-		unsigned int (*actor)(struct ata_scsi_args *args, u8 *rbuf))
+static void ata_scsi_rbuf_fill(struct ata_device *dev, struct scsi_cmnd *cmd,
+		unsigned int (*actor)(struct ata_device *dev,
+				      struct scsi_cmnd *cmd, u8 *rbuf))
 {
 	unsigned int rc;
-	struct scsi_cmnd *cmd = args->cmd;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
 
 	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
-	rc = actor(args, ata_scsi_rbuf);
-	if (rc == 0)
+	rc = actor(dev, cmd, ata_scsi_rbuf);
+	if (rc == 0) {
 		sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
 				    ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
+		cmd->result = SAM_STAT_GOOD;
+	}
 
 	spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
-
-	if (rc == 0)
-		cmd->result = SAM_STAT_GOOD;
 }
 
 /**
  *	ata_scsiop_inq_std - Simulate standard INQUIRY command
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Returns standard device identification data associated
@@ -1825,7 +1820,8 @@ static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_inq_std(struct ata_device *dev,
+				       struct scsi_cmnd *cmd, u8 *rbuf)
 {
 	static const u8 versions[] = {
 		0x00,
@@ -1866,30 +1862,30 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 	 * Set the SCSI Removable Media Bit (RMB) if the ATA removable media
 	 * device bit (obsolete since ATA-8 ACS) is set.
 	 */
-	if (ata_id_removable(args->id))
+	if (ata_id_removable(dev->id))
 		hdr[1] |= (1 << 7);
 
-	if (args->dev->class == ATA_DEV_ZAC) {
+	if (dev->class == ATA_DEV_ZAC) {
 		hdr[0] = TYPE_ZBC;
 		hdr[2] = 0x7; /* claim SPC-5 version compatibility */
 	}
 
-	if (args->dev->flags & ATA_DFLAG_CDL)
+	if (dev->flags & ATA_DFLAG_CDL)
 		hdr[2] = 0xd; /* claim SPC-6 version compatibility */
 
 	memcpy(rbuf, hdr, sizeof(hdr));
 	memcpy(&rbuf[8], "ATA     ", 8);
-	ata_id_string(args->id, &rbuf[16], ATA_ID_PROD, 16);
+	ata_id_string(dev->id, &rbuf[16], ATA_ID_PROD, 16);
 
 	/* From SAT, use last 2 words from fw rev unless they are spaces */
-	ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV + 2, 4);
+	ata_id_string(dev->id, &rbuf[32], ATA_ID_FW_REV + 2, 4);
 	if (strncmp(&rbuf[32], "    ", 4) == 0)
-		ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV, 4);
+		ata_id_string(dev->id, &rbuf[32], ATA_ID_FW_REV, 4);
 
 	if (rbuf[32] == 0 || rbuf[32] == ' ')
 		memcpy(&rbuf[32], "n/a ", 4);
 
-	if (ata_id_zoned_cap(args->id) || args->dev->class == ATA_DEV_ZAC)
+	if (ata_id_zoned_cap(dev->id) || dev->class == ATA_DEV_ZAC)
 		memcpy(rbuf + 58, versions_zbc, sizeof(versions_zbc));
 	else
 		memcpy(rbuf + 58, versions, sizeof(versions));
@@ -1899,7 +1895,8 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 
 /**
  *	ata_scsiop_inq_00 - Simulate INQUIRY VPD page 0, list of pages
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Returns list of inquiry VPD pages available.
@@ -1907,7 +1904,8 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_00(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_inq_00(struct ata_device *dev,
+				      struct scsi_cmnd *cmd, u8 *rbuf)
 {
 	int i, num_pages = 0;
 	static const u8 pages[] = {
@@ -1924,7 +1922,7 @@ static unsigned int ata_scsiop_inq_00(struct ata_scsi_args *args, u8 *rbuf)
 
 	for (i = 0; i < sizeof(pages); i++) {
 		if (pages[i] == 0xb6 &&
-		    !(args->dev->flags & ATA_DFLAG_ZAC))
+		    !(dev->flags & ATA_DFLAG_ZAC))
 			continue;
 		rbuf[num_pages + 4] = pages[i];
 		num_pages++;
@@ -1935,7 +1933,8 @@ static unsigned int ata_scsiop_inq_00(struct ata_scsi_args *args, u8 *rbuf)
 
 /**
  *	ata_scsiop_inq_80 - Simulate INQUIRY VPD page 80, device serial number
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Returns ATA device serial number.
@@ -1943,7 +1942,8 @@ static unsigned int ata_scsiop_inq_00(struct ata_scsi_args *args, u8 *rbuf)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_80(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_inq_80(struct ata_device *dev,
+				      struct scsi_cmnd *cmd, u8 *rbuf)
 {
 	static const u8 hdr[] = {
 		0,
@@ -1953,14 +1953,15 @@ static unsigned int ata_scsiop_inq_80(struct ata_scsi_args *args, u8 *rbuf)
 	};
 
 	memcpy(rbuf, hdr, sizeof(hdr));
-	ata_id_string(args->id, (unsigned char *) &rbuf[4],
+	ata_id_string(dev->id, (unsigned char *) &rbuf[4],
 		      ATA_ID_SERNO, ATA_ID_SERNO_LEN);
 	return 0;
 }
 
 /**
  *	ata_scsiop_inq_83 - Simulate INQUIRY VPD page 83, device identity
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Yields two logical unit device identification designators:
@@ -1971,7 +1972,8 @@ static unsigned int ata_scsiop_inq_80(struct ata_scsi_args *args, u8 *rbuf)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_inq_83(struct ata_device *dev,
+				      struct scsi_cmnd *cmd, u8 *rbuf)
 {
 	const int sat_model_serial_desc_len = 68;
 	int num;
@@ -1983,7 +1985,7 @@ static unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf)
 	rbuf[num + 0] = 2;
 	rbuf[num + 3] = ATA_ID_SERNO_LEN;
 	num += 4;
-	ata_id_string(args->id, (unsigned char *) rbuf + num,
+	ata_id_string(dev->id, (unsigned char *) rbuf + num,
 		      ATA_ID_SERNO, ATA_ID_SERNO_LEN);
 	num += ATA_ID_SERNO_LEN;
 
@@ -1995,21 +1997,21 @@ static unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf)
 	num += 4;
 	memcpy(rbuf + num, "ATA     ", 8);
 	num += 8;
-	ata_id_string(args->id, (unsigned char *) rbuf + num, ATA_ID_PROD,
+	ata_id_string(dev->id, (unsigned char *) rbuf + num, ATA_ID_PROD,
 		      ATA_ID_PROD_LEN);
 	num += ATA_ID_PROD_LEN;
-	ata_id_string(args->id, (unsigned char *) rbuf + num, ATA_ID_SERNO,
+	ata_id_string(dev->id, (unsigned char *) rbuf + num, ATA_ID_SERNO,
 		      ATA_ID_SERNO_LEN);
 	num += ATA_ID_SERNO_LEN;
 
-	if (ata_id_has_wwn(args->id)) {
+	if (ata_id_has_wwn(dev->id)) {
 		/* SAT defined lu world wide name */
 		/* piv=0, assoc=lu, code_set=binary, designator=NAA */
 		rbuf[num + 0] = 1;
 		rbuf[num + 1] = 3;
 		rbuf[num + 3] = ATA_ID_WWN_LEN;
 		num += 4;
-		ata_id_string(args->id, (unsigned char *) rbuf + num,
+		ata_id_string(dev->id, (unsigned char *) rbuf + num,
 			      ATA_ID_WWN, ATA_ID_WWN_LEN);
 		num += ATA_ID_WWN_LEN;
 	}
@@ -2019,7 +2021,8 @@ static unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf)
 
 /**
  *	ata_scsiop_inq_89 - Simulate INQUIRY VPD page 89, ATA info
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Yields SAT-specified ATA VPD page.
@@ -2027,7 +2030,8 @@ static unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_inq_89(struct ata_device *dev,
+				      struct scsi_cmnd *cmd, u8 *rbuf)
 {
 	rbuf[1] = 0x89;			/* our page code */
 	rbuf[2] = (0x238 >> 8);		/* page size fixed at 238h */
@@ -2048,13 +2052,14 @@ static unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf)
 
 	rbuf[56] = ATA_CMD_ID_ATA;
 
-	memcpy(&rbuf[60], &args->id[0], 512);
+	memcpy(&rbuf[60], &dev->id[0], 512);
 	return 0;
 }
 
 /**
  *	ata_scsiop_inq_b0 - Simulate INQUIRY VPD page B0, Block Limits
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Return data for the VPD page B0h (Block Limits).
@@ -2062,9 +2067,9 @@ static unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_b0(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_inq_b0(struct ata_device *dev,
+				      struct scsi_cmnd *cmd, u8 *rbuf)
 {
-	struct ata_device *dev = args->dev;
 	u16 min_io_sectors;
 
 	rbuf[1] = 0xb0;
@@ -2077,7 +2082,7 @@ static unsigned int ata_scsiop_inq_b0(struct ata_scsi_args *args, u8 *rbuf)
 	 * logical than physical sector size we need to figure out what the
 	 * latter is.
 	 */
-	min_io_sectors = 1 << ata_id_log2_per_physical_sector(args->id);
+	min_io_sectors = 1 << ata_id_log2_per_physical_sector(dev->id);
 	put_unaligned_be16(min_io_sectors, &rbuf[6]);
 
 	/*
@@ -2089,7 +2094,7 @@ static unsigned int ata_scsiop_inq_b0(struct ata_scsi_args *args, u8 *rbuf)
 	 * that we support some form of unmap - in thise case via WRITE SAME
 	 * with the unmap bit set.
 	 */
-	if (ata_id_has_trim(args->id)) {
+	if (ata_id_has_trim(dev->id)) {
 		u64 max_blocks = 65535 * ATA_MAX_TRIM_RNUM;
 
 		if (dev->quirks & ATA_QUIRK_MAX_TRIM_128M)
@@ -2105,7 +2110,8 @@ static unsigned int ata_scsiop_inq_b0(struct ata_scsi_args *args, u8 *rbuf)
 /**
  *	ata_scsiop_inq_b1 - Simulate INQUIRY VPD page B1, Block Device
  *			    Characteristics
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Return data for the VPD page B1h (Block Device Characteristics).
@@ -2113,11 +2119,12 @@ static unsigned int ata_scsiop_inq_b0(struct ata_scsi_args *args, u8 *rbuf)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_b1(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_inq_b1(struct ata_device *dev,
+				      struct scsi_cmnd *cmd, u8 *rbuf)
 {
-	int form_factor = ata_id_form_factor(args->id);
-	int media_rotation_rate = ata_id_rotation_rate(args->id);
-	u8 zoned = ata_id_zoned_cap(args->id);
+	int form_factor = ata_id_form_factor(dev->id);
+	int media_rotation_rate = ata_id_rotation_rate(dev->id);
+	u8 zoned = ata_id_zoned_cap(dev->id);
 
 	rbuf[1] = 0xb1;
 	rbuf[3] = 0x3c;
@@ -2133,7 +2140,8 @@ static unsigned int ata_scsiop_inq_b1(struct ata_scsi_args *args, u8 *rbuf)
 /**
  *	ata_scsiop_inq_b2 - Simulate INQUIRY VPD page B2, Logical Block
  *			    Provisioning
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Return data for the VPD page B2h (Logical Block Provisioning).
@@ -2141,7 +2149,8 @@ static unsigned int ata_scsiop_inq_b1(struct ata_scsi_args *args, u8 *rbuf)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_b2(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_inq_b2(struct ata_device *dev,
+				      struct scsi_cmnd *cmd, u8 *rbuf)
 {
 	/* SCSI Thin Provisioning VPD page: SBC-3 rev 22 or later */
 	rbuf[1] = 0xb2;
@@ -2154,7 +2163,8 @@ static unsigned int ata_scsiop_inq_b2(struct ata_scsi_args *args, u8 *rbuf)
 /**
  *	ata_scsiop_inq_b6 - Simulate INQUIRY VPD page B6, Zoned Block Device
  *			    Characteristics
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Return data for the VPD page B2h (Zoned Block Device Characteristics).
@@ -2162,10 +2172,11 @@ static unsigned int ata_scsiop_inq_b2(struct ata_scsi_args *args, u8 *rbuf)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_b6(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_inq_b6(struct ata_device *dev,
+				      struct scsi_cmnd *cmd, u8 *rbuf)
 {
-	if (!(args->dev->flags & ATA_DFLAG_ZAC)) {
-		ata_scsi_set_invalid_field(args->dev, args->cmd, 2, 0xff);
+	if (!(dev->flags & ATA_DFLAG_ZAC)) {
+		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
 		return 1;
 	}
 
@@ -2178,11 +2189,11 @@ static unsigned int ata_scsiop_inq_b6(struct ata_scsi_args *args, u8 *rbuf)
 	/*
 	 * URSWRZ bit is only meaningful for host-managed ZAC drives
 	 */
-	if (args->dev->zac_zoned_cap & 1)
+	if (dev->zac_zoned_cap & 1)
 		rbuf[4] |= 1;
-	put_unaligned_be32(args->dev->zac_zones_optimal_open, &rbuf[8]);
-	put_unaligned_be32(args->dev->zac_zones_optimal_nonseq, &rbuf[12]);
-	put_unaligned_be32(args->dev->zac_zones_max_open, &rbuf[16]);
+	put_unaligned_be32(dev->zac_zones_optimal_open, &rbuf[8]);
+	put_unaligned_be32(dev->zac_zones_optimal_nonseq, &rbuf[12]);
+	put_unaligned_be32(dev->zac_zones_max_open, &rbuf[16]);
 
 	return 0;
 }
@@ -2190,7 +2201,8 @@ static unsigned int ata_scsiop_inq_b6(struct ata_scsi_args *args, u8 *rbuf)
 /**
  *	ata_scsiop_inq_b9 - Simulate INQUIRY VPD page B9, Concurrent Positioning
  *			    Ranges
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Return data for the VPD page B9h (Concurrent Positioning Ranges).
@@ -2198,14 +2210,15 @@ static unsigned int ata_scsiop_inq_b6(struct ata_scsi_args *args, u8 *rbuf)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inq_b9(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_inq_b9(struct ata_device *dev,
+				      struct scsi_cmnd *cmd, u8 *rbuf)
 {
-	struct ata_cpr_log *cpr_log = args->dev->cpr_log;
+	struct ata_cpr_log *cpr_log = dev->cpr_log;
 	u8 *desc = &rbuf[64];
 	int i;
 
 	if (!cpr_log) {
-		ata_scsi_set_invalid_field(args->dev, args->cmd, 2, 0xff);
+		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
 		return 1;
 	}
 
@@ -2225,7 +2238,8 @@ static unsigned int ata_scsiop_inq_b9(struct ata_scsi_args *args, u8 *rbuf)
 
 /**
  *	ata_scsiop_inquiry - Simulate INQUIRY command
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Returns data associated with an INQUIRY command output.
@@ -2233,10 +2247,9 @@ static unsigned int ata_scsiop_inq_b9(struct ata_scsi_args *args, u8 *rbuf)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_inquiry(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_inquiry(struct ata_device *dev,
+				       struct scsi_cmnd *cmd, u8 *rbuf)
 {
-	struct ata_device *dev = args->dev;
-	struct scsi_cmnd *cmd = args->cmd;
 	const u8 *scsicmd = cmd->cmnd;
 
 	/* is CmdDt set?  */
@@ -2247,27 +2260,27 @@ static unsigned int ata_scsiop_inquiry(struct ata_scsi_args *args, u8 *rbuf)
 
 	/* Is EVPD clear? */
 	if ((scsicmd[1] & 1) == 0)
-		return ata_scsiop_inq_std(args, rbuf);
+		return ata_scsiop_inq_std(dev, cmd, rbuf);
 
 	switch (scsicmd[2]) {
 	case 0x00:
-		return ata_scsiop_inq_00(args, rbuf);
+		return ata_scsiop_inq_00(dev, cmd, rbuf);
 	case 0x80:
-		return ata_scsiop_inq_80(args, rbuf);
+		return ata_scsiop_inq_80(dev, cmd, rbuf);
 	case 0x83:
-		return ata_scsiop_inq_83(args, rbuf);
+		return ata_scsiop_inq_83(dev, cmd, rbuf);
 	case 0x89:
-		return ata_scsiop_inq_89(args, rbuf);
+		return ata_scsiop_inq_89(dev, cmd, rbuf);
 	case 0xb0:
-		return ata_scsiop_inq_b0(args, rbuf);
+		return ata_scsiop_inq_b0(dev, cmd, rbuf);
 	case 0xb1:
-		return ata_scsiop_inq_b1(args, rbuf);
+		return ata_scsiop_inq_b1(dev, cmd, rbuf);
 	case 0xb2:
-		return ata_scsiop_inq_b2(args, rbuf);
+		return ata_scsiop_inq_b2(dev, cmd, rbuf);
 	case 0xb6:
-		return ata_scsiop_inq_b6(args, rbuf);
+		return ata_scsiop_inq_b6(dev, cmd, rbuf);
 	case 0xb9:
-		return ata_scsiop_inq_b9(args, rbuf);
+		return ata_scsiop_inq_b9(dev, cmd, rbuf);
 	default:
 		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
 		return 1;
@@ -2494,7 +2507,8 @@ static unsigned int ata_msense_rw_recovery(u8 *buf, bool changeable)
 
 /**
  *	ata_scsiop_mode_sense - Simulate MODE SENSE 6, 10 commands
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Simulate MODE SENSE commands. Assume this is invoked for direct
@@ -2504,10 +2518,10 @@ static unsigned int ata_msense_rw_recovery(u8 *buf, bool changeable)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_mode_sense(struct ata_device *dev,
+					  struct scsi_cmnd *cmd, u8 *rbuf)
 {
-	struct ata_device *dev = args->dev;
-	u8 *scsicmd = args->cmd->cmnd, *p = rbuf;
+	u8 *scsicmd = cmd->cmnd, *p = rbuf;
 	static const u8 sat_blk_desc[] = {
 		0, 0, 0, 0,	/* number of blocks: sat unspecified */
 		0,
@@ -2572,17 +2586,17 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
 		break;
 
 	case CACHE_MPAGE:
-		p += ata_msense_caching(args->id, p, page_control == 1);
+		p += ata_msense_caching(dev->id, p, page_control == 1);
 		break;
 
 	case CONTROL_MPAGE:
-		p += ata_msense_control(args->dev, p, spg, page_control == 1);
+		p += ata_msense_control(dev, p, spg, page_control == 1);
 		break;
 
 	case ALL_MPAGES:
 		p += ata_msense_rw_recovery(p, page_control == 1);
-		p += ata_msense_caching(args->id, p, page_control == 1);
-		p += ata_msense_control(args->dev, p, spg, page_control == 1);
+		p += ata_msense_caching(dev->id, p, page_control == 1);
+		p += ata_msense_control(dev, p, spg, page_control == 1);
 		break;
 
 	default:		/* invalid page code */
@@ -2611,18 +2625,19 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
 	return 0;
 
 invalid_fld:
-	ata_scsi_set_invalid_field(dev, args->cmd, fp, bp);
+	ata_scsi_set_invalid_field(dev, cmd, fp, bp);
 	return 1;
 
 saving_not_supp:
-	ata_scsi_set_sense(dev, args->cmd, ILLEGAL_REQUEST, 0x39, 0x0);
+	ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST, 0x39, 0x0);
 	 /* "Saving parameters not supported" */
 	return 1;
 }
 
 /**
  *	ata_scsiop_read_cap - Simulate READ CAPACITY[ 16] commands
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Simulate READ CAPACITY commands.
@@ -2630,10 +2645,10 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
  *	LOCKING:
  *	None.
  */
-static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_read_cap(struct ata_device *dev,
+					struct scsi_cmnd *cmd, u8 *rbuf)
 {
-	struct ata_device *dev = args->dev;
-	u8 *scsicmd = args->cmd->cmnd;
+	u8 *scsicmd = cmd->cmnd;
 	u64 last_lba = dev->n_sectors - 1; /* LBA of the last block */
 	u32 sector_size; /* physical sector size in bytes */
 	u8 log2_per_phys;
@@ -2668,7 +2683,7 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 	 */
 	if (scsicmd[0] != SERVICE_ACTION_IN_16 ||
 	    (scsicmd[1] & 0x1f) != SAI_READ_CAPACITY_16) {
-		ata_scsi_set_invalid_field(dev, args->cmd, 1, 0xff);
+		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
 		return 1;
 	}
 
@@ -2688,16 +2703,16 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 	rbuf[10] = sector_size >> (8 * 1);
 	rbuf[11] = sector_size;
 
-	if (ata_id_zoned_cap(args->id) || args->dev->class == ATA_DEV_ZAC)
+	if (ata_id_zoned_cap(dev->id) || dev->class == ATA_DEV_ZAC)
 		rbuf[12] = (1 << 4); /* RC_BASIS */
 	rbuf[13] = log2_per_phys;
 	rbuf[14] = (lowest_aligned >> 8) & 0x3f;
 	rbuf[15] = lowest_aligned;
 
-	if (ata_id_has_trim(args->id) && !(dev->quirks & ATA_QUIRK_NOTRIM)) {
+	if (ata_id_has_trim(dev->id) && !(dev->quirks & ATA_QUIRK_NOTRIM)) {
 		rbuf[14] |= 0x80; /* LBPME */
 
-		if (ata_id_has_zero_after_trim(args->id) &&
+		if (ata_id_has_zero_after_trim(dev->id) &&
 		    dev->quirks & ATA_QUIRK_ZERO_AFTER_TRIM) {
 			ata_dev_info(dev, "Enabling discard_zeroes_data\n");
 			rbuf[14] |= 0x40; /* LBPRZ */
@@ -2709,7 +2724,8 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 
 /**
  *	ata_scsiop_report_luns - Simulate REPORT LUNS command
- *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Simulate REPORT LUNS command.
@@ -2717,7 +2733,8 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_report_luns(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_report_luns(struct ata_device *dev,
+					   struct scsi_cmnd *cmd, u8 *rbuf)
 {
 	rbuf[3] = 8;	/* just one lun, LUN 0, size 8 bytes */
 
@@ -3429,7 +3446,8 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 
 /**
  *	ata_scsiop_maint_in - Simulate a subset of MAINTENANCE_IN
- *	@args: device MAINTENANCE_IN data / SCSI command of interest.
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
  *	Yields a subset to satisfy scsi_report_opcode()
@@ -3437,20 +3455,20 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static unsigned int ata_scsiop_maint_in(struct ata_scsi_args *args, u8 *rbuf)
+static unsigned int ata_scsiop_maint_in(struct ata_device *dev,
+					struct scsi_cmnd *cmd, u8 *rbuf)
 {
-	struct ata_device *dev = args->dev;
-	u8 *cdb = args->cmd->cmnd;
+	u8 *cdb = cmd->cmnd;
 	u8 supported = 0, cdlp = 0, rwcdlp = 0;
 
 	if ((cdb[1] & 0x1f) != MI_REPORT_SUPPORTED_OPERATION_CODES) {
-		ata_scsi_set_invalid_field(dev, args->cmd, 1, 0xff);
+		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
 		return 1;
 	}
 
 	if (cdb[2] != 1 && cdb[2] != 3) {
 		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
-		ata_scsi_set_invalid_field(dev, args->cmd, 1, 0xff);
+		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
 		return 1;
 	}
 
@@ -4384,31 +4402,26 @@ EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 
 void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 {
-	struct ata_scsi_args args;
 	const u8 *scsicmd = cmd->cmnd;
 	u8 tmp8;
 
-	args.dev = dev;
-	args.id = dev->id;
-	args.cmd = cmd;
-
 	switch(scsicmd[0]) {
 	case INQUIRY:
-		ata_scsi_rbuf_fill(&args, ata_scsiop_inquiry);
+		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_inquiry);
 		break;
 
 	case MODE_SENSE:
 	case MODE_SENSE_10:
-		ata_scsi_rbuf_fill(&args, ata_scsiop_mode_sense);
+		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_mode_sense);
 		break;
 
 	case READ_CAPACITY:
 	case SERVICE_ACTION_IN_16:
-		ata_scsi_rbuf_fill(&args, ata_scsiop_read_cap);
+		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_read_cap);
 		break;
 
 	case REPORT_LUNS:
-		ata_scsi_rbuf_fill(&args, ata_scsiop_report_luns);
+		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_report_luns);
 		break;
 
 	case REQUEST_SENSE:
@@ -4436,7 +4449,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 		break;
 
 	case MAINTENANCE_IN:
-		ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
+		ata_scsi_rbuf_fill(dev, cmd, ata_scsiop_maint_in);
 		break;
 
 	/* all other commands */
-- 
2.47.0

