Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A228A1FD
	for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2025 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553718; cv=none; b=RiEjtsRdUpKIP4BKZMsX0/elUPHcZywo02NimatQo93ieTThukCHOsCDTl1mYxaN8JG0ceeyn9W5sK7BKPnE2GOQqagJKMmPuOaFFI+c8p/jnVKOat2vnA37Dah8HHnTn7lu/2tyjPsF+LSQgyjYwDL82zUH58o3nXs23ab2n2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553718; c=relaxed/simple;
	bh=41d33da96bV8spOgimodNPqUxZ4i30r1Q5iRoMDPrfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s37uE1DLS2Ql4ItF2eCpVLkdPw4v5hV0SyDGgVfA9EekyLKJSlLBKEZ9f9X1rlZO3hsq583CTmH86Sck7DIasyKuu8HPp2qguK7jtRyY2x2yU0Fah4/I2xDOXQzWkR6TbqlviV+o5sCQvNGhKDC/4e1xh0PIpkzXbHknjPdntNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ycy03rVC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ycy03rVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD76C4CEED;
	Tue, 10 Jun 2025 11:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749553718;
	bh=41d33da96bV8spOgimodNPqUxZ4i30r1Q5iRoMDPrfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ycy03rVCvK7YrBANQxXaTUeqCSPNi/Gbm/XKuD5KUa2H3OzlmL6+xAXNZLcznI5UU
	 AGX5u3VJv4843BTPxYaouv/8KUS9pl+fOaacRwWP5v3UohhQi/boHAElWy93YnRc/D
	 6oWKgA7CSrLxxv86Cf8d26j9IoQ/TYgANcbdQh53IJK2OAWTLCxJJ6rjTGgbKBr8oI
	 zNr8A5jN9/F6fLnkQXJg72vSrSKST4fToZ3nInLPrfT0hOlafDEzWzx12pPk/Jm/iW
	 3/AjNGK6V7ENQzjPyLv29ncMu3gpLgCry9zKVK8q65+YSlnQuTMqooDUu8ZDBgRr0O
	 KlxqE1qdFoa7Q==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me,
	Hans de Goede <hansg@kernel.org>,
	Andy Yang <andyybtc79@gmail.com>,
	Mikko Juhani Korhonen <mjkorhon@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 2/3] ata: ahci: Refactor ahci_broken_lpm()
Date: Tue, 10 Jun 2025 13:08:00 +0200
Message-ID: <20250610110757.1318959-7-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610110757.1318959-5-cassel@kernel.org>
References: <20250610110757.1318959-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2958; i=cassel@kernel.org; h=from:subject; bh=41d33da96bV8spOgimodNPqUxZ4i30r1Q5iRoMDPrfU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI8hIQqrmk+Erpjq6mzbv2T9+/OXpq7+GzW01/XrL/K1 +TF3bqW21HKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJqM1i+O/Lei7u0my2fU1H 99Sef5ytO3EbY/b7mVOX965J/s0X8/Ivw/8A9e1nH3+b3bk+70/5w9dOTWkrwplS+7azWG1ZUy6 mns4BAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Currently, the match table in ahci_broken_lpm() contains DMI BIOS dates
of BIOSes that are known to be working.

Having a list of known to be working versions is usually the wrong way to
do things (as this list could theoretically be infinite).

Refactor this match table to contain DMI BIOS dates of BIOSes that are
known to not be working, such that this list can be extended with BIOS
versions (for other boards) that are known to not be working, where there
is no good BIOS version (because all existing versions are broken).

Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e7c8357cbc54..05ff03b80b85 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1411,34 +1411,50 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
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
+			 * 1.31, build date 20180406, has working LPM, mark any
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
+			 * 1.28, build date 20180420, has working LPM, mark any
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
+			 * 1.33, build date 20180315, has working LPM, mark any
+			 * DMI BIOS date before that as broken.
+			 */
+			.driver_data = "20180314",
 		},
 		{
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W541"),
 			},
-			.driver_data = "20180409", /* 2.35 */
+			/*
+			 * 2.35, build date 20180409, has working LPM, mark any
+			 * DMI BIOS date before that as broken.
+			 */
+			.driver_data = "20180408",
 		},
 		{ }	/* terminate list */
 	};
@@ -1452,7 +1468,7 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 	dmi_get_date(DMI_BIOS_DATE, &year, &month, &date);
 	snprintf(buf, sizeof(buf), "%04d%02d%02d", year, month, date);
 
-	return strcmp(buf, dmi->driver_data) < 0;
+	return strcmp(buf, dmi->driver_data) <= 0;
 }
 
 static bool ahci_broken_online(struct pci_dev *pdev)
-- 
2.49.0

