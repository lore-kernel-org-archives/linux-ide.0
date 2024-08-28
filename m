Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1E158851
	for <linux-ide@vger.kernel.org>; Wed, 28 Aug 2024 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830037; cv=none; b=Tws6VAFExEXPM55krfAXVSZ1X6kfVERzAImHLShN8hPigpvDbInfM744kVVHH9aPhOChTR7EqniJy/xmZnHsJcscz3OI8+wSYChm9n3N0QkwPTjyhrskRpc3OuFsS8h5T+CvG9/vf7RBJ/EsVQgkYBeyGqptlW3/EO7TU4jEcxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830037; c=relaxed/simple;
	bh=KICtPi47iyNbVmN4wwMK2WRKIx+ofa1sxTeZ1eGP0g0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=daj4vuphmRzRaiLuZPTsvFk8aNhc9ADtoUuRUmtE7fceWJgsE1ImQLz3aYRF2asvROMDsxOsM2A4PvDJmjsos9pVfboEbiyp3xz9CuCoBbicQ+YWqX+KnNTP4DlzDo0YtDNHqa7VKbqtn7ol0TEnANfRPs2jE1P6/ihGQqa3Ui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eH36Af3a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eH36Af3a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DB4C4DE15;
	Wed, 28 Aug 2024 07:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724830036;
	bh=KICtPi47iyNbVmN4wwMK2WRKIx+ofa1sxTeZ1eGP0g0=;
	h=From:To:Cc:Subject:Date:From;
	b=eH36Af3aUe4e8T5/pbE9uXxZ0L7ybwumHuhsymjedt4bObqDiSBPzPsXKuIAqdYwJ
	 fWMFfjaa/TI22qkmeOIzca+xmmr/VPQQL6P2wns29k3I3xwdAvURWuuXeXlJOgEhHW
	 nJH8dZ7zrJIoEzO5ais8TyoZHJ3moOZFMg/qKX8q4AM7pk15NICEBMiVfLdRJlyomu
	 LIY8RnET0enLQvU2rvsGp7JWcRBGB1+mXVh/MkMHQxSGvHxCl5ocJh8/Dc0i4q6CA4
	 q30/hwK7W+2XXPcVZ68HJs8czspW8dQJmlug05mhd6LnIac4EbsaYOfQf4z6/E8qIG
	 /dIquLZyPl3EQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: libata: Add helper ata_eh_decide_disposition()
Date: Wed, 28 Aug 2024 09:27:04 +0200
Message-ID: <20240828072703.339060-2-cassel@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5595; i=cassel@kernel.org; h=from:subject; bh=KICtPi47iyNbVmN4wwMK2WRKIx+ofa1sxTeZ1eGP0g0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLOXXRv2JLs//eOldD+NdOy7S/fjzQ/8VewfVblDUap2 PJln7+4dJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAitXoM/zOuHV+ybN6dL1fl 2hmPrUs7X/NfaZlh/dtbQboPpy26aWrC8M92ne1r1ckckbPqo3ujX6xvErp37VakTalnoYFklsG uS7wA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Every time I see libata code calling scsi_check_sense(), I get confused
why the code path that is working fine for SCSI code, is not sufficient
for libata code.

The reason is that SCSI usually gets the sense data as part of the
completion, and will thus automatically call scsi_check_sense(), which
will set the SCSI ML byte (if any).

However, for libata queued commands, we always need to fetch the sense
data via SCSI EH, and thus do not get the luxury of having
scsi_check_sense() called automatically.

Add a new helper, ata_eh_decide_disposition(), that has a ata_eh_ prefix
to more clearly highlight that this is only needed for code called by EH,
while also having a similar name to scsi_decide_disposition(), such that
it is easier to compare the libata code with the equivalent SCSI code.

Also add a big kdoc comment explaining why this helper is called/needed in
the first place.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Add an empty line after the preexisting variable declaration in
 ata_eh_analyze_tf(), as suggested by Damien.

 drivers/ata/libata-eh.c   | 47 ++++++++++++++++++++++++++++++++++-----
 drivers/ata/libata-sata.c |  8 +++----
 drivers/ata/libata.h      |  1 +
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 214b935c2ced..7de97ee8e78b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1401,6 +1401,43 @@ unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key)
 	return err_mask;
 }
 
+/**
+ *	ata_eh_decide_disposition - Disposition a qc based on sense data
+ *	@qc: qc to examine
+ *
+ *	For a regular SCSI command, the SCSI completion callback (scsi_done())
+ *	will call scsi_complete(), which will call scsi_decide_disposition(),
+ *	which will call scsi_check_sense(). scsi_complete() finally calls
+ *	scsi_finish_command(). This is fine for SCSI, since any eventual sense
+ *	data is usually returned in the completion itself (without invoking SCSI
+ *	EH). However, for a QC, we always need to fetch the sense data
+ *	explicitly using SCSI EH.
+ *
+ *	A command that is completed via SCSI EH will instead be completed using
+ *	scsi_eh_flush_done_q(), which will call scsi_finish_command() directly
+ *	(without ever calling scsi_check_sense()).
+ *
+ *	For a command that went through SCSI EH, it is the responsibility of the
+ *	SCSI EH strategy handler to call scsi_decide_disposition(), see e.g. how
+ *	scsi_eh_get_sense() calls scsi_decide_disposition() for SCSI LLDDs that
+ *	do not get the sense data as part of the completion.
+ *
+ *	Thus, for QC commands that went via SCSI EH, we need to call
+ *	scsi_check_sense() ourselves, similar to how scsi_eh_get_sense() calls
+ *	scsi_decide_disposition(), which calls scsi_check_sense(), in order to
+ *	set the correct SCSI ML byte (if any).
+ *
+ *	LOCKING:
+ *	EH context.
+ *
+ *	RETURNS:
+ *	SUCCESS or FAILED or NEEDS_RETRY or ADD_TO_MLQUEUE
+ */
+enum scsi_disposition ata_eh_decide_disposition(struct ata_queued_cmd *qc)
+{
+	return scsi_check_sense(qc->scsicmd);
+}
+
 /**
  *	ata_eh_request_sense - perform REQUEST_SENSE_DATA_EXT
  *	@qc: qc to perform REQUEST_SENSE_SENSE_DATA_EXT to
@@ -1627,7 +1664,8 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc)
 	}
 
 	if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
-		enum scsi_disposition ret = scsi_check_sense(qc->scsicmd);
+		enum scsi_disposition ret = ata_eh_decide_disposition(qc);
+
 		/*
 		 * SUCCESS here means that the sense code could be
 		 * evaluated and should be passed to the upper layers
@@ -1942,11 +1980,10 @@ static int ata_eh_read_sense_success_non_ncq(struct ata_link *link)
 		return -EIO;
 
 	/*
-	 * If we have sense data, call scsi_check_sense() in order to set the
-	 * correct SCSI ML byte (if any). No point in checking the return value,
-	 * since the command has already completed successfully.
+	 * No point in checking the return value, since the command has already
+	 * completed successfully.
 	 */
-	scsi_check_sense(qc->scsicmd);
+	ata_eh_decide_disposition(qc);
 
 	return 0;
 }
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 48660d445602..76904dce017e 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1455,12 +1455,10 @@ int ata_eh_read_sense_success_ncq_log(struct ata_link *link)
 		qc->flags |= ATA_QCFLAG_SENSE_VALID;
 
 		/*
-		 * If we have sense data, call scsi_check_sense() in order to
-		 * set the correct SCSI ML byte (if any). No point in checking
-		 * the return value, since the command has already completed
-		 * successfully.
+		 * No point in checking the return value, since the command has
+		 * already completed successfully.
 		 */
-		scsi_check_sense(qc->scsicmd);
+		ata_eh_decide_disposition(qc);
 	}
 
 	return ret;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 6abf265f626e..e4029626641d 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -162,6 +162,7 @@ extern void ata_eh_finish(struct ata_port *ap);
 extern int ata_ering_map(struct ata_ering *ering,
 			 int (*map_fn)(struct ata_ering_entry *, void *),
 			 void *arg);
+enum scsi_disposition ata_eh_decide_disposition(struct ata_queued_cmd *qc);
 extern unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key);
 extern unsigned int atapi_eh_request_sense(struct ata_device *dev,
 					   u8 *sense_buf, u8 dfl_sense_key);
-- 
2.46.0

