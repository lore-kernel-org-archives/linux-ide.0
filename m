Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17C1E47BA
	for <linux-ide@vger.kernel.org>; Sat, 16 Aug 2025 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755347449; cv=none; b=UMUIDhahDui+vBl+Sb8MiVTMwQG3tFpTK4Jnyv5MdBKpLBeQ2Tg82ok//crYjZw1OnK8OaU/R8OH/W5S3ie3/P0jz7zTa7Sd5x2N2+mWvPJMHCQ6w66YirvWdtaciffGy7oVMC90fN08mXTD1BheqjjXCc2KD16xJp30+JIxrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755347449; c=relaxed/simple;
	bh=qAIHxsmG/0t/QE5YDtFyMPSD5phslD/jYv/XaKmrhKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTiZxlD00EFoe6d3hTG1klRBsOuzBKPQ01xvzd95PpgCEhmmPwJ+8Ycyu+DIFRFWfEBqc1KKVk3wKeO8hRf9KQR/P2kbanB+vceAxZMsjaGlDkJiAs4VW+KXGDp8GdrU88aP69N/q8/sVnDuphGblEye1K4nW6aI+WUY/npsk6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2yD8p/8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2yD8p/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E54CC4CEEF;
	Sat, 16 Aug 2025 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755347448;
	bh=qAIHxsmG/0t/QE5YDtFyMPSD5phslD/jYv/XaKmrhKo=;
	h=From:To:Cc:Subject:Date:From;
	b=S2yD8p/84bhiNRkD8zzcEVOoCtpt1D72L7VlbFpSAs6kGWXeZ7+2WQKMZulhc1+/m
	 DZai4/Ga3/AnN7nNBcCACIkHw+pSuc9Lae3Q42uw3qnk2APiJQKLVT0UQqzB8SlBMv
	 kH/qQHW84EJN06/O6n8QM7Tu5SeU8qBwy7QJAxMq2Wa1TDICZGTFBVgUFD6S4vSwJx
	 skCOZ8jDkJV3dSXJqUIp55EX2zVg4DXiz9eoMLarJV/w2ZSU1x8d6nP/CrkLLm229H
	 gXpb3GJa6GW2jDnTqmM+uYyCGAar16POhWQ2CSCV/mLRtrJpX0j7eYEA+JxbQrSVhd
	 RL2dNBYA/1nrw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for ata-6.17-rc2
Date: Sat, 16 Aug 2025 21:28:06 +0900
Message-ID: <20250816122806.712563-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit dfc0f6373094dd88e1eaf76c44f2ff01b65db851:

  Merge tag 'erofs-for-6.17-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs (2025-08-13 11:29:27 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-ata-6.17-rc2

for you to fetch changes up to 58768b0563916ddcb73d8ed26ede664915f8df31:

  ata: libata-scsi: Fix CDL control (2025-08-14 18:58:12 +0900)

----------------------------------------------------------------
ata fixes for 6.17-rc2

 - Fix a regression affecting old IDE/PATA device scan and introduced by
   the recent link power management cleanups & fixes. The regression
   prevented devices from being properly detected (me).

 - Fix command duration limits (CDL) feature control: attempting to
   enable the feature while NCQ commands are being executed resulted in
   a silent failure to enable CDL when needed (Igor).

----------------------------------------------------------------
Damien Le Moal (1):
      ata: libata-eh: Fix link state check for IDE/PATA ports

Igor Pylypiv (1):
      ata: libata-scsi: Fix CDL control

 drivers/ata/libata-eh.c   |  9 +++++++--
 drivers/ata/libata-scsi.c | 11 +++--------
 2 files changed, 10 insertions(+), 10 deletions(-)
