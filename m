Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37C2819
	for <linux-ide@vger.kernel.org>; Fri, 31 Jan 2025 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738321252; cv=none; b=XCIPu5yCwFkZF2sU08LKq5mGJt657Fu07ls/TiO9FivfDENDOcVLoBY9G6U44WgkdtIyxDXkqTk7gJm9NVLWbbBPqneW7dXi3F2QgnxEi6aXD2aqEyOVlNYidZmgOQnl66xosWPokn+aUmhHKgqoCqBpKjjOn/7eYYQajnep6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738321252; c=relaxed/simple;
	bh=W6kXchtrh7yNueBweWZVJg6Th6JhEO1Oe2Oospfjozc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ua3+KPXEQkdfsfsts/RkPDrvL/lEDp5Hxv8392h40C5hh35jRswgzxTDu2ZjL+hoiuPo0ZAaMprkSOdSjO5oxWTAXFIUToMrCmCIee+OyqhxI1l08TNS8zZag/x5IW94GjZfXqnhiZ2F2SuQ5NjFWwjIV4IWAauq6TMzx6LxzPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJAcvJC+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJAcvJC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13061C4CEE1;
	Fri, 31 Jan 2025 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738321252;
	bh=W6kXchtrh7yNueBweWZVJg6Th6JhEO1Oe2Oospfjozc=;
	h=From:To:Cc:Subject:Date:From;
	b=TJAcvJC+4bPKVzroVRrK35FWtpTimEazW0xnUJQZT8SYHlRJeG6DQ3+QWoBOkJUBb
	 K5AtRFG/sdap1agL7oH8s+atNNSF1UJeRwWR62B5U0QLdS7hfkSKoLo0L70oTlpIDE
	 8B+jmjsOFUPZKwmaHfs+qa4TlAoI87z3c1biQdh4v9rbhuZJdeJTEMICok7QsSiPR9
	 GVLjm1oBt7VxUv+Qq1FrcIAkbjtlrlJAiyvsQ+IDoKKWiWjLlZL59fY0qLmtCIy/8d
	 l+yUlK4MmQsZRSeCjgpLGYouRFWtBiuS8T3iVCo/VIDUHVG/gTzQeHyBz9MaOKVaqZ
	 FUKI8Y0xRlgrA==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.14-rc1-part2
Date: Fri, 31 Jan 2025 12:00:36 +0100
Message-ID: <20250131110036.389139-1-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit f2809aa4f591d98e4c560a23d7eaca804a8afc54:

  ahci: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() (2025-01-15 15:21:27 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-rc1-part2

for you to fetch changes up to 6e74e53b34b6dec5a50e1404e2680852ec6768d2:

  ata: libata-sff: Ensure that we cannot write outside the allocated buffer (2025-01-28 11:44:47 +0100)

----------------------------------------------------------------
ata changes for 6.14 part2

 - Add ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives (Daniel)

 - Ensure that PIO transfers using libata-sff cannot write outside
   the allocated buffer (me)

----------------------------------------------------------------
Daniel Baumann (1):
      ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives

Niklas Cassel (1):
      ata: libata-sff: Ensure that we cannot write outside the allocated buffer

 drivers/ata/libata-core.c |  4 ++++
 drivers/ata/libata-sff.c  | 18 ++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)
