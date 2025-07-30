Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0FE1A26B
	for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2025 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835234; cv=none; b=b6L69b7HRGquTgRryOw15X8LUfBwXkcMqkcklcKUkj9zL+spkYudlAhO4FMInMimQkBu/3IahDVhCoTJMIOOMelA3uBRsEmoNbJSVlFK9f+rvGsAdcRgQaCkz1b87U5fJ5DEtP84UPaIxARU74RpcKbgTnC9YDt3bKsphV2T6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835234; c=relaxed/simple;
	bh=qu/BiPP83IjZksPTfAEdfclMu09f+j3CK2PFvfcZh6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJ+reqS2L6wmHahZJ/+SjL9N0czeBnPAPpMJXWP1HodrB4yCG5jBu+5V/7D2a8T+eCr5PQcqojcvb1tdSiW6fCeJlro/kqZOtPE0GE9QtWMi4/qI4h5jNkk3gSU03P8J+poD0kJZk9nTRB6/0pK2guJO7bEYeHm+1ivclFO+gHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2OGUssr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2OGUssr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43834C4CEF6;
	Wed, 30 Jul 2025 00:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753835233;
	bh=qu/BiPP83IjZksPTfAEdfclMu09f+j3CK2PFvfcZh6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2OGUssrebhaoADVWrNb1QJNig8dXHZoI4c5ENixVAKXqoKPb3EZE2T1Y7eySOn9y
	 QYt8GduQR70W0ZA7MRgOYwAv46fiMOeL4wtWDsJfBdBKJ4AN09IN6yyBn5fwM1RB13
	 4qOQV7+IbqAxiBDFzcmpT7UbGskSBhOcSOKlBEbyIplJlFbxWZzQQitO4nQFRoduk6
	 4yxPg/ul4vBl2AalkUcFormcoeQKe3O/h5Y8JgN6F2At9zsIbKGLE/kL+1U8xdG2ro
	 XNUjtC+QbJeAl5MutA3pkgXh/ZYg3ekhw/KJQwYdZfyLgDBzJPjjp8SkRlGMi/Xw0e
	 gNDFy3vbj6E6Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Lorenz Brun <lorenz@brun.one>,
	Brandon Schwartz <Brandon.Schwartz@wdc.com>
Subject: [PATCH 2/2] ata: libata-scsi: Return aborted command when missing sense and result TF
Date: Wed, 30 Jul 2025 09:24:41 +0900
Message-ID: <20250730002441.332816-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730002441.332816-1-dlemoal@kernel.org>
References: <20250730002441.332816-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ata_gen_ata_sense() is always called for a failed qc missing sense data
so that a sense key, code and code qualifier can be generated using
ata_to_sense_error() from the qc status and error fields of its result
task file. However, if the qc does not have its result task file filled,
ata_gen_ata_sense() returns early without setting a sense key.

Improve this by defaulting to returning ABORTED COMMAND without any
additional sense code, since we do not know the reason for the failure.
The same fix is also applied in ata_gen_passthru_sense() with the
additional check that the qc failed (qc->err_mask is set).

Fixes: 816be86c7993 ("ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 9b16c0f553e0..57f674f51b0c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -938,6 +938,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
 		ata_dev_dbg(dev,
 			    "missing result TF: can't generate ATA PT sense data\n");
+		if (qc->err_mask)
+			ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
 		return;
 	}
 
@@ -992,8 +994,8 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 
 	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
 		ata_dev_dbg(dev,
-			    "missing result TF: can't generate sense data\n");
-		return;
+			    "Missing result TF: reporting aborted command\n");
+		goto aborted;
 	}
 
 	/* Use ata_to_sense_error() to map status register bits
@@ -1004,13 +1006,15 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
-	} else {
-		/* Could not decode error */
-		ata_dev_warn(dev, "could not decode error status 0x%x err_mask 0x%x\n",
-			     tf->status, qc->err_mask);
-		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
 		return;
 	}
+
+	/* Could not decode error */
+	ata_dev_warn(dev,
+		"Could not decode error 0x%x, status 0x%x (err_mask=0x%x)\n",
+		tf->error, tf->status, qc->err_mask);
+aborted:
+	ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
 }
 
 void ata_scsi_sdev_config(struct scsi_device *sdev)
-- 
2.50.1

