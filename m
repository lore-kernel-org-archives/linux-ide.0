Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C4027CCCE
	for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2025 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351204; cv=none; b=mMeXuZ40O7k7VIs/hi6ceepQhxAas/ZpHGf7U0DVLc2fPf8wB43uCYrjyMz71nFeqKPF02BysJdCf+JWclXJIQvEx5ncHdN5gwQIBh/EEuazL+oyceHA7EpxnDWDoDE5+FSBegVJw0GS3kef5wzqpZ25nDaJuEqZ3IMcvRXx5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351204; c=relaxed/simple;
	bh=yFa5zV/fydnGAZlp8B2SRvNLXoXpyxntEQfmfmV/VkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkSC12/TZQlOJXPViZ7Pxozox9F1gNUEjxpAultF4HN26rX5Hm4tyoMGpT8mQCjUwbHRYm3fQk4oxK1QddZfxqC/241TssgmFk2Q7LLE+ozEK9oXQmkcrmYWbgXtUBcyMGnqAm65tjmJNo3KWAOSCVrOhkGjfCQrh7ZslDL5qtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdCUjeWG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdCUjeWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D79FC4CEE2;
	Fri, 11 Apr 2025 06:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744351203;
	bh=yFa5zV/fydnGAZlp8B2SRvNLXoXpyxntEQfmfmV/VkE=;
	h=From:To:Cc:Subject:Date:From;
	b=SdCUjeWGOfOiYPgXuKEhpLKr+SLIGB9B925/j/CBSlpF6LyVmZvgBgTplDEBakmBy
	 UfRchwpXkbcRyTSI9EBqcNiKkV8Vp1pyiobmMRPw24B06VeLoDr1cuzS9wERgQ5knu
	 uZN/S906XirFqapzSJRKUrvzU9EmFtZjdaRg6N6T3m4eUgnVD5e9lZ+XZLtMDVq76X
	 Vpkl2eDp3tWyu01cT/v2SFAkLuqTscTq+w95fnyCrtZrtXjjqNnL7L/1eUpp/r2YpA
	 V9vLwE7DS9S13Is4WAmgzWARl3PWof5ZT0izmL9hDSVN39MZV4vg/M3J3UjEljif9q
	 1avEChk9+svPQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.15-rc2
Date: Fri, 11 Apr 2025 14:59:21 +0900
Message-ID: <20250411055921.1072892-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.15-rc2

for you to fetch changes up to 8d46a27085039158eb5e253ab8a35a0e33b5e864:

  ata: sata_sx4: Add error handling in pdc20621_i2c_read() (2025-04-09 15:24:49 +0900)

----------------------------------------------------------------
ata fixes for 6.15-rc1

 - Fix missing error checks during controller probe in the sata_sx4
   driver (Wentao)

 - Fix missing error checks during controller probe in the pata_pxa driver
   (Henry)

----------------------------------------------------------------
Henry Martin (1):
      ata: pata_pxa: Fix potential NULL pointer dereference in pxa_ata_probe()

Wentao Liang (1):
      ata: sata_sx4: Add error handling in pdc20621_i2c_read()

 drivers/ata/pata_pxa.c |  6 ++++++
 drivers/ata/sata_sx4.c | 13 ++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)
