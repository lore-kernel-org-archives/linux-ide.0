Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1573481DD
	for <linux-ide@vger.kernel.org>; Sun, 21 Dec 2025 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766299602; cv=none; b=Yd/haaic/C4x96X2bDKEIDTAIzbmqqRxG4nvwldX0J/oPM3maTNE80+pIWm5HXQufMrafIJd2wTLmnPX3teRNvP+dTAEMnbQNz8dyNxhGffxdn4iEGNHF4BzVxLIfpD/hbvyI3HUIH8S/krI9Y757Ereio8z7PBkdxkqIUH8Gfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766299602; c=relaxed/simple;
	bh=vQ7O9SXUWodEcugdJYxchOdxGvldqVLXn+FQsv3vGBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDBdsmPji+pClzwEmyXKjQvqHwyBk8D1XU3llqmwXGFArEFzI8EO4ZRR8SAafKURhZLguBNZp1G/Lxe51+aQJ0iD5bYuId00UBkUnpmK+fNlMbxtblk8L0J7BB4PKIvq+tFzaJ+8vS9yfMEoDsoC4dI5quOj7nC7KMgJ/aMmMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hONLdhmg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hONLdhmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA57EC4CEFB;
	Sun, 21 Dec 2025 06:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766299602;
	bh=vQ7O9SXUWodEcugdJYxchOdxGvldqVLXn+FQsv3vGBI=;
	h=From:To:Cc:Subject:Date:From;
	b=hONLdhmg8uhRi3sChG2TdypQPia0nC7Tv46zK0yxTvsbL2JlQ1AtPoAV4lEuPJpJN
	 MhUyKNZXbiefCdfddhU3OSxLq+fDImvlybeOgqgBeEYZLqy1AtQShd9XMejPE6JRN8
	 oiJsHmi4hDVLytbXRGDWUw3+fJ1RmtGnn0yrWrOYIvdnGti98qKrLAKvyKywNp3yd8
	 8uwNFOQT6IQjgTh6J/Vfaa4uqIqwzZHzWK0+qxJIBdvr0kg7PTslHeLMDqmOmltttJ
	 2lammtnCJ7b1aGReE5LmUV2F3kV5W5t7De8S87IR/quNuUrPU4UFlsUyoqhbAQrMCG
	 zbIA6X7BXGFsQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.19-rc2
Date: Sun, 21 Dec 2025 15:42:10 +0900
Message-ID: <20251221064210.283344-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.19-rc2

for you to fetch changes up to ba624ba88d9f5c3e2ace9bb6697dbeb05b2dbc44:

  ata: libata-core: Disable LPM on ST2000DM008-2FR102 (2025-12-16 14:23:10 +0900)

----------------------------------------------------------------
ata fixes for 6.19-rc2

 - Disable link power management (LPM) for a Seagate drive that is
   misbehaving when LPM is enabled.

----------------------------------------------------------------
Niklas Cassel (1):
      ata: libata-core: Disable LPM on ST2000DM008-2FR102

 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)
