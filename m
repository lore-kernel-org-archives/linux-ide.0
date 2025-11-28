Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16DF2E8DEB
	for <linux-ide@vger.kernel.org>; Fri, 28 Nov 2025 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319723; cv=none; b=IcZD0xOSqdzSCWEHImRsdUXx8yKQauMnIB0Y1lkKHc9i5+69ZiOtHyrFL2+lBeHIc3RP+sTSlZMRB9iFyz4jV1tjhjmi4S5bfSJaWB9chPGtsDgtsZ6hM2bKukc2aiE3sbYYLj+uPmY3+15WjzwtbjYRauTas7/SzkNHI0hbMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319723; c=relaxed/simple;
	bh=nw7ooSJ27cfriYIFvKYvHnab0dY3VMrSlrE1BtW+Euc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3ZIoYos3dT6szZVP25GQ9Q7bhHmUnDsCRarxvbwvrf0DCQHyWIT2Gmcdw6d9wN3OkOn+HkUOy51P0TWyFmlb49k9qvG5XVioX2kzD0DuUBkMQGT17fDh0IodwzlBL7Bk1sgoN0YBUC3jb3vH2tdEPt/Qzw1qjBf/gMgsiwIeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcKbQJ9B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcKbQJ9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D109C2BCB3;
	Fri, 28 Nov 2025 08:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764319722;
	bh=nw7ooSJ27cfriYIFvKYvHnab0dY3VMrSlrE1BtW+Euc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gcKbQJ9BUdzTEZba9KkoGcqhiOGvLkdRum7SXidwAS01RrKAiVMbMz/F5uXpmYiIA
	 Ibjs92Q3FBlnZoTCcKT8HkfUJHqloqsd0pkIR8Wt4mCbIbzfJJfFcHudi4gSZd/w0G
	 f21sesYs0lSm9MccQZMV1qfzt14m24CTQ19+KiU8noywoo/lml9OieWSf3zsjFsXzw
	 jkXTLcCSsvQ9VserpfBP4TWQuXLNW9MqoJjEEov8+y0BlVPMVgNeMfe9jN+CBXnvOY
	 xL6nQ2nh6uWxWc7IHKgKJlxXQJc6tE7wQq1C/cnZMpVh5sWDbk4cnlT+uazRUz3SWt
	 DbUCnDC85ooqg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 6/8] ata: libata: Add support to parse equal sign in libata.force
Date: Fri, 28 Nov 2025 09:48:21 +0100
Message-ID: <20251128084814.3798425-16-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128084814.3798425-10-cassel@kernel.org>
References: <20251128084814.3798425-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2915; i=cassel@kernel.org; h=from:subject; bh=nw7ooSJ27cfriYIFvKYvHnab0dY3VMrSlrE1BtW+Euc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI1Ey+zPJ6SU7LYT1fu9rPTr9cu5916488aX0ZJsaI41 1efZl6r6ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEfp5hZPjbf85wnppL9Ou9 ptOK0nfl5LjGa+2bfvHY3OcLd/ox+b9iZNjLfj5lKpPwNRtXzsyt/zfMcF7yZEaeyOTdgfYLba5 nirEAAA==
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

