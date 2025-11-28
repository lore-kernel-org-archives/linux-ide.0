Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A32FC89F
	for <linux-ide@vger.kernel.org>; Fri, 28 Nov 2025 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319718; cv=none; b=efr/rQY5QnWZIhIaS3aNPEa+n5B8ihhAYJuWXoTGbvli/dYbZVaEKdFDtQNwHf2KDTkOd0r0HRTxCJq7pg20NUGmb45X1XTuO2lEzAOcqM6XmBsm34EY0Epw+NVMRPLZpbgn1dL92dzPJ32Uk/fHdMOYibvj9C0nFMVuol+gdXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319718; c=relaxed/simple;
	bh=slqfS4/2ND7iJIJhdzRY2abg6efLBPkeefaC1inMWgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYlU8EPf5vWEZJL3wItSyEtDt0VctLh6GjcMRoB0wQ+gcaV74y1g3YNBJWOToKRjaWvAD3+xVW8OaA0ZPfFrrW6qOkGL6K/XOWAOsbmS19rjIOvlGmFkOm5Xod95NIlvXztLBtkRv8uwb0cI5lBdoFhsK1C5D7GUlgoD51/pHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEA7LV2I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEA7LV2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E49C2BCB3;
	Fri, 28 Nov 2025 08:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764319718;
	bh=slqfS4/2ND7iJIJhdzRY2abg6efLBPkeefaC1inMWgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEA7LV2IXBakPo/nx2k8uweDEM1r93QibdYSLoLTgY+1qUHbjvm9Gg135cUhXBaEn
	 P7IeOK9Ryyp3SAOCUUPGrR6/Tymp3tLTSBbhMdBu793Qt72UbAIEGst5KSxIQEa4+m
	 RLWzhruq18mVWogKjC/bvfCx/klLDBHs1so7tJPCVlXhRPHGCwKYuYziO+ci4ks0L3
	 3SH++pCAP4THANtLesdjs1fFbedrJ7bgPPOW2NpJldeBJlmEYzi3C6eJv3ND9Za3fE
	 3ZOccXKQIwN+rONyjS5mRUkGH/OI2DsG/V+X+0HfO2kzXuB9FD3X0PyejB7+6pZ0x/
	 8MqD0GsQSff9g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 3/8] ata: libata: Add ata_force_get_fe_for_dev() helper
Date: Fri, 28 Nov 2025 09:48:18 +0100
Message-ID: <20251128084814.3798425-13-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128084814.3798425-10-cassel@kernel.org>
References: <20251128084814.3798425-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874; i=cassel@kernel.org; h=from:subject; bh=slqfS4/2ND7iJIJhdzRY2abg6efLBPkeefaC1inMWgQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI1Ey9N+uwmfyhdeduVtXkH9x0+tr2x4sztuMl5Ex91v sjc2GX4qKOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATMb3KyPDBPPHju78vr1n6 x9ucN7z868Y8Pnae5fMC+3dvyq+VnMbKyLBWznxx3Brhu7vKU7X9j56KqfXrrAiLcLfg5eQ2XH4 jjgsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add ata_force_get_fe_for_dev() helper to get the struct ata_force_ent for
a struct ata_device.

Use the helper in ata_force_quirks().
The helper will also be used in follow up commits.

No functional change intended.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 55 ++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 634d6b07a92dc..b1ef45c1a376a 100644
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

