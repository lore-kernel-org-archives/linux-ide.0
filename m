Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A027A124
	for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2025 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702232; cv=none; b=gsRFmyHpRzYcpP9s3IPvS7uTwioc9t9zBE3jCL7M/lDjCLyFgpxLoZvewI6bUrr5wQ/N9Yif+0bmiiCrK7diQsz6uFkjlcgNWSi51b/eZi0qroKhJooXkhKDLtW0WEadEksQYUp9YvKYTlgW2UI7PUKpJmm41Wezm3EWvtjpRUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702232; c=relaxed/simple;
	bh=qFQpWHxGOeNl4Q8PK1tl8kiUBzVYuUd1q2DNjBZSWHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWsH/7ba/B296Fo3q31qOjMtGIb++LKEYAAWgfH1GtpPkWajjKAKfkpYUMDKIkoAiVkI9aChWBttFnk2ubwYuxWTTVMuTGt1ZT3t9oB8xf/0I1w58R/pZaawUCOuzFSn+6xpj/gO/cM0LapoCvREmHY7Jioy0/dyZYGP1yU0E6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6qNf/aR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6qNf/aR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F69C4CEED;
	Tue, 15 Apr 2025 07:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744702232;
	bh=qFQpWHxGOeNl4Q8PK1tl8kiUBzVYuUd1q2DNjBZSWHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6qNf/aRhdWMeo2JPKfvVeKcYLeT02PVJVTa46pBHJ0Hp92GfdNdieYsBnfHSrqkU
	 QeZ+aluTkSe2NcyVgfcsGbU5YbxXjXazaU+rSZaRg6qldCTgukhiNpITr/gLIIoq8X
	 DfFkBX9bOkVNuLDElf0ZkyZ3oKY6ZyzcohXthiY29xaOiEjVglHIya4OZL5emngBkt
	 jr4e72LHrsBzpeSLZcoMBX7QydSgkk4I7hgTI8RxzO3rgh5y/OH+HPCh5dC0iBN0RP
	 TjrEycmm4MTrJw4IIb/oyUAWizXdbWpnVRjTfji/np2Zu/u+eTTEVRxCHO6KxlpfrO
	 FZiupoNSBW2Tg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 3/3] ata: libata-sata: Use BIT() macro
Date: Tue, 15 Apr 2025 09:30:17 +0200
Message-ID: <20250415073013.414987-8-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415073013.414987-5-cassel@kernel.org>
References: <20250415073013.414987-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=cassel@kernel.org; h=from:subject; bh=qFQpWHxGOeNl4Q8PK1tl8kiUBzVYuUd1q2DNjBZSWHc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL/cXPdrO49e/d9c/PfKKmPvQ2O+jUhjKtte11CsqQmT DlUm768o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABNZu5eRoW1VuY3gvZdb21+0 7/yw4sYntuTbSQoci9L47qokzpPgW8zwT5PL97Fo6OUtGSkO/x5dzW099qsxi2u9YIlYlW+UC7M UKwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The BIT() macro is commonly used in the kernel.
Make use of it when converting a tag, fetched from the Successful NCQ
Commands log or the NCQ Command Error log, to a bit field.
This makes the code easier to read.

Suggested-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-sata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 076953d18db9..4e3034af285e 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1545,7 +1545,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 		 * If the command does not have any sense data, clear ATA_SENSE.
 		 * Keep ATA_QCFLAG_EH_SUCCESS_CMD so that command is finished.
 		 */
-		if (!(sense_valid & (1ULL << tag))) {
+		if (!(sense_valid & BIT(tag))) {
 			qc->result_tf.status &= ~ATA_SENSE;
 			continue;
 		}
@@ -1634,7 +1634,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 		return;
 	}
 
-	if (!(link->sactive & (1 << tag))) {
+	if (!(link->sactive & BIT(tag))) {
 		ata_link_err(link, "log page 10h reported inactive tag %d\n",
 			     tag);
 		return;
-- 
2.49.0

