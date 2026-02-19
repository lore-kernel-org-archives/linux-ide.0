Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AE2F3C37
	for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2026 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482508; cv=none; b=aflAG7gT0TkzuA9MIY2XcDN1u4jPpLH1lAA4i4tsjJ3SIxKuhkmWMXtVypjYGMK44KHe3GgbyIH373HKOlPCgSLRWN4Jb/VDByzam67WFCkhooYwbRKxdfEoS6WlRGPCDCCgJ7FMqEe5ENBew0ol61O2o6DMzXU2JhWh2TE8Nj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482508; c=relaxed/simple;
	bh=IMPCA4kaMMH/o8PU4a3UoKwUomBxVwvmz5ibV9rN3I4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6lDlHpCMS19T0lQD4a3R03hlMcugMYZPV21e/XZpLv6rMoM+87xvSQMf1Kr3tSJq0llB8f5BvCb9BfUNxteMzeKxBS3nEnpWji9JubQfhl18KKHPGbXbTPr9KNXwj/S/SdjJMadwXh3qduuanw4/p84jhlmXbnxSgI+1GKRb+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8sT8j3g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8sT8j3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAB9C4CEF7;
	Thu, 19 Feb 2026 06:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771482508;
	bh=IMPCA4kaMMH/o8PU4a3UoKwUomBxVwvmz5ibV9rN3I4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=C8sT8j3g+a+JmmPgWVa0lWA9TLNSkQngI1HYsYKE+A+0le3Tga2C17TGeFofz3TLX
	 W0AnVVr4HUUfzfBnxYwwASgYHYYuR7MhGnIzesSuzno0rqSyt9V0pa2oWilacpriir
	 PymD8McKU64KHElB9l/JM0iXYXTnWsd1QvdN332mgx6p2pRqYwstSNHUlv/HOrAlC7
	 ZxFpZy1O1pwDe6I0MYsoigHz7npcWVXzHooVkZnVb848zz/GDIUNxJ09+4EWUgED0V
	 CbDSDHgBiAP6pO8+2chRyO6AQLhtIVOqnNAbd6LAQ0e0NgRhv9fy9NLNuaQKYgW6mK
	 tQo+NfiHzmI6A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/5] ata: libata-sata: simplify ata_sas_queuecmd()
Date: Thu, 19 Feb 2026 15:23:09 +0900
Message-ID: <20260219062312.1030867-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219062312.1030867-1-dlemoal@kernel.org>
References: <20260219062312.1030867-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change ata_sas_queuecmd() to return early the result of
__ata_scsi_queuecmd() and remove the rc local variable.
This simplifies the code without any functional change.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-sata.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 04e1e774645e..00f7e5443e3d 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1378,15 +1378,13 @@ EXPORT_SYMBOL_GPL(ata_sas_sdev_configure);
 
 int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
 {
-	int rc = 0;
-
 	if (likely(ata_dev_enabled(ap->link.device)))
-		rc = __ata_scsi_queuecmd(cmd, ap->link.device);
-	else {
-		cmd->result = (DID_BAD_TARGET << 16);
-		scsi_done(cmd);
-	}
-	return rc;
+		return __ata_scsi_queuecmd(cmd, ap->link.device);
+
+	cmd->result = (DID_BAD_TARGET << 16);
+	scsi_done(cmd);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_sas_queuecmd);
 
-- 
2.53.0

