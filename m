Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173FC2C8
	for <linux-ide@vger.kernel.org>; Tue, 22 Oct 2024 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729565142; cv=none; b=MO0ap/CArDOMxsXAB0L/kf00XKP5ojn8Oyxxf9QTvYOVp4CfvyNXhOcL98BOfhtBy6Rrey0vspZNC9ZU05C1i9M46ctY3Qrrj7y/xpbrcCI6mZLSnTp6UwQOviw7H07UHdP7sC8a8iVsSHHWOnyt/BYqF8T+c8j5/+ffpGrnJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729565142; c=relaxed/simple;
	bh=wMBkIDn/zDXjbNQlCqtIE2zjKIuQmevdT/vLdw+PDvA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ftccx0Ay6bXHo0925bBTEnwA44gv+TvIAwKFqfvbabf9zFRjwEReF2AF4N5LbjHSTSKe/Hkh39uQEaTaHTs8xugvFt/Mba32Wt7nbTJQ13id9C3153WwIpQl2QtyHig/17r/aRVOB8VahdOSRfO8teu3CGcrka+Op3PzVaOLm9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrCZLz+j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrCZLz+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496E9C4CECD;
	Tue, 22 Oct 2024 02:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729565141;
	bh=wMBkIDn/zDXjbNQlCqtIE2zjKIuQmevdT/vLdw+PDvA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QrCZLz+jsmuiqh+2UIfdQRELKuxTBHNaC4PF5P2bdIrbQKbahiqCovVPhMkGyFiDv
	 mTMRT61My7vFFVUVCB/epklNExF6SNmbi/nHcGSELP4o6y/gpJ3ihpvHiOnmOQSpwi
	 +rgOb5qZbUx/MdujXulcazCzAdO4VwMgMmvz7x4+P3MoQti3RczXeaZ+ZLJULT5uiy
	 zwDyDyOOYc+bbmYDYoS2bYVp7VdzuOXpY0TIAk+grSrM0G5fnb4iDVtZE5wGhKwRhG
	 bJRSqElN9R2YsEq5uwq124/w2orn+/H8jQUZosjCHlL8B67RZs/M4GgYFzNJZqqAR3
	 C57JIQsiJpxAA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 3/6] ata: libata-scsi: Refactor ata_scsiop_maint_in()
Date: Tue, 22 Oct 2024 11:45:34 +0900
Message-ID: <20241022024537.251905-4-dlemoal@kernel.org>
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

Move the check for MI_REPORT_SUPPORTED_OPERATION_CODES from
ata_scsi_simulate() into ata_scsiop_maint_in() to simplify
ata_scsi_simulate() code.

Furthermore, since an rbuff fill actor function returning a non-zero
value causes no data to be returned for the command, directly return
an error (return 1) for invalid command formt after setting the invalid
field in cdb error.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 8097cf318b04..f9c70f650cfc 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3388,12 +3388,16 @@ static unsigned int ata_scsiop_maint_in(struct ata_scsi_args *args, u8 *rbuf)
 	struct ata_device *dev = args->dev;
 	u8 *cdb = args->cmd->cmnd;
 	u8 supported = 0, cdlp = 0, rwcdlp = 0;
-	unsigned int err = 0;
+
+	if ((cdb[1] & 0x1f) != MI_REPORT_SUPPORTED_OPERATION_CODES) {
+		ata_scsi_set_invalid_field(dev, args->cmd, 1, 0xff);
+		return 1;
+	}
 
 	if (cdb[2] != 1 && cdb[2] != 3) {
 		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
-		err = 2;
-		goto out;
+		ata_scsi_set_invalid_field(dev, args->cmd, 1, 0xff);
+		return 1;
 	}
 
 	switch (cdb[3]) {
@@ -3461,11 +3465,12 @@ static unsigned int ata_scsiop_maint_in(struct ata_scsi_args *args, u8 *rbuf)
 	default:
 		break;
 	}
-out:
+
 	/* One command format */
 	rbuf[0] = rwcdlp;
 	rbuf[1] = cdlp | supported;
-	return err;
+
+	return 0;
 }
 
 /**
@@ -4377,10 +4382,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 		break;
 
 	case MAINTENANCE_IN:
-		if ((scsicmd[1] & 0x1f) == MI_REPORT_SUPPORTED_OPERATION_CODES)
-			ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
-		else
-			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
+		ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
 		break;
 
 	/* all other commands */
-- 
2.47.0

