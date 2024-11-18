Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3881DFFB
	for <linux-ide@vger.kernel.org>; Mon, 18 Nov 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945025; cv=none; b=rmCx2IO/dzMxW7lfC+ZUoHnOGH/RfszbDfP7jyKqwNRPa5A6jXYZc9NJ5hiLPmoN/g8FlWNGa7fPY5YPw9KKqz752L5K/TDk1dbROKtIxHV00/67eehMnRSYZEON57WqbkJAgebTx7+K2DW3CIfFv1aKCxcZ2hae7Ebafhqs+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945025; c=relaxed/simple;
	bh=gFVl4IVwhm3HPvj4irnclh70RY6FKZCtAHE+pU79lDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q0W1Ii26749ruV89/g4UvY57gKRRYaHXzDAq3X0lx0sztI5Gp3vdIZ4VcOh8v2DI0tKpk8NwoePu330JrtUN/BJwgY2MpVJxlBQQgPEXcjn9eW5JmJXXM/PK5utkNBa/RXVtIrdP2vcY473v+m8x8Yb3v8izkvDWdtuzT7K+FTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hyxe02s/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hyxe02s/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBDEC4CECC;
	Mon, 18 Nov 2024 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731945024;
	bh=gFVl4IVwhm3HPvj4irnclh70RY6FKZCtAHE+pU79lDs=;
	h=From:To:Cc:Subject:Date:From;
	b=Hyxe02s/MCAybjaIXvmqagiiDo+0BGSUktv9DB0mNWFndyewZaHQsIFaf3C5zJ5tb
	 S/a2zGPZcC4V13xrSM+c2hzdYF5Vww64m9W+bwmZ/tmVN87SfCpDMLkuO93gnwadt7
	 RehltZvrhmQoRip65hp5VkbOnR8f+ZFboJkWXN3F7EYfQcwok3p3evYB3MpLjoD/X9
	 7igaaQBjpzIjjuWavgTGQjS2hT6tB18Jd57vpdPImpOj+5Jkh/Usz3HnBX5agYBio3
	 SSh51PX33P6cmCC3qdONkwyCRABK8jXElMqPZJvNrDyWDItrjbWg1tKFEG0Rr/nu+F
	 3cB7eV3f8Lflg==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.13-rc1
Date: Mon, 18 Nov 2024 16:50:11 +0100
Message-ID: <20241118155013.2706907-1-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.13-rc1

for you to fetch changes up to e8a2389ea808c3902d9938b20e40e2df36c3702b:

  dt-bindings: ata: ahci-platform: add missing iommus property (2024-11-12 12:15:59 +0100)

----------------------------------------------------------------
ata changes for 6.13

 - Fix typos in comments (Yan Zhen)

 - Remove unused macro definitions (Damien Le Moal)

 - Switch back to the .remove() callback (Uwe Kleine-König)

 - Make use of the get_unaligned_be24() helper instead of open coding
   (Andy Shevchenko)

 - Refactor and cleanup ata_scsi_simulate() command emulation, such that
   all commands use ata_scsi_rbuf_fill() with its own callback
   (Damien Le Moal)

 - Improve ata_scsi_simulate() command emulation by accurately setting the
   SCSI command residual (number of bytes not filled) in the command reply
   (Damien Le Moal)

 - Add missing iommus property in ahci-platform device tree binding
   (Frank Wunderlich)

----------------------------------------------------------------
Andy Shevchenko (1):
      ata: libata-scsi: Refactor scsi_6_lba_len() with use of get_unaligned_be24()

Damien Le Moal (7):
      ata: libata: Remove unused macro definitions
      ata: libata-scsi: Refactor ata_scsi_simulate()
      ata: libata-scsi: Refactor ata_scsiop_read_cap()
      ata: libata-scsi: Refactor ata_scsiop_maint_in()
      ata: libata-scsi: Document all VPD page inquiry actors
      ata: libata-scsi: Remove struct ata_scsi_args
      ata: libata-scsi: Return residual for emulated SCSI commands

Frank Wunderlich (1):
      dt-bindings: ata: ahci-platform: add missing iommus property

Uwe Kleine-König (1):
      ata: Switch back to struct platform_driver::remove()

Yan Zhen (1):
      ata: Fix typos in the comment

 .../devicetree/bindings/ata/ahci-platform.yaml     |   3 +
 drivers/ata/ahci.c                                 |   2 +-
 drivers/ata/ahci_brcm.c                            |   2 +-
 drivers/ata/ahci_ceva.c                            |   2 +-
 drivers/ata/ahci_da850.c                           |   2 +-
 drivers/ata/ahci_dm816.c                           |   2 +-
 drivers/ata/ahci_dwc.c                             |   2 +-
 drivers/ata/ahci_imx.c                             |   4 +-
 drivers/ata/ahci_mtk.c                             |   2 +-
 drivers/ata/ahci_mvebu.c                           |   2 +-
 drivers/ata/ahci_platform.c                        |   2 +-
 drivers/ata/ahci_qoriq.c                           |   2 +-
 drivers/ata/ahci_seattle.c                         |   2 +-
 drivers/ata/ahci_st.c                              |   2 +-
 drivers/ata/ahci_sunxi.c                           |   2 +-
 drivers/ata/ahci_tegra.c                           |   2 +-
 drivers/ata/ahci_xgene.c                           |   4 +-
 drivers/ata/libata-acpi.c                          |   4 +-
 drivers/ata/libata-scsi.c                          | 516 ++++++++++++---------
 drivers/ata/pata_arasan_cf.c                       |   2 +-
 drivers/ata/pata_ep93xx.c                          |   2 +-
 drivers/ata/pata_falcon.c                          |   4 +-
 drivers/ata/pata_ftide010.c                        |   2 +-
 drivers/ata/pata_gayle.c                           |   6 +-
 drivers/ata/pata_imx.c                             |   2 +-
 drivers/ata/pata_it8213.c                          |   2 +-
 drivers/ata/pata_ixp4xx_cf.c                       |   2 +-
 drivers/ata/pata_mpc52xx.c                         |   2 +-
 drivers/ata/pata_octeon_cf.c                       |   2 +-
 drivers/ata/pata_of_platform.c                     |   2 +-
 drivers/ata/pata_oldpiix.c                         |   2 +-
 drivers/ata/pata_platform.c                        |   2 +-
 drivers/ata/pata_pxa.c                             |   2 +-
 drivers/ata/pata_radisys.c                         |   2 +-
 drivers/ata/pata_rb532_cf.c                        |   2 +-
 drivers/ata/sata_dwc_460ex.c                       |   2 +-
 drivers/ata/sata_fsl.c                             |   2 +-
 drivers/ata/sata_gemini.c                          |   2 +-
 drivers/ata/sata_highbank.c                        |  12 +-
 drivers/ata/sata_mv.c                              |   2 +-
 drivers/ata/sata_rcar.c                            |   2 +-
 include/linux/libata.h                             |   4 +-
 42 files changed, 361 insertions(+), 262 deletions(-)
