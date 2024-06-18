Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E3D3C099
	for <linux-ide@vger.kernel.org>; Tue, 18 Jun 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724965; cv=none; b=I7Y1oEID2WR7UUxWGut0AU5BTsn1/BvgcnMdZqggZHNWMqm2PuW0C28tBTHQAyIw7TmFTvT93KBrMTGpnzmIQNvvAohvWRH7rARHC1PncK4Y182DzFZs7lVjZIMWHPhpKzQxFi0AhC+H2rOvek7NWl9uuJoM2Pwoe9EpJIxEgHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724965; c=relaxed/simple;
	bh=O9efohNnmPaH/M37FSBpouLvTMt9GpNqtDbOmQkTbBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nd4kz9amUeN8XlIMT4DrhEBkymnpn1s69LGJ5lah3Ka1cg2/ewqyodRwWMfvLwnKRn1ikAL8dE91zzLmypEWNolO6g2ezxeKdFkAwBY7bapBu2oz6BO+Sso5BUokq7rFkrTmSAIKyzNVnOeN2O2R6mQyh4fn7GRX31MagsJWCsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nybGGjAX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nybGGjAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82811C4AF1D;
	Tue, 18 Jun 2024 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718724965;
	bh=O9efohNnmPaH/M37FSBpouLvTMt9GpNqtDbOmQkTbBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nybGGjAXPIjfD16R25qUKWzjbT0KHBI8/hPZZMhHTuNvxm9x3Vx75nJTIs1WDLaSe
	 p24FxCuFNsrkuqyiLoP7Y3bjbQEksqpHWsRPCptffv6uoNQsKSszVB/VpJD8XhAx0/
	 VZXtc0gyU6uG4mAIMgxqjCVt7kPdL9ymoHO9TbL+5kSYiiunOfIWQBYX4T9TMSeAXv
	 orbOy45vzaUagA660aDavBXPWOiX7pjpnv48oA6rc9gIcbfxWF4/8Z0ZTCv61pR5An
	 Tz/OtWp1qEZuyIyVGQXtS7+pHL6OoIlT5AI57Jn60PVJBTgCysDwktfiXcSf4pG3aG
	 vOy+ifoblmDwA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 5/5] ata: ahci: Add debug print for external port
Date: Tue, 18 Jun 2024 17:35:43 +0200
Message-ID: <20240618153537.2687621-12-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618153537.2687621-7-cassel@kernel.org>
References: <20240618153537.2687621-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=cassel@kernel.org; h=from:subject; bh=O9efohNnmPaH/M37FSBpouLvTMt9GpNqtDbOmQkTbBU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIKV3rv75ScdWDSPYvfO3dMFFqbcd5M/Z3Qbffgha1Gy q6Nurted5SyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAizQ2MDPeTcgWF8zz0Zz50 d7r8XiPg+9WUi4K+20yKVZSklDjFbBj+uzIWhFWuFNc3zfxcv+D+rKSrVbxOU5OuHY71/7uANTy PEQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add a debug print that tells us if LPM is not getting enabled because the
port is external.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 07d66d2c5f0d..d79e46a59df9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1732,8 +1732,10 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
 	 * Management Interaction in AHCI 1.3.1. Therefore, do not enable
 	 * LPM if the port advertises itself as an external port.
 	 */
-	if (ap->pflags & ATA_PFLAG_EXTERNAL)
+	if (ap->pflags & ATA_PFLAG_EXTERNAL) {
+		ata_port_dbg(ap, "external port, not enabling LPM\n");
 		return;
+	}
 
 	/* user modified policy via module param */
 	if (mobile_lpm_policy != -1) {
-- 
2.45.2

