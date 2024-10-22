Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A3EC2C8
	for <linux-ide@vger.kernel.org>; Tue, 22 Oct 2024 02:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729565140; cv=none; b=PdgJnLvIZYQdP4ILtUOvcuym2swt0jOPz/gxI+Pv4848HYfQ6QfJoaYftsdHGZJthVFrU1siNCn2g4zYeZcVYwsVsN3uZM345gsfmCeDm2x8sugJ0c+8Kntfb9qGdz+lPTvyVHNI1bKCGoX5zcqk+qNK+abNQJgpaEunQfkYRvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729565140; c=relaxed/simple;
	bh=ZbyqsqNtYmB1J3zfyNNkT7ffSA4Wi+PRA/P9lFjRBFo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sl/JRPJY47hUPfM+H69NiPO6tR1rOdMoMjruNFqtvGeZ8SmF7k+OkiSElKFd4NOVwMaVvC0HDaGFF37fyXdW+nstoJc17wB19828sGkNxRPn+nzzR0Ysrhlo7e0uu5pCKhVkAEnaalyxR9EFkitjzwRatErzYvAPsb1jPqV0QQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arQnwuXZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arQnwuXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8128C4CEE7;
	Tue, 22 Oct 2024 02:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729565140;
	bh=ZbyqsqNtYmB1J3zfyNNkT7ffSA4Wi+PRA/P9lFjRBFo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=arQnwuXZ5kd0c76gkoJYbXe9NUsURxcIR+tEXhQNS+IxU7dWEPqFEWrRN6iwBQUrQ
	 lKSBSQWE0bCks2iLENtURLLQciwtE51U2+2v5xu8MQ3w0tH8iFVKhJn7036nY9SBUL
	 GP+go2FIlgDbgTIz52Qab1fUTEAOtAthXl4fv+iIwMkfE6XyzvxXTGdTpHZeCUXGR7
	 SWAYok5qGugfyOnY7eUN//QEAE8dm/gA117VeeLM85lpn2fDLsMDFs3laKThdL7esb
	 EX8YSFdT92+4zdQr6MLK3BtijPKeX0OoTFsxwzI1SIrby7mTJ7GmtPbSwUM/n0T05y
	 2z+sm1eEg9wxQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/6] ata: libata-scsi: Refactor ata_scsi_simulate()
Date: Tue, 22 Oct 2024 11:45:32 +0900
Message-ID: <20241022024537.251905-2-dlemoal@kernel.org>
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

Factor out the code handling the INQUIRY command in ata_scsi_simulate()
using the function ata_scsi_rbuf_fill() with the new actor
ata_scsiop_inquiry(). This new actor function calls the existing actors
to handle the standard inquiry as well as extended inquiry (VPD page
access).

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 106 ++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 43 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c97fc8dc270d..cc5bc47457d6 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1815,7 +1815,7 @@ static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
 }
 
 /**
- *	ata_scsiop_inq_std - Simulate INQUIRY command
+ *	ata_scsiop_inq_std - Simulate standard INQUIRY command
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *
@@ -2121,6 +2121,11 @@ static unsigned int ata_scsiop_inq_b2(struct ata_scsi_args *args, u8 *rbuf)
 
 static unsigned int ata_scsiop_inq_b6(struct ata_scsi_args *args, u8 *rbuf)
 {
+	if (!(args->dev->flags & ATA_DFLAG_ZAC)) {
+		ata_scsi_set_invalid_field(args->dev, args->cmd, 2, 0xff);
+		return 1;
+	}
+
 	/*
 	 * zbc-r05 SCSI Zoned Block device characteristics VPD page
 	 */
@@ -2145,6 +2150,11 @@ static unsigned int ata_scsiop_inq_b9(struct ata_scsi_args *args, u8 *rbuf)
 	u8 *desc = &rbuf[64];
 	int i;
 
+	if (!cpr_log) {
+		ata_scsi_set_invalid_field(args->dev, args->cmd, 2, 0xff);
+		return 1;
+	}
+
 	/* SCSI Concurrent Positioning Ranges VPD page: SBC-5 rev 1 or later */
 	rbuf[1] = 0xb9;
 	put_unaligned_be16(64 + (int)cpr_log->nr_cpr * 32 - 4, &rbuf[2]);
@@ -2159,6 +2169,57 @@ static unsigned int ata_scsiop_inq_b9(struct ata_scsi_args *args, u8 *rbuf)
 	return 0;
 }
 
+/**
+ *	ata_scsiop_inquiry - Simulate INQUIRY command
+ *	@args: device IDENTIFY data / SCSI command of interest.
+ *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
+ *
+ *	Returns data associated with an INQUIRY command output.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+static unsigned int ata_scsiop_inquiry(struct ata_scsi_args *args, u8 *rbuf)
+{
+	struct ata_device *dev = args->dev;
+	struct scsi_cmnd *cmd = args->cmd;
+	const u8 *scsicmd = cmd->cmnd;
+
+	/* is CmdDt set?  */
+	if (scsicmd[1] & 2) {
+		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
+		return 1;
+	}
+
+	/* Is EVPD clear? */
+	if ((scsicmd[1] & 1) == 0)
+		return ata_scsiop_inq_std(args, rbuf);
+
+	switch (scsicmd[2]) {
+	case 0x00:
+		return ata_scsiop_inq_00(args, rbuf);
+	case 0x80:
+		return ata_scsiop_inq_80(args, rbuf);
+	case 0x83:
+		return ata_scsiop_inq_83(args, rbuf);
+	case 0x89:
+		return ata_scsiop_inq_89(args, rbuf);
+	case 0xb0:
+		return ata_scsiop_inq_b0(args, rbuf);
+	case 0xb1:
+		return ata_scsiop_inq_b1(args, rbuf);
+	case 0xb2:
+		return ata_scsiop_inq_b2(args, rbuf);
+	case 0xb6:
+		return ata_scsiop_inq_b6(args, rbuf);
+	case 0xb9:
+		return ata_scsiop_inq_b9(args, rbuf);
+	default:
+		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
+		return 1;
+	}
+}
+
 /**
  *	modecpy - Prepare response for MODE SENSE
  *	@dest: output buffer
@@ -4263,48 +4324,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 
 	switch(scsicmd[0]) {
 	case INQUIRY:
-		if (scsicmd[1] & 2)		   /* is CmdDt set?  */
-			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
-		else if ((scsicmd[1] & 1) == 0)    /* is EVPD clear? */
-			ata_scsi_rbuf_fill(&args, ata_scsiop_inq_std);
-		else switch (scsicmd[2]) {
-		case 0x00:
-			ata_scsi_rbuf_fill(&args, ata_scsiop_inq_00);
-			break;
-		case 0x80:
-			ata_scsi_rbuf_fill(&args, ata_scsiop_inq_80);
-			break;
-		case 0x83:
-			ata_scsi_rbuf_fill(&args, ata_scsiop_inq_83);
-			break;
-		case 0x89:
-			ata_scsi_rbuf_fill(&args, ata_scsiop_inq_89);
-			break;
-		case 0xb0:
-			ata_scsi_rbuf_fill(&args, ata_scsiop_inq_b0);
-			break;
-		case 0xb1:
-			ata_scsi_rbuf_fill(&args, ata_scsiop_inq_b1);
-			break;
-		case 0xb2:
-			ata_scsi_rbuf_fill(&args, ata_scsiop_inq_b2);
-			break;
-		case 0xb6:
-			if (dev->flags & ATA_DFLAG_ZAC)
-				ata_scsi_rbuf_fill(&args, ata_scsiop_inq_b6);
-			else
-				ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
-			break;
-		case 0xb9:
-			if (dev->cpr_log)
-				ata_scsi_rbuf_fill(&args, ata_scsiop_inq_b9);
-			else
-				ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
-			break;
-		default:
-			ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
-			break;
-		}
+		ata_scsi_rbuf_fill(&args, ata_scsiop_inquiry);
 		break;
 
 	case MODE_SENSE:
-- 
2.47.0

