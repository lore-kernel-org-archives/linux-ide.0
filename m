Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C170B18027
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986842; cv=none; b=RDiGNeUXR5fUrvpx7EDwFR4aXHg7ZB2bVEVNVUHDq25m8CZoS9fhKhrQkI+poxOBdfbTifmtOmKD7EyhIKt02jQ19Fsh5OQANZFCQTsQuLLuKLwZf1kliNlXHkQTWEJqud9GydsoiOEDWq2EhkJt2JPooZT7rwwW4MH9KcW0hYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986842; c=relaxed/simple;
	bh=KKNwNPWnhvi3FWVxqgbPZ0Al8euhrRrLW4AV4co+gWY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVWbLeEUtpB1bmOmUm9LZRckh8ii3AS3nk+K2+o0EsOUxRsLuuTZKXTTGJAEp42t3ypuDp3yM3g6ZhNEvvZj8yEXuQQVTHnv9eXLA6DBf0PslhmS6Dit6+6+36JFRL8RCwRFYnkciMOpjb9qNfoDvlvHnDhW2GAI9F/G2yxJZpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVqzQGQT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVqzQGQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB0AC4CEEE;
	Fri, 27 Jun 2025 01:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750986842;
	bh=KKNwNPWnhvi3FWVxqgbPZ0Al8euhrRrLW4AV4co+gWY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iVqzQGQTV7atp1f7MsyDl2I5/zvkrsb8fZnF92oka+arZ3euxfEG0/MtaT6QiLusQ
	 JubYUH69t0M5V8JYAjD7q5B0tSX9g517bxTePlqWWMolIqSbjY58j4XhL0HYzOAsgE
	 jJYZcXVKxWarhpWmchheSzjw7sKTB42oDtDR+/wqcKBj3dk8/bpz4bfxJnUd4pgN1/
	 ZTOOSG7Hi+ImBCaBI+xfpBAd4pXibw1eZJ4P9Svm+frkf+iVMnusfH5rV3rcw/puRK
	 sXsEuSrY3f/mdyXC36oAr3YXO/dT32RXzqsjMOzU1tWfEP9S1ibP/G+o6Mh8uLQU4w
	 +GXP1xPHut01g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 3/6] ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig
Date: Fri, 27 Jun 2025 10:11:52 +0900
Message-ID: <20250627011155.701125-4-dlemoal@kernel.org>
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

Improve the description of the possible default SATA link power
management policies and add the missing description for policy 5.
No functional changes.

Fixes: a5ec5a7bfd1f ("ata: ahci: Support state with min power but Partial low power state")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
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
2.49.0

