Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB325A627
	for <linux-ide@vger.kernel.org>; Mon,  9 Jun 2025 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476745; cv=none; b=uierw+ZIR3u413pT8UB3wZeuU4EcIrKk123TvAkj3WWRy10+E5SBj+6Z5UqbKXdo9LzpSLngtED71aiivgwQkqGMIlyzPkd6e8IZHLjhAu82UYB7hOmKUZjptV0WMFsm8Lt1y4ZB/9qQo4lzxu68a6eo7kcvTnwOWoQfnOwZexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476745; c=relaxed/simple;
	bh=BbDFMjRj2c+Hw/Y7cLHyW+nXqrtYCsJbdkI/JExgYbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTBT8DOVd7kkqEZlGFd54AejOixz8Dm40Ljhmae5oBOl31VQikpqoxSg8JKmLf5KpZbKOOOR9TUTE/gEqdxnph/rrrLUY0HQSjwZ6vjk1drvWK5uljqp44EORIlDmtiw7W1LmlZuYsWQg93c0i4RvCFjYGmZ5W6uSWHcy3J8TTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXtyp+0C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXtyp+0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9701DC4CEED;
	Mon,  9 Jun 2025 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476745;
	bh=BbDFMjRj2c+Hw/Y7cLHyW+nXqrtYCsJbdkI/JExgYbY=;
	h=From:To:Cc:Subject:Date:From;
	b=mXtyp+0CVGbs0xRDXLilVq7YulV6g2cUyGeLIttbAN7XC7vNxcNQ3TyyJsAdPdKp3
	 fLsX4EXsXN955p+b2CIf43TP85SUqsNS6kpMsHy1JZFZyGI8sFe5+apY4Ji/Dz7g+2
	 vNL/yPRn42UIZvVy61Td554EU60ASxoj99bHK7eQL8ftzYDFWkAHYfoFONuUI3VBoR
	 Bdaba9l5d1GEHqZkItGlxNu3q9hFpnyaRUEdZM2fpC9e5ru00V0Riks2Wg7gzxOHoK
	 vXb9um0Pl3GRIpeDu8Hvdizw37yDcxhUdhSv+K/KaC8SuXzyJOjAG1TvQK9hyAarup
	 Mu5jSlHokETAw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me,
	Hans de Goede <hdegoede@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/2] ata: ahci: Refactor ahci_broken_lpm()
Date: Mon,  9 Jun 2025 15:45:40 +0200
Message-ID: <20250609134539.943587-3-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3340; i=cassel@kernel.org; h=from:subject; bh=BbDFMjRj2c+Hw/Y7cLHyW+nXqrtYCsJbdkI/JExgYbY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLcnjZbiAVen/HuRdDjogKHlBalGUXd1kdZmRew7nzYO qPYKedHRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACbydBkjQ8M/zvbmLYm38j6v DIu7Ibs05PvrXXcKnjq2RUcelO3p/M/wV2yJ246QyuSiGTUSq51EGWK02B4b3n/+Vc1wmdmsGtV uHgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Currently, the match table in ahci_broken_lpm() contains DMI BIOS dates
of BIOSes that are known to be working.

Having a list of known to be working versions is usually the wrong way to
do things (as this list could theoretically be infinite).

Refactor this match table to contain DMI BIOS dates of BIOSes that are
known to not be working, such that this list can be extended with BIOS
versions (for other boards) that are known to not be working, where there
is no good BIOS version (because all released versions are broken).

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 163ac909bd06..a6ce172fa928 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1411,27 +1411,39 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 static bool ahci_broken_lpm(struct pci_dev *pdev)
 {
 	static const struct dmi_system_id sysids[] = {
-		/* Various Lenovo 50 series have LPM issues with older BIOSen */
+		/* Table contains DMI BIOS dates of BIOSes with broken LPM. */
 		{
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X250"),
 			},
-			.driver_data = "20180406", /* 1.31 */
+			/*
+			 * 1.31, released 20180406, has working LPM, mark any
+			 * DMI BIOS date before that as broken.
+			 */
+			.driver_data = "20180405",
 		},
 		{
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L450"),
 			},
-			.driver_data = "20180420", /* 1.28 */
+			/*
+			 * 1.28, released 20180420, has working LPM, mark any
+			 * DMI BIOS date before that as broken.
+			 */
+			.driver_data = "20180419",
 		},
 		{
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T450s"),
 			},
-			.driver_data = "20180315", /* 1.33 */
+			/*
+			 * 1.33, released 20180315, has working LPM, mark any
+			 * DMI BIOS date before that as broken.
+			 */
+			.driver_data = "20180314",
 		},
 		{
 			.matches = {
@@ -1439,12 +1451,14 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W541"),
 			},
 			/*
-			 * Note date based on release notes, 2.35 has been
-			 * reported to be good, but I've been unable to get
-			 * a hold of the reporter to get the DMI BIOS date.
-			 * TODO: fix this.
+			 * Note: according to release notes, version 2.35 has
+			 * working LPM, but we do not have the DMI BIOS date for
+			 * this version, so the date, 20180310, is based on the
+			 * release notes. Mark any DMI BIOS date before that as
+			 * broken.
+			 * TODO: find with date with DMI BIOS date.
 			 */
-			.driver_data = "20180310", /* 2.35 */
+			.driver_data = "20180309",
 		},
 		{ }	/* terminate list */
 	};
@@ -1458,7 +1472,7 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 	dmi_get_date(DMI_BIOS_DATE, &year, &month, &date);
 	snprintf(buf, sizeof(buf), "%04d%02d%02d", year, month, date);
 
-	return strcmp(buf, dmi->driver_data) < 0;
+	return strcmp(buf, dmi->driver_data) <= 0;
 }
 
 static bool ahci_broken_online(struct pci_dev *pdev)
-- 
2.49.0

