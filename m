Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3B1D516F
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264936; cv=none; b=NOJQgxOXKIpiDgmvLhoudVFSiye9mvptlylytQ996ElRsSqaovDrPhvUEZQikTbdLYjMUyh/I4yueCkTEEjQ+hZESCTp6qg5tffd7wYZU33b+nP3XLhrprXAKqNGXaUyywxCUn8GSqXs9sSZUkWWqheWKFzaJoYGSdwuxGJtHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264936; c=relaxed/simple;
	bh=Cpecl7ADTEQ7nvGqqGDJ/Di8v+9NeidrX/OWGPFRSJY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naEm/2NL94aMVDLqxHCHwG4bpvDsALXuJX1PrXPdyQybg6c6yaGwpOG5z5N/RyDwh54DYfywoeBjOM37qJx169hCKYx6aZYsJ7QL8WskPbjWIsr0TeDLWABofa3THwHGfAP5ZdrXUc0SpALs34CtmHQBOb+SKYRkUJEOX9RY2QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkA/JnGe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkA/JnGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC54C4CEE3;
	Mon, 30 Jun 2025 06:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751264936;
	bh=Cpecl7ADTEQ7nvGqqGDJ/Di8v+9NeidrX/OWGPFRSJY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CkA/JnGekngUh/6tbSAB9CXfHtFQyRaob6ix965DG6Zu3nCiST28sQRJ8khmhgPAQ
	 UNrKBpOasrpNPQpvCuKeVINgd+ZUb2DwreNQ7CGps80W7YKEQt5NGHTPDS8R8NLSlG
	 7jt6VPS6boqTZwgEd5gKIrRwrdeKPvHU4+PUraKLdnC2jUqitdZ/n8wE0jOGHKyIFS
	 dHfpO340b7EEnmEfbwJjJ8OHVyn55CdsYiQt+r+DwXkz//Qs3PtsUh6lcqU+f0rfMV
	 KqxfDhc/s+x9STCR814L9C4Bf+3dw/4NtmkzH+MtZyQ3dlzOuigW3rjrakBAblKjU4
	 rZiitRdbqAMXw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 10/10] ata: libata_eh: Add debug messages to ata_eh_link_set_lpm()
Date: Mon, 30 Jun 2025 15:26:37 +0900
Message-ID: <20250630062637.258329-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630062637.258329-1-dlemoal@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To facilitate field debugging of link power management related issues,
add a debug message to ata_eh_link_set_lpm() to easily track LPM policy
changes done from EH context, that is, during device scan and
revalidation, error handling, and when a policy change is issued through
a host sysfs link_power_management_policy attribute.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-eh.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7f5d13f9ca73..7134a4ff6535 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2140,6 +2140,9 @@ static int ata_eh_link_set_lpm(struct ata_link *link,
 	if (WARN_ON_ONCE(policy == ATA_LPM_UNKNOWN))
 		return 0;
 
+	ata_link_dbg(link, "Set LPM policy: %d -> %d\n",
+		     old_policy, policy);
+
 	/*
 	 * DIPM is enabled only for ATA_LPM_MIN_POWER,
 	 * ATA_LPM_MIN_POWER_WITH_PARTIAL, and ATA_LPM_MED_POWER_WITH_DIPM, as
-- 
2.50.0

