Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE325B301
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374539; cv=none; b=uiUKFxTxdZoK/GtKAeF1hMStEQcomQLLW9kBc7Kr2Zyr/exChCNfERb0obXYdgl5PrGeBiQPvBWC+3VQf+Nq2EToHgizBgbG45XQA3EinSwIMbrdd2mHtHceQ+Ps5gysryaIq94gBEtGi1b2txeglATgtSg4cYq5T1XcFyzenY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374539; c=relaxed/simple;
	bh=GIp/DT+bb7+0tiP6AQohvxnh3HZlp3afXgVg+7RWKr0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPgUeYVEG9AzepiUrP1n84sha0ybdMxPQJlH12mpC2yGQdSMeHGqoD6dtbwkFXgv9l505uSS0J4yTnyiPXNrCfRR4VGRVueryuUR0zL71CJh6mBsoET7IA6oQiA4mt4Fe33dBQfGJVc7ZwG66yCdoSlg6g0KSAAkNHpjqpqCHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No4En0k4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No4En0k4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F39DC4CEF2;
	Tue,  1 Jul 2025 12:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374537;
	bh=GIp/DT+bb7+0tiP6AQohvxnh3HZlp3afXgVg+7RWKr0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=No4En0k4QdMIzPnf07oUT1Q6x72nsiRV5qUW2LGLkOb6JnlZ2sLZ5rcFR9YmVAE72
	 3UZVJW9AwoKyoM9CWe71GgjS60B+Nhul0OWlg5vnoUvx/0AroJKI7bNYpaIlDVcttC
	 ZXbFS+302N8aCscZKlKviisu2ABOHHkZFDlCFHH4gNn3GlREf4+eA5e55Hadolu0+G
	 8CSDDSF8QQT+B6eIK8Kb/WJYDv79sA53VmoyJDoNvFjYM1EgiRdLTHzIrywHA2cMa5
	 zN/hT0vKHtJ6ARGHFlhKekC9z8r/rhn/mWzNfVxliweV+MUa8/ZtPsXY2y50+miirv
	 ZZF1H20O/jQbA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 07/10] ata: ahci: Disallow LPM policy control for external ports
Date: Tue,  1 Jul 2025 21:53:18 +0900
Message-ID: <20250701125321.69496-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701125321.69496-1-dlemoal@kernel.org>
References: <20250701125321.69496-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ae1f3db006b7 ("ata: ahci: do not enable LPM on external ports")
added an early return in ahci_update_initial_lpm_policy() for all
ports flagged as external with the ATA_PFLAG_EXTERNAL port flag (e.g.
eSATA ports or hotplug capable ports) so that the target_lpm_policy of
these ports is unchanged and set to ATA_LPM_UNKNOWN. thus forcing libata
EH to not be called for external port. The goal of this change is to
preserve the initial power management policy to not break the hotplug
capability of external ports.

However, this change is incomplete as users or system daemon (e.g.
systemd-udevd) can still apply the system preferred power management
policy through sysfs, thus potentially unknowingly breaking the port
hotplug capability.

Modify ahci_update_initial_lpm_policy() to flag external ports with
ATA_FLAG_NO_LPM to prevent changes to the LPM policy by users through
the sysfs link_power_management_policy host attribute. Also set the
target_lpm_policy of external ports to ATA_LPM_MAX_POWER to ensure
that the port is not in a low power state preventing hotplug operations.

Since commit 439d47608bb3 ("ata: libata: Print if port is external on
boot") introduced an unconditional print on port probe signaling that a
port is external, the debug message signaling that fact and that LPM
will not be enabled is removed.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0760fa47d90e..a061aa3299ef 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1776,7 +1776,8 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
 	 * LPM if the port advertises itself as an external port.
 	 */
 	if (ap->pflags & ATA_PFLAG_EXTERNAL) {
-		ata_port_dbg(ap, "external port, not enabling LPM\n");
+		ap->flags |= ATA_FLAG_NO_LPM;
+		ap->target_lpm_policy = ATA_LPM_MAX_POWER;
 		return;
 	}
 
-- 
2.50.0

