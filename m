Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16562D6401
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957420; cv=none; b=QllMi+xntHYwUWWDmEX/mqRwYP+DC3ZlpINiypI3aTjmid6s6/RYFf35dN+Sb3uQzSqG/BrZL9IXOyYdgMK6s9KlwJhGud/SKRRV3Wbh7RZqLGFrw7e515cWTtwv8cSzx2TfdUcOVu2UgDS82dgI4JgUA8NRntwNppFjsCyWUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957420; c=relaxed/simple;
	bh=vzY3ZLvkjVWxrIn2k2QVZZFEYRFYH3NdBsvWpxPc0Q0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrxjaFGfioFIVZrI6oVwuo9Pa29muvBx+++/XkQ0nKShPqxOqJNMZaHp2Uoymx6imUEKlQGtnudOfhaEBthnWu6jHI2I1m0Eewgnmd9G8WQrjQp3SAqDnBSh6z9lC7CYyLwwOFIfDzkr6d4yPuuyygkSIeRcg29vXKLBpRXQAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbFjm+y9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbFjm+y9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519AA1F00A3D;
	Thu,  2 Jul 2026 01:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782957419;
	bh=+5iFb4B9sXjao3BQMPNZn1ywZIaKJm9xiUYrRFxKs/4=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=QbFjm+y9ifPjg0UfLno2ecmxorAYhijJtdYL/FkKNf+F5OXZ3H938Wn7T8ZkSbX3J
	 Z8wGePybIYfwbVhtRarQWdJRvFIeD1U3jVn8XvEytJChD9MtiEeoYxpiAS092eFrcU
	 VMDYc6S8Cb+AVoKJ91szJNmAQVOOsr0k5PXsebQclPGHGvytSXDDgxwg5wfScYAY9c
	 uUFqo2MYjXYvjTom5s6WiQnbPPzMvyLFH49gKxM7rvhHrzJi6JP9hv4lpYi/M9mDtZ
	 8T/SllQCKH1QMZ/fenADZKkLjmAPdr+aXuYYwXlsepckSYo18bDr8DzR1QkCTJo7Rd
	 +MmRlltNh84lA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v1 2/6] ata: libata-scsi: refactor ata_scsi_report_supported_opcodes()
Date: Thu,  2 Jul 2026 10:56:42 +0900
Message-ID: <20260702015646.1702539-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702015646.1702539-1-dlemoal@kernel.org>
References: <20260702015646.1702539-1-dlemoal@kernel.org>
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
This structure stores the operation code, service action (0 if there is
not any) and CDB length of a supported SCSI command that libata SAT can
translate or emulate.

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
 1 file changed, 109 insertions(+), 55 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b8aabd08f786..380ca3886a77 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3590,88 +3590,142 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	return 1;
 }
 
-static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
-						      struct scsi_cmnd *cmd,
-						      u8 *rbuf)
+struct ata_scsi_cmd {
+	u8 op;
+	u8 cdb_len;
+	u16 sa;
+};
+
+/*
+ * List of supported commands for translation or emulation, sorted in
+ * alphabetical order. All of these commands are processed either in
+ * ata_xlat_func() or in ata_scsi_simulate();
+ */
+static const struct ata_scsi_cmd ata_supported_cmds[] = {
+	{ ATA_12,		12,	0 },
+	{ ATA_16,		16,	0 },
+	{ INQUIRY,		 6,	0 },
+	{ MAINTENANCE_IN,	12,	MI_REPORT_SUPPORTED_OPERATION_CODES },
+	{ MODE_SENSE,		 6,	0 },
+	{ MODE_SENSE_10,	10,	0 },
+	{ MODE_SELECT,		 6,	0 },
+	{ MODE_SELECT_10,	10,	0 },
+	{ READ_6,		 6,	0 },
+	{ READ_10,		10,	0 },
+	{ READ_16,		16,	0 },
+	{ READ_CAPACITY,	10,	0 },
+	{ REPORT_LUNS,		12,	0 },
+	{ REQUEST_SENSE,	 6,	0 },
+	{ REZERO_UNIT,		 6,	0 },
+	{ SECURITY_PROTOCOL_IN,	12,	0 },
+	{ SECURITY_PROTOCOL_OUT, 12,	0 },
+	{ SEEK_6,		 6,	0 },
+	{ SEEK_10,		10,	0 },
+	{ SEND_DIAGNOSTIC,	 6,	0 },
+	{ SERVICE_ACTION_IN_16,	16,	SAI_READ_CAPACITY_16 },
+	{ START_STOP,		 6,	0 },
+	{ SYNCHRONIZE_CACHE,	10,	0 },
+	{ SYNCHRONIZE_CACHE_16,	16,	0 },
+	{ TEST_UNIT_READY,	 6,	0 },
+	{ WRITE_6,		 6,	0 },
+	{ WRITE_10,		10,	0 },
+	{ WRITE_16,		16,	0 },
+	{ WRITE_SAME_16,	16,	0 },
+	{ VERIFY,		10,	0 },
+	{ VERIFY_16,		16,	0 },
+	{ VARIABLE_LENGTH_CMD,	32,	0 },
+	{ ZBC_IN,		16,	ZI_REPORT_ZONES },
+	{ ZBC_OUT,		16,	ZO_CLOSE_ZONE },
+	{ ZBC_OUT,		16,	ZO_FINISH_ZONE },
+	{ ZBC_OUT,		16,	ZO_OPEN_ZONE },
+	{ ZBC_OUT,		16,	ZO_RESET_WRITE_POINTER },
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
-		if (ata_id_zoned_cap(dev->id) ||
-		    dev->class == ATA_DEV_ZAC)
-			supported = 3;
-		break;
+		return ata_id_zoned_cap(dev->id) || dev->class == ATA_DEV_ZAC;
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

