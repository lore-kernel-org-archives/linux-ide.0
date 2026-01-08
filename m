Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7C44A1599
	for <linux-ide@vger.kernel.org>; Thu,  8 Jan 2026 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881558; cv=none; b=pqEU4koCfxhhfgQwJ8++zDK88h+wYwFDH3hA7hn+Rgu6QvvgRW0Td7rRwsNfqhGTEa3vIHCWFBvSFVrQPm9E1riA0BhwllHOXO/+BlJcBjYyejDOs7mazIpgiobHKcW4QbylUarDzb8nvfNtYkKOH0xArgenIkoKlRhsOF1ANC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881558; c=relaxed/simple;
	bh=h/o9lA08jplzswrxgQUj9DfY9YREgsTfckLnzG9/v1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cf/OPGmr6sX+6ICKJgjlLlKqJJJPg+fPast1f1QRE+6sRR14fgjD3n0p+er1FeBhja0ZhnRMvH/tQ8ikesCmTmtA36BkQJcFxBX+Q1fe4w+fIQ4JVDNjuFcYLDX2X4syFLKZ9QfV6HX8Gqonz7S0rDBfj/zZmSuAJr995zEEewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/i9Zx3r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/i9Zx3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FA7C16AAE;
	Thu,  8 Jan 2026 14:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767881558;
	bh=h/o9lA08jplzswrxgQUj9DfY9YREgsTfckLnzG9/v1c=;
	h=From:To:Cc:Subject:Date:From;
	b=H/i9Zx3rZ5QVLFG0fEDqEJjkHIotIfyCGWVhPZ3CGa1MVi1R96ISet5/09RoQwQtb
	 Q7sRfTc7Eu0WcJgBghiCQHwLyxyXaSzr0QNYmdcq8RWY+IXq/ybwA+JePE4iO3JGIn
	 AucN6X7lMfth6ZIR47nN+ejuPeRMiwYGrm8mZKMKR1SycFlhuu+WXgMMrvs34ITzCE
	 u8vTRNza3Fr3iU4Chp5z6mLte5GHS05t1VpUs5tedkpZUFpKStNBDJLcDEXNw/fZjs
	 SHPayKtfV/C/99a/enUMzp+tAslhCYNz0T5LaARpGzoHMz/T5gvrAXDnJeAZeYEEpG
	 jaip9dIaAAPzQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata: Advertize device support for DIPM and HIPM features for ATAPI
Date: Thu,  8 Jan 2026 15:12:34 +0100
Message-ID: <20260108141234.2837566-2-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; i=cassel@kernel.org; h=from:subject; bh=h/o9lA08jplzswrxgQUj9DfY9YREgsTfckLnzG9/v1c=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLjdwdxP3odb3g9dMGz1yK3hGeoVx6KmWjIt/6r0fsQL tbmbedXdJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiFgEMf3h8M5n+vJTuZ3w9 ZxfTz3btaubInw4dIfP9TJhZ//Ue+snIsH/ry71nMhSuGUvfO7iAvbOT+dw7O7XbDer/v9nmHGu YxAUA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit b1f5af54f1f5 ("ata: libata-core: Advertize device support for DIPM
and HIPM features") added prints if the device supports DIPM and HIPM,
however, it forgot to update the same print for ATAPI devices.

Before changes:
ata1.00: ATAPI: Slimtype DVD A  DU8AESH, 6C2M, max UDMA/133

After changes:
ata1.00: ATAPI: Slimtype DVD A  DU8AESH, 6C2M, max UDMA/133 HIPM DIPM

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b96105481784..20d539730553 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3143,11 +3143,13 @@ int ata_dev_configure(struct ata_device *dev)
 		/* print device info to dmesg */
 		if (print_info)
 			ata_dev_info(dev,
-				     "ATAPI: %s, %s, max %s%s%s%s\n",
+				     "ATAPI: %s, %s, max %s%s%s%s%s%s\n",
 				     modelbuf, fwrevbuf,
 				     ata_mode_string(xfer_mask),
 				     cdb_intr_string, atapi_an_string,
-				     dma_dir_string);
+				     dma_dir_string,
+				     ata_id_has_hipm(dev->id) ? " HIPM" : "",
+				     ata_id_has_dipm(dev->id) ? " DIPM" : "");
 	}
 
 	/* determine max_sectors */
-- 
2.52.0

