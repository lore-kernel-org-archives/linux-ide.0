Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D573D413A
	for <linux-ide@vger.kernel.org>; Wed, 25 Feb 2026 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029203; cv=none; b=C3ka5NG5XQ2vFbXIT28Hgo8uIUYKwSTt03XEkxyfw6z0RKBvq+QBrSHSxRAvLS1jthaA7rAZhqM/x5w5kfCaaOD0XwbEOCgbgDgTD0x2SZSONDp3weT4PsCbyoP9rNnYX783wA9RWEHmFoVdznDx4BMHh3uKpSfp/mLkBxtGfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029203; c=relaxed/simple;
	bh=XVVkpMLUS1h4CkEHZbu7Kn8c4zKoEoycFgcT0pmT7z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDtLcaqMfvXCKdcgQIrXmEUQ8u+SL15K4I0kXLSw7FrhIwBW7tPS1l4fyQKKaHK1bJUEoll1Vu+a1LVkRS9SrR7dX2nA00VUl+s/MeISD5AzM4JU787HBBgq0q7MLI/LpjX6MdluGGBsJ86R1pJl1i5Dga8W72ndezyEKjvf3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahA938Z/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahA938Z/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16EDC19423;
	Wed, 25 Feb 2026 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772029203;
	bh=XVVkpMLUS1h4CkEHZbu7Kn8c4zKoEoycFgcT0pmT7z0=;
	h=From:To:Cc:Subject:Date:From;
	b=ahA938Z/Rhgu+fA7J2WxZYHZP/n7gRtaioGn8LHeQeHLPUym4L+Z7gciFdMkPsEjr
	 zWvMrC3TX6HB7KONDKtznR8udzSeB+1wZSvo6y8jHVaNzSXFKwS9IEbWbYYc4koQfJ
	 WO/kUQQnXJeMLvtjXJ/SzXcLm2QVYCFoXm/xsJUqMG9L9B95kEhSpE9yp/kJHWaJfy
	 NvJAtq5ZKUipJ6KPAH3Q3dFTiLoTPXJfKQtKwBON/sV+Q1z1d8qWRkuLtvCXggMi/t
	 QuMcP2jDXvPnFxzCJfsxuWUOJD4//hbbY3zptTKQCpr+TVLjjtvo697oetuvYeQ1nm
	 7h3Ay6InoPuZQ==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.0-rc2
Date: Wed, 25 Feb 2026 15:19:56 +0100
Message-ID: <20260225141956.3947017-1-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.0-rc2

for you to fetch changes up to 55db009926634b20955bd8abbee921adbc8d2cb4:

  ata: libata-core: fix cancellation of a port deferred qc work (2026-02-24 09:38:55 +0900)

----------------------------------------------------------------
ata fixes for 7.0-rc2

 - The newly introduced feature that issues a deferred (non-NCQ) command
   from a workqueue, forgot to consider the case where the deferred QC
   times out. Fix the code to take timeouts into consideration, which
   avoids a use after free (Damien)

 - The newly introduced feature that issues a deferred (non-NCQ) command
   from a workqueue, when unloading the module, calls cancel_work_sync(),
   a function that can sleep, while holding a spin lock. Move the function
   call outside the lock (Damien)

----------------------------------------------------------------
Damien Le Moal (2):
      ata: libata-eh: correctly handle deferred qc timeouts
      ata: libata-core: fix cancellation of a port deferred qc work

 drivers/ata/libata-core.c |  8 +++-----
 drivers/ata/libata-eh.c   | 22 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 8 deletions(-)
