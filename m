Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A15028312D
	for <linux-ide@vger.kernel.org>; Wed, 18 Jun 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241931; cv=none; b=X1mrG1NXQvj2tZLJ2CeUdDYpPPhVFAVODQ9OSpI22t+gZoF/5Pyul6eQkpY3pK9VxWPmJjeUflcs2hY65zZatlYJxcDrcGEWIU8jNT3ftNOtKBlKjVUzMQlrkrtKCo5AfachqG5Cn4ufxOvg/1xw0iD+jtl1PzWxNCKn3W2yWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241931; c=relaxed/simple;
	bh=atS2sJdBzmoJV/UKcdIAFQK31Ec389vQiyQqCGNrO8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNKHqfc3zSfEfECCNKas7BnswxFU3BcPrGHDgikK0GMcBnqTcd8tpjF2PVlRDozHtlJQ2IhqZhwnsMxvmfiwFwfvQAd+TRREjPLwsU+ru+dMxdo8JhNCSFTdruFyCaq2jv91zG+baghf5Jyh3mtHGKDEzyp0umJbmbgaoicjwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/k1ektf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/k1ektf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B043C4CEE7;
	Wed, 18 Jun 2025 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750241931;
	bh=atS2sJdBzmoJV/UKcdIAFQK31Ec389vQiyQqCGNrO8I=;
	h=From:To:Cc:Subject:Date:From;
	b=J/k1ektfB029gixGXBJGBBIVSRFD3rvH5n/Ke1B2hrlGyFsJQuAsNcImS9wc1ejCE
	 JRkmr0lT5vDJtFdeMSS/mtwrGIkikgbv5ftTdR91MBEBAuN0bdulK6TB+mTNk+AvN0
	 H8LZn01/flz/RX/Gjswidpe6skkx2qkq4T7x9lbEjteN2JNsbFBYtk4Em7nm3nrIpb
	 pf953AZsz1nEltapSrRbZ1iW9l6mKMaS7wnm3kdsFLdzTCtzDijd3WJbTjtOuNAzyd
	 0vsD9tgmyJyIB7bUIc4hVaH6PWjjlXmicThBTusJt6+BAocJ7ZLqYq1QuqvkNCphoZ
	 84D0jbC1qwweA==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.16-rc3
Date: Wed, 18 Jun 2025 12:18:42 +0200
Message-ID: <20250618101842.167712-1-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.16-rc3

for you to fetch changes up to a7b3b77fd111d49f8e25624e4ea1046322a57baf:

  ata: ahci: Disallow LPM for Asus B550-F motherboard (2025-06-17 11:11:39 +0200)

----------------------------------------------------------------
ata fixes for 6.16-rc3

 - Force PIO for ATAPI devices on VT6415/VT6330 as the controller locks up
   on ATAPI DMA (Tasos)

 - Fix ACPI PATA cable type detection such that the controller is not
   forced down to a slow transfer mode (Tasos)

 - Fix build error on 32-bit UML (Johannes)

 - Fix a PCI region leak in the pata_macio driver so that the driver no
   longer fails to load after rmmod (Philipp)

 - Use correct DMI BIOS build date for ThinkPad W541 quirk (me)

 - Disallow LPM for ASUSPRO-D840SA motherboard as this board interestingly
   enough gets graphical corruptions on the iGPU when LPM is enabled (me)

 - Disallow LPM for Asus B550-F motherboard as this board will get command
   timeouts on ports 5 and 6, yet LPM with the same drive works fine on
   all other ports (Mikko)

----------------------------------------------------------------
Johannes Berg (1):
      ata: pata_cs5536: fix build on 32-bit UML

Mikko Korhonen (1):
      ata: ahci: Disallow LPM for Asus B550-F motherboard

Niklas Cassel (2):
      ata: ahci: Use correct BIOS build date for ThinkPad W541 quirk
      ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard

Philipp Stanner (1):
      ata: pata_macio: Fix PCI region leak

Tasos Sahanidis (2):
      ata: pata_via: Force PIO for ATAPI devices on VT6415/VT6330
      ata: libata-acpi: Do not assume 40 wire cable if no devices are enabled

 drivers/ata/ahci.c        | 39 +++++++++++++++++++++++++++++++++------
 drivers/ata/libata-acpi.c | 24 ++++++++++++++++--------
 drivers/ata/pata_cs5536.c |  2 +-
 drivers/ata/pata_macio.c  |  2 +-
 drivers/ata/pata_via.c    |  9 ++++-----
 include/linux/libata.h    |  7 +++----
 6 files changed, 58 insertions(+), 25 deletions(-)
