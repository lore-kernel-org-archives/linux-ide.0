Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99B163
	for <linux-ide@vger.kernel.org>; Mon, 27 Jan 2025 00:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737936201; cv=none; b=fwoBgAOufW6YR2MbjhRBDlYM5bMBDf3vrjxlnnB7NuQlWZmxRnDcooWxK9RFRY7OUhZs4krsmb9AXrkGq2D3alFaGOuC72boUL1h9cV4tiYMo33awETd+ba8iQoaz0FiPwaMBWj6Ml4dDqxahSDgt1hRCPDurmd07KORs8UAIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737936201; c=relaxed/simple;
	bh=jr5BR/JxyK3aiA7uq8mbWF0exdw/4LOEcC1u9yL5xQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qi/bSG06WoRQicc1CUYFYvYbja7JFtSYhNfxOsQTiNzHbk4VXMmNhnqwGwhcABg7VPN2+CKTJgZ09gSZb0CpmZC1DpvpfaS+6ZAFe2Y4dV0aKGRRPN1uOzyZ9Tw9ytmxGTxg7y6OxFbk+zuhYzPwXQNDXBw09ZR0WpdYlu4qNjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AftnQPKO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AftnQPKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA06C4CED3;
	Mon, 27 Jan 2025 00:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737936200;
	bh=jr5BR/JxyK3aiA7uq8mbWF0exdw/4LOEcC1u9yL5xQ8=;
	h=From:To:Cc:Subject:Date:From;
	b=AftnQPKOBEIzKArnByVWX5sSzH7VBcuJEouX2Fizknfg9AvPg5RYiyWcvReCXY3h2
	 ce98bRPDI+ICPISnjXfgmLf9c69QPknU4+X6q0/RNZxFA3/ZM7GrhrqRfBWWY7bFYJ
	 xE8uaNaNCgofGSLhdQc1eExI9hmkXU5idug1ZeFK6pVyDKy1JaLzVjRc/WkGT8mAQr
	 uZzAT8M5IMWkFkhYsl+e5qG0ckAH1V2E2ReQYQhlrJgfk3EWSQAIoNT7jnsLCNCpBN
	 fNmrqnqPIhky9rEdl/GvIYFU/uNAVCCvxvyoFXvL0a4+TQUqZ97VTvu/Dq7KQnvCQW
	 ey9qjxh/Mlgmg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.14-rc1
Date: Mon, 27 Jan 2025 09:02:38 +0900
Message-ID: <20250127000238.1682504-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.14-rc1

for you to fetch changes up to f2809aa4f591d98e4c560a23d7eaca804a8afc54:

  ahci: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() (2025-01-15 15:21:27 +0100)

----------------------------------------------------------------
ata changes for 6.14

 - Constify struct pci_device_id (Christophe).
 - Remove unused code in the sata_gemini driver (David).
 - Improve libahci_platform to allow supporting non consecutive port
   numbers as specified in device trees (Josua).
 - Cleanup ahci driver code handling of port numbers with the new helper
   ahci_ignore_port() (me).
 - Use pm_sleep_ptr() to remove CONFIG_PM_SLEEP ifdefs in the ahci_st
   driver (Raphael). More of these changes will be included in the next
   cycle.

----------------------------------------------------------------
Christophe JAILLET (1):
      ata: Constify struct pci_device_id

Damien Le Moal (1):
      ahci: Introduce ahci_ignore_port() helper

Dr. David Alan Gilbert (2):
      ata: sata_gemini: Remove unused gemini_sata_reset_bridge()
      ata: sata_gemini: Remove remaining reset glue

Josua Mayer (1):
      ata: libahci_platform: support non-consecutive port numbers

Raphael Gallais-Pou (1):
      ahci: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()

 drivers/ata/ahci.h             | 13 ++++++++++++-
 drivers/ata/ahci_brcm.c        |  3 +++
 drivers/ata/ahci_ceva.c        |  6 ++++++
 drivers/ata/ahci_st.c          |  6 ++----
 drivers/ata/ata_generic.c      |  2 +-
 drivers/ata/libahci_platform.c | 40 ++++++++++++++++++++++++++++++++++------
 drivers/ata/pata_atp867x.c     |  2 +-
 drivers/ata/pata_piccolo.c     |  2 +-
 drivers/ata/sata_gemini.c      | 32 --------------------------------
 drivers/ata/sata_gemini.h      |  1 -
 10 files changed, 60 insertions(+), 47 deletions(-)
