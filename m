Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50093112C0
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678112; cv=none; b=QBWDUxN0+dLprNonRS8ScyP0/EEBIUybH7TBUe5Gg4SNJxP18dM8jqoIt8xUKS240BkZdQQxh5qooG2RePOkDU0deUc8mn3TaHU8mlGr9VO32rVxijS5aXdd4RrNb6HYHhKn7dXzFKVcUArt6hGJMKpsnuqBv22hx6xepj64iVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678112; c=relaxed/simple;
	bh=WCA2tt0tm09SyUss64OgNPOexcuuB/E/NmmkkLHl+nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPMs83rFiEZB2c2qgKtJpVea3aVYmeN3jMi04Tfw5rmJneb4tE74Yoz/BJcDdRgBJo8odYYMdIN2xg5P0jNWPx/JdWzyW2ag7nq96oEp0iWlcoE8NykD5Ds2gjWcwp6nWJBdhU9WQAIw21aCIlejZeP4tAEb/Hi5X1ZxxTK4L1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJhIxq52; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJhIxq52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A46C116D0;
	Tue,  2 Dec 2025 12:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764678112;
	bh=WCA2tt0tm09SyUss64OgNPOexcuuB/E/NmmkkLHl+nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJhIxq52VxsspRTYcWrc3pfyUuiGpwHnvjq+NpKN0Hhq8KQyGZ5V2qdEhmmOfCYNE
	 wLEwRYYv3S96fIPCGAXANdkg81Tp9qfQORNmwRNQxNK/MT7SZjAr9yHHJFPAGRxtMy
	 Aph0T8Wl3cucQhV9BWSuSHFtHcX4KQ81QE8qrfcLUyjlQn10pQ7THYQMjP2t9cqKOv
	 F6Wx6+8YgsVXJu/XOZnszUPBF6PbBhEd2ryg/HE6pliCNpKxPHlijgq8FSeDOBb5nI
	 dkiHqTyeqB5+UEVR8JEUdU3ZY9dD0cyn2GwGatD95SO0+/Y5sL4n9Pry3bI4B7Qhhl
	 dbqsmgAXGWxRg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 4/6] ata: libata: Add support to parse equal sign in libata.force
Date: Tue,  2 Dec 2025 13:21:34 +0100
Message-ID: <20251202122129.421783-12-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251202122129.421783-8-cassel@kernel.org>
References: <20251202122129.421783-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3044; i=cassel@kernel.org; h=from:subject; bh=WCA2tt0tm09SyUss64OgNPOexcuuB/E/NmmkkLHl+nM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL1bp57x6p3wXXB/bYtWaxbNmVtOVQmsj/cfnZVQonDy xsL7Q5e6ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEzmxk+B+WksJ4/cmMeVwR PdaWKvvUZxw/c6d6Vk5CTN7pJZO+2bsw/C/cffPP1d4HL4PPpOtuvnmr6wBfa8TbB7umt8xf6cf zfC8DAA==
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f7f5b530bc2a7..9a8da530e123a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6457,6 +6457,13 @@ EXPORT_SYMBOL_GPL(ata_platform_remove_one);
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
@@ -6544,8 +6551,9 @@ static int __init ata_parse_force_one(char **cur,
 				      const char **reason)
 {
 	char *start = *cur, *p = *cur;
-	char *id, *val, *endp;
+	char *id, *val, *endp, *equalsign, *char_after_equalsign;
 	const struct ata_force_param *match_fp = NULL;
+	u64 val_after_equalsign;
 	int nr_matches = 0, i;
 
 	/* find where this param ends and update *cur */
@@ -6588,10 +6596,36 @@ static int __init ata_parse_force_one(char **cur,
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
+	/* Parse the parameter value. */
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

