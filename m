Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01431494A00
	for <linux-ide@vger.kernel.org>; Wed, 13 May 2026 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685253; cv=none; b=aHViWVeERm4g2KYU4nIkEGBX9ruwZAe1gkylYDo6tpA8jv0TxNKql+uTBgehXPpBXzte9EAJpiOiuXXSSo4pwHQXST6tl8P6NOB3ofo9Jh4TVKjfQtLmqImcXyjASbmPE74PzxyNz3uQNqg6s56aj4lEmPLHH98nN6GT2JXhamI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685253; c=relaxed/simple;
	bh=QL1hgyowVfja/vcJIALXSKCDzjwmNt42m3BowKG8WeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3Bh1JliCfNHSXjeS8v3DPiesUWIT35Y+iK8h/RMitngb6R+GBbmKjEFhTFPNeG++RrYb/Dxx9wtSvnxB3+2j4K1ihGrVdup56EmD7/FnozVbxhECGZ9vBxdB/TnAW6um0W5Cu8ZGTV+MtuXBWBARk2Yt7KTI52mDcnqOJjhB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaJw5sJV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaJw5sJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3025AC19425;
	Wed, 13 May 2026 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778685252;
	bh=QL1hgyowVfja/vcJIALXSKCDzjwmNt42m3BowKG8WeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AaJw5sJVaOCRaU2hB4vvcQajcqQjX7ruecf55JaFFubL0BZnwjFDDM8GOB2+2nAVt
	 FJTPB83Qaw8AniTQKZJvBqbCFhEaSi7xjyYZXtQcaMhqfQhJJwYdXcml+Z3uQrFru3
	 hGUs3ZQcPc2By2WRNj6sd/hgXoNiKp+4CQlRMcEdsgcbM+Opee6V5F9nmVBSYVd2eh
	 GPrCSfkKeXyQU/ju9+HRqZDUYjHLYb9S1TunPqSotTh6plMP7dNRSejVaMtjJmGKMU
	 7JhpbrpbdrLN+/GZNr2fRDgLw7gJ1pOyfMhGQmDZG1qfBPrl7pQhLoxhdjT7qxOYjh
	 xul/W9GXQaFuQ==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v4 2/4] ata: libata-scsi: do not use the deferred QC feature for ATA_DEFER_PORT
Date: Wed, 13 May 2026 17:14:01 +0200
Message-ID: <20260513151359.1075403-8-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513151359.1075403-6-cassel@kernel.org>
References: <20260513151359.1075403-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567; i=cassel@kernel.org; h=from:subject; bh=QL1hgyowVfja/vcJIALXSKCDzjwmNt42m3BowKG8WeQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJYppq7PlbM0Fq6gOfF3uPrcoJeVP3jqLzVU8r6VXweh /fNErN9HaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjIX0FGhj3PuXafd3/++J/p 9/JeofMrWXx8lOY67ePYbGXS2th2ZRsjw4OwaRWZsplp1o+YJA53vDTPWZaQOOtMwix2J+0FiyV 5OAE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The deferred QC feature was meant to handle mixed NCQ and non-NCQ commands,
i.e. for return value ATA_DEFER_LINK.

ATA_DEFER_PORT is returned by PATA drivers, but also certain SATA drivers
like sata_mv and sata_sil24 that uses ap->excl_link to workaround hardware
bugs in these HBAs. Regardless of the reason, using the deferred QC feature
for ATA_DEFER_PORT is always wrong, and will break the ap->excl_link usage
of the SATA drivers that rely on that feature.

Modify ata_scsi_qc_issue() to only use the deferred QC feature when mixing
NCQ and non-NCQ commands, i.e. ATA_DEFER_LINK.

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b9064dd4390c..22642a0e6b84 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1789,11 +1789,11 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 		goto defer_qc;
 	case ATA_DEFER_PORT:
 		ret = SCSI_MLQUEUE_HOST_BUSY;
-		goto defer_qc;
+		goto free_qc;
 	default:
 		WARN_ON_ONCE(1);
 		ret = SCSI_MLQUEUE_HOST_BUSY;
-		goto defer_qc;
+		goto free_qc;
 	}
 
 issue_qc:
@@ -1813,6 +1813,7 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 		return 0;
 	}
 
+free_qc:
 	/* Force a requeue of the command to defer its execution. */
 	ata_qc_free(qc);
 
-- 
2.54.0

