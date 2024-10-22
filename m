Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05677C2C8
	for <linux-ide@vger.kernel.org>; Tue, 22 Oct 2024 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729565144; cv=none; b=EidOjQUR/5fowHcmUJxPQkiqILOc2k5cy9tMHGxctVV4avw/yDtKJGoa8uncjJzwavioeGHPZeE2MU8tBAld8ZGyAma/c9MYJ78xW84p4w72GH11B0ypJlTBt6oP5kMBqqgsZ3qzvJmg/o1WYp5TP5yFLnvpu/KDVCpae+irdhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729565144; c=relaxed/simple;
	bh=qaPS5hZCGVkdte95LKKDORi87RT1OzIr7VRHQnLyfFc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQ7HCMBvghFs1VTwDXJaXmxs5J2IRKnORS4TelHFJN2GSjT6KDEDsIgxjqf+NMZsNZJr9BnHr1RVsCJs20/P1+NdRLgkXeed1TyTN3lQZ/OiyWM2ztHQzWVWyLdaRzkATp1+SaXxcLG1Cg5h+hSqP40Qv2f3yKxwRaELRzzkKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1lUcWuD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1lUcWuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829E5C4CECD;
	Tue, 22 Oct 2024 02:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729565143;
	bh=qaPS5hZCGVkdte95LKKDORi87RT1OzIr7VRHQnLyfFc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Z1lUcWuDISqAK8jUMjWAmkUp0W9AIFguXrkwXZ6wmJ2BeZkG/cjUGc0hldcj74kjj
	 36ElUmwYQ91WfVKWWHcqWgSlfKzhCc4dz80NNoQACG0PdHNvuxijDvLXaLgq27Ycdu
	 GryIyLhF2qvtTtwn1Irc+uH/PopouuL0vSQhjA89Ul/fL5gwAbXxajTEhPjF7vs/ye
	 KIfzJgj7QMDezY/FlYKVK8BTg2+wiN8gs7nbyiH6pBQGeM7h7URfBNjcf8/7bPEbXs
	 Ovp5gHZ/CQaacMz7ayaQ5/6PhLVVmtOtx05rjS50SN6GVu47In4qtJ9LS48g1UTU/d
	 eZmATlr++HdNg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 6/6] ata: libata-scsi: Return residual for emulated SCSI commands
Date: Tue, 22 Oct 2024 11:45:37 +0900
Message-ID: <20241022024537.251905-7-dlemoal@kernel.org>
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

The function ata_scsi_rbuf_fill() used to fill the reply buffer of
emulated SCSI commands always copies the ATA reply buffer
(ata_scsi_rbuf) up to the size of the SCSI command buffer (the transfer
length for the command), even if the reply is shorter than the SCSI
command buffer. This leads to issuers of the SCSI command to always get
a result without any residual (resid is always 0) despite the
potentially shorter reply for the command.

Modify all fill actors used by ata_scsi_rbuf_fill() to return the number
of bytes filled for the reply and 0 in case of error. Using this value,
add a call to scsi_set_resid() in ata_scsi_rbuf_fill() to set the
correct residual for the SCSI command when the reply length is shorter
than the command buffer.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 81 +++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4593258d2b6a..556f7b417f3b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1792,17 +1792,19 @@ static void ata_scsi_rbuf_fill(struct ata_device *dev, struct scsi_cmnd *cmd,
 		unsigned int (*actor)(struct ata_device *dev,
 				      struct scsi_cmnd *cmd, u8 *rbuf))
 {
-	unsigned int rc;
 	unsigned long flags;
+	unsigned int len;
 
 	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
 
 	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
-	rc = actor(dev, cmd, ata_scsi_rbuf);
-	if (rc == 0) {
+	len = actor(dev, cmd, ata_scsi_rbuf);
+	if (len) {
 		sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
 				    ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
 		cmd->result = SAM_STAT_GOOD;
+		if (scsi_bufflen(cmd) > len)
+			scsi_set_resid(cmd, scsi_bufflen(cmd) - len);
 	}
 
 	spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
@@ -1890,7 +1892,11 @@ static unsigned int ata_scsiop_inq_std(struct ata_device *dev,
 	else
 		memcpy(rbuf + 58, versions, sizeof(versions));
 
-	return 0;
+	/*
+	 * Include all 8 possible version descriptors, even if not all of
+	 * them are popoulated.
+	 */
+	return 96;
 }
 
 /**
@@ -1928,7 +1934,8 @@ static unsigned int ata_scsiop_inq_00(struct ata_device *dev,
 		num_pages++;
 	}
 	rbuf[3] = num_pages;	/* number of supported VPD pages */
-	return 0;
+
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -1955,7 +1962,8 @@ static unsigned int ata_scsiop_inq_80(struct ata_device *dev,
 	memcpy(rbuf, hdr, sizeof(hdr));
 	ata_id_string(dev->id, (unsigned char *) &rbuf[4],
 		      ATA_ID_SERNO, ATA_ID_SERNO_LEN);
-	return 0;
+
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2016,7 +2024,8 @@ static unsigned int ata_scsiop_inq_83(struct ata_device *dev,
 		num += ATA_ID_WWN_LEN;
 	}
 	rbuf[3] = num - 4;    /* page len (assume less than 256 bytes) */
-	return 0;
+
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2053,7 +2062,8 @@ static unsigned int ata_scsiop_inq_89(struct ata_device *dev,
 	rbuf[56] = ATA_CMD_ID_ATA;
 
 	memcpy(&rbuf[60], &dev->id[0], 512);
-	return 0;
+
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2104,7 +2114,7 @@ static unsigned int ata_scsiop_inq_b0(struct ata_device *dev,
 		put_unaligned_be32(1, &rbuf[28]);
 	}
 
-	return 0;
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2134,7 +2144,7 @@ static unsigned int ata_scsiop_inq_b1(struct ata_device *dev,
 	if (zoned)
 		rbuf[8] = (zoned << 4);
 
-	return 0;
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2157,7 +2167,7 @@ static unsigned int ata_scsiop_inq_b2(struct ata_device *dev,
 	rbuf[3] = 0x4;
 	rbuf[5] = 1 << 6;	/* TPWS */
 
-	return 0;
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2177,7 +2187,7 @@ static unsigned int ata_scsiop_inq_b6(struct ata_device *dev,
 {
 	if (!(dev->flags & ATA_DFLAG_ZAC)) {
 		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
-		return 1;
+		return 0;
 	}
 
 	/*
@@ -2195,7 +2205,7 @@ static unsigned int ata_scsiop_inq_b6(struct ata_device *dev,
 	put_unaligned_be32(dev->zac_zones_optimal_nonseq, &rbuf[12]);
 	put_unaligned_be32(dev->zac_zones_max_open, &rbuf[16]);
 
-	return 0;
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2219,7 +2229,7 @@ static unsigned int ata_scsiop_inq_b9(struct ata_device *dev,
 
 	if (!cpr_log) {
 		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
-		return 1;
+		return 0;
 	}
 
 	/* SCSI Concurrent Positioning Ranges VPD page: SBC-5 rev 1 or later */
@@ -2233,7 +2243,7 @@ static unsigned int ata_scsiop_inq_b9(struct ata_device *dev,
 		put_unaligned_be64(cpr_log->cpr[i].num_lbas, &desc[16]);
 	}
 
-	return 0;
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2255,7 +2265,7 @@ static unsigned int ata_scsiop_inquiry(struct ata_device *dev,
 	/* is CmdDt set?  */
 	if (scsicmd[1] & 2) {
 		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
-		return 1;
+		return 0;
 	}
 
 	/* Is EVPD clear? */
@@ -2283,7 +2293,7 @@ static unsigned int ata_scsiop_inquiry(struct ata_device *dev,
 		return ata_scsiop_inq_b9(dev, cmd, rbuf);
 	default:
 		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
-		return 1;
+		return 0;
 	}
 }
 
@@ -2614,24 +2624,27 @@ static unsigned int ata_scsiop_mode_sense(struct ata_device *dev,
 			rbuf[3] = sizeof(sat_blk_desc);
 			memcpy(rbuf + 4, sat_blk_desc, sizeof(sat_blk_desc));
 		}
-	} else {
-		put_unaligned_be16(p - rbuf - 2, &rbuf[0]);
-		rbuf[3] |= dpofua;
-		if (ebd) {
-			rbuf[7] = sizeof(sat_blk_desc);
-			memcpy(rbuf + 8, sat_blk_desc, sizeof(sat_blk_desc));
-		}
+
+		return rbuf[0] + 1;
+	}
+
+	put_unaligned_be16(p - rbuf - 2, &rbuf[0]);
+	rbuf[3] |= dpofua;
+	if (ebd) {
+		rbuf[7] = sizeof(sat_blk_desc);
+		memcpy(rbuf + 8, sat_blk_desc, sizeof(sat_blk_desc));
 	}
-	return 0;
+
+	return get_unaligned_be16(&rbuf[0]) + 2;
 
 invalid_fld:
 	ata_scsi_set_invalid_field(dev, cmd, fp, bp);
-	return 1;
+	return 0;
 
 saving_not_supp:
 	ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST, 0x39, 0x0);
 	 /* "Saving parameters not supported" */
-	return 1;
+	return 0;
 }
 
 /**
@@ -2674,7 +2687,7 @@ static unsigned int ata_scsiop_read_cap(struct ata_device *dev,
 		rbuf[6] = sector_size >> (8 * 1);
 		rbuf[7] = sector_size;
 
-		return 0;
+		return 8;
 	}
 
 	/*
@@ -2684,7 +2697,7 @@ static unsigned int ata_scsiop_read_cap(struct ata_device *dev,
 	if (scsicmd[0] != SERVICE_ACTION_IN_16 ||
 	    (scsicmd[1] & 0x1f) != SAI_READ_CAPACITY_16) {
 		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
-		return 1;
+		return 0;
 	}
 
 	/* sector count, 64-bit */
@@ -2719,7 +2732,7 @@ static unsigned int ata_scsiop_read_cap(struct ata_device *dev,
 		}
 	}
 
-	return 0;
+	return 16;
 }
 
 /**
@@ -2738,7 +2751,7 @@ static unsigned int ata_scsiop_report_luns(struct ata_device *dev,
 {
 	rbuf[3] = 8;	/* just one lun, LUN 0, size 8 bytes */
 
-	return 0;
+	return 16;
 }
 
 /*
@@ -3463,13 +3476,13 @@ static unsigned int ata_scsiop_maint_in(struct ata_device *dev,
 
 	if ((cdb[1] & 0x1f) != MI_REPORT_SUPPORTED_OPERATION_CODES) {
 		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
-		return 1;
+		return 0;
 	}
 
 	if (cdb[2] != 1 && cdb[2] != 3) {
 		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
 		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
-		return 1;
+		return 0;
 	}
 
 	switch (cdb[3]) {
@@ -3542,7 +3555,7 @@ static unsigned int ata_scsiop_maint_in(struct ata_device *dev,
 	rbuf[0] = rwcdlp;
 	rbuf[1] = cdlp | supported;
 
-	return 0;
+	return 4;
 }
 
 /**
-- 
2.47.0

