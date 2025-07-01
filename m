Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5433A347D5
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751328983; cv=none; b=gs2o6R89iNq6/3rbLiL6KEptg697/iGUKX6UAreOoBN54yoIaHoVaxZs6DDYeNO5oXxbbRL8cGk2Dl/zqoai88uwGap/TiIhFqL5lInTUiBfkbkK36DFUsg5Tbr1MgOEYwLtgL7J9Y6GTo7XHmQ2VqKL8SQ2Kp+6Jji383SxFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751328983; c=relaxed/simple;
	bh=qhimBdFodNcu3NHbyhvSBhfZoypPsjTxyv8KKq3uAFY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/Poi0APyaiOF2PD8W5xojw9nSCznrA5hkc9fCye6mwdfwISCvbO3a/Q9yVEy8Xh09BjDhBnzaakxCsgWW1mYiL48MfpSOarLQccGaVbgbSbs9cZBbBOMfunorfqLbFZ5cIy2ptTo4KmG7ex9PYzm15hpDiKeUXiixjACf2ZpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTZeKQ7S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTZeKQ7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1912C4CEE3;
	Tue,  1 Jul 2025 00:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751328983;
	bh=qhimBdFodNcu3NHbyhvSBhfZoypPsjTxyv8KKq3uAFY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YTZeKQ7SCold50rxkEmOGYCWZGM4+9JrGG6ahXPJySDoqJsGu+DXbWAoQJEPFGMaO
	 Va7emzf0MH4PkQ4GL/h5XmK5UA0hMzCspwX4XsyZOMQKRaropTuivKkL2ydG50Wm4v
	 DwY5L1jYaXb1sitqmGuyT+mw3rdJnbVUOBzO3zdAbhQskEO/eUkMSfFRghSFlGVxwI
	 7v05UzuuBVsawZt1rNYksCXNDqOingUQQBQvBzujdK0Iu0frtqBJxL48GZgFz2yUcb
	 q/F/iiKKfrRWA8xQUgrTN/ge4arRKJd7zqC/G/2cb/qiPtdOOpJMAMaLVUEkJu8t4B
	 eUJzh1kjUlHuQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 08/10] ata: ahci: Disallow LPM policy control if not supported
Date: Tue,  1 Jul 2025 09:14:06 +0900
Message-ID: <20250701001408.330364-9-dlemoal@kernel.org>
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

Commit fa997b0576c9 ("ata: ahci: Do not enable LPM if no LPM states are
supported by the HBA") introduced an early return in
ahci_update_initial_lpm_policy() to ensure that the target_lpm_policy
of ports belonging to a host that does not support the Partial, Slumber
and DevSleep power states is unchanged and remains set to
ATA_LPM_UNKNOWN and thus prevents the execution of
ata_eh_link_set_lpm().

However, a user or a system daemon (e.g. systemd-udevd) may still
attempt changing the LPM policy through the sysfs
link_power_management_policy of the host.

Improve this to prevent sysfs LPM policy changes by setting the flag
ATA_FLAG_NO_LPM for the port of such host, and initialize the port
target_lpm_policy to ATA_LPM_MAX_POWER to guarantee that no unsupported
low power state is being used on the port and its link.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/ahci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a061aa3299ef..5558e9f7b85d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1792,7 +1792,10 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
 	if ((ap->host->flags & ATA_HOST_NO_PART) &&
 	    (ap->host->flags & ATA_HOST_NO_SSC) &&
 	    (ap->host->flags & ATA_HOST_NO_DEVSLP)) {
-		ata_port_dbg(ap, "no LPM states supported, not enabling LPM\n");
+		ata_port_dbg(ap,
+			"No LPM states supported, forcing LPM max_power\n");
+		ap->flags |= ATA_FLAG_NO_LPM;
+		ap->target_lpm_policy = ATA_LPM_MAX_POWER;
 		return;
 	}
 
-- 
2.50.0

