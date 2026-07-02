Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01F2388881
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974067; cv=none; b=kx6KK0xHogrxj6YeZ44N60Hom8xBvpU2bgPNBiXuVen4GAzLiy26IHc01nn8olD4Bou6Q8IGQ61IbLgTjWhrYU5SEes7AGmambMG23xKLi96fF3lpxu5Yjzn8vjSRH0NteH4pRncwwxJpg3u8mlGjhEGQ6gE55xb6LC6pWSjK1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974067; c=relaxed/simple;
	bh=EDs6cvUyzAtIxOfVtAFfo2TbXmKi+DECsD5j/GlrSzY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYYWZXmKlW5SLU5khleIJw7dQr3qfoL+KdJ/pEyQptxoBdfqfi/2RSrX6Gpi8wZrBcHIy/PwgartKsFV0HbiY6FQscRBP0QgQMnUl1BbeIWfjnSX6Mi+0owFGEJFFPaRIYYsSvaO0DsG9YZOPKSKIqsTaw9cpWCWwyh4KD8TCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENeAtWqV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENeAtWqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792611F00A3D;
	Thu,  2 Jul 2026 06:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782974065;
	bh=wWd4+9/7zVnzYa9fR/FJkAkj9BWjjENrHIXffhV2A3I=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=ENeAtWqVcUB0L6l9e5E4F9D//Bi6Up+9kZSJDd1ReXJlD1XtNfl5vXdtsODf4g/HJ
	 r06zqhebgYDjJN7Z4eg59WAlMscI+Jinr+IiteNFhQN9NrLh+fo18nD31T5+svzAl4
	 4GCx3aZWB5kJR0wrTApFotr/9V2fBY365/6Pmk1OIIr9QH8GO9Oeso6BprwInE5e95
	 dYiJ4hlK232ArAJSvEF2coSW65nxrz2OxFCL1iku4lriO/+48OVn5ULcZwwsNn5IFy
	 9cAkBawRFyUfRb4pQuIBy0B+RW5Y5HlV9dvsc4uWA5t3E4oGw0oIu5QWfRZLZ87gHu
	 ffKsJNgUEIdAg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 3/5] ata: libata-scsi: improve service action support in ata_scsi_report_supported_opcodes()
Date: Thu,  2 Jul 2026 15:34:10 +0900
Message-ID: <20260702063412.1892584-4-dlemoal@kernel.org>
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

ata_scsi_report_supported_opcodes() is ignoring the service action
specified in the SCSI command CDB, but the one command format must take
this field into consideration. With the reporting options field set to 1,
the REPORT SUPPORTED OPERATION CODES command must be failed if the
specified opcode to check has service actions, while reporting option 3
must match supported opcodes together with the specified service action.

Stop ignoring the service action by passing it to
ata_scsi_cmd_is_supported() and searching for commands in the
array of supported commands (ata_supported_cmds) using both the command
opcode and service action.

Introduce the helper function ata_scsi_supported_cmd_use_sa() to determine
if a particular command has service actions and use this function to fail
a REPORT SUPPORTED OPERATION CODES command if such command is specified
with reporting options 1.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 41 ++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4f0ae44f59dd..86ac41a7d81a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3642,32 +3642,46 @@ static const struct ata_scsi_cmd ata_supported_cmds[] = {
 	{ SECURITY_PROTOCOL_OUT, 12,	false,	0 },
 };
 
-static const struct ata_scsi_cmd *ata_scsi_get_supported_cmd(u8 op)
+static const struct ata_scsi_cmd *ata_scsi_get_supported_cmd(u8 op, u16 sa)
 {
 	const struct ata_scsi_cmd *cmd;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(ata_supported_cmds); i++) {
 		cmd = &ata_supported_cmds[i];
-		if (cmd->op == op)
+		if (cmd->op == op && cmd->sa == sa)
 			return cmd;
 	}
 
 	return NULL;
 }
 
+static bool ata_scsi_supported_cmd_use_sa(u8 op)
+{
+	const struct ata_scsi_cmd *cmd;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ata_supported_cmds); i++) {
+		cmd = &ata_supported_cmds[i];
+		if (cmd->op == op)
+			return cmd->sa_valid;
+	}
+
+	return false;
+}
+
 struct ata_scsi_cmd_support {
 	u8 cdlp;
 	u8 rwcdlp;
 };
 
-static bool ata_scsi_cmd_is_supported(struct ata_device *dev, u8 op,
+static bool ata_scsi_cmd_is_supported(struct ata_device *dev, u8 op, u16 sa,
 				      struct ata_scsi_cmd_support *sup)
 {
 	const struct ata_scsi_cmd *cmd;
 
 	/* First, see if we support the command. */
-	cmd = ata_scsi_get_supported_cmd(op);
+	cmd = ata_scsi_get_supported_cmd(op, sa);
 	if (!cmd)
 		return false;
 
@@ -3713,15 +3727,28 @@ static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
 {
 	struct ata_scsi_cmd_support sup;
 	u8 *cdb = cmd->cmnd;
-
-	if (cdb[2] != 1 && cdb[2] != 3) {
+	u16 sa = 0;
+
+	switch (cdb[2]) {
+	case 1:
+		/* One command format with command support data, ignore sa. */
+		if (ata_scsi_supported_cmd_use_sa(cdb[3])) {
+			ata_scsi_set_invalid_field(dev, cmd, 3, 0xff);
+			return 0;
+		}
+		break;
+	case 3:
+		/* One command format */
+		sa = get_unaligned_be16(&cdb[4]);
+		break;
+	default:
 		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
 		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
 		return 0;
 	}
 
 	/* One command format */
-	if (ata_scsi_cmd_is_supported(dev, cdb[3], &sup)) {
+	if (ata_scsi_cmd_is_supported(dev, cdb[3], sa, &sup)) {
 		rbuf[0] = sup.rwcdlp;
 		rbuf[1] = (sup.cdlp << 3) | 0x03;
 	} else {
-- 
2.54.0

