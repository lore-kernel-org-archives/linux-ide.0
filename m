Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E91B942
	for <linux-ide@vger.kernel.org>; Tue,  6 Feb 2024 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707254063; cv=none; b=opK60uVCmKtu73+sYmx9htl1Hy1nT6eYt0W/n7lDw4pICDKZm1IZoQ0DFiq2xFgBNrXqb5BMT+WrfLT2DAEciZ8cUCPRnTAOYR0NWo6np4wy1H8O4tQNEhyIB8EPcjlxuynHD2A7aVcYM4GPYa/UJlXjjzPczEahg+DmhuCVlac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707254063; c=relaxed/simple;
	bh=WVW7rapzVbtdhBN/8wNUHqabi6PJi+e9tY2txdgsxp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0FYJM/cqun0bHJMiOCKBkKxaved0KKwAlL6en6BHJTZQlAsEG8GHBCPneYNp9IXsxpX2yJgWfnSjrNX0+nWeXaQqNCzB0C3D1/9Nd1drSLAuDrym9Owy8P+aXIVLaQblOorHhFxVMQphqTCnikKEzR8HsQID0pg+xQtq7nFdOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkCgu/Mk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkCgu/Mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879F6C433C7;
	Tue,  6 Feb 2024 21:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707254063;
	bh=WVW7rapzVbtdhBN/8wNUHqabi6PJi+e9tY2txdgsxp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kkCgu/MkjZe4lQvhZX6+tKFz95gRMOKZWHr6PIG8zqmbrJQeoTvZFyXw6MZG+GP9J
	 r2WRDTEgXPPskP4kdLrcQBGUtNpTT0jYLK+qjsULri4hRWfgqDmegkr43/N5W9Kl+l
	 eT0sfLJbMwPyNZqyu7IwD6lqRIGrO4C/av2rDxUW/V7yoayiEXrP9X5YjYBY0hoi4o
	 fAyGcKgieAvtZT7jhfADfAWCgqLqf1cGzwfVzlEzO0vhm2TZ+rmOVfPECFypy1WvgB
	 PgjAyR+xskB4fLQyMLNjWsY/QRqakPh9wjyVnP93s2hDBz/wWvtp4xYj1dAEps7Yeo
	 VXvJtfHLrygJQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 2/5] ata: ahci: a hotplug capable port is an external port
Date: Tue,  6 Feb 2024 22:13:43 +0100
Message-ID: <20240206211352.1664816-3-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206211352.1664816-1-cassel@kernel.org>
References: <20240206211352.1664816-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A hotplug capable port is an external port, so mark it as such.

We even say this ourselves in libata-scsi.c:
/* set scsi removable (RMB) bit per ata bit, or if the
 * AHCI port says it's external (Hotplug-capable, eSATA).
 */

This also matches the terminology used in AHCI 1.3.1
(the keyword to search for is "externally accessible").

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index aa58ce615e79..4d3ec6d15ad1 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1648,9 +1648,10 @@ static void ahci_mark_external_port(struct ata_port *ap)
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
 
-	/* mark esata ports */
+	/* mark external ports (hotplug-capable, eSATA) */
 	tmp = readl(port_mmio + PORT_CMD);
-	if ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS))
+	if (((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)) ||
+	    (tmp & PORT_CMD_HPCP))
 		ap->pflags |= ATA_PFLAG_EXTERNAL;
 }
 
-- 
2.43.0

