Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D144915218D
	for <linux-ide@vger.kernel.org>; Mon, 13 May 2024 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606713; cv=none; b=kO0vNiZwe5VXXfXPitjVxHqe4KJXEbOEfJedaQEPYc84bQa6DLLyZ9Oer7gzjF/ezbUFhdy42WUfk9nz/QB3NMqNjfCHTZlZjIQAcGjCE7+VeX4JtH9RAExDHhjvkLKI3JjvWmDhFJdvadMRnj41fFLWJ4ZPH6miRj/oRiwhnhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606713; c=relaxed/simple;
	bh=hFsR+PlJT+Ki9pX/K52Ew72eB/KGhug7N/SpL4S+QMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ak6bcKsKYEZaUbhQ3OwS6WHSX9/cmutT2bn69VBUtFZReLF4lTMTQ2wVssDc7aKuv4M0mDZKwuYmCFYd4rCjTEVDpdKBRYMUHXe7VJQV3O7cogFzxO8Piml+EQ8gMY2CCT1eOJhDB1TBjBLsxURQyyEMBl0ATG4o58xbkN9SHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avLyT21+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avLyT21+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3867DC113CC;
	Mon, 13 May 2024 13:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715606713;
	bh=hFsR+PlJT+Ki9pX/K52Ew72eB/KGhug7N/SpL4S+QMs=;
	h=From:To:Cc:Subject:Date:From;
	b=avLyT21+albx0mOHM4B2pW+GUzB/43LmSm7lQi1UULVcU8WjQf1RdOjLuz9glXldS
	 gt4B2Z7/wUr9EQK7xIaVFxkAU5lB8IC+3WcADRJiJeK9ceD+RhYjb1RytIVCytKNaz
	 FCKbW2enBP3CbdHmInBY9UBxjF8UNKgQUxkeg5qKBCZNjy33s6wETaFprHdoo3SjXn
	 W096H1mZtGWT33PUjYHq+7At3bwgyzg7sIo95joewbX3TnaAv1eNNjKPj/1Dzd7zpN
	 HKAzrZ3UP8ymtW7/WidODFU0y2h/oFLt5bEiOdwEGRcTExR3BbyPTSmSrg3G6wqQG9
	 xQtN1eArENgwg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.10-rc1
Date: Mon, 13 May 2024 22:25:11 +0900
Message-ID: <20240513132512.159143-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.10-rc1

for you to fetch changes up to d4a89339f17c87c4990070e9116462d16e75894f:

  ata: pata_legacy: make legacy_exit() work again (2024-05-07 07:23:31 +0900)

----------------------------------------------------------------
ata changes for 6.10-rc1

 - Convert the bindings for the imx-pata and ahci-da850 drivers to DT
   schemas (from Animesh).

 - Correct the code to handle HAS_IOPORT dependencies and conditionally
   compile drivers as needed (From Niklas).

 - Correct the legacy_exit() function in the pata_legacy driver to
   properly handle cleanups on driver exit (From Serget).

 - Small code simplification removing the ata_exec_internal_sg()
   function and folding it into its only caller (From me).

----------------------------------------------------------------
Animesh Agarwal (2):
      dt-bindings: ata: imx-pata: Convert to dtschema
      dt-bindings: ata: ahci-da850: Convert to dtschema

Damien Le Moal (1):
      ata: libata-core: Remove ata_exec_internal_sg()

Niklas Schnelle (1):
      ata: add HAS_IOPORT dependencies

Sergey Shtylyov (1):
      ata: pata_legacy: make legacy_exit() work again

 .../devicetree/bindings/ata/ahci-da850.txt         |  18 ----
 .../devicetree/bindings/ata/fsl,imx-pata.yaml      |  42 ++++++++
 Documentation/devicetree/bindings/ata/imx-pata.txt |  16 ---
 .../devicetree/bindings/ata/ti,da850-ahci.yaml     |  39 ++++++++
 drivers/ata/Kconfig                                |  28 +++---
 drivers/ata/libata-core.c                          | 108 ++++++---------------
 drivers/ata/libata-sff.c                           |   4 +
 drivers/ata/libata.h                               |   8 +-
 drivers/ata/pata_legacy.c                          |   8 +-
 9 files changed, 139 insertions(+), 132 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
 create mode 100644 Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt
 create mode 100644 Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml
