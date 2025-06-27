Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A7215B54A
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986844; cv=none; b=lAsK/afabywX1YEeQolVwNgTmb0gvWAOVh51Py1BwUs1OqbeTpFHnl5BUmsuT0ByPNKzc0fzWKXPlFoPKtEVTn43Ks+CaBo858ivBSC8zy/6/N8nlySHpnimSZ2NoKOD0ofZ9L/hlSQWqeqktXV3d3bdQUhNTU8OKBL4+0zaMgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986844; c=relaxed/simple;
	bh=6xuakKebX6SJpYG62FShax/TD/Ck/5u6XwKTgWXPXNc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LV6m+lWujLGRYXJve19QPe3jvfsEyC+EXnBPHTOEUDGsz80vwsEkXHHjcin8Nku38auwdfrmi9hfv3zGs9QP7oO3nK40IFpAFI0hc4PTFSt0BHUBgY0tMx15/im5FuT7LB3ueeuoWL9qcJj+rHL+LuHK8hQ2fcPYA7bBHtA8QFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI7NO5gx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI7NO5gx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93528C4CEF4;
	Fri, 27 Jun 2025 01:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750986844;
	bh=6xuakKebX6SJpYG62FShax/TD/Ck/5u6XwKTgWXPXNc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XI7NO5gxMxDIzch/qN8Sg1Vt5gc7fNp+OdfdlbUkfqu81/bePK3qCeJ6VWl6d376u
	 wSQVFWKvxOjwj1SzvVQtWgsL7WZIIFcIT3hgQs6Vt0bbUspXwt+JP0+z6H/8Ga0kyJ
	 G0HBpnlfDmENqZoZqZWVKxGxjUkV7Pm3FnLwedebQonm7D77Z2U5XBXUIkq787HSEP
	 Y6kOTKmfnTWVTj7R4l6Fxz7tBqpdY0hP4LItA05+6JLGxe2oxaulp4DtUTKQJoptHR
	 CVq6xQmz3OuGT4B0LSR15iHajIJIXX0gFbvoJ6stAQNJfEEwQ0zt4/27Bbv6p41Y/p
	 2qKld9TkkM4yQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 5/6] ata: ahci: Clarify mobile_lpm_policy description
Date: Fri, 27 Jun 2025 10:11:54 +0900
Message-ID: <20250627011155.701125-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627011155.701125-1-dlemoal@kernel.org>
References: <20250627011155.701125-1-dlemoal@kernel.org>
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
2.49.0

