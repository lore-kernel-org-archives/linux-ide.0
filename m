Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C281F1BC099
	for <linux-ide@vger.kernel.org>; Thu,  3 Jul 2025 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751527071; cv=none; b=ayVs5PIZgjntJHXF/GXCoPsjaa62lhKT319TLLnAK+oe01s2GGpVcUpO/nD85aB+IzieuPjPis6I1u65PTRGOvXfQ81aD7cbLrUYV7yMF15NSdMC7csYcZevO8fruUQpeGS7dzsLQs0dZwSSrOePjh+gAYChIihzwScEq8UkzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751527071; c=relaxed/simple;
	bh=H/k4sOBa33M2nU4D9qtgjPCVQ0JmC+0G9sTZd140mHY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g5K3SaHcxxYk9Ok7YPrLYIZYt4TwspRqcjSXJyskDIU0mR6Rkd/xuwZESOQA0aW7gp+zCoY5dI8B2hLXqicyF9IYwqQlNyjD/7ROHpy6V4RyPRLocwjGt6Ru1lNJT/JTlLqnKBnYsrA37vMfavSw2RT62547FVO1Fq3Dd7arBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkhp4yg6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkhp4yg6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AF1C4CEE3;
	Thu,  3 Jul 2025 07:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751527071;
	bh=H/k4sOBa33M2nU4D9qtgjPCVQ0JmC+0G9sTZd140mHY=;
	h=From:To:Subject:Date:From;
	b=qkhp4yg6XOkl1ATV1AnIDPBsWE7MlckT+D6Rk/O/85sC+SXXVk1d9st6cn8lq/qGv
	 rK5fOO68ecCzp/3qS2FghpPHAiBt/IlrJ3OFpes/NLKRDMHCww8KcJTp1NOtIRYMo5
	 8aIwWOfiBxBsKtqgGV+qPy6mYaBq7txL3mEsKtprERT3EmGfvcW69MQ98WTCThHU2Y
	 lasMoxpYmg9i3++kBaGG63yLZf+wwU03MVCJUEa/FmWxeeM3gS4zxH+8oTW8I69n46
	 2gYl4xY4E4aJvBSNGrD2KGBDKcjjBWYqJzsvhkbHdqEKe6gJxjr2m+Ng4P7ijXXTx9
	 dkqD3gb69EOgA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/3] Improve log directory handling and some cleanups
Date: Thu,  3 Jul 2025 16:15:38 +0900
Message-ID: <20250703071541.278243-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch improves handling of a device general purpose log
directory by avoiding repeated accesses to it using a cache.

The following 2 patches are simple cleanups that do not introduce
functional changes.

Damien Le Moal (3):
  ata: libata-core: Cache the general purpose log directory
  ata: libata-core: Make ata_dev_cleanup_cdl_resources() static
  ata: libata-eh: Rename and make ata_set_mode() static

 drivers/ata/libata-core.c   | 45 ++++++++++++++++++++++++++++++++-----
 drivers/ata/libata-eh.c     | 11 ++++-----
 drivers/ata/libata.h        |  2 --
 drivers/ata/pata_optidma.c  |  4 +++-
 drivers/ata/pata_pcmcia.c   |  4 ++--
 drivers/ata/pata_pdc2027x.c |  2 +-
 drivers/ata/sata_sil.c      |  2 +-
 include/linux/libata.h      |  5 ++++-
 8 files changed, 56 insertions(+), 19 deletions(-)

-- 
2.50.0

