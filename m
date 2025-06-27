Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FAF18027
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986840; cv=none; b=lrAyHMonoGEXZa6EEJywOid2ByjExpbF3OnFoG0CJjer9tSEgDqTWhayvHEvAfF9xmgpCrfjbPnsi0uw0340ngMsIO6vv/BU2DiI9Ou4o/k/6gtfVXDRfujzrope4JXEEM6mkFnGVC3axOZoKjG7eQsuTbd1TwHRPMkSK0i1TIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986840; c=relaxed/simple;
	bh=FJs4mF3MoAz6zF+fitBrKASB4dHq9FRpZLLCPHuCgnM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=p6AAcT+UBjDgAxcPG3BXbSvKSeo5nCrJxiJpXCVvkt20oVgrnbEr7IRmV9mIr55HXwvY5gthgMgzOrkNDB/64TWXIz1f8xk7MmHE4WA2LxyNFhhTIbbiZ31m1EGUCPYP/m+M+XI1jBlfrkONMVj9CLSzVVJKhRgZowI9aHIqO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7V6iN5+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7V6iN5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356DCC4CEEB;
	Fri, 27 Jun 2025 01:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750986839;
	bh=FJs4mF3MoAz6zF+fitBrKASB4dHq9FRpZLLCPHuCgnM=;
	h=From:To:Subject:Date:From;
	b=C7V6iN5+eLUmhCEaIyEc4Ejj7m0HN1pG+Vr6sJmJoJWMV2L4EwuYHrT9CyXUQvrNQ
	 kmizLu8Owt4FYe2IdZlY5WdhB5TId8MIDpuxwORNxZwqVhD3XZCgOTNusE8VoT6B0a
	 0cPHxsYe5wNAjefgAUHVnNokFTV6HlaHO+stNqVw78cS1Y1fItMl5zRH831PuW8K7f
	 7Rl9ja0FM+0nEg3jemHwa14RBXmhhgeZQOV9+1fBHolTqgjVmmCiEcw8c+m55y94ac
	 NNkFSVUQQQcU7kZp6yUSHlo/X4lnQ/qnkwm93DcqTpLSgrJLiTb67+ar5hvj8SG1C9
	 /z9FwRr3fz+AA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/6] Various cleanups
Date: Fri, 27 Jun 2025 10:11:49 +0900
Message-ID: <20250627011155.701125-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6 patches to clean libata code and better document parameters (config
and AHCI driver module parameters).

Overall, no functional changes are introduced.

Damien Le Moal (6):
  ata: libata: Remove ATA_DFLAG_ZAC device flag
  ata: libata-scsi: Cleanup ata_scsi_offline_dev()
  ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig
  ata: libata: Improve LPM policies description
  ata: ahci: Clarify mobile_lpm_policy description
  ata: libata-eh: Move and rename ata_eh_set_lpm()

 drivers/ata/Kconfig       |  36 +++--
 drivers/ata/ahci.c        |   4 +-
 drivers/ata/libata-core.c |  13 +-
 drivers/ata/libata-eh.c   | 304 +++++++++++++++++++-------------------
 drivers/ata/libata-scsi.c |  20 ++-
 drivers/ata/libata.h      |   9 +-
 include/linux/libata.h    |  18 ++-
 7 files changed, 211 insertions(+), 193 deletions(-)

-- 
2.49.0

