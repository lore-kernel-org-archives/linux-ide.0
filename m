Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0D54903
	for <linux-ide@vger.kernel.org>; Thu,  2 May 2024 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642021; cv=none; b=I6EUZliOyMHKbFLbDVeD7G09FACjD78pmIf8oqAhE4K295rx9RGleaZB7LIN1++Q4FE/zhv02nWMFi9lT1q8oDFk3Grz4Cffj55nQ1ZTUVuAkCnZUprc6RSCynP4jgzuedXeZ080+8FSXgJ0MHLdY1H7iGLPfeqgDucf2A+05aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642021; c=relaxed/simple;
	bh=SIPsjuWWAKjoSy4OhRRldFMWjU1fCyAMWNkBZLTidl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxsZkKD4zccoY/uMDWFi8c9czLfQTyeWn0FE1XBACX2T22wWQ3hWg9lp2sv8Tws51jkwcNRqUvW9lAuK2Bpu54VBheKLsTXcM/oG8rDAlLdfMelEOR6h0FlAtXEfdXV0QDeF+BVuGbcOOHa+W7oJlwACeVhZ9oebxpcOm8p5QXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W07xk3mM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W07xk3mM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4DDC113CC;
	Thu,  2 May 2024 09:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642020;
	bh=SIPsjuWWAKjoSy4OhRRldFMWjU1fCyAMWNkBZLTidl8=;
	h=From:To:Cc:Subject:Date:From;
	b=W07xk3mMJaVcvrg1Hahufx7Soi0RKvt515iSRLuX50g+/1G586+haJ6iSuQGT3O8H
	 6ShRLrQL4bBVNL/yQKcanuYmu2hCN5khWLaaRPrV02cHFu7XkFCvxYENJyEFSlvNRk
	 BzmiRtO/bi1fY8tmE5yCyAkvrfMg9rQ+Xw2U2F8N2eDZw5iZ79vbdDBihLNnI19UWj
	 SzFBA+r0S09nVc0+R84Xm9qig/1IJM/XHRTCnG6Sxk+vluu8+jgxqD2rcU7HfOifSQ
	 KXARuswYOJ0uH1EUWaa1unPmNNCINxx+0OiRD6SRJY2T23IABcg4m52pPBuvUvo1h/
	 tatyZsVCUaqeA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: Kconfig: Update SATA_MOBILE_LPM_POLICY default to med_power_with_dipm
Date: Thu,  2 May 2024 11:26:53 +0200
Message-ID: <20240502092652.450831-2-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=cassel@kernel.org; h=from:subject; bh=33FA4f1/zSKvjB099TmakDCYZWcQelS5SBXqEka8D4M=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKMY2JiBbWvX+P6ee7lebuI512CUyZ+erqn58mlv7LfX 5yfE9uv1FHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJKGoz/FO8Ns1ZaoPY0r1d DBuLN8cbsX+7I2cSlPPlxsMjbo/0/6ox/M9XnRSf/aQzOeaUuIvmO03Gzu2n756oerNxTfXP649 djzMCAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Historically this was set to "keep_firmware_settings" to prevent problems
with power management on very old drives. However it's been observed that
almost all modern Linux distributions either set the policy to
"med_power_with_dipm" in the kernel configuration or update it to this via
userspace policy changes. Update the policy default in the kernel to
"med_power_with_dipm" to match that behavior as well.

Changing the default was previously not a good idea, because LPM disables
detection of hot plug removals, however, since commit ae1f3db006b7 ("ata:
ahci: do not enable LPM on external ports"), a port marked as external
will always be initialized to "keep_firmware_settings", regardless of the
SATA_MOBILE_LPM_POLICY Kconfig value. Therefore, changing the default is
now considered safe (external ports included).

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
[cassel: rebased and reworded commit message]
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index b595494ab9b4..e00536b49552 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -118,7 +118,7 @@ config SATA_AHCI
 config SATA_MOBILE_LPM_POLICY
 	int "Default SATA Link Power Management policy"
 	range 0 4
-	default 0
+	default 3
 	depends on SATA_AHCI
 	help
 	  Select the Default SATA Link Power Management (LPM) policy to use
-- 
2.44.0

