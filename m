Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D661146D6A
	for <linux-ide@vger.kernel.org>; Mon, 26 May 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268199; cv=none; b=S8JT0RW07352sJUHagcQQusGM2Q0WPNnoi4zktCQ+6e1LVh8PXHX8hqIAv/V7WuXI6dodfWVypeV7puf5yfOtSWTecWabPpWZfbMMTcKD5eWKfrH4saXakL2CAt1Nxl/t9hK/s7U4eYajpyWF4OU6kLtjYOZiOFtc29Sb1pmLDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268199; c=relaxed/simple;
	bh=cgADaCG4ANfi0RaQJE8ZhI6v1htljNc6MoMXwQzabw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9LD3D0ggeitdEYC5WHfgIbkz8+QBLhOwQ7wWxPVi+w7D/REdXvCJfV9QEIeowcGnEjUz54SykFIcwVGSvnY4bAG9nOD7oz2wdS/Mwy1aDMHofoetv28tjyPq6e1djJfcfW3QaJQDKqzK3EcKQdSw0RzOabdYDI9CzsVNVp71rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9U2GefS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9U2GefS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E03BC4CEE9;
	Mon, 26 May 2025 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748268198;
	bh=cgADaCG4ANfi0RaQJE8ZhI6v1htljNc6MoMXwQzabw0=;
	h=From:To:Cc:Subject:Date:From;
	b=X9U2GefScAneNgQkIFLm9qOkxgQVVFkhX1Mfw5mTXV4Cyq3wi8WtFDvBZIyKnmLPa
	 Rz4XkFKCZ91/YrJrBQagqmgsI+R63F3YLUwLNGzEMcaGIXiw90w1LVB/dxDBfVEBbJ
	 1mo/p+CJmKhr2g9Ugg6XW6v4szjYX0vkxHDdOl8G27c820vvjc9jTo593sA9nndIDb
	 wStnp2rfNUZVMsx5upc10HEPJfbyoiymjMH0PytYojRcMTjD0yiU7IjSydmVMJuSST
	 qjFZb6ixDpUSyn0ZJ3eqlnTY6r0vuRnEy+b/Drh/L50FQHBsoqjrPvgvsLfvMwFX9D
	 0a4X29LzvUrqw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>
Cc: kernel-dev@rsta79.anonaddy.me,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Yang <andyybtc79@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard
Date: Mon, 26 May 2025 16:03:13 +0200
Message-ID: <20250526140312.228894-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709; i=cassel@kernel.org; h=from:subject; bh=cgADaCG4ANfi0RaQJE8ZhI6v1htljNc6MoMXwQzabw0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJMSha8uvYrb6HojuyIzSnCez88X5hwiWdi1McHZbO7m 3ewH4i70VHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJ7H7KyLAzduXPqeU3jVYo +q8q+zHzu0v+1Lz1SxU4Hv5an+EukvOCkeFg6hfuXZqmojf2yesW23w40p986+F9sbzXq/O6r5x /v5wNAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

A user has bisected a regression which causes graphical corruptions on his
screen to commit 7627a0edef54 ("ata: ahci: Drop low power policy board
type").

Simply reverting commit 7627a0edef54 ("ata: ahci: Drop low power policy
board type") makes the graphical corruptions on his screen to go away.
(Note: there are no visible messages in dmesg that indicates a problem
with AHCI.)

The user also reports that the problem occurs regardless if there is an
HDD or an SSD connected via AHCI, so the problem is not device related.

The devices also work fine on other motherboards, so it seems specific to
the ASUSPRO-D840SA motherboard.

While enabling low power modes for AHCI is not supposed to affect
completely unrelated hardware, like a graphics card, it does however
allow the system to enter deeper PC-states, which could expose ACPI issues
that were previously not visible (because the system never entered these
lower power states before).

There are previous examples where enabling LPM exposed serious BIOS/ACPI
bugs, see e.g. commit 240630e61870 ("ahci: Disable LPM on Lenovo 50 series
laptops with a too old BIOS").

Since there hasn't been any BIOS update in years for the ASUSPRO-D840SA
motherboard, disable LPM for this board, in order to avoid entering lower
PC-states, which triggers graphical corruptions.

Reported-by: Andy Yang <andyybtc79@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220111
Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 163ac909bd06..03f24bff040c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1411,7 +1411,10 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 static bool ahci_broken_lpm(struct pci_dev *pdev)
 {
 	static const struct dmi_system_id sysids[] = {
-		/* Various Lenovo 50 series have LPM issues with older BIOSen */
+		/*
+		 * Various Lenovo 50 series and some ASUS boards have LPM issues
+		 * with older BIOS versions.
+		 */
 		{
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
@@ -1446,6 +1449,13 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 			 */
 			.driver_data = "20180310", /* 2.35 */
 		},
+		{
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_PRODUCT_VERSION, "ASUSPRO D840MB_M840SA/D840MB"),
+			},
+			.driver_data = "20230208", /* 320 */
+		},
 		{ }	/* terminate list */
 	};
 	const struct dmi_system_id *dmi = dmi_first_match(sysids);
-- 
2.49.0

