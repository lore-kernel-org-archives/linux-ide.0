Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F5DC2C8
	for <linux-ide@vger.kernel.org>; Tue, 22 Oct 2024 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729565141; cv=none; b=L+ijCgClXC2Jxs/g3QKr8lSF9qmhQC7iGtObmPNl8OMgcMeUWynvrnMG7et+oHRssPep6xE4rc2qOAmVRWL6sBuXXOP0hQHPS5J/S1vhw3MuouhcxTqNgc/ZWmrvPkziax+7fGfT4foKVJZDwmpft6kjrbhi9yNx0bOyPTHvtM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729565141; c=relaxed/simple;
	bh=a0Y7xEYIh6BHAzZZKXLJY5IRXzRxXI5sJf6Vv74YtCE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jr/dD82NLEklsaAj/IGDiqOx0qM5otHZj6BIoiOkuzBfUvackGyyELxrqm5sP/UOyttJ6wvxyFNxKa0mQRS7ly8FYZA5XtKySMZu58NvVMj13GN6Dbn2Y9v+iYDcbU+rFsNABbjTCjBZSJ0Udl4a2copikZ7ZpPN17TF2fcmAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKXLAdLK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKXLAdLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86498C4CEC3;
	Tue, 22 Oct 2024 02:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729565140;
	bh=a0Y7xEYIh6BHAzZZKXLJY5IRXzRxXI5sJf6Vv74YtCE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iKXLAdLK4FHWvGJA8lnahe8eLf4VweBAMxtb9c12CoESvmCMmT8U8iSQk90VSovHC
	 G69wNDLjxhMu9pOO3EsA2w8rQfHKIkIbhBawJ4W0QV7qauXKcWhYZ2OBD0zvzGRCSD
	 aHatdu2DJWNx3Uuw4YW6IW4aEtfzr4+4hhBVazmzOfQUP3hQm6YYomrRKB3cZhOpxZ
	 cReWf4ik/kRdKZQ3tQAxngR71I9jhT87huyUgFaDYMRm6Et/WCO5SUtTSbmXX0JKAw
	 ICVDGZvAadOXEKLLVuf4Cywb0drf+hB0gzqPOmZv8TC8DAY5TpcEHHkhiyyZtwNjzr
	 qgSlY8B6oYgbA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/6] ata: libata-scsi: Refactor ata_scsiop_read_cap()
Date: Tue, 22 Oct 2024 11:45:33 +0900
Message-ID: <20241022024537.251905-3-dlemoal@kernel.org>
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

Move the check for the scsi command service action being
SAI_READ_CAPACITY_16 from ata_scsi_simulate() into ata_scsiop_read_cap()
to simplify ata_scsi_simulate() for processing capacity reading commands
(READ_CAPACITY and SERVICE_ACTION_IN_16).

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 87 +++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 41 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index cc5bc47457d6..8097cf318b04 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2579,6 +2579,7 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
 static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 {
 	struct ata_device *dev = args->dev;
+	u8 *scsicmd = args->cmd->cmnd;
 	u64 last_lba = dev->n_sectors - 1; /* LBA of the last block */
 	u32 sector_size; /* physical sector size in bytes */
 	u8 log2_per_phys;
@@ -2588,7 +2589,7 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 	log2_per_phys = ata_id_log2_per_physical_sector(dev->id);
 	lowest_aligned = ata_id_logical_sector_offset(dev->id, log2_per_phys);
 
-	if (args->cmd->cmnd[0] == READ_CAPACITY) {
+	if (scsicmd[0] == READ_CAPACITY) {
 		if (last_lba >= 0xffffffffULL)
 			last_lba = 0xffffffff;
 
@@ -2603,42 +2604,52 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 		rbuf[5] = sector_size >> (8 * 2);
 		rbuf[6] = sector_size >> (8 * 1);
 		rbuf[7] = sector_size;
-	} else {
-		/* sector count, 64-bit */
-		rbuf[0] = last_lba >> (8 * 7);
-		rbuf[1] = last_lba >> (8 * 6);
-		rbuf[2] = last_lba >> (8 * 5);
-		rbuf[3] = last_lba >> (8 * 4);
-		rbuf[4] = last_lba >> (8 * 3);
-		rbuf[5] = last_lba >> (8 * 2);
-		rbuf[6] = last_lba >> (8 * 1);
-		rbuf[7] = last_lba;
 
-		/* sector size */
-		rbuf[ 8] = sector_size >> (8 * 3);
-		rbuf[ 9] = sector_size >> (8 * 2);
-		rbuf[10] = sector_size >> (8 * 1);
-		rbuf[11] = sector_size;
-
-		rbuf[12] = 0;
-		rbuf[13] = log2_per_phys;
-		rbuf[14] = (lowest_aligned >> 8) & 0x3f;
-		rbuf[15] = lowest_aligned;
-
-		if (ata_id_has_trim(args->id) &&
-		    !(dev->quirks & ATA_QUIRK_NOTRIM)) {
-			rbuf[14] |= 0x80; /* LBPME */
-
-			if (ata_id_has_zero_after_trim(args->id) &&
-			    dev->quirks & ATA_QUIRK_ZERO_AFTER_TRIM) {
-				ata_dev_info(dev, "Enabling discard_zeroes_data\n");
-				rbuf[14] |= 0x40; /* LBPRZ */
-			}
+		return 0;
+	}
+
+	/*
+	 * READ CAPACITY 16 command is defined as a service action
+	 * (SERVICE_ACTION_IN_16 command).
+	 */
+	if (scsicmd[0] != SERVICE_ACTION_IN_16 ||
+	    (scsicmd[1] & 0x1f) != SAI_READ_CAPACITY_16) {
+		ata_scsi_set_invalid_field(dev, args->cmd, 1, 0xff);
+		return 1;
+	}
+
+	/* sector count, 64-bit */
+	rbuf[0] = last_lba >> (8 * 7);
+	rbuf[1] = last_lba >> (8 * 6);
+	rbuf[2] = last_lba >> (8 * 5);
+	rbuf[3] = last_lba >> (8 * 4);
+	rbuf[4] = last_lba >> (8 * 3);
+	rbuf[5] = last_lba >> (8 * 2);
+	rbuf[6] = last_lba >> (8 * 1);
+	rbuf[7] = last_lba;
+
+	/* sector size */
+	rbuf[ 8] = sector_size >> (8 * 3);
+	rbuf[ 9] = sector_size >> (8 * 2);
+	rbuf[10] = sector_size >> (8 * 1);
+	rbuf[11] = sector_size;
+
+	if (ata_id_zoned_cap(args->id) || args->dev->class == ATA_DEV_ZAC)
+		rbuf[12] = (1 << 4); /* RC_BASIS */
+	rbuf[13] = log2_per_phys;
+	rbuf[14] = (lowest_aligned >> 8) & 0x3f;
+	rbuf[15] = lowest_aligned;
+
+	if (ata_id_has_trim(args->id) && !(dev->quirks & ATA_QUIRK_NOTRIM)) {
+		rbuf[14] |= 0x80; /* LBPME */
+
+		if (ata_id_has_zero_after_trim(args->id) &&
+		    dev->quirks & ATA_QUIRK_ZERO_AFTER_TRIM) {
+			ata_dev_info(dev, "Enabling discard_zeroes_data\n");
+			rbuf[14] |= 0x40; /* LBPRZ */
 		}
-		if (ata_id_zoned_cap(args->id) ||
-		    args->dev->class == ATA_DEV_ZAC)
-			rbuf[12] = (1 << 4); /* RC_BASIS */
 	}
+
 	return 0;
 }
 
@@ -4333,14 +4344,8 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 		break;
 
 	case READ_CAPACITY:
-		ata_scsi_rbuf_fill(&args, ata_scsiop_read_cap);
-		break;
-
 	case SERVICE_ACTION_IN_16:
-		if ((scsicmd[1] & 0x1f) == SAI_READ_CAPACITY_16)
-			ata_scsi_rbuf_fill(&args, ata_scsiop_read_cap);
-		else
-			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
+		ata_scsi_rbuf_fill(&args, ata_scsiop_read_cap);
 		break;
 
 	case REPORT_LUNS:
-- 
2.47.0

