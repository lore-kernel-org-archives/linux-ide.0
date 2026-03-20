Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7B339DBD0
	for <linux-ide@vger.kernel.org>; Fri, 20 Mar 2026 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004402; cv=none; b=qMFHmwi689d838h94kfSGppVRFnPwbb5Yp4WYCo+kjA3KICzGbPqCQKCdXZkLjgZLqF43oEcVc1kd0ncH8jUQEjLkgXkocPVqvE61aisy/V+hhaLFJtoN9anrnZtx2pg8jKxRik3MyGuZevqHB5l1ctD1VDuXnFz6xf+w2Onfpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004402; c=relaxed/simple;
	bh=HbijZu8l45jPjryRKgQ4iikPooqF+NovZ57WuGQeVWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fI51HHOSsRpP8zmC5NZp1vukRk4y+0A9y3J6QxvSKfnJvx/sF2dq6h8TaExhBitZZuIWmkZvyiJsqFn5JsSxaKNMu/4fEpiUlXyEMZXdiHvhV/Fve8RVwvFD83zMuIF/12RQY+KTSjhy71L2vUJUCtANjn4xN0Wn+8jejZQ9hEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqKJsmik; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqKJsmik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEB2C4AF0C;
	Fri, 20 Mar 2026 11:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774004401;
	bh=HbijZu8l45jPjryRKgQ4iikPooqF+NovZ57WuGQeVWg=;
	h=From:To:Cc:Subject:Date:From;
	b=rqKJsmikgcIvhhSTsRwUsk713R+vXcwt69GqtI8Bng+5qx6S7I6nyQ/n9o9Guajzf
	 2mtwqq/WuWt5h5efuCW+jbeCFh1iVt9yQtk5xWH10l91H3TVdAbfUJYuK4OjhcYGva
	 JE5pQMQmlPWRsCx8tP3RHdmI43N0FAFEtNvz/Cq6oTk3bs8D8xvpogv+OHALhLCi7D
	 oqmks3BYReXVC+PZ9O9XlzM1AQQv3GkYycAnNIZ/qZnRqqs0fTD5Hhzgd2Ic3W9TqQ
	 5Z7eXExEGkrBWAaLGvB9riUf42S86ckQwAOva0l/vl2UFhwdxYg1/iE/wnzDGGXl/M
	 dIm6KteKf6LHg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-scsi: refactor ata_scsiop_maint_in()
Date: Fri, 20 Mar 2026 11:59:51 +0100
Message-ID: <20260320105950.286341-2-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3112; i=cassel@kernel.org; h=from:subject; bh=HbijZu8l45jPjryRKgQ4iikPooqF+NovZ57WuGQeVWg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL3aiyL2LOtdbXDsulPLC0Ejf7ElbOtUM9N4mN5dWqSk uor2V/ZHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjIvkOMDMcW6PLEbhF49jrs e7zhfjbPKKNLSSFuluI/oh+FFn8Q52Fk+CF6R8+335fnDssJ0aQIhaUdx2Qc513Or2H8xrPg4Ze LjAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_scsiop_maint_in() is currently quite confusing to read, because it
currently only implements support for the service action REPORT SUPPORTED
OPERATION CODES.

Thus, when this function is checking for "invalid command format", it is
not very clear if it is an invalid command format for the MAINTENANCE IN
command itself, or an invalid command format for the (currently one and
only) service action/subcommand implemented for this command.

Move the service action to a separate function, so it is more clear that
the "invalid command format" check is actually specific for the REPORT
SUPPORTED OPERATION CODES service action.

This also makes it easier and less confusing to add support for additional
service actions in the future.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 47 ++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 00b3ffbfe169..06f3a243f037 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3573,28 +3573,13 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	return 1;
 }
 
-/**
- *	ata_scsiop_maint_in - Simulate a subset of MAINTENANCE_IN
- *	@dev: Target device.
- *	@cmd: SCSI command of interest.
- *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
- *
- *	Yields a subset to satisfy scsi_report_opcode()
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-static unsigned int ata_scsiop_maint_in(struct ata_device *dev,
-					struct scsi_cmnd *cmd, u8 *rbuf)
+static unsigned int ata_scsi_report_supported_opcodes(struct ata_device *dev,
+						      struct scsi_cmnd *cmd,
+						      u8 *rbuf)
 {
 	u8 *cdb = cmd->cmnd;
 	u8 supported = 0, cdlp = 0, rwcdlp = 0;
 
-	if ((cdb[1] & 0x1f) != MI_REPORT_SUPPORTED_OPERATION_CODES) {
-		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
-		return 0;
-	}
-
 	if (cdb[2] != 1 && cdb[2] != 3) {
 		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
 		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
@@ -3674,6 +3659,32 @@ static unsigned int ata_scsiop_maint_in(struct ata_device *dev,
 	return 4;
 }
 
+/**
+ *	ata_scsiop_maint_in - Simulate a subset of MAINTENANCE_IN
+ *	@dev: Target device.
+ *	@cmd: SCSI command of interest.
+ *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
+ *
+ *	Yields a subset to satisfy scsi_report_opcode()
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+static unsigned int ata_scsiop_maint_in(struct ata_device *dev,
+					struct scsi_cmnd *cmd, u8 *rbuf)
+{
+	u8 *cdb = cmd->cmnd;
+	u8 service_action = cdb[1] & 0x1f;
+
+	switch (service_action) {
+	case MI_REPORT_SUPPORTED_OPERATION_CODES:
+		return ata_scsi_report_supported_opcodes(dev, cmd, rbuf);
+	default:
+		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
+		return 0;
+	}
+}
+
 /**
  *	ata_scsi_report_zones_complete - convert ATA output
  *	@qc: command structure returning the data
-- 
2.53.0

