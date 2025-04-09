Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B550E1D618E
	for <linux-ide@vger.kernel.org>; Wed,  9 Apr 2025 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744188351; cv=none; b=krU2HBpCVIPKdCpjxbsNhyYsfkBaJeoWFKMhTMTJff2IrBXOq2qFRRfEsc8YKgi2b+HXdHJakj9ux8L2OMBsfr5LvVfFymF7HAXfECdOtMEzTcI+0O9/iCJBjmqIBUa+2DAjRgoCn7PNkXXRpbqFVaS0romAgJ4o807dCM/RiAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744188351; c=relaxed/simple;
	bh=7lO7q/bTa6BXftewhXk/EyGhDeoX1Rbvq2Jzo2CHogE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUgFkgYM24LnM0zow9SsGAbjxF/KDrZ8TLbIfQTAlcr2JgnEBWOgY8Ta3LijJmeo2K7ImgXFe+Rbs21g2I0RMugFe1LhXKxiaTbR0ipFlIDVS1O0PHhqx6Eff9HN7E5L7k4/iquC/J/pIgR/b7CnkXOBSP5EdjxlZueQ4zy/S4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyYPt3EN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyYPt3EN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF1AC4CEE3;
	Wed,  9 Apr 2025 08:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744188351;
	bh=7lO7q/bTa6BXftewhXk/EyGhDeoX1Rbvq2Jzo2CHogE=;
	h=From:To:Cc:Subject:Date:From;
	b=IyYPt3ENWRF3tjPTW4KNFIulvl0Y2USTJdFX5cKDCb8WEhFba8tde0lJeZ3ZA+rJ4
	 UHABjDahDNfOz+aIsQeRX8fjrcFl4mLSzWI95jRB1fpTTpcG7W1ClVRWZrXnppEGRX
	 KPZyDjYkZbU1v510ZATGbt5hHCuX24ox/lhFVZ+HuLqs3iBAcMRWw5jdgCaAFeY+51
	 j+Z010wywgj4tYZIyZwETLNHtuXfOL5yyco0gcnI1RGJouogtK++ssxesDL7h+iEts
	 V93iHtXYNb8yWVY3xF2KdH1PwOB50f1LTmFmFOxopeCJtVBRwXBD+tJpuPxIQqvAXa
	 ZGI0BHx3wFstA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2] ata: libata-sata: Use LBA from sense data descriptor
Date: Wed,  9 Apr 2025 10:45:47 +0200
Message-ID: <20250409084546.121694-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1688; i=cassel@kernel.org; h=from:subject; bh=7lO7q/bTa6BXftewhXk/EyGhDeoX1Rbvq2Jzo2CHogE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNK/Ge+us2U+GyTx+OCK7XwXd67V+NtU+PfU2riZHz5eX ZRW5FxW0VHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJiBcxMnz7vlW2sExNOlDT aE3c2qJNJ1vOdpWlGz+LWtaU2jm7up2RocXJzK9+jcpqxsL6c6+dW+Tv8gWpPvnz7sv0sq0+m3O VmAE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The definition of the LBA field in the sense data descriptor is:

"If definition of the sense data to be returned when a command completes
without an error includes an LBA value, then the LBA field contains the
defined value. Otherwise, the LBA field contains a copy of the LBA field
in the command inputs for the command that completed without an error
and returned sense data."

Thus, the LBA field in the sense data descriptor can contain a LBA value
that is different from the LBA field in the command input.

Therefore, just like how ata_eh_read_log_10h() overrides qc->result_tf
with the LBA in the NCQ Command Error log, override qc->result_tf with
the LBA in the Successful NCQ Commands log.

Fixes: 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL commands using policy 0xD")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-sata.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index ba300cc0a3a3..c21fdacd0777 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1556,6 +1556,14 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 			continue;
 		}
 
+		/* LBA in sense data desc can be different from LBA in qc->tf */
+		qc->result_tf.lbal = sense[8];
+		qc->result_tf.lbam = sense[9];
+		qc->result_tf.lbah = sense[10];
+		qc->result_tf.hob_lbal = sense[11];
+		qc->result_tf.hob_lbam = sense[12];
+		qc->result_tf.hob_lbah = sense[13];
+
 		/* Set sense without also setting scsicmd->result */
 		scsi_build_sense_buffer(dev->flags & ATA_DFLAG_D_SENSE,
 					qc->scsicmd->sense_buffer, sk,
-- 
2.49.0

