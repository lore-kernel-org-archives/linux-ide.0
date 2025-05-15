Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D891EFF93
	for <linux-ide@vger.kernel.org>; Thu, 15 May 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317403; cv=none; b=knlQKbh5wIUzll05pyuYe48PDfN/nO4ef84OXjUVeJgQs4L2jaOsBDwXJiHE7TfIl/Cd2Hqr3F86iMSNDMDJ7yN4eM8agJ8Nl+0ch/REgMCU8THvbFpw+8t7hSzitOwVEiw9WwooRH5HMN+ixWm7IJV5qiZO2At+b5b/nN5deR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317403; c=relaxed/simple;
	bh=EiLXkQP1/XWE2gt/GeSFwaEdk8OQpi0zYE0EtIXJjuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbbMJaVwYK7vBnvB5rG3C1ZqYln7FfzAbKUNzGSw0woRxmlDmYZ9xmcYPIAHpRQdB/75jOrxEUmukXwZwj7Pl4nJyZ6yWoBmwUdy3kBO5lcPBYVms+CujkNpCxEMGlR1PexqSvTI68cKqn5dGpfkK9bflvU2PM3UIw/i6JSif/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl9a/ihz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl9a/ihz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E400CC4CEF1;
	Thu, 15 May 2025 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747317403;
	bh=EiLXkQP1/XWE2gt/GeSFwaEdk8OQpi0zYE0EtIXJjuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hl9a/ihzwozsyuZsVzhJi6gWzc+PDUX1yYGOyLFjdB80970mDaGGsgd8jxbvVaSbg
	 oCRKPykxcBmYaSu8+bhZ7urTgvjOCzFWCqWeAnxQ7KoVyb/Lm3H9ZRUMg6oRkprQII
	 0zmw7G+tIGXqCb5c0W6x0sFCDsdLE6OgFj8/R2S+xlsS8CgNg7JZ27uY55FmKfVwYS
	 OfeRwuYamC+Rk7FRx5l0ZAw7J0GZYQPUb5YW3uycBJIlJtMK+OKxNQvgdljK3yFAE2
	 KtYNoYqtJY29cfSNA65gJnuNAUUHI9MhEZI53J2kyQkz/LaRq8Kydubyiyin1kkJzs
	 9Vr6Icaujz9Yg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 5/5] ata: libata-eh: Keep DIPM disabled while modifying the allowed LPM states
Date: Thu, 15 May 2025 15:56:27 +0200
Message-ID: <20250515135622.720623-12-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515135622.720623-7-cassel@kernel.org>
References: <20250515135622.720623-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2468; i=cassel@kernel.org; h=from:subject; bh=EiLXkQP1/XWE2gt/GeSFwaEdk8OQpi0zYE0EtIXJjuA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJUP/VMuzj5peil1bXbn4ezXQiNfZy0bBmn2aR5Vm3L9 jr92Gd1q6OUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATmbCF4a/0hnuyvJbc1gzX uOe6hDM6HOm9rG9lyxDn/ejulq2ZntWMDL1ztd9fnMBquTRidWvjyVl++0sM1xZ5nNp31PDWw6N nglgB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Currently, it is possible that LPM is enabled while calling the set_lpm()
callback.

The current code performs a SET FEATURES command to disable DIPM if
policy < ATA_LPM_MED_POWER_WITH_DIPM, this means that it will currently
disable DIPM for policies:
ATA_LPM_UNKNOWN, ATA_LPM_MAX_POWER, ATA_LPM_MED_POWER
(but not for policy ATA_LPM_MED_POWER_WITH_DIPM).

The code called after calling the set_lpm() callback will later perform
a SET FEATURES command to enable DIPM, if
policy >= ATA_LPM_MED_POWER_WITH_DIPM.

As we can see DIPM will not be disabled before calling set_lpm() if the LPM
policy is: ATA_LPM_MED_POWER_WITH_DIPM, ATA_LPM_MIN_POWER_WITH_PARTIAL,
or ATA_LPM_MIN_POWER.

Make sure that we always disable DIPM before calling the set_lpm()
callback. This is because the set_lpm() callback is the function (for AHCI)
that sets the proper bits in PxSCTL.IPM, reflecting the support of the HBA.
PxSCTL.IPM controls the LPM states that the device is allowed to enter.

If the device tries to enter a state disabled by PxSCTL.IPM, the host will
NAK the transition.

If we do not disable DIPM before modifying PxSCTL.IPM, it is possible that
DIPM will try (and will be allowed to) enter a LPM state that the HBA does
not support (since we have not yet written PxSCTL.IPM, the HBA wasn't able
to NAK the transition).

While at it, remove the guard of host support for DIPM around the disabling
of DIPM. While it makes sense to take host support for DIPM into account
when enabling DIPM, it makes zero sense to take host support into account
when disabling DIPM.

If the host does not support DIPM, that is an even bigger reason why DIPM
should be disabled on the device side.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0e36a7806cff..c11d8e634bf7 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3471,8 +3471,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			hints &= ~ATA_LPM_HIPM;
 
 		/* disable DIPM before changing link config */
-		if (policy < ATA_LPM_MED_POWER_WITH_DIPM &&
-		    (dev_has_dipm && host_has_dipm)) {
+		if (dev_has_dipm) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_DISABLE, SATA_DIPM);
 			if (err_mask && err_mask != AC_ERR_DEV) {
-- 
2.49.0

