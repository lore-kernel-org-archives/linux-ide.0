Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927EC3596B
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374539; cv=none; b=irQ374i1ugQDW/Mzb4r4V3aS8cW/J98aOhlA9by0HmEwldG6pbi4aRRigjExlPMssFoFNn5nZmhjqm17hUnlfW0NmbDFx5+QstZWdwx/4mGBLX8osB3uOOB8HErSaVWXs3/hAIGaIIV8Dk0GVANF6fx3UPRYqCK2eC5gpF9Qlpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374539; c=relaxed/simple;
	bh=4SrOsTyUHG9RvBTStbXQ+P+Y2matKcycdhJJyfqkd4w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FX+oKuSTwI6s1+IeZLuqhuCYzfCvE5Zto2sFkXcueY3S7KZJ2MsTxgOsub5ly6/YSaa1fjyclFtevUl6D/nJvphbvLY1O+YwKNS4Fy0hlL5bdzp3yKFu63U55Ui4ZOOHIy+MEtUvAmDrvhAOlF4wrFtnXpdzXpX7poeOVVkhUdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZZ59kSo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZZ59kSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DABC4CEEB;
	Tue,  1 Jul 2025 12:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374538;
	bh=4SrOsTyUHG9RvBTStbXQ+P+Y2matKcycdhJJyfqkd4w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tZZ59kSo1qtIePx34fXuPjHmOYKlPrhtmihTYnjiiH+ys+XJ0xmxiPuhlKLSYZPq5
	 LLG41zc8V5Zq7c/80O/ZTGvh3pi8pwxgsOswwXHH1Sa0AtCzZcGXZ0oWk2M5ZdTDOR
	 v1GNULLj/3OoCGNMs7JN+Ihqqn6bn4G3+9ZIKm47b/bMNIme6awqrQ98qo+5tMHE3y
	 R5cpBczyqhoV11Td9atDHcBNYOJflRqnDpf0+INcm6qhAT0D6XGWNGvNTvuOM6E/72
	 yXbHolWP0eX2lGCL8zDxlgg2f80CF43LJXxNQpXgYEknJlf06eJ3zT7mFqAJ3tp0Gh
	 EKIvIaeV11cOw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 08/10] ata: ahci: Disallow LPM policy control if not supported
Date: Tue,  1 Jul 2025 21:53:19 +0900
Message-ID: <20250701125321.69496-9-dlemoal@kernel.org>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
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

