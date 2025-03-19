Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC49254AF4
	for <linux-ide@vger.kernel.org>; Wed, 19 Mar 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377800; cv=none; b=ek0+PcCaVTg7wn+SN8SZXZpPsKlUUEpwkFwfmhnvX/NcVR5BWhBdhDD9YAqH2mW1Q6Le4aXRPA8b2hkKr9V4WpoCypfZPFIyN1dxbe6YYYmr3ojIy/ieCbJ5JVVIEU5nXFjMBYRJ7mRRPV+JuadkpkNK3yQlJafZbV89HHe7kHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377800; c=relaxed/simple;
	bh=t3mCd9RQzQiAKgDCSeFW4byW1sAMuzhPdi1uN3b4oOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZXzYek0X8IVsMgEl+GK4Of5D48H5Md4U+Ua1jmNozEHnKzqFZ3e422ov3/pvA4hSLSL0j/h1JkHCZZXaVSOwx0iYlaIJxxBjQzVSnFKOUh05FlHR34L/CxDqAAo1LrAVsokdIQasRtmLJAu1m16TogETQJat3o/oFdpqYnnYVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRIaC6n8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRIaC6n8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5DCC4CEE9;
	Wed, 19 Mar 2025 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742377799;
	bh=t3mCd9RQzQiAKgDCSeFW4byW1sAMuzhPdi1uN3b4oOg=;
	h=From:To:Cc:Subject:Date:From;
	b=PRIaC6n8n7RNow7xsB8mIFZJ8aWB4ndEXWIMaExDMc6BvcqksHmmovWNewJFso75h
	 fxmjWSawj0FFXlVEHuoLd2Hf71cJwBDiQQd/MEWn+5cHGmw7PXFSCoQ+PleRoXnR0/
	 NwmjGUT/c2zQCSj5lYUBh7uUj9wmrwP+UCXuLEe1khB/IRqa6Ug52g67EHtvxErc27
	 IdMK/4XtKzc3xg5t6pxyosWDWvo4PCQDH3cOyufH8E2P9fz0u65bEOJvxQwhOmOjoD
	 G7hQB8oDhwvVv9z69DhZIEciNsT3QtJ1Flt0jbWLUkIH28bcYwT2aKqDEWyGMsC6pB
	 IxM+w72VkclXw==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.14-final
Date: Wed, 19 Mar 2025 10:49:50 +0100
Message-ID: <20250319094950.2576556-1-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit a2f925a2f62254119cdaa360cfc9c0424bccd531:

  Revert "ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives" (2025-03-01 10:18:25 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-final

for you to fetch changes up to f2aac4c73c9945cce156fd58a9a2f31f2c8a90c7:

  ata: libata-core: Add ATA_QUIRK_NO_LPM_ON_ATI for certain Samsung SSDs (2025-03-18 10:11:28 +0100)

----------------------------------------------------------------
ata fix for 6.14-final

 - Fix a regression on ATI AHCI controllers, where certain Samsung
   drives fails to be detected on a warm boot when LPM is enabled.

   LPM on ATI AHCI works fine with other drives. Likewise, the
   Samsung drives works fine with LPM with other AHI controllers.

   Thus, just like the weirdo ATA_QUIRK_NO_NCQ_ON_ATI quirk, add a
   new ATA_QUIRK_NO_LPM_ON_ATI quirk to disable LPM only on ATI
   AHCI controllers.

----------------------------------------------------------------
Niklas Cassel (1):
      ata: libata-core: Add ATA_QUIRK_NO_LPM_ON_ATI for certain Samsung SSDs

 drivers/ata/libata-core.c | 14 +++++++++++---
 include/linux/libata.h    |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)
