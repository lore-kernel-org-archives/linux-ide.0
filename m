Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7332BDC26
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974066; cv=none; b=cRYzcqg6nRSHYQi4DNE4aapShyaZ9ZZ6ZR3gCBI3yIjwDjZe5wcbJfKQR10HbB5Yaz6Sdqm6LB4z+RE00ZcW2eqtfS6FtPeP0gJ/nBV3KOz6rf71a/0HnOlTcJp1HenmDlqMtdwGaqqRxEQRmHmIV44RRCx2WdGtEJHeW/OtN94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974066; c=relaxed/simple;
	bh=yIl5yjIla1lUhG/xKIiDIMKXX5KNUx8Eda6atw2Do8U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaCBwQbtFzXdgBRD3YUpKqAdiEXXwKMHXSndkRbczdY51wN8koayh05BrbxRC/PWbK6bmtvxqx4WKq/5lzqQhVhnHn6RLJfSf3zkQpyy514pAXySzpAe66sCizwPa9ypqWdStvBNhz0A4QdBIBzNe/2t8QJXJijn/iQSeq/wiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLxPVgta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLxPVgta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADE11F00A3E;
	Thu,  2 Jul 2026 06:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782974065;
	bh=o0XMWh4yki3reRF9xE6HcyQp2w0UXlppbEJp1N7fPrw=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=DLxPVgtauZ7OpE4iRk4zVWrFCwbIL0l/7i5yaqcz0utgL/T9iroX4gnQOrG29WXEF
	 dzHqg/VN3AcI9YAr+V3dEierldAwX1E0nlYFzq18uwQR8aPnhj8TC+a264+hcYvfup
	 vP082NuoRvoNyBd2VL1AqAejE0LzBLMBpauAhi32S+GrIsz2P0Yv2TlCSoOd/L2Ews
	 FsLOYsvAOvo01JockgBGH3ti4r7elruI31rK1epN55vY9cNyEXvLMnHjkhgZm/QZmW
	 cl12G175A59ZF2oQriuIQK83V32pp/nkC+yZaDpkrSArXrIXfhRgmR+O/nqYlYv+vK
	 QPUnHa0JQ1BYg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 2/5] ata: libata-scsi: refactor ata_scsi_report_supported_opcodes()
Date: Thu,  2 Jul 2026 15:34:09 +0900
Message-ID: <20260702063412.1892584-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702063412.1892584-1-dlemoal@kernel.org>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ata_scsi_report_supported_opcodes() is very limited in functionality as it
lacks support for the all command format and also does not handle
correctly commands that have a service action.

In preparation for adding these missing features, refactor how
ata_scsi_report_supported_opcodes() operates to make modifications and
extensions easier. To do so, introduce the array of supported commands
ata_supported_cmds. This array entries are of type struct ata_scsi_cmd.
This structure stores the operation code, CDB length, and the service
action of a supported SCSI command that libata SAT can translate or
emulate. Since some service actions (e.g. ZI_REPORT_ZONES) can have a
value of 0, the field sa_valid of struct ata_scsi_cmd is used to indicate
if the sa field is valid, or if it should be ignored.

The helper function ata_scsi_get_supported_cmd() is implemented to search
for a particular command by opcode in this array. This function is used in
ata_scsi_cmd_is_supported() together with a struct ata_scsi_cmd_support to
check based on the target device features if the specified command is
supported.

ata_scsi_cmd_is_supported() is used as the main function in
ata_scsi_report_supported_opcodes() to determine if a particular command
is supported and fill the command reply rbuf as needed. In the case of a
command that is not supported, the support field is set to 1 as specified
in SPC, indicating that the command is not supported.

Of note is that the old ata_scsi_report_supported_opcodes() code did not
handle the WRITE_SAME_16 and VARIABLE_LENGTH_CMD commands which are both
supported and translated by libata-scsi. The ata_supported_cmds array
includes these commands.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 164 +++++++++++++++++++++++++-------------
 1 file changed, 110 insertions(+), 54 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8811bfc37369..4f0ae44f59dd 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3590,87 +3590,143 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	return 1;
 }
 
-static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
-						      struct scsi_cmnd *cmd,
-						      u8 *rbuf)
+struct ata_scsi_cmd {
+	u8 op;
+	u8 cdb_len;
+	bool sa_valid;
+	u16 sa;
+};
+
+/*
+ * Array of commands supported with translation or emulation, sorted in
+ * ascending opcode and service action order. All of these commands are
+ * processed either in ata_xlat_func() or in ata_scsi_simulate();
+ */
+static const struct ata_scsi_cmd ata_supported_cmds[] = {
+	{ TEST_UNIT_READY,	 6,	false,	0 },
+	{ REZERO_UNIT,		 6,	false,	0 },
+	{ REQUEST_SENSE,	 6,	false,	0 },
+	{ READ_6,		 6,	false,	0 },
+	{ WRITE_6,		 6,	false,	0 },
+	{ SEEK_6,		 6,	false,	0 },
+	{ INQUIRY,		 6,	false,	0 },
+	{ MODE_SELECT,		 6,	false,	0 },
+	{ MODE_SENSE,		 6,	false,	0 },
+	{ START_STOP,		 6,	false,	0 },
+	{ SEND_DIAGNOSTIC,	 6,	false,	0 },
+	{ READ_CAPACITY,	10,	false,	0 },
+	{ READ_10,		10,	false,	0 },
+	{ WRITE_10,		10,	false,	0 },
+	{ SEEK_10,		10,	false,	0 },
+	{ VERIFY,		10,	false,	0 },
+	{ SYNCHRONIZE_CACHE,	10,	false,	0 },
+	{ MODE_SELECT_10,	10,	false,	0 },
+	{ MODE_SENSE_10,	10,	false,	0 },
+	{ VARIABLE_LENGTH_CMD,	32,	true,	ATA_32 },
+	{ ATA_16,		16,	false,	0 },
+	{ READ_16,		16,	false,	0 },
+	{ WRITE_16,		16,	false,	0 },
+	{ VERIFY_16,		16,	false,	0 },
+	{ SYNCHRONIZE_CACHE_16,	16,	false,	0 },
+	{ WRITE_SAME_16,	16,	false,	0 },
+	{ ZBC_OUT,		16,	true,	ZO_CLOSE_ZONE },
+	{ ZBC_OUT,		16,	true,	ZO_FINISH_ZONE },
+	{ ZBC_OUT,		16,	true,	ZO_OPEN_ZONE },
+	{ ZBC_OUT,		16,	true,	ZO_RESET_WRITE_POINTER },
+	{ ZBC_IN,		16,	true,	ZI_REPORT_ZONES },
+	{ SERVICE_ACTION_IN_16,	16,	true,	SAI_READ_CAPACITY_16 },
+	{ REPORT_LUNS,		12,	false,	0 },
+	{ ATA_12,		12,	false,	0 },
+	{ SECURITY_PROTOCOL_IN,	12,	false,	0 },
+	{ MAINTENANCE_IN,	12,	true,	MI_REPORT_SUPPORTED_OPERATION_CODES },
+	{ SECURITY_PROTOCOL_OUT, 12,	false,	0 },
+};
+
+static const struct ata_scsi_cmd *ata_scsi_get_supported_cmd(u8 op)
 {
-	u8 *cdb = cmd->cmnd;
-	u8 supported = 0, cdlp = 0, rwcdlp = 0;
+	const struct ata_scsi_cmd *cmd;
+	int i;
 
-	if (cdb[2] != 1 && cdb[2] != 3) {
-		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
-		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
-		return 0;
+	for (i = 0; i < ARRAY_SIZE(ata_supported_cmds); i++) {
+		cmd = &ata_supported_cmds[i];
+		if (cmd->op == op)
+			return cmd;
 	}
 
-	switch (cdb[3]) {
-	case INQUIRY:
-	case MODE_SENSE:
-	case MODE_SENSE_10:
-	case READ_CAPACITY:
-	case SERVICE_ACTION_IN_16:
-	case REPORT_LUNS:
-	case REQUEST_SENSE:
-	case SYNCHRONIZE_CACHE:
-	case SYNCHRONIZE_CACHE_16:
-	case REZERO_UNIT:
-	case SEEK_6:
-	case SEEK_10:
-	case TEST_UNIT_READY:
-	case SEND_DIAGNOSTIC:
-	case MAINTENANCE_IN:
-	case READ_6:
-	case READ_10:
-	case WRITE_6:
-	case WRITE_10:
-	case ATA_12:
-	case ATA_16:
-	case VERIFY:
-	case VERIFY_16:
-	case MODE_SELECT:
-	case MODE_SELECT_10:
-	case START_STOP:
-		supported = 3;
-		break;
+	return NULL;
+}
+
+struct ata_scsi_cmd_support {
+	u8 cdlp;
+	u8 rwcdlp;
+};
+
+static bool ata_scsi_cmd_is_supported(struct ata_device *dev, u8 op,
+				      struct ata_scsi_cmd_support *sup)
+{
+	const struct ata_scsi_cmd *cmd;
+
+	/* First, see if we support the command. */
+	cmd = ata_scsi_get_supported_cmd(op);
+	if (!cmd)
+		return false;
+
+	/* Now refine the support report depending on the device features. */
+	memset(sup, 0, sizeof(*sup));
+	switch (op) {
 	case READ_16:
-		supported = 3;
 		if (dev->flags & ATA_DFLAG_CDL) {
 			/*
 			 * CDL read descriptors map to the T2A page, that is,
 			 * rwcdlp = 0x01 and cdlp = 0x01
 			 */
-			rwcdlp = 0x01;
-			cdlp = 0x01 << 3;
+			sup->rwcdlp = 0x01;
+			sup->cdlp = 0x01;
 		}
-		break;
+		return true;
 	case WRITE_16:
-		supported = 3;
 		if (dev->flags & ATA_DFLAG_CDL) {
 			/*
 			 * CDL write descriptors map to the T2B page, that is,
 			 * rwcdlp = 0x01 and cdlp = 0x02
 			 */
-			rwcdlp = 0x01;
-			cdlp = 0x02 << 3;
+			sup->rwcdlp = 0x01;
+			sup->cdlp = 0x02;
 		}
-		break;
+		return true;
 	case ZBC_IN:
 	case ZBC_OUT:
-		if (ata_dev_is_zoned(dev))
-			supported = 3;
-		break;
+		return ata_dev_is_zoned(dev);
 	case SECURITY_PROTOCOL_IN:
 	case SECURITY_PROTOCOL_OUT:
-		if (dev->flags & ATA_DFLAG_TRUSTED)
-			supported = 3;
-		break;
+		return dev->flags & ATA_DFLAG_TRUSTED;
 	default:
 		break;
 	}
 
+	return true;
+}
+
+static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
+						      struct scsi_cmnd *cmd,
+						      u8 *rbuf)
+{
+	struct ata_scsi_cmd_support sup;
+	u8 *cdb = cmd->cmnd;
+
+	if (cdb[2] != 1 && cdb[2] != 3) {
+		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
+		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
+		return 0;
+	}
+
 	/* One command format */
-	rbuf[0] = rwcdlp;
-	rbuf[1] = cdlp | supported;
+	if (ata_scsi_cmd_is_supported(dev, cdb[3], &sup)) {
+		rbuf[0] = sup.rwcdlp;
+		rbuf[1] = (sup.cdlp << 3) | 0x03;
+	} else {
+		rbuf[1] = 0x01;
+	}
 
 	return 4;
 }
-- 
2.54.0

