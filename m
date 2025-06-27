Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918122264A3
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010858; cv=none; b=FwDk7nTqlIu4U4tDXnDFYgBQw61/5qQciSmMgK4WgGEZjWc/FeAEG7jzIyaBaDYwaO91WgaSKlBF7/LG+3pFbiDVEcJXntFHWEopsu1xkXoDgZg25OWuQzfWTTlCn2co58jT3LqUI0I+LK1erv3PcZC6fHj412rnIbgyWB2gEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010858; c=relaxed/simple;
	bh=UQUW1Cn8VP1gOylRwYbsPX5LsDUWsGp1OaQ+QHREkxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzOKrZR2UhWAkSy5O/t6v8P5QYVxge1KnnrCxw+An+PQ2/cTsvlrNctBL3/XEG0g7glbvxp/N9/E4B3anVvj64ZgEDo7dVm6Cm2iqklgElNI9vW3gosCDMYOEvOkrAzsSn5U5m4ZYyD+aMmlK/FG1dK3fwOht6yNx7u514sfvt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq0394PQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq0394PQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8BCC4CEED;
	Fri, 27 Jun 2025 07:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751010858;
	bh=UQUW1Cn8VP1gOylRwYbsPX5LsDUWsGp1OaQ+QHREkxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oq0394PQtsq+0KdNrhv/WbaGVzrR6iapqEO/xMdhAWuQAsq+ivzFlvbsah9OfWeK8
	 4gn20uWfKFr9/ZHGsT+BTUgQeNBn88xZYUP2xpf7XsvWb4XaFmjKykxrlQxu20eQiI
	 y0/7JqWt0X9wSpqcy14U599uzeRFeFLc5suBrGSMM3oOOgrUw43ufyxAP3BAybbMPC
	 3l15gcpoD6s2lg+6NkCi7cpJKk/7h8Wq2N5JAbOXJTLQ//mD4o8Tj66GizSImCaYpK
	 k071ezM0AV1gZaRdXpbZVgRkvPDXFJWlnW9qCmi+WwsD2u+z6vkjy3uAG8rgU9tS4p
	 nzL+P6sljDxdg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 3/6] ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig
Date: Fri, 27 Jun 2025 16:52:04 +0900
Message-ID: <20250627075207.23969-4-dlemoal@kernel.org>
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

Improve the description of the possible default SATA link power
management policies and add the missing description for policy 5.
No functional changes.

Fixes: a5ec5a7bfd1f ("ata: ahci: Support state with min power but Partial low power state")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e00536b49552..1d53d7b568bd 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -117,23 +117,39 @@ config SATA_AHCI
 
 config SATA_MOBILE_LPM_POLICY
 	int "Default SATA Link Power Management policy"
-	range 0 4
+	range 0 5
 	default 3
 	depends on SATA_AHCI
 	help
 	  Select the Default SATA Link Power Management (LPM) policy to use
 	  for chipsets / "South Bridges" supporting low-power modes. Such
 	  chipsets are ubiquitous across laptops, desktops and servers.
-
-	  The value set has the following meanings:
+	  Each policy combines power saving states and features:
+	   - Partial: The Phy logic is powered but is in a reduced power
+                      state. The exit latency from this state is no longer than
+                      10us).
+	   - Slumber: The Phy logic is powered but is in an even lower power
+                      state. The exit latency from this state is potentially
+		      longer, but no longer than 10ms.
+	   - DevSleep: The Phy logic may be powered down. The exit latency from
+	               this state is no longer than 20 ms, unless otherwise
+		       specified by DETO in the device Identify Device Data log.
+	   - HIPM: Host Initiated Power Management (host automatic transisitons
+		   to partial and slumber).
+	   - DIPM: Device Initiated Power Management (device automatic
+		   transitions to partial and slumber).
+
+	  The possible values for the default SATA link power management
+	  policies are:
 		0 => Keep firmware settings
-		1 => Maximum performance
-		2 => Medium power
-		3 => Medium power with Device Initiated PM enabled
-		4 => Minimum power
-
-	  Note "Minimum power" is known to cause issues, including disk
-	  corruption, with some disks and should not be used.
+		1 => No power savings (maximum performance)
+		2 => HIPM (Partial)
+		3 => HIPM (Partial) and DIPM (Partial and Slumber)
+		4 => HIPM (Partial and DevSleep) and DIPM (Partial and Slumber)
+		5 => HIPM (Slumber and DevSleep) and DIPM (Partial and Slumber)
+
+	  Excluding the value 0, higher values represent policies with higher
+	  power savings.
 
 config SATA_AHCI_PLATFORM
 	tristate "Platform AHCI SATA support"
-- 
2.50.0

