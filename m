Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C3736829F
	for <linux-ide@vger.kernel.org>; Fri, 20 Mar 2026 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000577; cv=none; b=eUPTI+Lqw/gKLjbwO1V9DFR90vtrZ7s4iixCcRJM3HYZ6xEafc1/goH/jRChW1Ne10C/rkINaSi65OVmFP2yWUNtVD1736/rYKs98yS6uhHyBSdA3qP5nU2s7rsLEYMDfsodmG9Nqb0GhG1lzmUyTyd1tCfAuUpiLtjMfdHlF2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000577; c=relaxed/simple;
	bh=wihSJ/tZHGagnO0FGTXCZxtd42iey1gYZvjpdVGnwEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJ+7HGQJOl0OUZwlojh1P3poatqfRA+KwaN24tyXKFRl8bYyhVNpTlGxcg7w6hlk82ig53K8hGotf3NyR+5EFS5vehSZiaDzbEXs3tiReWQuzWNWXf6nXOO388HevZMGjczlfpGK1MKLCrK8r31oplvMhJwXYUnXT3a3ncE2PEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQE8Xymf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQE8Xymf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B09C4CEF7;
	Fri, 20 Mar 2026 09:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774000576;
	bh=wihSJ/tZHGagnO0FGTXCZxtd42iey1gYZvjpdVGnwEU=;
	h=From:To:Cc:Subject:Date:From;
	b=iQE8XymfjPTfhDeN7k149zYxutoQiK7Li+aRSC5qR/6x6H3fNfbvjnzw9SqC5aG67
	 2ID2hP/egCQ8VixxsPDAl7Rw+Q/ef2zkyCvV4NQYXCPAIZnf5QricJkv6Q3UN97dXk
	 Wbmu+/607TIVRPV76ddc9CEi+QfEKDnTtf9eK+nX+3KmHP0cbIHlx8BXaPdmBQm7Kl
	 7dg0l8kAjFRjOnmBK71b67OIHUvSP4o3JwocTGOeFPcS8aJv3nvi9vfuKFHS+RJv7i
	 urPEIek8CU+x5g760x87eOfFlDSMCXd9rxYM4TixIfSb27RJNuwBq8xBE9sLCaB6CV
	 E1YCbbz1jZQKQ==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.0-rc5
Date: Fri, 20 Mar 2026 10:55:38 +0100
Message-ID: <20260320095538.133163-1-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit ee0e6e69a772d601e152e5368a1da25d656122a8:

  ata: libata-eh: Fix detection of deferred qc timeouts (2026-03-06 09:58:47 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.0-rc5

for you to fetch changes up to e6d7eba23b666d85cacee0643be280d6ce1ebffc:

  ata: libata-scsi: report correct sense field pointer in ata_scsiop_maint_in() (2026-03-20 09:59:30 +0100)

----------------------------------------------------------------
ata fixes for 7.0-rc5

 - ADATA SU680 SSDs are causing command timeouts when LPM is enabled.
   Enable the ATA_QUIRK_NOLPM quirk to prevent LPM from being enabled
   on these devices. (Damien)

 - When receiving a REPORT SUPPORTED OPERATION CODES command with an
   invalid REPORTING OPTIONS format, sense data should have the field
   pointer set to byte 2 (the location of the REPORTING OPTIONS field)
   instead of incorrectly pointing to byte 1. (Damien)

----------------------------------------------------------------
Damien Le Moal (2):
      ata: libata-core: disable LPM on ADATA SU680 SSD
      ata: libata-scsi: report correct sense field pointer in ata_scsiop_maint_in()

 drivers/ata/libata-core.c | 3 +++
 drivers/ata/libata-scsi.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)
