Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D2825A340
	for <linux-ide@vger.kernel.org>; Mon,  9 Jun 2025 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476747; cv=none; b=I4y50Wj+D47FV9VXK3RecCtWL2k+36usUkiiSabaehYGVisyWsZScMa5HH2cCH1bF7OrRhD2O3FfRrO9YEwM6QlCiXK8GZVS7pIiUUYwiFOIg4XqlGaVexptzU3XLiNKt9B5gaeeWoRnZ9O6q5DJQxyyypoqwbfXCaDqQ4O/HlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476747; c=relaxed/simple;
	bh=ySch94OZA20kfyWJKQ3EfvDsM3TBKpn7tFrNsfqjWtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsGJ3q9qNOdasnXbzND+HkS48hCRxNkZnsRMERbvnyZUFI2JDyweA0xXcPt0k4XFLtkDMzHfjmkeUKOc8ATnkrx2XjD3frXdRnwQEAMAKb3vFCJqrjIiG6qJ+FxyOT3fBUeH9i1Bs55RZCNUEvqY+WHcP9DMzMBCWI68yvte5kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4YaqG3j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4YaqG3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99499C4CEF0;
	Mon,  9 Jun 2025 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476747;
	bh=ySch94OZA20kfyWJKQ3EfvDsM3TBKpn7tFrNsfqjWtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4YaqG3jsWxfWQYdj07vI5+xLVBcY1/IhpnSLUZ/bM0UuNH6iPrwuL+atFMGQmhSW
	 6FcfQf3SSYP5UQUewg0hZribp17bwjZlGK8viEdhhE46VvtOAfMIsGmMkT6PUiIYp0
	 whm5LXIoV0Qbgpjz5g3CDTbD8NbAY2IAJs4ekm+gSIBdfUinL6hGCz7xuCIpXCd/Xw
	 92s7DMhZGk2b9PUuYFXZhan1q+/wU8T3gQdrKi049itSKpE6F0W6C4OsduPQCnlWhK
	 TvVBmb7s7UuxiqG0oFtslJvlujtPs/kc5wqA560UkBrMx2YJEku2HsdlT2IvuBbBW1
	 9cbo37mpDHXXw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me,
	Hans de Goede <hdegoede@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Niklas Cassel <cassel@kernel.org>,
	stable+noautosel@kernel.org,
	Andy Yang <andyybtc79@gmail.com>
Subject: [PATCH 2/2] ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard
Date: Mon,  9 Jun 2025 15:45:41 +0200
Message-ID: <20250609134539.943587-4-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609134539.943587-3-cassel@kernel.org>
References: <20250609134539.943587-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428; i=cassel@kernel.org; h=from:subject; bh=ySch94OZA20kfyWJKQ3EfvDsM3TBKpn7tFrNsfqjWtI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLcnrZM87lmozJPPnXC9/SIFsdN56rW7dLIvrta8du6V 38L/8943VHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJrNRiZNgTuqaf5QKT6+YW 6+13c7REZvDa5JUyG7ZOVO11tDoYIsLw39fqg9uxprVfeqbbGL5J4vwYdjlUW3HLy4vdvvu4kj/ vZgcA
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

Cc: stable+noautosel@kernel.org # Depends on ahci_broken_lpm() refactor
Reported-by: Andy Yang <andyybtc79@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220111
Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a6ce172fa928..be464d0f46a4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1460,6 +1460,17 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 			 */
 			.driver_data = "20180309",
 		},
+		{
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_PRODUCT_VERSION, "ASUSPRO D840MB_M840SA"),
+			},
+			/*
+			 * 320, released 20230208, has broken LPM, no working
+			 * BIOS has been released at time of writing.
+			 */
+			.driver_data = "20230208",
+		},
 		{ }	/* terminate list */
 	};
 	const struct dmi_system_id *dmi = dmi_first_match(sysids);
-- 
2.49.0

