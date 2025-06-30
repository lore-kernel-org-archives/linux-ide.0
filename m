Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19811D516F
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264933; cv=none; b=nrAhTRSL5cR/HxMABmA8B26C7UzUpFNiaFut0jzeyllsBGr3iHxM/5773C5YxkO4gmki8fYrrX+OUvApVah7R++5V1rD+PtKVd+s0+VtVJ0dvbsO4o7D/B6K9MiRvUSflTTVnfpuSd8LPVqH9v7ZWprc2ZT8GnlG+YCKNsu8g60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264933; c=relaxed/simple;
	bh=9Swpiwa71zlvz6N2D1pgan2owId2ZKVzmSy9XOgxJMs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKK1nCF2KW1Hto7LYXT61AB8lfwnxnnYr0eYoJ2+J+8fTG50U0RYTae6jrnzvhTgnq+V/e/cipzlicFPgcpm9PsQXype6Tvs2L59Efotq39B6G7nhfyBHxgYVSRsqXTtDlafHvJ7cSonCypcF5v8t+6pnEw3Wn9dPxTPTgRnvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ozl14e8V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ozl14e8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7B9C4CEEB;
	Mon, 30 Jun 2025 06:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751264933;
	bh=9Swpiwa71zlvz6N2D1pgan2owId2ZKVzmSy9XOgxJMs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ozl14e8VHvsT/WfCPgqUdt+Msdatwa8Nyqyqv1pN8oA5qosGlGLqYrk1JfS9esxv8
	 GTk/wXhrmYeQacM2sXT6+JTJ7N93E2FRNO0FKVw6j9t+JKbVmJd9r9he5AoTAGDCrm
	 KSGZNM9BpFpNgpx46iNJ7KANhW8+cDBdxcIOjOEDGdCeaxEXdmAbRBjcXqYacePSON
	 7ciJn9oFffL40ngCB/KeU+dOxw3PUm1l7u53zByTZaS4M01oh8lyqKNEFHkBnnSN0j
	 05MMKDTdNj/An9vGvM2cwRMrLG9g9y4zqTu9K6NNRSZKvJylCXAjY0tiiI3Q2UABuE
	 JMQXFbN2qWCEA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 07/10] ata: ahci: Disallow LPM policy control for external ports
Date: Mon, 30 Jun 2025 15:26:34 +0900
Message-ID: <20250630062637.258329-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630062637.258329-1-dlemoal@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
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
 drivers/ata/ahci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0760fa47d90e..34698ae39f55 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1776,7 +1776,9 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
 	 * LPM if the port advertises itself as an external port.
 	 */
 	if (ap->pflags & ATA_PFLAG_EXTERNAL) {
-		ata_port_dbg(ap, "external port, not enabling LPM\n");
+		ata_port_warn(ap, "External port, forcing LPM max_power\n");
+		ap->flags |= ATA_FLAG_NO_LPM;
+		ap->target_lpm_policy = ATA_LPM_MAX_POWER;
 		return;
 	}
 
-- 
2.50.0

