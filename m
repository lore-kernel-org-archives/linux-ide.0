Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCE9175A98
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 01:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957421; cv=none; b=X92zKFgn9cYq9UbThqgBMFrbphfOr07zi92/VicV3Rm2a9eDaBjw5ZMfNCnSsAWwEtl/bMv7/dwxC/Ku/u3hPxTdZcnhMRngv70/LmoKRXZVrAaKmGm51LPyRwqNcuEN0jUCzvsFNMlrBF0SfQOctsoYAwNFDP40b3hpiLg5yQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957421; c=relaxed/simple;
	bh=CASxHAWgE3H4MNEHrmPzT1wvXGXx6tQI/d6E6+PzBlk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGRmV2rwBj424ccMtbyWFt5iKmJ8pDDWQjH2+Yo8QsXNWXLXsuVj2tbNNgkxX528X8/wA6z8id7PEsx1CBZUbXdo4I4OLPZihagvLLrrVTBjpwG6vToS8aFo4E0O3zMWAfFYxZWbFyuKt/CL059MRgR6pxn7dkjilYH9Gjh6Y2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gu0hAHuR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu0hAHuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39381F000E9;
	Thu,  2 Jul 2026 01:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782957420;
	bh=0mxXPMSfFbqqZeamg0zjzQF7Q0RqBiT+yMxw1jDmEOc=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=gu0hAHuRS1BjN+oZgFOkSONCeNGWL6Po7IrJ/ejQQGl/fK434krMxVhJH9ZviRx3Z
	 jtGPFcLHgnTNxGf2DQVI0ubSDxmy+DFyqXpMsf9i/8cO2weQ2gpIc62DTTgVjq3ez7
	 ssQ6hFAVl/hu6koxBxLgG9IjakGRzDAGY0JFu4m/prCABXD8Isv4iKITQw6Chw1eX8
	 UcK8Dfm7UFhmERGwHnqAl1InFdxWtDkyK9iWp1Vcb8CqOR20QwDjSEWDcdE1Wv221Q
	 60tytQ1Tvl7xFZeByOH8MTRAPVGSaQ6rChGhXZLUKMh2UiopP3yesBbLA3XtOas9FY
	 +wsviosvAZnPg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v1 3/6] ata: libata-scsi: improve service action support in ata_scsi_report_supported_opcodes()
Date: Thu,  2 Jul 2026 10:56:43 +0900
Message-ID: <20260702015646.1702539-4-dlemoal@kernel.org>
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

Introduce the helper function ata_scsi_supported_cmd_has_sa() to determine
if a particular command has service actions and use this function to fail
a REPORT SUPPORTED OPERATION CODES command if such command is specified
with reporting options 1.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 43 ++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 380ca3886a77..e432e521ad31 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3641,32 +3641,46 @@ static const struct ata_scsi_cmd ata_supported_cmds[] = {
 	{ ZBC_OUT,		16,	ZO_RESET_WRITE_POINTER },
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
 
+static bool ata_scsi_supported_cmd_has_sa(u8 op)
+{
+	const struct ata_scsi_cmd *cmd;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ata_supported_cmds); i++) {
+		cmd = &ata_supported_cmds[i];
+		if (cmd->op == op)
+			return cmd->sa != 0;
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
 
@@ -3696,6 +3710,8 @@ static bool ata_scsi_cmd_is_supported(struct ata_device *dev, u8 op,
 	case ZBC_IN:
 	case ZBC_OUT:
 		return ata_id_zoned_cap(dev->id) || dev->class == ATA_DEV_ZAC;
+	case SERVICE_ACTION_IN_16:
+		return sa == SAI_READ_CAPACITY_16;
 	case SECURITY_PROTOCOL_IN:
 	case SECURITY_PROTOCOL_OUT:
 		return dev->flags & ATA_DFLAG_TRUSTED;
@@ -3712,15 +3728,28 @@ static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
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
+		if (ata_scsi_supported_cmd_has_sa(cdb[3])) {
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

