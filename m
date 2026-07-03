Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3A31DDBF
	for <linux-ide@vger.kernel.org>; Fri,  3 Jul 2026 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051565; cv=none; b=oE6vB8KlKBdUHWqQ0ja3LMDe+ISfd4i8DU6VQgGDEvEJHiyXzwlu4nQMKiNMlYpOljwmcjekfRfXAx2PqKkaGOx66c9tyOTJ2SVjGxvZtA4dy/tCQMwqYoq3zRlgXgcZfk1Tygxav37v3RXTKVORUP0ag0Pcs2V9DF6Lq8yTMB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051565; c=relaxed/simple;
	bh=HgIfsq2wMIQ+uFiQ8ffLwqQwo/cCxJ7SdEww3r5MRVw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuCP84fBQK4cH6MPKMrBwmSxD/LITZzv32i/JrXF32riV42AVzkYVrtx1wdAcXRcvksvBqGq89Wz9m4K9OeZSuMOMHCyMaN4SG5B5B68gcF4R/grYcROm8V1RNUmPBbGo/+JNMf+K8HgY6Cv6IahNGo4ysxwJKkIWZo/im9cCjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOEt+/Ke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOEt+/Ke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC351F00ACA;
	Fri,  3 Jul 2026 04:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051546;
	bh=eVInzZeBYplKHcGEgGi1ZvNz3stKzvJhQWs8BftSneg=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=lOEt+/Kee+OLMnSVbJLaz6Oqsu63vov5IS4aUzbh4ZgApT1AComfFmr1p3lS40fSG
	 usD5CYqHuX3O7jvqYFKCPSF2kFwTn7AV8p0cNckUahNUJA2i3fx7HamNK+xjrlE0sY
	 9GRA8obU7EUz066zQFweGX46u23bDAwerKj03PQMx4OQHQoRWlr5ZFZlh1+LaMjhn3
	 4eezrXr01B/j3XJJCbRybBQT2cwtityd++U0eDJMlCOLeVvJBCWuV2RK6UCjMiHi0c
	 R2KPGWy1HelZ8x8U2MMh1J/dlijKmFlBBjgnibRe4u0b7kQ7CFGazVnHWSoSZnvpjj
	 gn2janQrOZOUQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 5/5] ata: libata-scsi: support the all command format for reporting supported commands
Date: Fri,  3 Jul 2026 13:05:32 +0900
Message-ID: <20260703040532.2152614-6-dlemoal@kernel.org>
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

Add support to ata_scsi_report_supported_opcodes() for the all command
format indicated with a reporting option of 0. The function
ata_scsi_report_all_supported_opcodes() is introduced to implement this
support. This function operates by testing all commands of the
ata_supported_cmds array and testing them using
ata_scsi_cmd_is_supported(), filling rbuf as it loops through all the
commands that libata can emulate or translate.

With this change, sg_opcodes /dev/sdX is able to list all commands
supported by libata and a device. An example below is shown for a SATA
disk also supporting CDL:

  # sg_opcodes /dev/sda
    ATA       WDC  WUH722626AL  WZ41
    Peripheral device type: disk

  Opcode  Service    CDB  RWCDLP,  Name
  (hex)   action(h)  size   CDLP
  -----------------------------------------------
   00                  6    0,0    Test Unit Ready
   01                  6    0,0    Rezero Unit
   03                  6    0,0    Request Sense
   08                  6    0,0    Read(6)
   0a                  6    0,0    Write(6)
   0b                  6    0,0    Seek(6)
   12                  6    0,0    Inquiry
   15                  6    0,0    Mode select(6)
   1a                  6    0,0    Mode sense(6)
   1b                  6    0,0    Start stop unit
   1d                  6    0,0    Send diagnostic
   25                 10    0,0    Read capacity(10)
   28                 10    0,0    Read(10)
   2a                 10    0,0    Write(10)
   2b                 10    0,0    Seek(10)
   2f                 10    0,0    Verify(10)
   35                 10    0,0    Synchronize cache(10)
   55                 10    0,0    Mode select(10)
   5a                 10    0,0    Mode sense(10)
   7f     1ff0        32    0,0    ATA pass-through(32)
   85                 16    0,0    ATA pass-through(16)
   88                 16    1,1    Read(16)
   8a                 16    1,2    Write(16)
   8f                 16    0,0    Verify(16)
   91                 16    0,0    Synchronize cache(16)
   9e       10        16    0,0    Read capacity(16)
   a0                 12    0,0    Report luns
   a1                 12    0,0    ATA pass-through(12)
   a3        c        12    0,0    Report supported operation codes

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/ata/libata-scsi.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 5dd76579327e..97fa65adafe0 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3758,6 +3758,42 @@ static bool ata_scsi_cmd_is_supported(struct ata_device *dev, u8 op, u16 sa,
 	return true;
 }
 
+static unsigned int
+ata_scsi_report_all_supported_opcodes(struct ata_device *dev, u8 *rbuf)
+{
+	struct ata_scsi_cmd_support sup;
+	const struct ata_scsi_cmd *cmd;
+	unsigned int len = 4;
+	u8 *buf = &rbuf[len];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ata_supported_cmds); i++) {
+		if (len > ATA_SCSI_RBUF_SIZE - 8)
+			break;
+
+		cmd = &ata_supported_cmds[i];
+
+		/* All command format */
+		if (!ata_scsi_cmd_is_supported(dev, cmd->op, cmd->sa, &sup))
+			continue;
+
+		buf[0] = cmd->op;
+		put_unaligned_be16(cmd->sa, &buf[2]);
+		buf[5] = (sup.rwcdlp << 6) | (sup.cdlp << 2);
+		if (cmd->sa_valid)
+			buf[5] |= 0x01;
+		put_unaligned_be16(cmd->cdb_len, &buf[6]);
+
+		/* CTDP == 0 */
+		len += 8;
+		buf += 8;
+	}
+
+	put_unaligned_be32(len - 4, &rbuf[0]);
+
+	return len;
+}
+
 static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
 						      struct scsi_cmnd *cmd,
 						      u8 *rbuf)
@@ -3767,6 +3803,9 @@ static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
 	u16 sa = 0;
 
 	switch (cdb[2]) {
+	case 0:
+		/* All command format */
+		return ata_scsi_report_all_supported_opcodes(dev, rbuf);
 	case 1:
 		/* One command format with command support data, ignore sa. */
 		if (ata_scsi_supported_cmd_use_sa(cdb[3])) {
-- 
2.54.0

