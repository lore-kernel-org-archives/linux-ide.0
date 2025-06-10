Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049728A1FD
	for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2025 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553716; cv=none; b=GgmXyrQMPoMPR2yJGgEOCGDOmW8QhxgBowyyk1ehx9cOnyuThaIkCpb43nI0eJWflAnXdUSNuwoMuwaPi4D0tEN1x8lXn7un/gq/l+B1MPYL+W2GutsKusw86G7LGxn5zqAEDGsubH5Z24/GtB0iI0yzw860OOnWs5ZaS7RB1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553716; c=relaxed/simple;
	bh=o1gG8stxkEVwxRLdcNkKgMc7RCK3ZNUEtzzD4ead2ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijNWDhgGh2vXrNUxJ8nkRwOcL/jJDysBhX3Zg5EGg3HOMfzrEOWVWuj4YLdoaQYudfa7wHrGxEUYgAaLXCWikndqoXbA39EEdE/qq8a2yKSIjac9JP+4uHMioAd6B/AQC82dhuDz91AJeSsv5ujZMAE+N6onP1lIUkXCpQnA8hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7wV+GHS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7wV+GHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5443C4CEED;
	Tue, 10 Jun 2025 11:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749553715;
	bh=o1gG8stxkEVwxRLdcNkKgMc7RCK3ZNUEtzzD4ead2ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7wV+GHS6zrsh8HBubUMVniNfe+iWGNoCWg/m8sk0y/JZnWXXpBRZpQ6zSaepEwg9
	 2r8U/9jq4PrbBVO5ByGF+K5R7J0n79TlMt/V//Gdnx1yA7ySBc1rQ5bhgFi/Eus2Yx
	 IXbAishiPWQXoAKyElgurKc6RnzWm7OBYMs1SXtJn1iZDICWhr8X91iJ67lbuNtCJ4
	 bnwaTXs6AzS33JeTksbKyleW1vRp09bD0kihQSfwv6ZDmPhDd1odvC8Jy+5OolWo8D
	 3njH1PKtS5wz+vMtm1lqd+WnEdJgPMUkzulKbWbzs3Y8bYxGkAgBhNmFwEGkRD39vg
	 +ZnNxoMnQxpYQ==
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
Subject: [PATCH v2 1/3] ata: ahci: Use correct BIOS build date for ThinkPad W541 quirk
Date: Tue, 10 Jun 2025 13:07:59 +0200
Message-ID: <20250610110757.1318959-6-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610110757.1318959-5-cassel@kernel.org>
References: <20250610110757.1318959-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=cassel@kernel.org; h=from:subject; bh=o1gG8stxkEVwxRLdcNkKgMc7RCK3ZNUEtzzD4ead2ko=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI8hITaC15d2Juv+GHZYdnPHdtPzXFn/LB90+ZHawpiN Xr8F0pO6ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBELpUyMmz+fVY7u2eKyELf Y1f/35q1PDYxOElJ49fSrYsiFzrc2i/B8N/Z9u7Ja2UXzPduuf3Xr7Eg993JpTnrBFyyRcMvPux +o8wBAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Fix the TODO in ahci_broken_lpm() by using the proper BIOS build date.

The proper BIOS build date was provided by Hans, see Link.

Link: https://lore.kernel.org/linux-ide/6ea509c8-b38d-4941-8a29-c1117ff3dd5b@redhat.com/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 163ac909bd06..e7c8357cbc54 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1438,13 +1438,7 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 				DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W541"),
 			},
-			/*
-			 * Note date based on release notes, 2.35 has been
-			 * reported to be good, but I've been unable to get
-			 * a hold of the reporter to get the DMI BIOS date.
-			 * TODO: fix this.
-			 */
-			.driver_data = "20180310", /* 2.35 */
+			.driver_data = "20180409", /* 2.35 */
 		},
 		{ }	/* terminate list */
 	};
-- 
2.49.0

