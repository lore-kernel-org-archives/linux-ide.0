Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488CD48989D
	for <linux-ide@vger.kernel.org>; Fri, 31 Jul 2026 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541983; cv=none; b=oh1J5RoifCrTl2bvEZfRHWlYEPq7YH+rNIVoZaK3cA1TJOh6QO/9r37d/AbYrSkRJgxvmeb286+rqi5NMyZLVg3dK/ZfBld3i+vPLMr/oNa5rqyr/p3hiwJvxSTrT8c4jusFGn83W5IsLkveAqljraVrpiGrGeQg93g6eBWpbzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541983; c=relaxed/simple;
	bh=pdrDauV8j4WMZz+JpRm73kABGbVOnX3pVlIWjmQc+/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0pquwawOhIAZosjjgbYhDvb79Cgy2xlFAWmkWH4LyiGcHY/1cTP+beDEwepvtKep2f71KWXIpXyphAtMsv6WeEOxs9x3YlPCtUfYvWU/kKuQ6T8JBq1o3qgZROnPSJOoiHgjB2/TKVnW6fHr2JaPyN/jcNR2Jxoz2LS7Ag8nCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFfd8aR/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFfd8aR/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2431F00AC4;
	Fri, 31 Jul 2026 23:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785541981;
	bh=0OGcyU6MYqJXTI5eup57HVlMd/tZMt9uN6X6ByjV5mY=;
	h=From:To:Cc:Subject:Date;
	b=YFfd8aR/QXEABfaixN4L/SzqH2vbXDbbrS55uRH8JlBNM7UwTDU9CS9DEQBzo9Lsv
	 U5EM6jX2DPKhIv5bzuFbEiAWvXWNa+Dvpc3D6gJMoAbqkYxucOHPxxix9o9t17qXrd
	 7dsLlzn254LIJ9LHNW+MXQ2kOHag0pcw/rpDeRE/h+fUMn1kEH7sfT/sd+uMvUG7EO
	 eav7SRt0PyEyKtNhtSpUgFOec/RsuMBkx5clH8qkC6ibl1w78thevt4tUnjU1A58iy
	 WQ4VrzMHIsxfCKyZ3q3SGKmkhQqFymaSpwZJ6MzOEm8wG0K47SutOQ3sUUucG0ce0p
	 MoLL9l67QrA7g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.2-rc6
Date: Sat,  1 Aug 2026 08:52:49 +0900
Message-ID: <20260731235249.273921-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit c2130f6553f4a5cbdc259de069600117a995f197:

  ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion bit-scanning (2026-07-13 14:32:11 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.2-rc6

for you to fetch changes up to 3fd70e96914d761c17c376aadd0b0d1a3c9badba:

  ata: libata-sata: fix ata_scsi_lpm_supported() iteration (2026-07-29 10:55:11 +0900)

----------------------------------------------------------------
ata fixes for 7.2-rc6

 - Fix PCI resource initialization in the sata_mv driver to keep legacy
   Marvell boards functional (Rosen).

 - Fix ahci_ceva driver initialization error path (Radhey).

 - Fix libata header file to remove a kernel doc compilation warning
   (Randy).

 - Increase the timeout for the STANDBY IMMEDIATE command to avoid
   suspend failures with drives that are slow to respond to this command
   (Matt).

 - Fixes for the handling of timed out commands in the presence of
   deferred non-NCQ commands, to avoid excessive delays in executing the
   error handler (me).

 - Disable link power management for a couple of WD drives that have
   been identified as not functioning properly when power management is
   used (Niklas).

 - Fix the device iteration loop when checking for link power management
   support to correctly handle port multiplier setups (Niklas).

----------------------------------------------------------------
Damien Le Moal (3):
      ata: libata-scsi: terminate deferred commands on time out
      ata: libata-scsi: schedule deferred atapi command
      scsi: libsas: terminate deferred commands on time out

Matt Vollrath (1):
      ata: libata-eh: Increase STANDBY IMMEDIATE timeout

Niklas Cassel (3):
      ata: libata-core: Disable LPM on some WD drives
      ata: libata-core: Disable LPM on WD Green 2.5 480GB
      ata: libata-sata: fix ata_scsi_lpm_supported() iteration

Radhey Shyam Pandey (1):
      ata: ahci_ceva: fix error paths in ceva_ahci_platform_enable_resources()

Randy Dunlap (1):
      ata: libata: avoid kernel-doc warnings

Rosen Penev (1):
      ata: sata_mv: accept 1 or 2 resources in platform probe

 drivers/ata/ahci_ceva.c             |  18 ++++--
 drivers/ata/libata-core.c           |   9 +++
 drivers/ata/libata-eh.c             |  37 +++++------
 drivers/ata/libata-sata.c           |   2 +-
 drivers/ata/libata-scsi.c           | 119 ++++++++++++++++++++++++++++++++----
 drivers/ata/libata.h                |   3 +-
 drivers/ata/sata_mv.c               |   2 +-
 drivers/scsi/libsas/sas_scsi_host.c |  15 +++++
 include/linux/ata.h                 |   6 +-
 include/linux/libata.h              |   6 +-
 include/scsi/libsas.h               |   2 +
 11 files changed, 173 insertions(+), 46 deletions(-)
