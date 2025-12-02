Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275FF30EF88
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678109; cv=none; b=UA4sQG1DJOBPjnl3YsFa5xFeg5UbEOqCSFNdzj8NCzfCDRe2qb1girRA776g+pmM63JXnFJi+0bou1xKGydOhjHqDTnVls0shsst5ql1kV2NKSV7ZRw3W1m2eRky3UE3ep5qxt09MouhFsTTNHgruKBQnCSIQgstPLFyaV5n/zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678109; c=relaxed/simple;
	bh=lF40p/yPD0pbIM88Z9E+WqvuPmKQ2rVs2NLqJRwUOtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYjVz6/+Ksg2DE+mcNhp8BD4zItuR0a46PCNY7CsW6vN3njC31A4pMLk5zL+vcDpCbqnDxoy+wxbYCDb/V47oUzXYGdCcMGtzTgsJyrAaqtIb1w98VEpAYHxyv2/iEbSOmJuSzAhsUJv8HYhFm01R1BHSVOZxqli6q3uvgt49dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1OZMHfK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1OZMHfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F2EC16AAE;
	Tue,  2 Dec 2025 12:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764678109;
	bh=lF40p/yPD0pbIM88Z9E+WqvuPmKQ2rVs2NLqJRwUOtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G1OZMHfKp2hY9mX0UV2Kgg5Ip7Y2xfsR2Y8GGS+L70mkeB74LadkEc1LdXs6VW5rQ
	 US8qydnk/X35OfgMlk7DmXEV6JIPHY3skndC+BS7wlgjPeXHCFYF6rSIuHnbl0dc08
	 /l/g3FT78DX83TJb5Nn0yLkCWSI/QtyvKeMCmWuMtx1W0X1JSDUZdEWq3satuURIg5
	 +dlPbJx0XHWFiyNLsFicVQ3bDiHK0qrUiXX9Q9eKtq6F/pGQKmp4m66TTVagby2X4T
	 XL33IHRVaKcZB+UZ7U2+wSd4M0wcQetfZwQnKfi2fvXpDAafEByeFQVBY/1xQFnxKP
	 mErnhU8+vBDSg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 2/6] ata: libata: Add ata_force_get_fe_for_dev() helper
Date: Tue,  2 Dec 2025 13:21:32 +0100
Message-ID: <20251202122129.421783-10-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251202122129.421783-8-cassel@kernel.org>
References: <20251202122129.421783-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2968; i=cassel@kernel.org; h=from:subject; bh=lF40p/yPD0pbIM88Z9E+WqvuPmKQ2rVs2NLqJRwUOtM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL1bp7zXOIUO+nmtY8F2fMrxOdF696OS3Fi6V5pJ/D7W voG6wclHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhISgEjw4ntUfsk6hstgzuD FrzadOGsWMcqkWdptxJDVv/JLgqw6GX4w+FWbFKwumbRS3+lScvYdM5axqpMy+5O0jlbumZh18J WPgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add ata_force_get_fe_for_dev() helper to get the struct ata_force_ent for
a struct ata_device.

Use the helper in ata_force_quirks().
The helper will also be used in follow up commits.

No functional change intended.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 56 ++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e33008803e04e..4dad69b603713 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -474,19 +474,10 @@ static void ata_force_xfermask(struct ata_device *dev)
 	}
 }
 
-/**
- *	ata_force_quirks - force quirks according to libata.force
- *	@dev: ATA device of interest
- *
- *	Force quirks according to libata.force and whine about it.
- *	For consistency with link selection, device number 15 selects
- *	the first device connected to the host link.
- *
- *	LOCKING:
- *	EH context.
- */
-static void ata_force_quirks(struct ata_device *dev)
+static const struct ata_force_ent *
+ata_force_get_fe_for_dev(struct ata_device *dev)
 {
+	const struct ata_force_ent *fe;
 	int devno = dev->link->pmp + dev->devno;
 	int alt_devno = devno;
 	int i;
@@ -496,8 +487,7 @@ static void ata_force_quirks(struct ata_device *dev)
 		alt_devno += 15;
 
 	for (i = 0; i < ata_force_tbl_size; i++) {
-		const struct ata_force_ent *fe = &ata_force_tbl[i];
-
+		fe = &ata_force_tbl[i];
 		if (fe->port != -1 && fe->port != dev->link->ap->print_id)
 			continue;
 
@@ -505,16 +495,38 @@ static void ata_force_quirks(struct ata_device *dev)
 		    fe->device != alt_devno)
 			continue;
 
-		if (!(~dev->quirks & fe->param.quirk_on) &&
-		    !(dev->quirks & fe->param.quirk_off))
-			continue;
+		return fe;
+	}
 
-		dev->quirks |= fe->param.quirk_on;
-		dev->quirks &= ~fe->param.quirk_off;
+	return NULL;
+}
 
-		ata_dev_notice(dev, "FORCE: modified (%s)\n",
-			       fe->param.name);
-	}
+/**
+ *	ata_force_quirks - force quirks according to libata.force
+ *	@dev: ATA device of interest
+ *
+ *	Force quirks according to libata.force and whine about it.
+ *	For consistency with link selection, device number 15 selects
+ *	the first device connected to the host link.
+ *
+ *	LOCKING:
+ *	EH context.
+ */
+static void ata_force_quirks(struct ata_device *dev)
+{
+	const struct ata_force_ent *fe = ata_force_get_fe_for_dev(dev);
+
+	if (!fe)
+		return;
+
+	if (!(~dev->quirks & fe->param.quirk_on) &&
+	    !(dev->quirks & fe->param.quirk_off))
+		return;
+
+	dev->quirks |= fe->param.quirk_on;
+	dev->quirks &= ~fe->param.quirk_off;
+
+	ata_dev_notice(dev, "FORCE: modified (%s)\n", fe->param.name);
 }
 #else
 static inline void ata_force_pflags(struct ata_port *ap) { }
-- 
2.52.0

