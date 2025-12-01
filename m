Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C544A304BD4
	for <linux-ide@vger.kernel.org>; Mon,  1 Dec 2025 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592521; cv=none; b=UjKUWzEo5oSVuW2fab7Nc26ywokJttvp4twMdDwINrmbbD8lhbiU3k8pWw/BfOWJi8ZzMo9S4duT4ZKa+XA237HeXhuPJ7xZbhtpG3xQ6zTzyjOeSlikuOuyvpg8lMao6gxuw25RuAf/Xd1mpX7dbDUttH7DsgkZGhNx/Prbguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592521; c=relaxed/simple;
	bh=ocQPHDgUOId7qi86GJuySP0vdbbbe6hUOWz5bIOHGMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6GLjkdZLukIQcNqIAOpY2MbofrDyKXIQZQYyDIY1UiWpiW+wBdgn/dJb0Le9O19aWZydWp9cy0QIuMck7mc7ukaQPwUJmHE0cfXbl1wcUvbzCx+Ix9ho+aW45t/dul7SOq8SuaaJr/mMqgoom1brY70TIliDhr6diL38oDg+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt1G6Plu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt1G6Plu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0C9C16AAE;
	Mon,  1 Dec 2025 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764592521;
	bh=ocQPHDgUOId7qi86GJuySP0vdbbbe6hUOWz5bIOHGMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lt1G6Plu+ftpb0+kc87N8MdER/S0Tf/4v+b6cn4PtKLtGu9dauo1ROzwQWRAoQNyX
	 r5TM5QmDImWjUxxqsYxgqAhCGa7xNPWtq2ZZTqaMrzalmykR5eRAdHSCMsP5OnNToY
	 N1oKC+sPzKRfaYFa5K6M325s/5S/1v+WlRnnk8pvYJH7V+OoPA3cIh4Nj68Cj90z/R
	 Yb3Jv0Q3M3rf/m8FmyqSNwBARC0V/+suhb1ABkwyDTQMd64GRSTfrDIkdjzouS6UQw
	 Ma5zTPqrLATyiGPMwhTjthsWRbQ2lafzT2bBmj35Isx/ys1s8lLCTNpmK9eSzZGadc
	 6pXPEqTrRxHZw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 4/8] ata: libata: Add ata_force_get_fe_for_dev() helper
Date: Mon,  1 Dec 2025 13:35:06 +0100
Message-ID: <20251201123501.246282-14-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201123501.246282-10-cassel@kernel.org>
References: <20251201123501.246282-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2936; i=cassel@kernel.org; h=from:subject; bh=ocQPHDgUOId7qi86GJuySP0vdbbbe6hUOWz5bIOHGMQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ1u6vuvI3k2Ra8PKJI/qZ0p2SzeNOav5PXPxb81y63w tU1c01VRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACayfDMjw5ZtfxOYvadenLiP Jee8e3ZXqZuqbwrjhn8BzxIlQtau28rw37tiU0SKa8Hp/Rn72zu4rhybt/hK+q56l9IsxiUrZl1 iZgYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add ata_force_get_fe_for_dev() helper to get the struct ata_force_ent for
a struct ata_device.

Use the helper in ata_force_quirks().
The helper will also be used in follow up commits.

No functional change intended.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/ata/libata-core.c | 55 ++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 90b7a1bf93474..3657cd28e09a4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -474,29 +474,20 @@ static void ata_force_xfermask(struct ata_device *dev)
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
+static const struct ata_force_ent
+*ata_force_get_fe_for_dev(struct ata_device *dev)
 {
 	int devno = dev->link->pmp + dev->devno;
 	int alt_devno = devno;
 	int i;
+	const struct ata_force_ent *fe;
 
 	/* allow n.15/16 for devices attached to host port */
 	if (ata_is_host_link(dev->link))
 		alt_devno += 15;
 
 	for (i = 0; i < ata_force_tbl_size; i++) {
-		const struct ata_force_ent *fe = &ata_force_tbl[i];
+		fe = &ata_force_tbl[i];
 
 		if (fe->port != -1 && fe->port != dev->link->ap->print_id)
 			continue;
@@ -505,16 +496,38 @@ static void ata_force_quirks(struct ata_device *dev)
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

