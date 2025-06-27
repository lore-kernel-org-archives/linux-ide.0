Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82D2264C9
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010859; cv=none; b=IiKOos0lDCHdfis4TvtzDWdoj1FMeJwCGISgLRrTEfeu7gOAHM2vUtHe1OEmtmRqIh5K4iwoxvqDPoArjcZ+T2V6AO7RwlVyL/UYmXXPMbf5GhkPERjng96ENFwHUL+PTHsFoObU/79jeVHk39EbRV59VdhVqfCESsfhYSzELrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010859; c=relaxed/simple;
	bh=S/cRfPIMKFude15SJxgMPruShX2jm2Gr81pda78LQOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pL/jMIvJj06NQdndUtSEU0kblcWP5aTzeheMnbj9XhjjIGpzQfL0gz7zqhQ9AAIUg0hyej3IzIceWfSksZ7PbdU1xCqwB4uv2/tMmlM3D499P6MeK3fOR4WLvNDM3uZ3af/JMTaks/2UfAEWNeE0TNvmI1oYjedFRJ3wHr/nHwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5k77Bhh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5k77Bhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9F9C4CEF0;
	Fri, 27 Jun 2025 07:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751010859;
	bh=S/cRfPIMKFude15SJxgMPruShX2jm2Gr81pda78LQOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5k77BhhNdwt2N+H+Ex9CLeskqwrI/fPEbmPTftQ/RC2R9YL4ck06b0O2axFjobls
	 ibFfnYJVwGb3BdDAqPfWSqwuvQhu66964mskqkgWQat/1ON0kkAE2shArAaFnf1arl
	 +DNR4fEvVcybUtDRpuakNus9+tGraUOZxPwcrtWOc4Ws268wIIpcNhviz17PpsHyme
	 FxbayIzIiA1cR1naL7j8i0qtSP2UuM+rAp1Y1u0luQWcH/TkHmNGsuE3rN8jP6wCcp
	 7VZ/0pryDLi3BpqeVKFEQGlXpN7bQY24rzb8zT+yNCHb5Kbpd+Zk+8rxLvzBBkhtCZ
	 5RWSJnYatUHPA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 5/6] ata: ahci: Clarify mobile_lpm_policy description
Date: Fri, 27 Jun 2025 16:52:06 +0900
Message-ID: <20250627075207.23969-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627075207.23969-1-dlemoal@kernel.org>
References: <20250627075207.23969-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Despite its name, the mobile_lpm_policy module parameter defines the
default LPM policy to use for an AHCI adapter for all chipsets,
including desktop and server chipsets. Clarify this point in the
parameter description.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/ahci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e5e5c2e81d09..9347d0ec8793 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -674,7 +674,9 @@ MODULE_PARM_DESC(marvell_enable, "Marvell SATA via AHCI (1 = enabled)");
 
 static int mobile_lpm_policy = -1;
 module_param(mobile_lpm_policy, int, 0644);
-MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
+MODULE_PARM_DESC(mobile_lpm_policy,
+		 "Default LPM policy. Despite its name, this parameter applies "
+		 "to all chipsets, including desktop and servers chipsets");
 
 static char *ahci_mask_port_map;
 module_param_named(mask_port_map, ahci_mask_port_map, charp, 0444);
-- 
2.50.0

