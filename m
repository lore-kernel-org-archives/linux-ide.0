Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1C2F1FE2
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751328982; cv=none; b=fvo+zXtKIcE/pPm5pXU1wLd53Eqh9GexNUCwv7v3ylpnqTewReq1DBP/S/BVt/ctNkJwwxGTpbGPSLEmpWnWv1a/dQl1dEFbNGtQaXiEGiLcdAJEALgZeciOOJu1aG4d/IlgcoEyEFH5m7+PnBdWvf5eYdIsKbLdMk1l7JQ6Fns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751328982; c=relaxed/simple;
	bh=4jB9RYIKUm00GaPb3iMfa02jrKrqPqNvSDtvaprpwXY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLevcUV+XYqSnm2XsvQ0mcMq6zpsSBxdfIAuMcpSaBHSh24Ony3ks8tguCh26IdDDmk7BJNdzGAdmN5sjVBr8kn4gYxd4wUuC4zXe/eUPlEPwOkeWSOGaQPIvJ/Pmda51t3Nh/fJy7b3iU9ZL3hvu7TtVc7Alr1VzqzQwm/p3mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qV1IVL2P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qV1IVL2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8B7C4CEF1;
	Tue,  1 Jul 2025 00:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751328982;
	bh=4jB9RYIKUm00GaPb3iMfa02jrKrqPqNvSDtvaprpwXY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qV1IVL2PVePdss5m/DBgAG0Ggx9/wnOjVLuin7H2e7iqdZrJh3xXGY5TTXy3UwzTP
	 bWEIyGx6rvQ38w/VoEeb9pRlh85AcsYcYVy0nfoGv22OJbb5n/uqB7FHh4l0lwmpt7
	 mL4KrWmyXMk3mdHlzKIxAJL3AmsvcMwtRkkwtLEP+QyPUjs0AHwU1N+a+b6aSdEfs2
	 UM0QtYZczgRQ/zVGUW8oPpLHSqT0FJjF3ncyP4hmVHx/sqoqN0mTkGD3DHivz65eSR
	 +jrGd4SLKqSv49MmoBmmu46xEuMWydIUsslbzWW2NiioIMOgR3oHlw/q80UkKSUKDk
	 CJ5UzBeURtX3w==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 06/10] ata: ahci: Disable DIPM if host lacks support
Date: Tue,  1 Jul 2025 09:14:04 +0900
Message-ID: <20250701001408.330364-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701001408.330364-1-dlemoal@kernel.org>
References: <20250701001408.330364-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AHCI specification version 1.3.1 section 8.3.1.4 (Software
Requirements and Precedence) states that:

If CAP.SSC or CAP.PSC is cleared to ‘0’, software should disable
device-initiated power management by issuing the appropriate SET
FEATURES command to the device.

To satisfy this constraint and force ata_dev_configure to disable the
device DIPM feature, modify ahci_update_initial_lpm_policy() to set the
ATA_FLAG_NO_DIPM flag on ports that have a host with either the
ATA_HOST_NO_PART flag set or the ATA_HOST_NO_SSC flag set.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1b4151d95888..0760fa47d90e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1780,6 +1780,13 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
 		return;
 	}
 
+	/* If no Partial or no Slumber, we cannot support DIPM. */
+	if ((ap->host->flags & ATA_HOST_NO_PART) ||
+	    (ap->host->flags & ATA_HOST_NO_SSC)) {
+		ata_port_dbg(ap, "Host does not support DIPM\n");
+		ap->flags |= ATA_FLAG_NO_DIPM;
+	}
+
 	/* If no LPM states are supported by the HBA, do not bother with LPM */
 	if ((ap->host->flags & ATA_HOST_NO_PART) &&
 	    (ap->host->flags & ATA_HOST_NO_SSC) &&
-- 
2.50.0

