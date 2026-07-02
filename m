Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73D2D73B6
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957423; cv=none; b=dvqknI5KP5BMpamzevsvaHybQleAQcv0kzkX2QsBjKMZ5F5sCiG5gaXTeFncBunuB9DEhNNIXZZjrGjDMf6zJ2LsG/KxbY42b6oY80vMHGsz/2Wz3DX8QuJNqsnu6GV3y6pYlaIOr0fk2lLxdv+AV44LKSbu7ktW47Ofc8PjqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957423; c=relaxed/simple;
	bh=uXmjWCj+8O8X9f3q9/vOrmn8SIhcTbG6Ozz4C802/7U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7T+a4JFGZEWioTCessf0sRxnrhnarZVghc0d91aly/JGuFFEJhNULph4/tgUS78oDh8HXBZojZUiOJ0e+sD2zwaQQYu915M5ZMpxWLqtZAVpDPlaLLZeOadWZJEwawRylgwxrHWQ+fN3AJv3KOjd4WEcMTFnvbi+6Iuqc3HFyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XemPxzHY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XemPxzHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A5F1F000E9;
	Thu,  2 Jul 2026 01:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782957422;
	bh=eAEYWjPJcB/dcdv/05zNdYqvKT13/3tEiyqqRvIyNZM=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=XemPxzHYd84nFzHY7B7KCwv/WeIaw9VV4VHU+Y+fpaRERzHoFWi+P7cYWyYQIBNA/
	 1igwhfO1aHhH4PutGN469hq/0xD1Es6nHRqyolJ6nQle92hdNhhTHxb4C+z2UlHXbQ
	 OwWWrOCyeP8aPywscLcqmJMBMrDsHfoYuk67z71tbQxWG2upOeq/CbCvurhARzWxsB
	 43WYyd8MOWV565Aw4bZruJ1UzgRXJAixxj+Qg02IyYNhMUeOfioVGrvvipcmSLgrff
	 iBmORyS+Qo6RsfhT8wUPaOTaTxXTbcEEQp44o9k8SPbeBqbBdEtk5jIWisQ06g/Blp
	 klE/Thd+kwL1g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v1 6/6] ata: libata-scsi: support the all command format for reporting supported commands
Date: Thu,  2 Jul 2026 10:56:46 +0900
Message-ID: <20260702015646.1702539-7-dlemoal@kernel.org>
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

Add support to ata_scsi_report_supported_opcodes() for the all command
format indicated with a reporting option of 0. The function
ata_scsi_report_all_supported_opcodes() is introduced to implement this
support. This function operates by testing all commands of the
ata_supported_cmds array and testing them using
ata_scsi_cmd_is_supported(), filling rbuf as it loops through all the
commands that libata can emulate or translate.

With this change, sg_opcodes /dev/sdX is able to list all commands
supported by a device. An example below is shown for SATA diski
supporting CDL:

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
  7f                 32    0,0    Variable length
  85                 16    0,0    ATA pass-through(16)
  88                 16    1,1    Read(16)
  8a                 16    1,2    Write(16)
  8f                 16    0,0    Verify(16)
  91                 16    0,0    Synchronize cache(16)
  93                 16    0,0    Write same(16)
  9e       10        16    0,0    Read capacity(16)
  a0                 12    0,0    Report luns
  a1                 12    0,0    ATA pass-through(12)
  a3        c        12    0,0    Report supported operation codes

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3f313050c63f..30e2cf3b03dc 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3731,6 +3731,42 @@ static bool ata_scsi_cmd_is_supported(struct ata_device *dev, u8 op, u16 sa,
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
+		buf[5] |= (sup.rwcdlp << 6) | (sup.cdlp << 2);
+		if (cmd->sa)
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
@@ -3740,6 +3776,9 @@ static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
 	u16 sa = 0;
 
 	switch (cdb[2]) {
+	case 0:
+		/* All command format */
+		return ata_scsi_report_all_supported_opcodes(dev, rbuf);
 	case 1:
 		/* One command format with command support data, ignore sa. */
 		if (ata_scsi_supported_cmd_has_sa(cdb[3])) {
-- 
2.54.0

