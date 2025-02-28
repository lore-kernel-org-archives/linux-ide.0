Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC326B2D9
	for <linux-ide@vger.kernel.org>; Fri, 28 Feb 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745569; cv=none; b=nRnC02RDaWSVXoi6eEoSaTKa0KYM54nzx+x6TXtTEPfkI05OI8/YPpQwaR1fivjeUIz19YTM0uFPZXA9DCLhl7SQOIxott9JqeXQqF2oVyVofNruP25TrVo+CcM8h078PIbSg53PU5gYKG7+86ReSHErXgau99otOyzIdnQjPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745569; c=relaxed/simple;
	bh=elDl5mzeQs6sr3rABrSFXB+2y7dOuRkeAqQQan0PYI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Stzrju9dY9J9EAGArRUBtGveBCwCgUjdLnOXvjoGrS5LinZeyBIn9+RSPn4t/4weQuiT90ffc+oK24aib+Ki0kUqWCahQK5CZFHkyLF6DbbEGdWSYza4yI6+XkSOrPMGQtbzsUeaqnDKHnLeBoxga6ldF4ezbHqJOZJsMYYmkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZBMMhx6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZBMMhx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16911C4CEE4;
	Fri, 28 Feb 2025 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740745568;
	bh=elDl5mzeQs6sr3rABrSFXB+2y7dOuRkeAqQQan0PYI4=;
	h=From:To:Cc:Subject:Date:From;
	b=YZBMMhx6juAXRwYe6V2LIii08Jiz+2wt++0kZpNMh60UkS5hYrKIwgawsRKj463Kn
	 8sWewkteoiKnQzANSKOXXKzCz891GCKHvWjs7GHk1jmbwSDYbDV5Mt3IvfMLOqZizb
	 7396MN54u4RiJnZ+7LqsjO1UxMyxHmEC/g+J9Lz/38nVB4DwW2TPmlid7VmDalGSbb
	 Q0gxknC1t/ovrlW4PcDI9FZwCiYP+N//SJzuuHzr7zM0PvsaWZ8NvZrCIM0XbRyboi
	 VioB5W6yrSc4wpRO9eMH8XlBoJEFzLql9qLNNgar4TB09dKuQYckKwcXjZchqr856e
	 BvFSCCdAVwR9w==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Daniel Baumann <daniel@debian.org>
Cc: Dieter Mummenschanz <dmummenschanz@web.de>,
	linux-ide@vger.kernel.org
Subject: [PATCH] Revert "ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives"
Date: Fri, 28 Feb 2025 13:26:04 +0100
Message-ID: <20250228122603.91814-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=cassel@kernel.org; h=from:subject; bh=elDl5mzeQs6sr3rABrSFXB+2y7dOuRkeAqQQan0PYI4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIPro5OdWp+wPHq0P5LMyNuvO1liXwmWZK2c+v+Nw+3S y/zc9tzraOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQAT+WHI8D//Q//pyZn+q1wK OzqyEtpWqne1sySt+GB3l2NtZuilaQwM/4t+HDT4vprBVIztRsYlEdW7Z/dOOe1g/025+/q9SgP f6SwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

This reverts commit cc77e2ce187d26cc66af3577bf896d7410eb25ab.

It was reported that adding ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives
breaks entering lower package states for certain systems.

It turns out that Samsung SSD 870 QVO actually has working LPM when using
a recent SSD firmware version.

The author of commit cc77e2ce187d ("ata: libata-core: Add ATA_QUIRK_NOLPM
for Samsung SSD 870 QVO drives") reported himself that only older SSD
firmware versions have broken LPM:
https://lore.kernel.org/stable/93c10d38-718c-459d-84a5-4d87680b4da7@debian.org/

Unfortunately, he did not specify which older firmware version he was using
which had broken LPM.

Let's revert this quirk, which has FW version field specified as NULL
(which means that it applies for all Samsung SSD 870 QVO firmware versions)
for now. Once the author reports which older firmware version(s) that are
broken, we can create a more fine grained quirk, which populates the FW
version field accordingly.

Fixes: cc77e2ce187d ("ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives")
Reported-by: Dieter Mummenschanz <dmummenschanz@web.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219747
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 63ec2f218431..c085dd81ebe7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4143,10 +4143,6 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "Samsung SSD 860*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM |
 						ATA_QUIRK_NO_NCQ_ON_ATI },
-	{ "Samsung SSD 870 QVO*",	NULL,	ATA_QUIRK_NO_NCQ_TRIM |
-						ATA_QUIRK_ZERO_AFTER_TRIM |
-						ATA_QUIRK_NO_NCQ_ON_ATI |
-						ATA_QUIRK_NOLPM },
 	{ "Samsung SSD 870*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM |
 						ATA_QUIRK_NO_NCQ_ON_ATI },
-- 
2.48.1

