Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37EF28DF18
	for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2025 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553721; cv=none; b=VJvoy+1PsJnlUqeqWzkCBNZc1iGZnpqmoG4W4Co5EXUpoge9JD1Qm9jX+6VZP7/Q62ZTBxI2LhlEmqmR8wJZzDtMqjp0kXlZzx42DBOKbnMmw9IkjHiubcpiqVghgMu0rSixrvf0di++FIT++49j9PtYGmGgxyGvnF4gFkbfVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553721; c=relaxed/simple;
	bh=IUfk++09lUBuFviE0YkNx5yfHUAOsRWEjBMoQi0vEZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NppsFZGxIZkgJS0tLCyy9obciAicYmyeXQcP9Jzg1uHZBN5TowMM2t3Cdu7tfCck6xmtUQfDNAvJRuR65dUZyUEQVRDgBclLpzBOvD/5ZvlynQ/o4lxRkbRNdVFBzx8wjz1O/4EBcBImVr/GWcjwYO1q3oEzCDfVMpVTwy3hoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTdG2wnC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTdG2wnC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AF0C4CEF1;
	Tue, 10 Jun 2025 11:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749553720;
	bh=IUfk++09lUBuFviE0YkNx5yfHUAOsRWEjBMoQi0vEZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTdG2wnCQ8ctkxdoCipes4qKO/71+BWfvo5zSYSipvimGYKDzh52oGw0xOyia2hGx
	 dQ2Osk1fZOTrFyNF8cOIIM/euif1Z9dmcmLf5DoCcXmraxBeuLkl8acbiO15uCJAPo
	 /LMqyI0ZGOIPwJ06sApnHWYTA3XMrLimjn4JyYEDJBiLmsP+JcitiRzNdPeA3iF3UP
	 pTDAInapCyPBUgf6FufBgg6z5a8G96NRA1ABaMLtvIIULGjl4V64k3n9hps7ZFcrWJ
	 uDKeY9N3AebDA27svIZKzVuqdRMIW2QchD8NNAPnYdVfgbnws2mvH3upfFhmFSlBvN
	 CC0CdBq2ToWrQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me,
	Hans de Goede <hansg@kernel.org>,
	Andy Yang <andyybtc79@gmail.com>,
	Mikko Juhani Korhonen <mjkorhon@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Niklas Cassel <cassel@kernel.org>,
	stable+noautosel@kernel.org
Subject: [PATCH v2 3/3] ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard
Date: Tue, 10 Jun 2025 13:08:01 +0200
Message-ID: <20250610110757.1318959-8-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610110757.1318959-5-cassel@kernel.org>
References: <20250610110757.1318959-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470; i=cassel@kernel.org; h=from:subject; bh=IUfk++09lUBuFviE0YkNx5yfHUAOsRWEjBMoQi0vEZo=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI8hIRuljHYcb37pnJpFcMD5d6Y8rVnfokHrslKDZ0// U3NzeiijlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEwk4DwjwzR+NvuOfPGD+u5J /ZF3dUqX6L3MlQ2KNMk+97JO3Wr6O4b/FZcmv/83i5Hx2K8T/5RvXfAy7SjMyiu8G8rb++xV6sJ SbgA=
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
Reviewed-by: Hans de Goede <hansg@kernel.org>
Reported-by: Andy Yang <andyybtc79@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220111
Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 05ff03b80b85..b065440bd911 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1456,6 +1456,17 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 			 */
 			.driver_data = "20180408",
 		},
+		{
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_PRODUCT_VERSION, "ASUSPRO D840MB_M840SA"),
+			},
+			/*
+			 * 320, build date 20230208, has broken LPM, no working
+			 * BIOS exists at the time of writing.
+			 */
+			.driver_data = "20230208",
+		},
 		{ }	/* terminate list */
 	};
 	const struct dmi_system_id *dmi = dmi_first_match(sysids);
-- 
2.49.0

