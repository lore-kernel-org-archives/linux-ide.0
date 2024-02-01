Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7186C626D0
	for <linux-ide@vger.kernel.org>; Thu,  1 Feb 2024 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804125; cv=none; b=R4P/5WX2gCtQ4c3/jg83f4ALqRyUQsGR5cc23qDmypgBEoRfHtV1yU58WUSl9d17OP+102CxBIgUtL8mlbyzaOjI0ueca1f0eE7pgCt2wmRx8dUaoTAEoq3ZJNuC3pVthw0yg9FWTs0uDOvCnNx5dqP0fvWSL88wzsvjVx87RiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804125; c=relaxed/simple;
	bh=XwBw/wcnkq1I4IsmsAg3fqAf7rKRzuFhBPPLWIpe6Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+x/dwYNWKEEw4frL7di2rFb9FS1YDzgTvCyt7EX/CV7tpbBk6LfTPMlzgW0W/nj/oMdjKxkFi3OIygFjTBdZwq4SjQ4rSkTSk+A7W0eFQVtvVLF20GecUlCst0e+zqBFEDOIW/5R1wGa1c91iM0s/EcdyujFDmBYo5gmzvAKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+7e4KgL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+7e4KgL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DADC433C7;
	Thu,  1 Feb 2024 16:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706804125;
	bh=XwBw/wcnkq1I4IsmsAg3fqAf7rKRzuFhBPPLWIpe6Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+7e4KgLjGvtxClz/gsgMiYE3wI5qRiXYRImAl8z1ovtM4qFXhYUqGAAAG/AH2zcv
	 JJbMBuzOGMEldMRC/bmMcrnUavZYDkbnTcVtxNRaDjdrNnAgbe+a2OUZ5En9Mpiytx
	 RoNgGOjDgEGdVCw9VMmN8f0SI3UMAHQZetYSFOPMXWNUZG+jzHBzZoidtXwreEvJWt
	 wWaACeagH/3Og4RzannPcu8Chv7NaLWxSkFx4l82aPMof/4KeChdWR2Rd7LFjaOCi7
	 nstBrVanEbf9Y8zX+tSQZR/eU7J7mFbGjpUD7H+y4oWNK0VgCKbZ6ROn9BMA2s+jKt
	 TEs7jTq7t+hFA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	linux-ide@vger.kernel.org
Subject: [PATCH 3/5] ata: ahci: drop hpriv param from ahci_update_initial_lpm_policy()
Date: Thu,  1 Feb 2024 17:15:00 +0100
Message-ID: <20240201161507.1147521-4-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201161507.1147521-1-cassel@kernel.org>
References: <20240201161507.1147521-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need for ahci_update_initial_lpm_policy() to take hpriv as a
parameter, it can easily be derived from the ata_port.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8c8403bae36f..19b605c98d42 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1654,9 +1654,9 @@ static void ahci_mark_external_port(struct ata_port *ap)
 		ap->pflags |= ATA_PFLAG_EXTERNAL;
 }
 
-static void ahci_update_initial_lpm_policy(struct ata_port *ap,
-					   struct ahci_host_priv *hpriv)
+static void ahci_update_initial_lpm_policy(struct ata_port *ap)
 {
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	int policy = CONFIG_SATA_MOBILE_LPM_POLICY;
 
 
@@ -1949,7 +1949,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		/* mark external ports (hotplug-capable, eSATA) */
 		ahci_mark_external_port(ap);
 
-		ahci_update_initial_lpm_policy(ap, hpriv);
+		ahci_update_initial_lpm_policy(ap);
 
 		/* disabled/not-implemented port */
 		if (!(hpriv->port_map & (1 << i)))
-- 
2.43.0

