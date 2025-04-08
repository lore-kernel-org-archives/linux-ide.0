Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D20264FB2
	for <linux-ide@vger.kernel.org>; Tue,  8 Apr 2025 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104543; cv=none; b=Z2pyh5fPz0h0OAkZ5P2BGDPYk8xWETuJq3X+gmKklSjeWXd3UZKMKWE4NTCLKhbJxQvBoOl8PPg/PibSqgbr4AXN0XfJgaUkB1US7hr8F4BF1pHCF0sl49ScltbXkaOiUexhax1qe84SVYDvzNf+yWyESqXZ3UgAINyxGkroXHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104543; c=relaxed/simple;
	bh=BQqiXp56wGB9ADnPwnZRumoehm0WQNd69lBG2hk+iSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHco8hBLNsLAV/dmIxX3ibcFW9SChuVPh0R4KjXEk1A+CuuMp6FFcshrjrtpn6bxMs6eFYDl0JSzfEjGrPBgBlrkdE6TA4eRyViyAZEnMSoIB5IE0tysJIoDgjpGJftPCjE7ay8SRo0TBxIhg2iDPpo1SE4g8C1cZ/a+1rJVIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1m+5XMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1m+5XMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F10C4CEEC;
	Tue,  8 Apr 2025 09:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744104542;
	bh=BQqiXp56wGB9ADnPwnZRumoehm0WQNd69lBG2hk+iSU=;
	h=From:To:Cc:Subject:Date:From;
	b=X1m+5XMJZ4EFCmA7XgGElncr+1eo8Kl80cOd4HCndleC1ISTHZPbewRpPUCQR8mVT
	 pNZOIAaYnBbOAvzRBBsegt/GQJoFEGlgOj3DYdWaz8WEdGsNCrWK/PVKHGZfoCnaqm
	 WVSJaalEaLEOMHJ0zn+Aa6p+Rn2CbfXL8Q+aR7mUZMIIOslYb5R2DvJlVRx56yFaVO
	 jwbVXOgM5wTYbLRgXXDWOE4I3Um1l4oZu1+q0h24EUsSRTEqq9X98UdUy+ZNfI6kJ0
	 8LLErucOiH6oz2kX+m026ZMK0l4fLywKyoRorLyPyQTyE1qbE59CBwLroMR/0rT+7z
	 +mpHnr2wG71hw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-sata: Use LBA from sense data descriptor
Date: Tue,  8 Apr 2025 11:28:59 +0200
Message-ID: <20250408092858.227519-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=cassel@kernel.org; h=from:subject; bh=BQqiXp56wGB9ADnPwnZRumoehm0WQNd69lBG2hk+iSU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNK/vIk6cK98WXGKYEzbrmSnDQy5UvKWHFZapxVXNNpdV pIU3Hq4o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABMxusDwP7Av6KB3zAa3yEvv J3Ld591Vs1Z74ZVGh4nM7lO1eHv1JjH89/dulr8yv6pUsjvb4QATg9ECl7zcKy+/u944xpZw/nE TPwA=
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

