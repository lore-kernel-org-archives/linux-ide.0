Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739303;
	b=DeFbQUoWPqDTwcHkrVDuplZwOUUVOmkfx5QhYF8+j/wTr69UIPtKZcMvIGdwph7pTfkt
	 ZM1e5pGtFiIBs7rrOzT8eKefBiON5EpuP1GitzabjrzcX+bgp7iCstdQWy6B6KkLDEqu7
	 kw+yvuT8Sw+1lVC3Rn6ree9Z43ln5eK/kLnbP9oYfLATWE/QCUilhbXuGvUlnm30NeM0b
	 V8Qb8xJmtUiV/m7DwgtT5kACS5m1nOUOpBMzwHhYfiM4TSo8SHmVtD8WA5dnwp7nbGpdx
	 He1YrFear2sWhyUf6liRqgzeKmaf5GGVqd6ijP9ybqCJ2K+EZZkPEdrarBUHgavQodg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739303;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=JIzh6U5utD9I/XV1ofqEizcGewetXkVlNWKf4obdnI4=;
	b=kFr+2V/m+nfy5elTygCmV/RPH44U0IWneO5LZCoB+w0pBVIVTIgs6YPn8CQFNF+ciLiX
	 o3hbVZ3zZtvPY5Kjvo6vzEIhYBBn4/OP6ezMuZKX0deqaseA8b19ZbvynH8bUbAS0+8zh
	 9NZxbCNtu0JNPbQNKgksAyvuV9IU0aVOwB6KGMC8IFMuAoGnLnUo7d+Vfasn/vgmat+vS
	 hNSdm32D4IXLOMSGoxrZ2iK9XY+VTyLNVTBb+jo7BRRrF9cwo2j0G24ds9aOY/Ih4te/o
	 ElXEOVbib6B3r7Cai1GVXoTxDFWpxhRu6y++5mJdqrac7SDH36Rfmc1ESXnnFA3pP+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jn6qOmPD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52590606A324
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jn6qOmPD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A551F00A02;
	Tue,  3 Nov 2026 20:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739302;
	bh=JIzh6U5utD9I/XV1ofqEizcGewetXkVlNWKf4obdnI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jn6qOmPDKBVCtzQXzzaUtWvOt+Ss6QCbnod/Vq4C+MV7DAsGKfPrZz+gN6F0Fj7BA
	 uc8KNebaN5xljMLkuU9Wau57mYu2pP62lzI6mrsf5bkSX9DC9TsiGsn9J21HYMRc0c
	 qFpXgM+a/WFDRA3sL4plkjb1bbYPGEh9L4lty2XtAfiUsBgbHisWw95e7Atq1qoVja
	 eXNr7zS7IwEDmbq3WfyY8qcWJ0BGN6woDgohq/u7KiBWZ9qoEMkAYqqaU/MY77msRm
	 R+aEm82af14YNLBPimIcYL2XikosYSOL2NM0yMOqdLk9tJkO5USs3DHHEdmyZVFH35
	 dtqE0fzswt55g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Shao Mingyin <shao.mingyin@zte.com.cn>,
	Hannes Reinecke <hare@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/8] ata: libata-scsi: do not accept subpage code FFh in MODE SELECT
Date: Tue,  3 Nov 2026 21:54:51 +0100
Message-ID: <20261103205448.931471-12-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103205448.931471-10-cassel@kernel.org>
References: <20261103205448.931471-10-cassel@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021; i=cassel@kernel.org; h=from:subject; bh=h1mj7F5085LSwdRBIX52F2uCoUR+TuHVmcbUbgQ8YJg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJeecn2zu8pu1y2Wazo4/Q3p9JUvtnN4OjbImGx0NojM /Jd+uQpHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiILCfDP+XLxz36n18POb2p bs3FmdvuNUwr4TLjvf7OnOmZvGZIXwrDX5kIp/sPpjnveRbsJ3ze7uXSELmHc1YwWK64Wmax6HN KFiMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When the SUBPAGE CODE of the mode page in a MODE SELECT parameter list
is FFh, ata_scsi_mode_select_xlat() rejects it for the control mode
page, but accepts it for all other mode pages, i.e. for the caching
mode page, the only other mode page that it supports.

However, FFh is not the subpage code of an actual mode page: SPC-7
(7.5.2) only defines it as the MODE SENSE request code for all
subpages. SUBPAGE CODE FFh only means "all subpages" in requests, i.e.
in the MODE SENSE CDB for mode pages and in the LOG SELECT CDB for log
pages (see SPC-5, 6.8), while the SUBPAGE CODE of a mode page in a MODE
SELECT parameter list identifies a specific mode page. Also, SAT-2 and
later versions of SAT define the Caching mode page with the SPF bit set
to zero (see SAT-6, 10.4.9), i.e. without a SUBPAGE CODE field.

Remove the ALL_SUB_MPAGES case, so that SUBPAGE CODE FFh is rejected
like any other unsupported subpage.

Fixes: 1b26d29ccd59 ("[libata] scsi: implement MODE SELECT command")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7081caa8eb93..d7923bc664d6 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4643,19 +4643,11 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
 	}
 
 	/*
-	 * Supported subpages: all subpages and ATA feature sub-page f2h of
-	 * the control page.
+	 * The only supported subpage is the ATA feature sub-page f2h of the
+	 * control page.
 	 */
 	if (spg) {
 		switch (spg) {
-		case ALL_SUB_MPAGES:
-			/* All subpages is not supported for the control page */
-			if (pg == CONTROL_MPAGE) {
-				fp = (p[0] & 0x40) ? 1 : 0;
-				fp += hdr_len + bd_len;
-				goto invalid_param;
-			}
-			break;
 		case ATA_FEATURE_SUB_MPAGE:
 			if (qc->dev->flags & ATA_DFLAG_CDL &&
 			    pg == CONTROL_MPAGE)
-- 
2.56.0

