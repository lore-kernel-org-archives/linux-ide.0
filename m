Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6016C277C86
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670527; cv=none; b=Sq8qDpEHCov9FSFC5xGDi2vPiB0UwkcXGBVjbZ+guMhXNwEPkn3h0N+xeSnfsqVgKyFUeKYMZ+viCxwETqw0810OlfNr42Eg86/g11H/PmVRRy9yBxbBZTvjA49bMGbFaC20tdGeM9O8pw3rKvNJA7JGHTPqjcENTCEK7adQXfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670527; c=relaxed/simple;
	bh=KRxcbdKdE/XXpwJwN1sl/NkvSmhHf5Zs+9lkFnd51Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iOhLzosdN1mP6nxsC18s4OnIGDAJG5YmUy7EKBsIPeVk1BQOFsTkDzKk4YzJRbJDScYaxMtAi1cldXm+9kv/d1RXn7at+SYcbOKGcmE9pm6Q+g96YDY/vs8DuMXoNCSuW30UNfwycvZ1qJYQrA430cAY7qWaoX/7xxdIEzXnp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdGZs8n0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdGZs8n0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B524FC4CEF1;
	Tue,  2 Dec 2025 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764670526;
	bh=KRxcbdKdE/XXpwJwN1sl/NkvSmhHf5Zs+9lkFnd51Q0=;
	h=From:To:Cc:Subject:Date:From;
	b=qdGZs8n0np8BXb7rVclQfT810NHspKm9il4E/YdLEcrr8yLcwG3OK4wiQbO57cEFH
	 nboDITkrsfn1hWV4EIfBDHKmx/KoryTAIdtMv1Tyr6RG8p8PXdftFbFB1rEz9X7zkK
	 SP5/k5hGalDlVZ85AlzxHfZzz0dJwnn5u0NsIqF4Sj59aTHEMfdYaFIX/Lxkx1r1fq
	 nQPWfHBnCERhODyvu9vC/8g2+urca7S2bHCHUQxC6H0oYkZpFd6tEH+V9PajBXzZuV
	 WSwCwBVL5/jBMSbU3/y+ObzEcYDbatKhVbOd9dGchF7Wa985MJ6Nut4OY1pN2PLcnJ
	 htlha77YGQwVw==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.19-rc1
Date: Tue,  2 Dec 2025 11:14:01 +0100
Message-ID: <20251202101403.362869-1-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.19-rc1

for you to fetch changes up to 6ce0dd9f54ea9773c0aedfaab7b858fc68a848ba:

  ata: libata-core: Disable LPM on Silicon Motion MD619{H,G}XCLDE3TC (2025-11-28 06:58:24 +0100)

----------------------------------------------------------------
ata changes for 6.19-rc1

 - Add DT binding for the Eswin EIC7700 SoC SATA Controller (Yulin Lu)

 - Allow 'iommus' property in the Synopsys DWC AHCI SATA controller
   DT binding (Rob Herring)

 - Replace deprecated strcpy with strscpy in the pata_it821x driver
   (Thorsten Blum)

 - Add Iomega Clik! PCMCIA ATA/ATAPI Adapter PCMCIA ID to the
   pata_pcmcia driver (René Rebe)

 - Add ATA_QUIRK_NOLPM quirk for two Silicon Motion SSDs with broken
   LPM support (me)

 - Add flag WQ_PERCPU to the workqueue in the libata-sff helper
   library to explicitly request the use of the per-CPU behavior
   (Marco Crivellari)

----------------------------------------------------------------
Marco Crivellari (1):
      ata: libata-sff: add WQ_PERCPU to alloc_workqueue users

Niklas Cassel (1):
      ata: libata-core: Disable LPM on Silicon Motion MD619{H,G}XCLDE3TC

René Rebe (1):
      ata: pata_pcmcia: Add Iomega Clik! PCMCIA ATA/ATAPI Adapter

Rob Herring (Arm) (1):
      dt-bindings: ata: snps,dwc-ahci: Allow 'iommus' property

Thorsten Blum (1):
      ata: pata_it821x: Replace deprecated strcpy with strscpy in it821x_display_disk

Yulin Lu (1):
      dt-bindings: ata: eswin: Document for EIC7700 SoC ahci

 .../bindings/ata/eswin,eic7700-ahci.yaml           | 79 ++++++++++++++++++++++
 .../devicetree/bindings/ata/snps,dwc-ahci.yaml     |  4 ++
 drivers/ata/libata-core.c                          |  4 ++
 drivers/ata/libata-sff.c                           |  3 +-
 drivers/ata/pata_it821x.c                          |  5 +-
 drivers/ata/pata_pcmcia.c                          |  1 +
 6 files changed, 93 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml
