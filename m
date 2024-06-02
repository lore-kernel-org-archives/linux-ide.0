Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871402A1B0
	for <linux-ide@vger.kernel.org>; Sun,  2 Jun 2024 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717349916; cv=none; b=n4GYn2o7RwIlNBXA11TKCoL3wQIIJslxwWPpUL8ZMJJINnwMTmYm0L6KtictPxQBswbwboh5YYbhgwAjTm3bIEDj1o47wk5/NuEBV1IvgnyMQwAPMpFgGmevwNYkFCUdl0ffPbYMc8bpdKEOt7htqzvSjZmrJ0N0GeEzlEscYww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717349916; c=relaxed/simple;
	bh=onNudQVPiPYbZsGy+MnmVURtE3eUg+c724hi/emL0Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ctqGhDCNjsUXfLf8CWZqNwirLd9KAygFkunUJWji6nmXwSPouV69umTjWT9h5jrNGyFoOiTd1uvQzA5aZ8ZQaTr2Y4D8q7MGsN9raxy1uE/5IuqtBDLPP1sE+vI8kvBUZbXh2yqhuI3RJ63F9mRYjAzD+Y73uz9qDnYC7jjMhl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDb4YXAQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDb4YXAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F067FC32781;
	Sun,  2 Jun 2024 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717349916;
	bh=onNudQVPiPYbZsGy+MnmVURtE3eUg+c724hi/emL0Iw=;
	h=From:To:Cc:Subject:Date:From;
	b=kDb4YXAQcrGli9mDtt1x96YdyA+1ZtXFG8svivwqfurkGJUL048HDlK2psQI4kpBv
	 +UWqN6c02vvNLbaUzIbXIs0xKKz7XWAi6Lo4AL3Z1CqAPrHcqxoYHlFnXjJLx4FZ4b
	 WlTmDVy3Y1KtQJiY6HO5+iqrGG+vxBe0iMF+HVgEW8o9jYAahpVvC0FnRACw1dvpqm
	 BBRQT05P08oEOrHzLh4Gpq8gRNyZCz/e95Ca3QNHEvn99LXQy+VAZtZY0IJEAkley9
	 P0pqn99bh1GWUYJC/DbrChe6DkGrOCvqgAAFTN6WJ6QsvGn7rW00lpykql1JNzSPLE
	 4VLjMqyMp2zgA==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.10-rc2
Date: Sun,  2 Jun 2024 19:38:29 +0200
Message-ID: <20240602173829.886553-1-cassel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc2

for you to fetch changes up to 3cb648c4dd3e8dde800fb3659250ed11f2d9efa5:

  ata: libata-core: Add ATA_HORKAGE_NOLPM for Apacer AS340 (2024-05-31 15:14:06 +0200)

----------------------------------------------------------------
ata fixes for 6.10-rc2

 - Add a quirk for three different devices that have shown issues with
   LPM (link power management). These devices appear to not implement LPM
   properly, since we see command timeouts when enabling LPM. The quirk
   disables LPM for these problematic devices. (Me)

 - Do not apply the Intel PCS quirk on Alder Lake. The quirk is not needed
   and was originally added by mistake when LPM support was enabled for
   this AHCI controller. Enabling the quirk when not needed causes the
   the controller to not be able to detect the connected devices on some
   platforms.

----------------------------------------------------------------
Jason Nader (1):
      ata: ahci: Do not apply Intel PCS quirk on Intel Alder Lake

Niklas Cassel (3):
      ata: libata-core: Add ATA_HORKAGE_NOLPM for Crucial CT240BX500SSD1
      ata: libata-core: Add ATA_HORKAGE_NOLPM for AMD Radeon S3 SSD
      ata: libata-core: Add ATA_HORKAGE_NOLPM for Apacer AS340

 drivers/ata/ahci.c        | 1 -
 drivers/ata/libata-core.c | 9 ++++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)
