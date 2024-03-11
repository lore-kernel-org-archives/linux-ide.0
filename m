Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18243B79F
	for <linux-ide@vger.kernel.org>; Mon, 11 Mar 2024 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159579; cv=none; b=Aqy+Q4CMzsY82xHh34nhI2a9Y6LnvfquIgGoSNF7fVqmaApwx68bP+Cyn7LnsJsqMIT8LcvYdYdvQdfiQjO8Zim/zMft0MoowPWexLRYvhnxsolXjkxv26rQWv8MWd2H1wgHAs+5SBbmYX6KwWuek4O3JEXYVuEUA3GgGqMeiUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159579; c=relaxed/simple;
	bh=uGRRZiMOIPDAKyWfCXomSlRkxvqemxkL/GRJkEQpvw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JQPB4VVSgPEe4tKoti0vA4gRCWMLt4xGWHzpslJOZCCBwKnRh1kyqk8DfV+6/zHKfHzy0sTZaH1n6efNsi4gRtQu01UOBTbUy1MboGQeH8+JZ1ru5VhdoumQlnC+UfhVs0JdD7/t564pCQa473duHbwVCD0cGGPQXbsPwRQdnOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV8qDbBZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV8qDbBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72416C433F1;
	Mon, 11 Mar 2024 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710159578;
	bh=uGRRZiMOIPDAKyWfCXomSlRkxvqemxkL/GRJkEQpvw8=;
	h=From:To:Cc:Subject:Date:From;
	b=eV8qDbBZykbF/UCwwq11EGW0NoDcw9Wj4+RCykMzBkON7ZMcEwD1fG5uBpzEx8cuo
	 TswkvrhFqdC+DAaFQv7mcKUOn4edv+r10RZFmmH8SrCA42w1ioEgumHWS7QCOyABvF
	 8ouvQCzbSPTCjZENcFOiY3JXXa3uyM/Kfz0fkanMRQVQZO3/xeywuO3Wh3UH50Y+GK
	 Im2PD4JYjfpDi2aCDSH8eBHSKriwPk1BK5VjPZOMGlUroL/WdBeWUpMT7Rbm65sV2k
	 RIy9jGJJblfAQKQAKhWwqXNEEYH4SZ94LuQkk5MBtuqn0LuFQL2TTajk786sqwJmjK
	 EJMAZEdL/MDfw==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.9-rc1
Date: Mon, 11 Mar 2024 13:19:27 +0100
Message-ID: <20240311121929.3420655-1-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.9-rc1

for you to fetch changes up to 13ec4098d8032b0e8d2b2548803002df80d7f9c6:

  ahci: print the number of implemented ports (2024-02-21 19:13:43 +0100)

----------------------------------------------------------------
ata changes for 6.9-rc1

 - Do not enable LPM for external ports (hotplug-capable ports or eSATA
   ports), as the HBA will not be able to detect hot plug removal events
   when LPM is enabled. (from me)

 - Drop the board type board_ahci_low_power. Now when we make sure that we
   won't enable LPM for external ports, we can always set the LPM policy to
   CONFIG_SATA_MOBILE_LPM_POLICY for internal ports. There is thus no
   longer any need for the board type board_ahci_low_power, so it can be
   removed. (As before, LPM features not supported by the HBA and/or the
   device will not be enabled, regardless of the LPM policy Kconfig.)
   (from Mario Limonciello)

   Note that the default CONFIG_SATA_MOBILE_LPM_POLICY value is still 0
   (which will not try to enable any LPM features), however, most Linux
   distributions override this and set it to 3 (Medium power with DIPM).
   We intend to change the default to 3 in the coming cycles, but we will
   wait a cycle or two.

 - Add board type board_ahci_pcs_quirk and make all legacy Intel platforms
   use it. The Intel PCS quirk was being applied to basically all Intel
   platforms, which caused some issues (the device failing to come back
   after a reset), when being applied to newer Intel platforms where it
   shouldn't have been applied. Add board type board_ahci_pcs_quirk and
   make legacy Intel platforms use it. New platforms can be added using
   board type board_ahci (which will not have the quirk applied).
   (from me)

 - Rename board_ahci_nosntf to board_ahci_pcs_quirk_no_sntf to more clearly
   highlight that it applies two different quirks. (from me)

 - Modify the ahci_broken_devslp() quirk to be implemented like all the
   other quirks (i.e. define a board type for the quirk). (from me)

 - Drop unused board_ahci_noncq board type. (from me)

 - Rename board_ahci_nomsi to board_ahci_no_msi to match the other board
   types. (from me)

 - Make pata_parport_bus_type const. (from Ricardo B. Marliere)

 - Remove at91 compact flash device tree binding. (The binding is not used
   by any driver.) (from Hari Prasath Gujulan Elango)

 - Convert MediaTek device tree binding to json-schema.
   (from Rafał Miłecki)

 - At boot, print the number of implemented ports, instead of printing the
   maximum number of ports supported by the HBA silicon. (from me)

----------------------------------------------------------------
Hari Prasath Gujulan Elango (1):
      dt-bindings: ata: atmel: remove at91 compact flash documentation

Mario Limonciello (1):
      ata: ahci: Drop low power policy board type

Niklas Cassel (10):
      ata: ahci: move marking of external port earlier
      ata: ahci: a hotplug capable port is an external port
      ata: ahci: drop hpriv param from ahci_update_initial_lpm_policy()
      ata: ahci: do not enable LPM on external ports
      ahci: clean up intel_pcs_quirk
      ahci: rename board_ahci_nosntf
      ahci: clean up ahci_broken_devslp quirk
      ahci: drop unused board_ahci_noncq
      ahci: rename board_ahci_nomsi
      ahci: print the number of implemented ports

Rafał Miłecki (1):
      dt-bindings: ata: convert MediaTek controller to the json-schema

Ricardo B. Marliere (1):
      ata: pata_parport: make pata_parport_bus_type const

 Documentation/devicetree/bindings/ata/ahci-mtk.txt |  51 ---
 .../devicetree/bindings/ata/atmel-at91_cf.txt      |  19 -
 .../devicetree/bindings/ata/mediatek,mtk-ahci.yaml |  98 +++++
 drivers/ata/Kconfig                                |   5 +-
 drivers/ata/ahci.c                                 | 434 ++++++++++-----------
 drivers/ata/ahci.h                                 |  10 +-
 drivers/ata/libahci.c                              |  21 +-
 drivers/ata/pata_parport/pata_parport.c            |   2 +-
 8 files changed, 329 insertions(+), 311 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-mtk.txt
 delete mode 100644 Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
 create mode 100644 Documentation/devicetree/bindings/ata/mediatek,mtk-ahci.yaml
