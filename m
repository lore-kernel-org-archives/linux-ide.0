Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45153AFD1D
	for <linux-ide@vger.kernel.org>; Tue, 19 May 2026 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206875; cv=none; b=LwyE83sFQhZQmvr0yZldbbOHuycgHIzLNvVRMJkDLv23rXvXL6wV9cuP458rH5K33Fq9NiDeZQu9jhY4NekGT5M6PGDho/8vpMV0OGTnEehWHgqfa9v51MBXvujA4aKUDKxno47+0sr6Gq2nhRYD1Ku4l8zFGMPRpcrDYa95Mck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206875; c=relaxed/simple;
	bh=G3ZXsitxw1LI8U3i6qGLIg1LFocVVxpjiAZNF1/piB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sgPppsumchC5/oXGSVeF8mJaO4my/RyravWCeVJ1RcrYBu3oK7K75Uygrgj27s95bgLs5S30n9yHG8svN6sfJiJdRq3MNvrsVgrDcPzjqwJGiC893Ioko7NRu9+MNlhI8ZOaiYzixkpxFfkavEk4oozTHyH9s156f7mtLiShBRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2wHNUXD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2wHNUXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90ADEC2BCB8;
	Tue, 19 May 2026 16:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779206874;
	bh=G3ZXsitxw1LI8U3i6qGLIg1LFocVVxpjiAZNF1/piB4=;
	h=From:To:Cc:Subject:Date:From;
	b=o2wHNUXDz6kWwdpNIa3gq4UGQqlGSImkTLr5uNpDAYecPd6m8UAYTZwffTqCwXx42
	 QVkv9vj01FR9qjMVPXhKKu2UAarQYr8wOFbXZF90jyjgwHHWSKNJZP+V/EvOk3X5KM
	 ug2xB2xNdv8Lsqa3kFV0xDvfIf8v+Zp9STYH1aNO/5TEIKXrqmkAx1xdA5w3xQcoUr
	 O6d4wLHCT5ykOGpMPQAuxC4+clLaIvTfYmcr75/7NrxnDETwNQQn1dFO1cTV6LSxbu
	 BqyFpzOc1j3ktsVzk5+c+WzcP+WJgwvRthos4yQ3andhEy/xoSQcrSmLJWhYDysGr+
	 T9IT1ZmtvuelA==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.1-rc5
Date: Tue, 19 May 2026 18:07:46 +0200
Message-ID: <20260519160746.2087727-1-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 163f6494233e1679ec6fa6a4803f74ae7b1c94db:

  ata: pata_parport: switch to dynamic root device (2026-04-27 11:38:16 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.1-rc5

for you to fetch changes up to 759e8756da00aa115d504a18155b1d1ee1cc12e8:

  ata: libata-scsi: do not needlessly defer commands when using PMP with FBS (2026-05-18 12:26:51 +0200)

----------------------------------------------------------------
ata fixes for 7.1-rc5

 - Make sure that the issuing of a deferred non-NCQ command via
   workqueue feature is only used when mixing NCQ and non-NCQ commands
   to the same link (i.e. return value ATA_DEFER_LINK), and nothing
   else. This way we will not incorrectly try to use the feature for
   e.g. PATA drivers.

 - The deferred non-NCQ command was stored in a per-port struct.
   When using Port Multipliers with FIS-Based Switching, we would thus
   needlessly defer commands to all other links. Store the deferred QC
   in a per-link struct, such that Port Multipliers with FBS will get
   the same performance as before.

 - The issuing of a deferred non-NCQ command via workqueue feature
   broke support for Port Multipliers using Command-Based Switching.
   The issuing of a deferred non-NCQ command via workqueue feature is
   not compatible with the use of ap->excl_link, which PMPs with CBS
   use for fairness (using implicit round robin).

----------------------------------------------------------------
Niklas Cassel (4):
      ata: libata-scsi: improve readability of ata_scsi_qc_issue()
      ata: libata-scsi: do not use the deferred QC feature for ATA_DEFER_PORT
      ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
      ata: libata-scsi: do not needlessly defer commands when using PMP with FBS

 drivers/ata/libata-core.c |  9 +++--
 drivers/ata/libata-eh.c   |  8 ++---
 drivers/ata/libata-pmp.c  | 18 ++++++++--
 drivers/ata/libata-scsi.c | 89 +++++++++++++++++++++++++++--------------------
 drivers/ata/sata_sil24.c  |  6 +++-
 include/linux/libata.h    |  7 ++--
 6 files changed, 87 insertions(+), 50 deletions(-)
