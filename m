Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E7A347D5
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751328982; cv=none; b=Y7wXlqv/tvU7jqCEDr0dNh1ysOwk7XjceGFpMvt8FlJVQpTqauY4DrLggYnmMZF75fg6fTsRCgai5/0TyjfT94rTpXKcnXoS2D1HgCTYH8sTSpmbRMupVIOo5Rl3ZUAXtJtUDqiiUOWG6mLUi4uhxpTDezA5GnP92m0DY/7FW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751328982; c=relaxed/simple;
	bh=wyc070ITZ7p3F1Uil+q0KE/Mx9b+Z4fjBsBNHOSqHGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li8GWEtoT1H4FgsK/enO6iO8A3gbegIbNhLlsH5gxG4UIY9eCxHlu04koSvVnuwWWuqhACdli0Ya9RpTJk7xjew9V7bK1AMy0ke8P4Rssr6BJp9hRvBvnMTFowPy2jUPEh82jmL7tA6K3EJdAtzDR8sA3hRWKi7bFys1yAwRNcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFs+9i/E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFs+9i/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3D2C4CEF0;
	Tue,  1 Jul 2025 00:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751328982;
	bh=wyc070ITZ7p3F1Uil+q0KE/Mx9b+Z4fjBsBNHOSqHGU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gFs+9i/EZYHYtV4CaUcxsZ8DoebKLX1r4GJyrOhbZnnQ2mmE4Yvp4O6Ay9m8Pd6j9
	 YP1TuskuIWPeJaCeHop7aWqgyQ9eKt8LuD3Q64MSwD1Th7x0r7YUS7dKCr6pUXHlXP
	 Xr2dz3ahlAGtLs7681qFTIh5WoVqmkf/upTJcgbt8sIaM3pASG6Ew3ynvjGaLqdQfP
	 zIg413mQ/0KA0KckGyf7K5A/y01eg6NXLRct+QvMxfy33AlergGST6N19RwnPGr0zb
	 S0SZ1ASzCwwkOulU48T8l1nexK3xyYmqzN2Hsq7c175abJ9O7TvdGQwHwg6Bj+AUCd
	 mHeaxxV0ergvg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 07/10] ata: ahci: Disallow LPM policy control for external ports
Date: Tue,  1 Jul 2025 09:14:05 +0900
Message-ID: <20250701001408.330364-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701001408.330364-1-dlemoal@kernel.org>
References: <20250701001408.330364-1-dlemoal@kernel.org>
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

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
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

