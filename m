Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422F23F392
	for <linux-ide@vger.kernel.org>; Sat,  1 Mar 2025 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740822543; cv=none; b=HS4PJutUq0LQxpbonu77Uizk+o1eXPl+A2EujVQykXL8eIPZ/HAIW4jNVN9t1IVPbnJ3rrDicArmFyMTE1JcWP7Es0KXNiZvQ2YmDZd7S/DwKtETfwAXBkrgWPppe6lBMQD6JOGHWx6hmr7yDCdijRIBUcwMJfvO+c/xRlNIhaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740822543; c=relaxed/simple;
	bh=msd8PFvOFxLMGxNqZwQ7teQhIcdO7rvbntk7p1BMlNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MiRXV90f+oproFs8L3cNzSyRRa1I4IjXB3kYvgsVQa/3s7np6GKasSVx7gq3kkpc8AcSzAncNVQdlw+vWIiKumJehWn+At8aVsy/wxRb9KQGQk9cXMUXJe60r6akQnpdrIiROOg2hSyTOANzZdUXbp8DNJtvsRhEgv6rnwcgpVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VomWpjqA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VomWpjqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD027C4CEDD;
	Sat,  1 Mar 2025 09:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740822542;
	bh=msd8PFvOFxLMGxNqZwQ7teQhIcdO7rvbntk7p1BMlNg=;
	h=From:To:Cc:Subject:Date:From;
	b=VomWpjqA+Fo2yfHFnBBQOfLIxcx1c9UAqCxPEp5DgkMzwRafhKFhpTtbBpC1KT9wV
	 eonvZ8m5e0hG69AzBFlfX6WxkzoUeFh90t7yYiRfwMu2DwgSdlKLmnytIdKhtmPjJv
	 HfVLXjYU+K9fxugej+5r8kiKdTiW3P41RYs1SEJzN1df2l3uRBv9+yhtbwqTDpJU0X
	 t1XGYkxqiFQPnVkWw62y9WEiytL7G9q9+8POB20yg742eJbf56SC+xhXbF23XtSV9U
	 R70zdAJrO4OhFNXAjy99rW63GKHqZ4oUrOkIFzlZlr4EEANYBFaDAfyD7xif4Lk+aY
	 0DCizK2Y1+Lgw==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.14-rc5
Date: Sat,  1 Mar 2025 10:48:39 +0100
Message-ID: <20250301094839.260353-1-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 2c202e6c4f4dd19d2e8c1dfac9df05170aa3934f:

  ata: libahci_platform: Do not set mask_port_map when not needed (2025-02-10 11:54:38 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-rc5

for you to fetch changes up to a2f925a2f62254119cdaa360cfc9c0424bccd531:

  Revert "ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives" (2025-03-01 10:18:25 +0100)

----------------------------------------------------------------
ata fixes for 6.14-rc5

 - Fix a regression where the enablement of the PHYs would be skipped
   for device trees without any port child nodes. (me)

 - Revert ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives, as it stops
   systems from entering lower package states. LPM works on newer
   firmware versions. We will need a more refined quirk that only
   targets the older firmware versions. (me)

----------------------------------------------------------------
Niklas Cassel (2):
      ata: ahci: Make ahci_ignore_port() handle empty mask_port_map
      Revert "ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives"

 drivers/ata/ahci.h        | 8 ++++++--
 drivers/ata/libahci.c     | 1 +
 drivers/ata/libata-core.c | 4 ----
 3 files changed, 7 insertions(+), 6 deletions(-)
