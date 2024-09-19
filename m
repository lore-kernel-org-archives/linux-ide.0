Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFCE18E776
	for <linux-ide@vger.kernel.org>; Thu, 19 Sep 2024 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726728740; cv=none; b=OZkcmx01HP67wIAimMQ8Xq+ojn3FvCoHiDSz9h3/4WHJ6sZa5+t6GnHYOpQ5F8FPMdIW8fRgaSjNoB0PZCc0963lpkPCd/Am5a8P1l0VZ0p2loJrPH94LfjPvF9rO+G+YPZwW2naUKh2s+HHFkEKD/3L0q3h2JXO7ZTTIOhpnS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726728740; c=relaxed/simple;
	bh=ZuyZOfXftzgMSi4nmW9pGusz3RzaPHdxNwj5TjgQ5+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jvb4rT8b1omrzicfz+gVV7X5Ud4YMUWnMZl5Wb5Rp0URDpOAaDxQntP28c81J21hsSgSDodVE02MPBBJFl17IEuwwHeBTRKJOEn5AECLKIuPBaNxCyAYdaKjmk4+GAcR8N2FS4Stv3OfmmLIwyce9hyhWjX/k6XyM82kxLWes44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFKFCbZI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFKFCbZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE99C4CEC4;
	Thu, 19 Sep 2024 06:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726728740;
	bh=ZuyZOfXftzgMSi4nmW9pGusz3RzaPHdxNwj5TjgQ5+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=PFKFCbZIhnXy9ZwXPRJiWo0hA6xgJEb5y6BvEiiBBKsRO5P+kTw+PhCRxtXkT6V0E
	 nAI6Izkmc0KqLqJxtwKTlrw1tUr1ogcpAiZWa+aOP2ekyYQo8E9DuQ3whndI00vg+s
	 gGCMVndOf1WdKsIvvOMzxlMOe+apRDwGH9r66Ts3ZVy8/1SNBZ4Nbj05a2jIu1BsG6
	 WqitIeomBFGs6/CnKv9tjadMxHF0KOliam5ybGE1R1YoZQ3Z5Rfi4JMVje+1q41hMf
	 7Sp2FG6rrY7TRGrsKLF4X5Ia2jved7Eryu9rq6nwB7EUZ50d7ci4IJz6Y8i0HUpjBK
	 ElaBg335kLwpQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.12-rc1
Date: Thu, 19 Sep 2024 15:52:18 +0900
Message-ID: <20240919065218.144785-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.12-rc1

for you to fetch changes up to e5dd410acb34c7341a0a93b429dcf3dabf9e3323:

  ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data (2024-09-11 08:03:43 +0900)

----------------------------------------------------------------
ata changes for 6.12

 - Convert the qcom AHCI controller DT bindings to DT schema (from
   Rayyan)

 - Cleanup of libata core and drivers code handling controller and
   device quirks to rename "blacklist" to the more neutral "quirk" and
   to replace the rarely used "horkage" term with the more common
   "quirk" naming (from me)

 - Add libata-core message to print the quirks applied to a controller
   or device (from me)

 - Remove the not-so-useful function ata_noop_qc_prep() from libata core
   (from me)

 - ahci_imx driver cleanup, improvements and DT bindings compatible
   strings update (from Richard and Dan)

 - libahci_platform improvements (from Zhang)

 - Remove obsolete functions declarations from libata header files (from
   Gaosheng)

 - Improve teh ahci_brcm driver using managed device resources funetions
   (from Zhang)

 - Introduce new helper function to improve libata EH code readability
   (from Niklas)

 - Enable module autoloading for the pata_ftide010, pata_ixp4xx and
   sata_gemini drivers (from Liao)

 - Move SATA related functions and data declaraions from libata-core to
   libata-sata (from me)

 - Rename the function handling the sense data for successful NCQ
   commands log to better reflect that function actions (from me)

 - Reduce libata memory usage by moving port resources to struct
   ata_device and by optimizing the management of resources for CDL
   capable devices (from me)

 - Improve libata-eh handling of failed ATA passthrough commands (from
   Niklas)

----------------------------------------------------------------
Damien Le Moal (23):
      ata: libata: Change ata_dev_knobble() to return a bool
      ata: libata: Rename ata_dma_blacklisted()
      ata: libata: Use QUIRK instead of HORKAGE
      ata: libata: Print quirks applied to devices
      ata: pata_serverworks: Do not use the term blacklist
      ata: ahci: Rephrase comment to not use the term blacklist
      ata: sata_sil: Rename sil_blacklist to sil_quirks
      ata: ata_piix: Remove useless comment in piix_init_sidpr()
      ata: pata_cs5520: Rephrase file header comment
      ata: pata_hpt366: Rename hpt_dma_blacklisted()
      ata: pata_hpt37x: Rename hpt_dma_blacklisted()
      ata: libata: Remove ata_noop_qc_prep()
      ata: libata: Print device quirks only once
      ata: libata: Cleanup libata-transport
      ata: libata-scsi: Improve ata_scsi_handle_link_detach()
      ata: libata: Improve __ata_qc_complete()
      ata: libata: Move sata_down_spd_limit() to libata-sata.c
      ata: libata: Move sata_std_hardreset() definition to libata-sata.c
      ata: libata: Rename ata_eh_read_sense_success_ncq_log()
      ata: libata: Move sector_buf from struct ata_port to struct ata_device
      ata: libata: Introduce ata_dev_free_resources
      ata: libata: Improve CDL resource management
      ata: libata: Fix W=1 compilation warning

Dan Carpenter (1):
      ata: ahci_imx: Fix error code in probe()

Gaosheng Cui (1):
      ata: libata: Remove obsolete function declarations

Liao Chen (3):
      ata: pata_ftide010: Enable module autoloading
      ata: pata_ixp4xx: Enable module autoloading
      ata: sata_gemini: Enable module autoloading

Niklas Cassel (2):
      ata: libata: Add helper ata_eh_decide_disposition()
      ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data

Rayyan Ansari (2):
      dt-bindings: ata: qcom,ipq806x-ahci: use dtschema
      dt-bindings: ata: qcom,apq8064-ahci: add to dtschema

Richard Zhu (5):
      dt-bindings: ata: Add i.MX8QM AHCI compatible string
      ata: ahci_imx: Clean up code by using i.MX8Q HSIO PHY driver
      ata: ahci_imx: AHB clock rate setting is not required on i.MX8QM AHCI SATA
      ata: ahci_imx: Enlarge RX water mark for i.MX8QM SATA
      ata: ahci_imx: Correct the email address

Zhang Zekun (2):
      ata: libahci_platform: Simplify code with for_each_child_of_node_scoped()
      ata: ahci_brcm: Use devm_platform_ioremap_resource_byname() helper function

 .../devicetree/bindings/ata/ahci-platform.yaml     |  33 +-
 .../devicetree/bindings/ata/imx-sata.yaml          |  47 ++
 .../devicetree/bindings/ata/qcom-sata.txt          |  48 --
 drivers/ata/ahci.c                                 |   2 +-
 drivers/ata/ahci_brcm.c                            |   4 +-
 drivers/ata/ahci_imx.c                             | 404 +++-------
 drivers/ata/ata_piix.c                             |   1 -
 drivers/ata/libahci_platform.c                     |  19 +-
 drivers/ata/libata-core.c                          | 886 ++++++++++-----------
 drivers/ata/libata-eh.c                            |  68 +-
 drivers/ata/libata-pmp.c                           |   3 +-
 drivers/ata/libata-sata.c                          | 137 +++-
 drivers/ata/libata-scsi.c                          |  23 +-
 drivers/ata/libata-sff.c                           |  11 +-
 drivers/ata/libata-transport.c                     | 305 ++++---
 drivers/ata/libata-zpodd.c                         |   2 +-
 drivers/ata/libata.h                               |  26 +-
 drivers/ata/pata_cs5520.c                          |   6 +-
 drivers/ata/pata_ep93xx.c                          |   2 -
 drivers/ata/pata_ftide010.c                        |   1 +
 drivers/ata/pata_hpt366.c                          |  10 +-
 drivers/ata/pata_hpt37x.c                          |  10 +-
 drivers/ata/pata_icside.c                          |   2 -
 drivers/ata/pata_it821x.c                          |   4 +-
 drivers/ata/pata_ixp4xx_cf.c                       |   1 +
 drivers/ata/pata_mpc52xx.c                         |   1 -
 drivers/ata/pata_octeon_cf.c                       |   1 -
 drivers/ata/pata_serverworks.c                     |  16 +-
 drivers/ata/sata_gemini.c                          |   1 +
 drivers/ata/sata_sil.c                             |  14 +-
 drivers/scsi/libsas/sas_ata.c                      |   1 -
 include/linux/libata.h                             | 157 ++--
 32 files changed, 1128 insertions(+), 1118 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/qcom-sata.txt
