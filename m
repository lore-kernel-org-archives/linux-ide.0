Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C466E221266
	for <linux-ide@vger.kernel.org>; Fri, 25 Apr 2025 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621778; cv=none; b=rF4IXss5c/qXAxTiKiIE2ZUAf07C/l2A5yS4X7gVhw0BYImnIt6p3ZMnmxEjrqHlXKYbcqlIzU0K0nv7VRDebziZkUDmyvGCRONfX9XGE7u86r3wN+osrptB0MLZwVS+wkGna6t3cN/XIOoyJyX1K0SaZbrwhSGjfYgO+0KBzOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621778; c=relaxed/simple;
	bh=97oEX8Ygs2+9Mo40cUHkJmpCAG9PROptVblVGAiONvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQF5x4TqbNWC6vfWb5XrGsAh4M7cVGeweT0JwwAkr1EdO2i5PPjL3S/d9NZwn9Qk02iepRECQWqexrKOQRm27DDKZOOjfBFpdbR7b5vbT9lrStRspOnjRFUQHWYWhddQRoC1tQqNnzx62WfG7dafXDSxD4Y50pOb3o9DpgHRfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs7XSSyA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs7XSSyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEFDC4CEE4;
	Fri, 25 Apr 2025 22:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745621778;
	bh=97oEX8Ygs2+9Mo40cUHkJmpCAG9PROptVblVGAiONvw=;
	h=From:To:Cc:Subject:Date:From;
	b=fs7XSSyAhMzJIqJ1EBgePh00xN+gTfJ8BwJz4T+Bc4ygddRxNzK0yJDuLOzbkN3bP
	 zBCETbUAclGOZYlZxCt1tmCGmaYiigJyPz8bt09gwn0QbLgkEqT/4mg++JRl4gEPAr
	 DDYEsYKam1qIDm+p+tlKG+YLa8IltkFBvlfKWJTZOHxcXr0XtHIFUsWtqpt7uB7sth
	 WZ2/v/yQvSelutV40rju46ML/iNwJvfUowzQ49a2g5bYH+MGziE+bHepZgS5SPxb2K
	 cYlVwm8Om9fuZuqRnPgiwBwEg5MRll+cFrfaTtJTkW2lqf5+zaYTR17guEuNb1A69E
	 pjb0ksWLTyC5g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.15-rc4
Date: Sat, 26 Apr 2025 07:55:21 +0900
Message-ID: <20250425225521.2178472-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 399eab7f92fb73ffe621294a2d6bec8fc9f3b36b:

  ata: libata-sata: Save all fields from sense data descriptor (2025-04-16 17:33:17 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.15-rc4

for you to fetch changes up to 14a3cc755825ef7b34c986aa2786ea815023e9c5:

  scsi: Improve CDL control (2025-04-22 16:06:08 +0900)

----------------------------------------------------------------
ata fixes for 6.15-rc4

 * Fix the incorrect return type of ata_mselect_control_ata_feature()

 * Several fixes for the control of the Command Duration Limits feature
   to avoid unnecessary enable and disable actions. Avoiding the
   unnecessary enable action also avoids unwanted resets of the CDL
   statistics log page as that is implied for any enable action.

 * Fix the translation for sensing the control mode page to correctly
   return the last enable or disable action performed, as defined in
   SAT-6. This correct mode sense information is used to fix the
   behavior of the scsi layer to avoid unnecessary mode select command
   issuing.

----------------------------------------------------------------
Damien Le Moal (4):
      ata: libata-scsi: Fix ata_mselect_control_ata_feature() return type
      ata: libata-scsi: Fix ata_msense_control_ata_feature()
      ata: libata-scsi: Improve CDL control
      scsi: Improve CDL control

 drivers/ata/libata-scsi.c | 25 +++++++++++++++++--------
 drivers/scsi/scsi.c       | 36 ++++++++++++++++++++++++------------
 2 files changed, 41 insertions(+), 20 deletions(-)
