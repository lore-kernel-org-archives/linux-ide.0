Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF91383C88
	for <linux-ide@vger.kernel.org>; Sat, 14 Mar 2026 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527393; cv=none; b=qwYIkxrrf+ma6rZMCW6VqS1em/BWGWNhsSjFIGFe7+dFREbL/0cdHT5boDUPmSSXmUJkd2LKoO5nrkCEOT6DAgtq9m5IpOBoEdJ9Z17n/OVTMlQroBbUtb4k1fVLTEZrilCV9R54tYLOPRr2r6ikm5fTh15YRXVF8Q3aOLhl6Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527393; c=relaxed/simple;
	bh=44oWNguCVrxwZd6v/U4N3zuzKJmOefHwuoheMah1XFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qyrMEdWppmbzp2a9PpbMahnZ6V5nyICGPQgyd1dveJfthKZP+Lq5Vkm1KrMRkU+/82wDPF1stW5/Zq9LyAP6IfvW5CSN0Jyxd6NNFdnfEoMoLhfiQvm/pxGvOYPEsmd6tbJ0o0a/Gh2ggqMEfqqDakTPiDRXLGyHEvFHqSRVyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocs2JTf8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocs2JTf8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B51CC116C6;
	Sat, 14 Mar 2026 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773527392;
	bh=44oWNguCVrxwZd6v/U4N3zuzKJmOefHwuoheMah1XFM=;
	h=From:To:Cc:Subject:Date:From;
	b=ocs2JTf8PjHhidm+DFSfWL7nQg/+iV1VBp/gt+G3Z5KGB5fY8o6ls1DE/G7cACEPv
	 5jqhoIL+MMNP9jZgdsoOzGhkzHrSOT0Lw7e3unwamgRSDXix99FP4Hbq3r7yPWU1iz
	 3wcv6IQwoIQcMk9vjSt3AQ4uKDeVSUehexC5nKqAPkyuvfcQxByXG9XzyX9cIrG4B7
	 GwlCeuHurCC46lZqkbEZypKtxfg0P044AJfgHCwU1EyRoBMgjL+vY4bFqNxPAANmOP
	 UDJORc6KjZgHGQbpBjYKZ0no0FlW3cdVlfzrLaZB3gr+H3OjFhvFTUsm1TBjOu2wuV
	 rfwd40y3fdbGA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Mohammad Khaled Bayan <mhd.khaled.bayan@gmail.com>
Subject: [PATCH] ata: libata-core: disable LPM on ADATA SU680 SSD
Date: Sun, 15 Mar 2026 07:24:15 +0900
Message-ID: <20260314222415.51176-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ADATA SU680 SSDs suffer from NCQ read and write commands timeouts or bus
errors when link power management (LPM) is enabled. Flag these devices
with the ATA_QUIRK_NOLPM quirk to prevent the use of LPM and avoid these
command failures.

Reported-by: Mohammad Khaled Bayan <mhd.khaled.bayan@gmail.com>
Closes: https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.17/+bug/2144060
Cc: stable@vger.kernel.org
Tested-by: Mohammad-Khaled Bayan <mhd.khaled.bayan@gmail.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6c4e567b6582..374993031895 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4188,6 +4188,9 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "ST3320[68]13AS",	"SD1[5-9]",	ATA_QUIRK_NONCQ |
 						ATA_QUIRK_FIRMWARE_WARN },
 
+	/* ADATA devices with LPM issues. */
+	{ "ADATA SU680",	NULL,		ATA_QUIRK_NOLPM },
+
 	/* Seagate disks with LPM issues */
 	{ "ST1000DM010-2EP102",	NULL,		ATA_QUIRK_NOLPM },
 	{ "ST2000DM008-2FR102",	NULL,		ATA_QUIRK_NOLPM },
-- 
2.53.0

