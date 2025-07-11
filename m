Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DDF20298C
	for <linux-ide@vger.kernel.org>; Fri, 11 Jul 2025 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222256; cv=none; b=fEgJ3R1A9BnW+6o1AIA5/5p3DHmZQeDVXkNO2wNFtNKZCDxOD3X4Z50wOrChyscrkQtdOlRv+ziWB7Blvn1myH2LHAPgYrkKJW7TL94Q6+rufIokMV71VeI2Gz0eQb8rOmYlQpvwAzIJ8V5RuFjtp5X3nn9DNfvq4pu36GUVUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222256; c=relaxed/simple;
	bh=lagXzsNrLhoCvKs+EkL0ceG+78cTO8qy8zLcXlT0HBw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d4I5AIhWOkIeeeI6RJgoLO4IrtimJ5oJGot/8iS/TarKMYSFVa4QTssGUoaSOGmxZqHm3aa/HDtGkOMI+PVWd5EKX9Y3LZbly6lJMudqbQOBbClepr5Tc3RbTgOS/s5arIDAx6xZPt0NbxtaGWgi+0Edw7dmsHDjTE1VjWfo7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAH6t8x4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAH6t8x4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3D8C4CEED;
	Fri, 11 Jul 2025 08:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222255;
	bh=lagXzsNrLhoCvKs+EkL0ceG+78cTO8qy8zLcXlT0HBw=;
	h=From:To:Subject:Date:From;
	b=mAH6t8x4VQxMUp+zxkY1F52zPhChd/CIuSv/10aU6V4CN6Bw3svjIM+JMEY3c8CsU
	 19Jo1cniXpgyZTpSdCufeZN9br+qil+UCEguj2KtJNL+wqjRTWHirpFc+o/Nl0EbxX
	 2PWakGb5fksAH+1nMGRYfH/ij6LUOAz2pTXQpi+yAzilM6vakTz16eq8UBNM83KUnM
	 MXpI9eLQsFyaxeYGvyKO8A9RG4EwLhvPd3EmiwnW3/ccM3C5fkxCj4C9J5w0dJVa/z
	 zqrI2OzefL3dEmAJSR+zOkExDNrpqPVVYipmBD573YTsmsJuWxun0FFRQAxwBxEk2f
	 ammYFI5be0geA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3] ata: libata-eh: Make ata_eh_followup_srst_needed() return a bool
Date: Fri, 11 Jul 2025 17:21:58 +0900
Message-ID: <20250711082158.220047-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ata_eh_followup_srst_needed() returns an integer used as a boolean. So
change this function to return that type.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
Changes from v2:
 - Added review tags
 - Extracted it from the patch series "libata-eh cleanups"

 drivers/ata/libata-eh.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 42aafb1ddb5a..436536112043 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2781,15 +2781,15 @@ static int ata_do_reset(struct ata_link *link, ata_reset_fn_t reset,
 	return reset(link, classes, deadline);
 }
 
-static int ata_eh_followup_srst_needed(struct ata_link *link, int rc)
+static bool ata_eh_followup_srst_needed(struct ata_link *link, int rc)
 {
 	if ((link->flags & ATA_LFLAG_NO_SRST) || ata_link_offline(link))
-		return 0;
+		return false;
 	if (rc == -EAGAIN)
-		return 1;
+		return true;
 	if (sata_pmp_supported(link->ap) && ata_is_host_link(link))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 int ata_eh_reset(struct ata_link *link, int classify,
-- 
2.50.1

