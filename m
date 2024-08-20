Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A2633F9;
	Tue, 20 Aug 2024 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724123054; cv=none; b=T+gAgp2xcQu44CyC4qQMPAIQa6kWCLQLQfmXJfec6c7JWxpxPb3J+ApgU8rQFspYFzazWmV94IBe5Os1pCt6OjIfWBHeKFvJDqcaSBUZVyVwuKvHuMaZbTx4op05hbsHeCmmNQ6Iyx6vgnqEzEmhEF/aD66pPbMIO8qRhq7MI+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724123054; c=relaxed/simple;
	bh=MdybkHN1W8TFHXAp6viXS9GpruhneDQMcSQvKLUfAR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvgKbYF95LqR2LvJsJbHJZ8YDVT9taeerncwNoG7jbACPVBPEEjDBleJkKwjtIEfYpOyvJN29Nsa7fFP7Syb9Ky4TE0H5tnxvUqIs6WXnWl4omf9pGRFVI1vDwXTmSM8nvDskw+tm1h2/bQnxbsl9UDm3hpi+tHOHxg5sLtvt98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=TJnLdl5U; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TJnLdl5U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724123051;
	bh=j18FxuxXXJMOWMGzYuy1XXaguXnu+CDqwsfolFW8yPw=;
	h=From:To:Cc:Subject:Date:From;
	b=TJnLdl5UcrCgjvU63ZVQXCF1ofCK3w9mJviG/rZVuwaAKtp1bgOeSjdJuPFgUvgzd
	 kemIcAHqMrerA8ismK8KmApQPIkw2nxB7cDrEHYsyGZTE7vsrrD4IiM8lEbWvSozDD
	 tnNAwFAJyI3BzEtmBHy7U2wM1ABArdT+dpNj9s2vhxvNgbI3ZVU/PODux6ARuLkv1j
	 3AiiO8CpBpsUo4O9btT75QT5k4oUD2+znRMOGncZOk8ijD/VO7dEva199QK8+VnfSo
	 f9Jyt2CLYmoYMoXBY2c44T+oEvOJoh07i820ESWYCF9BCG1cwr2wnnS9UadvyY046p
	 jq+DTGWWTamIw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WnvSW1SKXz4wd6;
	Tue, 20 Aug 2024 13:04:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: cassel@kernel.org
Cc: dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	<linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>,
	<hch@lst.de>,
	linux-ppc@kolla.no,
	vidra@ufal.mff.cuni.cz
Subject: [PATCH v2] ata: pata_macio: Use WARN instead of BUG
Date: Tue, 20 Aug 2024 13:04:07 +1000
Message-ID: <20240820030407.627785-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The overflow/underflow conditions in pata_macio_qc_prep() should never
happen. But if they do there's no need to kill the system entirely, a
WARN and failing the IO request should be sufficient and might allow the
system to keep running.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/ata/pata_macio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

v2: Use AC_ERR_SYSTEM as suggested by Damien.

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 1cb8d24b088f..f2f36e55a1f4 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -554,7 +554,8 @@ static enum ata_completion_errors pata_macio_qc_prep(struct ata_queued_cmd *qc)
 
 		while (sg_len) {
 			/* table overflow should never happen */
-			BUG_ON (pi++ >= MAX_DCMDS);
+			if (WARN_ON_ONCE(pi >= MAX_DCMDS))
+				return AC_ERR_SYSTEM;
 
 			len = (sg_len < MAX_DBDMA_SEG) ? sg_len : MAX_DBDMA_SEG;
 			table->command = cpu_to_le16(write ? OUTPUT_MORE: INPUT_MORE);
@@ -566,11 +567,13 @@ static enum ata_completion_errors pata_macio_qc_prep(struct ata_queued_cmd *qc)
 			addr += len;
 			sg_len -= len;
 			++table;
+			++pi;
 		}
 	}
 
 	/* Should never happen according to Tejun */
-	BUG_ON(!pi);
+	if (WARN_ON_ONCE(!pi))
+		return AC_ERR_SYSTEM;
 
 	/* Convert the last command to an input/output */
 	table--;
-- 
2.46.0

