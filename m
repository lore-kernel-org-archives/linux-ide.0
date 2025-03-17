Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B7418C337
	for <linux-ide@vger.kernel.org>; Mon, 17 Mar 2025 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231049; cv=none; b=skpowOdsuyT/JhrNUzuzDDOooNLdUaZ15mne/dravZ7nQCgQm1Jx/m+eZvQiMoI7UdkTYCNz4ieO50kRT/5dxsdZTBYVd0XON7j2Ro83QS69Hwv3aA6X73+yMAjdyPWkr+MC/JyqouWF1ULwJNTLUZBZgwKhSQyKvIFmKHf4WGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231049; c=relaxed/simple;
	bh=KVQ7igmHz46m9k8v4X+Kpu+yvNX+nkVpNQ1jQsepvtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cq4A0ZIwG3j40069coibRMPEni+aOurhWnRbrgBseUbAOb0T4dw9f17p1SB+87bVAqptsgwVIyS4D1nged786u0cM1VT6grCDPhlsZa38Wl1a1rKoeQReTjswfVmPKZmaMp4m06m8FMHxYedEjoxCDR2cS+tqeB5k3qKyKj+IGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nx97s6ZP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx97s6ZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A90CC4CEE3;
	Mon, 17 Mar 2025 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742231048;
	bh=KVQ7igmHz46m9k8v4X+Kpu+yvNX+nkVpNQ1jQsepvtk=;
	h=From:To:Cc:Subject:Date:From;
	b=nx97s6ZPi41DdJXTosbllZEKmz9ynONPUI3o7hVBc/gwm71TZWeO2gE2uddDNhg22
	 +CYJQJmuNvhCMUBD/HI7m4WV07yppBp2+KW1ivHXRzA3s3y7exstWQJQgl9lEeto1Z
	 /VujqmdsLMKcpgn3dzyy9dhb+Wb3qc/qhSIUpGt9NAMHkxUmkBCkrSw0N6pZW5t5FF
	 kS95lzazdVp56A6G7F68Lygiha2Q5BF7l/8x2AC4PJ5tfc4gTgrRA8Xb5bZZ3sXS7T
	 soo7FLwgU7Jez17N/QWEr0qumlIcOMNMyGm2LNBT4axSNidPWWkXxv8bMnqUKoAsQM
	 uN8T9Tvl7lJTA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Eric <eric.4.debian@grabatoulnz.fr>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-core: Add ATA_QUIRK_NO_LPM_ON_ATI for certain Samsung SSDs
Date: Mon, 17 Mar 2025 18:03:49 +0100
Message-ID: <20250317170348.1748671-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4569; i=cassel@kernel.org; h=from:subject; bh=KVQ7igmHz46m9k8v4X+Kpu+yvNX+nkVpNQ1jQsepvtk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJvhH795s27WlhexUvOc8Gqt559swoCw82m7//N3fJHm VX33cfwjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzEooeRYWJhx4X/Fz3Cheaf Z2jV0D7FGFHq2tt0bN7Gh5fmflzqfprhf73jg3275S0cpL9+33hXfJd7BqfmC/YEU58p/FeNohq 3sQIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Before commit 7627a0edef54 ("ata: ahci: Drop low power policy board type")
the ATI AHCI controllers specified board type 'board_ahci' rather than
board type 'board_ahci'. This means that LPM was historically not enabled
for the ATI AHCI controllers.

By looking at commit 7a8526a5cd51 ("libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI
for Samsung 860 and 870 SSD."), it is clear that, for some unknown reason,
that Samsung SSDs do not play nice with ATI AHCI controllers. (When using
other AHCI controllers, NCQ can be enabled on these Samsung SSDs without
issues.)

In a similar way, from user reports, it is clear the ATI AHCI controllers
can enable LPM on e.g. Maxtor HDDs perfectly fine, but when enabling LPM
on certain Samsung SSDs, things break. (E.g. the SSDs will not get detected
by the ATI AHCI controller even after a COMRESET.)

Yet, when using LPM on these Samsung SSDs with other AHCI controllers, e.g.
Intel AHCI controllers, these Samsung drives appear to work perfectly fine.

Considering that the combination of ATI + Samsung, for some unknown reason,
does not seem to work well, disable LPM when detecting an ATI AHCI
controller with a problematic Samsung SSD.

Apply this new ATA_QUIRK_NO_LPM_ON_ATI quirk for all Samsung SSDs that have
already been reported to not play nice with ATI (ATA_QUIRK_NO_NCQ_ON_ATI).

Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Reported-by: Eric <eric.4.debian@grabatoulnz.fr>
Closes: https://lore.kernel.org/linux-ide/Z8SBZMBjvVXA7OAK@eldamar.lan/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 14 +++++++++++---
 include/linux/libata.h    |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c085dd81ebe7f..d956735e2a764 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2845,6 +2845,10 @@ int ata_dev_configure(struct ata_device *dev)
 	    (id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
 		dev->quirks |= ATA_QUIRK_NOLPM;
 
+	if (dev->quirks & ATA_QUIRK_NO_LPM_ON_ATI &&
+	    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI))
+		dev->quirks |= ATA_QUIRK_NOLPM;
+
 	if (ap->flags & ATA_FLAG_NO_LPM)
 		dev->quirks |= ATA_QUIRK_NOLPM;
 
@@ -3897,6 +3901,7 @@ static const char * const ata_quirk_names[] = {
 	[__ATA_QUIRK_MAX_SEC_1024]	= "maxsec1024",
 	[__ATA_QUIRK_MAX_TRIM_128M]	= "maxtrim128m",
 	[__ATA_QUIRK_NO_NCQ_ON_ATI]	= "noncqonati",
+	[__ATA_QUIRK_NO_LPM_ON_ATI]	= "nolpmonati",
 	[__ATA_QUIRK_NO_ID_DEV_LOG]	= "noiddevlog",
 	[__ATA_QUIRK_NO_LOG_DIR]	= "nologdir",
 	[__ATA_QUIRK_NO_FUA]		= "nofua",
@@ -4142,13 +4147,16 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 						ATA_QUIRK_ZERO_AFTER_TRIM },
 	{ "Samsung SSD 860*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM |
-						ATA_QUIRK_NO_NCQ_ON_ATI },
+						ATA_QUIRK_NO_NCQ_ON_ATI |
+						ATA_QUIRK_NO_LPM_ON_ATI },
 	{ "Samsung SSD 870*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM |
-						ATA_QUIRK_NO_NCQ_ON_ATI },
+						ATA_QUIRK_NO_NCQ_ON_ATI |
+						ATA_QUIRK_NO_LPM_ON_ATI },
 	{ "SAMSUNG*MZ7LH*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM |
-						ATA_QUIRK_NO_NCQ_ON_ATI, },
+						ATA_QUIRK_NO_NCQ_ON_ATI |
+						ATA_QUIRK_NO_LPM_ON_ATI },
 	{ "FCCT*M500*",			NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM },
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c1c57f814b98d..e5695998acb02 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -88,6 +88,7 @@ enum ata_quirks {
 	__ATA_QUIRK_MAX_SEC_1024,	/* Limit max sects to 1024 */
 	__ATA_QUIRK_MAX_TRIM_128M,	/* Limit max trim size to 128M */
 	__ATA_QUIRK_NO_NCQ_ON_ATI,	/* Disable NCQ on ATI chipset */
+	__ATA_QUIRK_NO_LPM_ON_ATI,	/* Disable LPM on ATI chipset */
 	__ATA_QUIRK_NO_ID_DEV_LOG,	/* Identify device log missing */
 	__ATA_QUIRK_NO_LOG_DIR,		/* Do not read log directory */
 	__ATA_QUIRK_NO_FUA,		/* Do not use FUA */
@@ -432,6 +433,7 @@ enum {
 	ATA_QUIRK_MAX_SEC_1024		= (1U << __ATA_QUIRK_MAX_SEC_1024),
 	ATA_QUIRK_MAX_TRIM_128M		= (1U << __ATA_QUIRK_MAX_TRIM_128M),
 	ATA_QUIRK_NO_NCQ_ON_ATI		= (1U << __ATA_QUIRK_NO_NCQ_ON_ATI),
+	ATA_QUIRK_NO_LPM_ON_ATI		= (1U << __ATA_QUIRK_NO_LPM_ON_ATI),
 	ATA_QUIRK_NO_ID_DEV_LOG		= (1U << __ATA_QUIRK_NO_ID_DEV_LOG),
 	ATA_QUIRK_NO_LOG_DIR		= (1U << __ATA_QUIRK_NO_LOG_DIR),
 	ATA_QUIRK_NO_FUA		= (1U << __ATA_QUIRK_NO_FUA),
-- 
2.48.1

