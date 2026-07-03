Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2C83191CE
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051555; cv=none; b=n+h7EoKAZ95lSPEmj3NRPv7vbkvMyYFIn7KBoDzmMO8LgCKWFp2l+fzrlPHl+YkX6Rjoj/N+F3ei1gXRMiQiFvlanlHh1pjQPztpulF75igigg2O6f3eCqNhlq1Aei+hn1V22SFNJUhr1eFDmBduW/aA/kfb6qiuQwf8j4GviMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051555; c=relaxed/simple;
	bh=X5JuDAm6ZOQd3+dxikj9H0JfCgrpVejFW9kDg1bfKjM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IimU5IBFIJ8gTcnRl5gC4SlZs/LAP8WJkjLRcFZg/5I/kkE8X2/iklaQGb+A/K9wC0Ks7ykagdpVTrNRe5qSK+umdHLjIEDyRzrE7vLZ/vARVTmcKCEQx6uBquY6lreLemeUYPNTlSg1w8UOia5Zsg2hcGjailh7HfoJDWvtDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2MD3bcM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2MD3bcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F131F00A3A;
	Fri,  3 Jul 2026 04:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051545;
	bh=cAK1DJBCXt+fysrPjPj2bC0Ot41c5+FWhALinaiKk4Q=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=P2MD3bcMUKtSq5Dz8Ue2BFzF3Q7GRAdMdmHkHpXs6wPWPKkN66dv/CZ9qu/0uXJev
	 qMxF76QzxbPoTBLy2+6XN1fBQ9mqifq8uViZpOPT9ipogi1Um70b9cTFtGCxMzuSmh
	 7xexTiuHtuUfG3j0lmVZEKj7q800Zwh4vDU4yAS02SN5ES72cSOzkoBpynO+iZHQ6P
	 im1HTRY+p8QNvGAZFU5aH5YIIV70JkKOK/7C2U4bediWlYNo3glsfxfPKAnnkZMFju
	 AiGvF+4Un6HD0iBLWSUhQoTauWplBsJRqfTYK97neuN6jsmO0cJfLYlY/0lGTLRqA7
	 5TC1JUiKMKnIg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 2/5] ata: libata-scsi: refactor ata_scsi_report_supported_opcodes()
Date: Fri,  3 Jul 2026 13:05:29 +0900
Message-ID: <20260703040532.2152614-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703040532.2152614-1-dlemoal@kernel.org>
References: <20260703040532.2152614-1-dlemoal@kernel.org>
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
handle the VARIABLE_LENGTH_CMD/ATA_32 command which is supported and
translated by libata-scsi. The ata_supported_cmds array includes this
command. As commented in the code, WRITE_SAME_16 is left out of the array
of supported command ata_scsi_write_same_xlat() prevents the use of this
command as a passthrough command.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 201 ++++++++++++++++++++++++++++----------
 1 file changed, 147 insertions(+), 54 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a86721b5df7f..e502b8702f98 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3590,87 +3590,180 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
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
+ *
+ * Note: commands that are not fully supported may be left out of this array
+ * so that they are not reported as supported for passthrough but still
+ * available through the block layer. For now, this includes the following
+ * commands:
+ *  - WRITE_SAME_16: ata_scsi_write_same_xlat() forbids passthrough commands
+ */
+static const struct ata_scsi_cmd ata_supported_cmds[] = {
+	{	.op = TEST_UNIT_READY,		.cdb_len = 6	},
+	{	.op = REZERO_UNIT,		.cdb_len = 6	},
+	{	.op = REQUEST_SENSE,		.cdb_len = 6	},
+	{	.op = READ_6,			.cdb_len = 6	},
+	{	.op = WRITE_6,			.cdb_len = 6	},
+	{	.op = SEEK_6,			.cdb_len = 6	},
+	{	.op = INQUIRY,			.cdb_len = 6	},
+	{	.op = MODE_SELECT,		.cdb_len = 6	},
+	{	.op = MODE_SENSE,		.cdb_len = 6	},
+	{	.op = START_STOP,		.cdb_len = 6	},
+	{	.op = SEND_DIAGNOSTIC,		.cdb_len = 6	},
+	{	.op = READ_CAPACITY,		.cdb_len = 10	},
+	{	.op = READ_10,			.cdb_len = 10	},
+	{	.op = WRITE_10,			.cdb_len = 10	},
+	{	.op = SEEK_10,			.cdb_len = 10	},
+	{	.op = VERIFY,			.cdb_len = 10	},
+	{	.op = SYNCHRONIZE_CACHE,	.cdb_len = 10	},
+	{	.op = MODE_SELECT_10,		.cdb_len = 10	},
+	{	.op = MODE_SENSE_10,		.cdb_len = 10	},
+	{
+		.op = VARIABLE_LENGTH_CMD,	.cdb_len = 32,
+		.sa_valid = true,
+		.sa = ATA_32
+	},
+	{	.op = ATA_16,			.cdb_len = 16	},
+	{	.op = READ_16,			.cdb_len = 16	},
+	{	.op = WRITE_16,			.cdb_len = 16	},
+	{	.op = VERIFY_16,		.cdb_len = 16	},
+	{	.op = SYNCHRONIZE_CACHE_16,	.cdb_len = 16	},
+	{
+		.op = ZBC_OUT,			.cdb_len = 16,
+		.sa_valid = true,
+		.sa = ZO_CLOSE_ZONE
+	},
+	{
+		.op = ZBC_OUT,			.cdb_len = 16,
+		.sa_valid = true,
+		.sa = ZO_FINISH_ZONE
+	},
+	{
+		.op = ZBC_OUT,			.cdb_len = 16,
+		.sa_valid = true,
+		.sa = ZO_OPEN_ZONE
+	},
+	{
+		.op = ZBC_OUT,			.cdb_len = 16,
+		.sa_valid = true,
+		.sa = ZO_RESET_WRITE_POINTER
+	},
+	{
+		.op = ZBC_IN,			.cdb_len = 16,
+		.sa_valid = true,
+		.sa = ZI_REPORT_ZONES
+	},
+	{
+		.op = SERVICE_ACTION_IN_16,	.cdb_len = 16,
+		.sa_valid = true,
+		.sa = SAI_READ_CAPACITY_16
+	},
+	{	.op = REPORT_LUNS,		.cdb_len = 12	},
+	{	.op = ATA_12,			.cdb_len = 12	},
+	{	.op = SECURITY_PROTOCOL_IN,	.cdb_len = 12	},
+	{
+		.op = MAINTENANCE_IN,		.cdb_len = 12,
+		.sa_valid = true,
+		.sa = MI_REPORT_SUPPORTED_OPERATION_CODES
+	},
+	{	.op = SECURITY_PROTOCOL_OUT,	.cdb_len = 12	},
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

