Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7331B2260C
	for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2025 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795903; cv=none; b=EC9eSi3vG6BKVZDVZs9UYhWVuU0EsXAipbpFm9bXXqk9S3Vymup7tx4GNdtO0E7nfWJbftAluM4q8inF0nkf4DY1VucbMtmaQhKq1QeoiziRZu5BEt5sC30o0NF1bgN4xvBTxwcgjNXuzkf+rQlgo6J2zKLsaVO3xDumraTa/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795903; c=relaxed/simple;
	bh=+4T8p8WgMVKMBthbWENfoVtUKl5HloUdUr/dRJ2LpTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+77MzHbwuNWOZzCC2kAj+gehm2wIznQcHydIhG00EhBwCRa1UzgtqieFlvR5cg3N5kVn7VwggTZiBcG0SS2JugyfzMuwi9RzNxVW1JpzhZD/G+rxzHYGPWHuf8z9wUridXIZ3ID9imB+AF6JhkduO4Zv5RSstyn9MREX8bcSoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaIyI9kl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaIyI9kl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6246C4CEE9;
	Wed, 16 Apr 2025 09:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744795902;
	bh=+4T8p8WgMVKMBthbWENfoVtUKl5HloUdUr/dRJ2LpTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaIyI9klNU2bnnPM6+XVqgkeoOODKt/U+1f5Q86HDX1wx3G38zwt/IP+fyo6N91Ex
	 Fml0431AQxLO1u7CfeRM5bjKg/FEtMX+Ae+uV1fGzRpnxRIn9DqkrDG2FwxaEUzn/u
	 pjngXrx1WPohoDQlHsRMQvW/F7F03KzUvFcIXNzcV0aud/O7Vbwi8fywRXqBA+XRzW
	 36hkFY30wmUal1zPqmAxShuSAtKzSq21R+fGOxDjBBDClSA+HXGpX8Orr/ESG6fxyv
	 YQxDzRqZUuVsLMEErnu4hAQhhufmcyeUJjjLs9iFtWZc7/ur7mDfiGN3sZk24UUAKQ
	 ANeA9ddj0+oIg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 3/3] ata: libata-sata: Use BIT() macro to convert tag to bit field
Date: Wed, 16 Apr 2025 11:31:31 +0200
Message-ID: <20250416093127.63666-8-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416093127.63666-5-cassel@kernel.org>
References: <20250416093127.63666-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324; i=cassel@kernel.org; h=from:subject; bh=+4T8p8WgMVKMBthbWENfoVtUKl5HloUdUr/dRJ2LpTI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL/V3zZOON7QIlenc4rf4Hrl9IvsPzbeXGB+b+Xtdql4 XFtiXVrO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRiveMDA1S1bP7pV9vPuOv HsjpcL/vDJfz+u5YMQ2rc1JSi+u/dTD8U3CXvLs6UHBzmMuCZyFshsw1y9bVsnzIzOy+lGjLlPO OHQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The BIT() macro is commonly used in the kernel.
Make use of it when converting a tag, fetched from the Successful NCQ
Commands log or the NCQ Command Error log, to a bit field.
This makes the code easier to read.

Suggested-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-sata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 89d3b784706b..4e3034af285e 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1545,7 +1545,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 		 * If the command does not have any sense data, clear ATA_SENSE.
 		 * Keep ATA_QCFLAG_EH_SUCCESS_CMD so that command is finished.
 		 */
-		if (!(sense_valid & (1 << tag))) {
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

