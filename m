Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4AE2556E
	for <linux-ide@vger.kernel.org>; Mon,  1 Dec 2025 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592525; cv=none; b=aKy5B6Pjz6Fo3dMyTewgbh+uuX1pRB4uAnnnK1b/41QO/PHH8EG8eYQZLpEbD/LNvkOzQZUeVFgPc3REfJczE+5WY5A+MkXPSmY6PdcBG+IF4bcb83yl8E7WO/jL6J4QoL4xGc57XUEBYgtWXeJU4Wdm68MnPbrDhBaIhs5YvwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592525; c=relaxed/simple;
	bh=Tci+tbdjRK/rm/4TANKs/0MUyr7LBb/9zFttIrWv+D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0gGDnOqZHM/k9rMooq9/ry2CEo9EEw8O+tlL3dEXqUnWeEjp06g78nxbn/gHB2UoSIgDfrPnlcgVb/6eu5DKvceDwqSqt+OFvDHKTFHA+ByeTOUt4EPvSK/rzQeOzltkvpp0syN4K3aMI5FjERIsTyNQbgMlvaoPIU/FTaHqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wzf/J8zs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wzf/J8zs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72462C16AAE;
	Mon,  1 Dec 2025 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764592524;
	bh=Tci+tbdjRK/rm/4TANKs/0MUyr7LBb/9zFttIrWv+D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wzf/J8zsQsXdswytbjGbdhCnsxcH+D+LC7QrhCKlpzc2Klc4dJOxo+mUtbblXxXfU
	 q+jKkhdZopTCIlV20lxQJiTNxjA024zX56jBpo/CE4M2LhKR+rOT+PZr6xNEB1npic
	 dhg1DGHPA0g7cxQXrZA95qSMgQSY6VaDVPy/BYqEeUlTCsFSkrbGcRUrkgq9OXfReS
	 rRuVmK3du16d20KZQVf6dBg8wK83dYsp4Z3c/1nys6JmN1VY9u+VD5+hyeLSJNO2mv
	 0NYxJ4O9hX3neFRmZMTuwjmuVtWPFpWBpK71yt4u04DbcPAXNv3Ep42w7HRjimVjh+
	 dmxFr0JKCaV9g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 6/8] ata: libata: Add support to parse equal sign in libata.force
Date: Mon,  1 Dec 2025 13:35:08 +0100
Message-ID: <20251201123501.246282-16-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201123501.246282-10-cassel@kernel.org>
References: <20251201123501.246282-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2977; i=cassel@kernel.org; h=from:subject; bh=Tci+tbdjRK/rm/4TANKs/0MUyr7LBb/9zFttIrWv+D4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ1u6tMp+7Y3qCaPCu2OPHANP256uYLZmh+FAq2/3B69 xG/auZXHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhI6x2Gf6ZenNGCE3NtTNca WyZt0d3gF7lc9usK5cnz+HJW7N9n28fwv3q2/IynZw9xXFuhajitX/+rn8q0aKFpTRun8SySVX6 6hAkA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Currently, no libata.force parameter supports an arbitrary value.

All allowed values, e.g. udma/16, udma/25, udma/33, udma/44, udma/66,
udma/100, udma/133 have hardcoded entries in the force_tbl table.

Add code to allow a libata.force param with the format
libata.force=param=param_value, where param_value can be an arbitrary
value.

This code will be used in a follow up commit.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/ata/libata-core.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 697188b990dd6..7f59eca2a65be 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6461,6 +6461,13 @@ EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 	{ "no" #name,	.quirk_on	= (flag) },	\
 	{ #name,	.quirk_off	= (flag) }
 
+/*
+ * If the ata_force_param struct member 'name' ends with '=', then the value
+ * after the equal sign will be parsed as an u64, and will be saved in the
+ * ata_force_param struct member 'value'. This works because each libata.force
+ * entry (struct ata_force_ent) is separated by commas, so each entry represents
+ * a single quirk, and can thus only have a single value.
+ */
 static const struct ata_force_param force_tbl[] __initconst = {
 	force_cbl(40c,			ATA_CBL_PATA40),
 	force_cbl(80c,			ATA_CBL_PATA80),
@@ -6548,8 +6555,9 @@ static int __init ata_parse_force_one(char **cur,
 				      const char **reason)
 {
 	char *start = *cur, *p = *cur;
-	char *id, *val, *endp;
+	char *id, *val, *endp, *equalsign, *char_after_equalsign;
 	const struct ata_force_param *match_fp = NULL;
+	u64 val_after_equalsign;
 	int nr_matches = 0, i;
 
 	/* find where this param ends and update *cur */
@@ -6592,10 +6600,36 @@ static int __init ata_parse_force_one(char **cur,
 	}
 
  parse_val:
-	/* parse val, allow shortcuts so that both 1.5 and 1.5Gbps work */
+	equalsign = strchr(val, '=');
+	if (equalsign) {
+		char_after_equalsign = equalsign + 1;
+		if (!strlen(char_after_equalsign) ||
+		    kstrtoull(char_after_equalsign, 10, &val_after_equalsign)) {
+			*reason = "invalid value after equal sign";
+			return -EINVAL;
+		}
+	}
+
+	/* parse val */
 	for (i = 0; i < ARRAY_SIZE(force_tbl); i++) {
 		const struct ata_force_param *fp = &force_tbl[i];
 
+		/*
+		 * If val contains equal sign, match has to be exact, i.e.
+		 * shortcuts are not supported.
+		 */
+		if (equalsign &&
+		    (strncasecmp(val, fp->name,
+				 char_after_equalsign - val) == 0)) {
+			force_ent->param = *fp;
+			force_ent->param.value = val_after_equalsign;
+			return 0;
+		}
+
+		/*
+		 * If val does not contain equal sign, allow shortcuts so that
+		 * both 1.5 and 1.5Gbps work.
+		 */
 		if (strncasecmp(val, fp->name, strlen(val)))
 			continue;
 
-- 
2.52.0

