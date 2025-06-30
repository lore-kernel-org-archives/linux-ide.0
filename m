Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5091FF7D7
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264932; cv=none; b=rKYId4onMfWE3BUxkebAnzqMKoiU6d7FaSm45dQ/lA5pvupYZeE2fr5MXVQdjcIg6XFGtRm5xw9JU01bassQZ8B/Arc5QG0vL+YvjBvWA3fSw8CqynFm1QfcvOvqsX6rYc7G8OpCHgi2hNKyo4aLxrQ4c9QcFtefKnxLM0NcMxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264932; c=relaxed/simple;
	bh=H/Yt4A3xXEOz5w+X3LxU76KoTq+zCXsN8tULhp9MfnA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4ARXFf3wYQe6jmBdxGbcG++LWSFWiu4ahfuuMvRsFPmRrBJm4FkWwmH9JK7lhSCBZAz6f2EFTswEWKyU2GCaIrtcUru1WPUuL0QpwzP2rrMa1fxWtEwxIsof0d59ftO96S0XYneej3ujwegR2J80Z3dinqyHkjd/7QILujaPsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGfRitOZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGfRitOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E86FC4CEE3;
	Mon, 30 Jun 2025 06:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751264932;
	bh=H/Yt4A3xXEOz5w+X3LxU76KoTq+zCXsN8tULhp9MfnA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NGfRitOZvWN+WlFsjKGdeLIfILLGIujWlL/zXlTDRFMn/VBfHDpQrip966VaBaXeb
	 rP5PLC+bMrONt+ONbQ3qwDCHbmOcfGXU3uYa74lGlZ0FKoszbv0JPnvZb/fwTawttW
	 pdkFy1UFidwXJYMBUYpIzVoemNEXJibISYIXTvyXwKO+u7RANl0R7ll5y+in5eMGWj
	 JSqweuydE/RT4eo6cejg1rYeSz0a8riMMM/DgpFFm5/rwZ2A/xddMWYeA7G5pK05RC
	 iJTn8EDQvCP25Z175F/KddQbaeLVPLGC7K4bMub0DDhHeXWGvL5qYP2kG2WBRk441m
	 03ALwgltySaOQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 06/10] ata: ahci: Disable DIPM if host lacks support
Date: Mon, 30 Jun 2025 15:26:33 +0900
Message-ID: <20250630062637.258329-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630062637.258329-1-dlemoal@kernel.org>
References: <20250630062637.258329-1-dlemoal@kernel.org>
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

