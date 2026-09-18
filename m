Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17E03A838A
	for <linux-ide@vger.kernel.org>; Fri, 18 Sep 2026 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735244; cv=none; b=Ys+PzuiyE7f4cLI8Fy0mXxiv53zQnm+It7tJ7RH8voGCRS5G5Js20rgj0iH216VN/vgb2YgRG54tWEWW3QqO1PmwcW5T1D9Li7bC9Fkvs/Mg+b+lfhmPtjZuD2BIx98MDMyDsY8Hbe9Nm6bNgugGQiJJUgoI7QPK1LaKF/07qL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735244; c=relaxed/simple;
	bh=2KCUklYn2NdsZFe4jcfKkVeFApxgif3UphIQSkmc4W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuHy01qasnPQ2NwxLreoUtAW88VnAYqg9iOOZveA4BEoi7/YT61AzfVtsXr4Iob8gUvJAcV0cv7uULwoeRMj/NTokOKsmYge3kmB/V10TV8QVm0jTU9Ok3taFI4Aih3yZL3OFbPEjeKkW735BG9RKWjeFR1N3x/APP+iTcLj+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlhdMI/E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlhdMI/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9CB1F00893;
	Fri, 18 Sep 2026 12:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789735242;
	bh=TLCyi8SxVY7DyiTdE9rAc67pFiYblsT6UZ0IZazPlP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UlhdMI/E+7giI2XjR+i5jc/B9WM+t7ZL/GKC924eHjGoIhrOj9z+I2vUnKCfA1IOX
	 CYfpQteCg+C8eEcvVqbKkRQyunOtfDtlyzvK0o2vcjajRXxKWINpfjwYWgQH9fjam5
	 MtM+95cLRJLwZDn1PfL9yg1e1CTwKFQ/ITJ5ixsPrlWSCh2eS417Qa2uxSSXRxFLig
	 Q+ZtuWIgkXT8psfKB9yeisElzKplbzXsUleDN+3o7zp3QAk5bU1+1+tpUAQlksqhoV
	 cdTRDov5HiKqNkwSsiQAKCJS5HZCovRykaWayeqMeqREjh3W/Fc7w8zYUcKuuH+3rV
	 3UqEVFKP4ZgHw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	grandmastertriplej@gmail.com,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Natikar, Basavaraj" <basavaraj.natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/2] ata: libata-core: Extend Samsung LPM quirk to AMD controllers
Date: Fri, 18 Sep 2026 14:40:32 +0200
Message-ID: <20260918124030.1962773-5-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918124030.1962773-4-cassel@kernel.org>
References: <20260918124030.1962773-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4120; i=cassel@kernel.org; h=from:subject; bh=2KCUklYn2NdsZFe4jcfKkVeFApxgif3UphIQSkmc4W0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLWGtpddVfhrpr52X3djKSXn/4b/OM4afTshPGU11M17 WtvRTGndZSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiqbsZGW6XKtpPZ2OYVPY0 Mir3j97TzxtKVM2eb9nl5Hb7Z8ChRZmMDFOVZSbsyLcIevPHVpKv26VHTvvmXRez+J0HBKPVbrZ sYAMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

A Samsung SSD 870 QVO 8TB connected to an AMD 600 Series chipset SATA
controller is reported to time out on STANDBY IMMEDIATE during system
suspend with med_power_with_dipm enabled. The command completes when
using max_performance instead.

The existing Samsung LPM quirk only matches ATI controllers, leaving
AMD controllers unaffected. Rename it to
ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD and extend the vendor check to AMD for
the same Samsung SSD model patterns. Keep LPM behavior unchanged for
other controller vendors, including Intel.

Leave ATA_QUIRK_NO_NCQ_ON_ATI restricted to ATI, since the reported AMD
issue concerns LPM rather than NCQ.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221986
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 15 ++++++++-------
 include/linux/libata.h    |  4 ++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f482c0a6d7e9..92233fb25051 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2972,9 +2972,10 @@ static void ata_dev_config_lpm(struct ata_device *dev)
 		    (dev->id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
 			dev->quirks |= ATA_QUIRK_NOLPM;
 
-		/* ATI specific quirk */
-		if ((dev->quirks & ATA_QUIRK_NO_LPM_ON_ATI) &&
-		    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI))
+		/* ATI and AMD specific quirk */
+		if ((dev->quirks & ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD) &&
+		    (ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI) ||
+		     ata_dev_check_adapter(dev, PCI_VENDOR_ID_AMD)))
 			dev->quirks |= ATA_QUIRK_NOLPM;
 	}
 
@@ -4136,7 +4137,7 @@ static const char * const ata_quirk_names[] = {
 	[__ATA_QUIRK_MAX_SEC]		= "maxsec",
 	[__ATA_QUIRK_MAX_TRIM_128M]	= "maxtrim128m",
 	[__ATA_QUIRK_NO_NCQ_ON_ATI]	= "noncqonati",
-	[__ATA_QUIRK_NO_LPM_ON_ATI]	= "nolpmonati",
+	[__ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD] = "nolpmonatiandamd",
 	[__ATA_QUIRK_NO_ID_DEV_LOG]	= "noiddevlog",
 	[__ATA_QUIRK_NO_LOG_DIR]	= "nologdir",
 	[__ATA_QUIRK_NO_FUA]		= "nofua",
@@ -4420,15 +4421,15 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	{ "Samsung SSD 860*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM |
 						ATA_QUIRK_NO_NCQ_ON_ATI |
-						ATA_QUIRK_NO_LPM_ON_ATI },
+						ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD },
 	{ "Samsung SSD 870*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM |
 						ATA_QUIRK_NO_NCQ_ON_ATI |
-						ATA_QUIRK_NO_LPM_ON_ATI },
+						ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD },
 	{ "SAMSUNG*MZ7LH*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM |
 						ATA_QUIRK_NO_NCQ_ON_ATI |
-						ATA_QUIRK_NO_LPM_ON_ATI },
+						ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD },
 	{ "FCCT*M500*",			NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM },
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 313e96173b19..48bde275968d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -76,7 +76,7 @@ enum ata_quirks {
 	__ATA_QUIRK_MAX_SEC,		/* Limit max sectors */
 	__ATA_QUIRK_MAX_TRIM_128M,	/* Limit max trim size to 128M */
 	__ATA_QUIRK_NO_NCQ_ON_ATI,	/* Disable NCQ on ATI chipset */
-	__ATA_QUIRK_NO_LPM_ON_ATI,	/* Disable LPM on ATI chipset */
+	__ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD, /* Disable LPM on ATI and AMD chipsets */
 	__ATA_QUIRK_NO_ID_DEV_LOG,	/* Identify device log missing */
 	__ATA_QUIRK_NO_LOG_DIR,		/* Do not read log directory */
 	__ATA_QUIRK_NO_FUA,		/* Do not use FUA */
@@ -115,7 +115,7 @@ enum {
 	ATA_QUIRK_MAX_SEC		= BIT_ULL(__ATA_QUIRK_MAX_SEC),
 	ATA_QUIRK_MAX_TRIM_128M		= BIT_ULL(__ATA_QUIRK_MAX_TRIM_128M),
 	ATA_QUIRK_NO_NCQ_ON_ATI		= BIT_ULL(__ATA_QUIRK_NO_NCQ_ON_ATI),
-	ATA_QUIRK_NO_LPM_ON_ATI		= BIT_ULL(__ATA_QUIRK_NO_LPM_ON_ATI),
+	ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD	= BIT_ULL(__ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD),
 	ATA_QUIRK_NO_ID_DEV_LOG		= BIT_ULL(__ATA_QUIRK_NO_ID_DEV_LOG),
 	ATA_QUIRK_NO_LOG_DIR		= BIT_ULL(__ATA_QUIRK_NO_LOG_DIR),
 	ATA_QUIRK_NO_FUA		= BIT_ULL(__ATA_QUIRK_NO_FUA),
-- 
2.55.0

