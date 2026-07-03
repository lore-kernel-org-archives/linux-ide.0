Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A851277035
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051557; cv=none; b=jT29YE+ksvvAZeoImxjPFKCjG3e5o8Gm28VFduW2w7OYF740yOAjv4CMXj6gvzEU1pU7I4ds9ApjZvsmqIjXFi3hsnyxWgI0lFHGgv+eZ52cj0Sv/AtgbExoIuexM3XHmrYos00UgKmOQRCXr7VrK6gOW7fCWLkWxiq6C8oV8wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051557; c=relaxed/simple;
	bh=pGp9ZAaQhwB/bCLNa0MGAZk41VMA4hJ1/mIDrAnh24k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfYISpSS9b25jzgnyJvjUfbP6r8/0zxMwPK8loBkvMBjy/ssZVuqm8iYa+yc/u+auLHzs5wgaXKALqTPkJNFY/Vq1WWzgbsdrv92KBGyOg0MXmEV26X4RHpTzXNcxq3XKABrjUeA6BdFhN3RNDh9IRViAPyzYtEJZLdbO6A0LKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnIo7p+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnIo7p+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8A91F00A3F;
	Fri,  3 Jul 2026 04:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051545;
	bh=SP+6qAOGPrtZQgerQODVGUBQ00zQfjlHcoWnwoI60Rg=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=lnIo7p+Itq2IqrBu8C/GON5VvbjYkBJYcgnYV2//9K8CoZ8PnZQxDS6+flKYG7XK1
	 FENkwwPEbmOHdEAYq+oyK05ifzVeAmeZO9Hxh93TDG1KeJjyjt1hfAGqUu6kAooK9K
	 E/wI6ti3s9L5apG2YkCffmBjS5+gfDzgPLxwPmCidlh/pmvOE7OGdCKmVXZ/J5aqB0
	 v7cCyIZg60PuaZCGYHszkiFGaWuzEUf3PAIVju3u274nuDplFerd4CNsBPdIoFfk0p
	 BaqBXIraGWDDbhGItlJpBVNsUHWJ7ma0ZnacHoJcRYRh8Cwt9T48eHSkSmdILmEuBz
	 X1Ga44Ay5s3Nw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 3/5] ata: libata-scsi: improve service action support in ata_scsi_report_supported_opcodes()
Date: Fri,  3 Jul 2026 13:05:30 +0900
Message-ID: <20260703040532.2152614-4-dlemoal@kernel.org>
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
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/ata/libata-scsi.c | 41 ++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e502b8702f98..4d4cdf304740 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3679,32 +3679,46 @@ static const struct ata_scsi_cmd ata_supported_cmds[] = {
 	{	.op = SECURITY_PROTOCOL_OUT,	.cdb_len = 12	},
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
 
@@ -3750,15 +3764,28 @@ static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
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

