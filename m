Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A7E198851
	for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2025 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931023; cv=none; b=JwF5aBIdx3Tev0okhDwjGk8U6GjlHJeZrnE9u7ST1xX+nqoX5zmZyKyuZxRGwRxO5uobNK/CSq9aZAlOMHaY1dnp8J3OdDN5a7sIsXduFnI+veuHUbnKoXDOirGfXoIg4/rWqfYRj9Td5xx9Md1yPFNSr4vZ61Z2TkFzOVK8Bzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931023; c=relaxed/simple;
	bh=uew84E+BIJ/h1dYLkOeewze4two5IP0lrHkcvR3nPdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Svj+YiUGuEBpcbdGrvUz2Hr5LeljYbL+4cHPfB3T+sJ/rFt7D9AkLwwq0ukc5Y4lgH+poi76eC13RCBrSO3detR4cxmAu/mwcwdaLw6JPdDhSJ7bw72XZOoM4I41fuJHx+OHBQvnsAi27lcokvlonYI4dZxLgfwhPBDyt51zFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcgswCUv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcgswCUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFC7C4CEE4;
	Tue, 25 Mar 2025 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742931023;
	bh=uew84E+BIJ/h1dYLkOeewze4two5IP0lrHkcvR3nPdI=;
	h=From:To:Cc:Subject:Date:From;
	b=NcgswCUvUPCQgOSkStsjT2RHofedGCNL+S1hhUv7WjcsPkBXjuEfCupAxKFuSSlgF
	 57lnZcBeNKfh9BX+T+s/QKS8xgx51JcApI6v2Ub5vyPE7sIgN+FQQxo+WEVg8xUnHp
	 K4nrUG2jYEJ9sK6iXRJVarSATV54KRKqTKDbNB2T7xwTe74ROdZiuGw/4m5GGMBfvB
	 HFKTBp2aeSGhPKFIAXjJ/U/6WKmrrQWfOl5l7oV6bgNnCYzz+oGyNNZjN4ND3kYPqJ
	 DXyxPAeeoRkVM7UH3Akf38KFkc2LYVqrt6HLXyltuwKFK94VFDVAnYCFNSQBtrkgMG
	 4ibxmg8qG0iOA==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.15-rc1
Date: Tue, 25 Mar 2025 20:29:36 +0100
Message-ID: <20250325193004.3777124-1-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.15-rc1

for you to fetch changes up to 565d065acd7ea871874ac32e54e58af2d15a182a:

  ata: ahci: simplify init function (2025-03-19 17:27:58 +0100)

----------------------------------------------------------------
ata changes for 6.15

 - Add 'external' to the libata.force module parameter, in order to
   allow a user to workaround broken firmware (me)

 - Use the str_up_down() helper in the sata_via driver (Salah Triki)

 - Convert the Freescale PowerQUICC SATA device tree binding to YAML
   (J. Neuschäfer)

 - Do not use ATAPI DMA for a device that only supports PIO (me)

 - Add Marvell 88SE9215 PCI device ID to the ahci driver.
   Since the controller has quirks, it cannot rely on the generic
   AHCI PCI class code entry (Daniel Kral)

 - Improve the return value of atapi_check_dma() (Huacai Chen)

 - Fix the NCQ Non-Data log not supported print to actually reference
   the correct log (me)

 - Make Marvel 88SE9215 prefer DMA for ATAPI devices (Huacai Chen)

 - Simplify the AHCI IRQ vector allocations by performing the IRQ
   vector allocations in the same function, regardless of IRQ type
   (Tomas Henzl)

----------------------------------------------------------------
Daniel Kral (1):
      ahci: add PCI ID for Marvell 88SE9215 SATA Controller

Huacai Chen (2):
      ata: libata: Improve return value of atapi_check_dma()
      ahci: Marvell 88SE9215 controllers prefer DMA for ATAPI

J. Neuschäfer (1):
      dt-bindings: ata: Convert fsl,pq-sata to YAML

Niklas Cassel (3):
      ata: libata-core: Add 'external' to the libata.force kernel parameter
      ata: libata-eh: Do not use ATAPI DMA for a device limited to PIO mode
      ata: libata: Fix NCQ Non-Data log not supported print

Salah Triki (1):
      ata: sata_via: Use str_up_down() helper in vt6420_prereset()

Tomas Henzl (1):
      ata: ahci: simplify init function

 Documentation/admin-guide/kernel-parameters.txt    |  2 +
 .../devicetree/bindings/ata/fsl,pq-sata.yaml       | 60 ++++++++++++++++++++++
 Documentation/devicetree/bindings/ata/fsl-sata.txt | 28 ----------
 drivers/ata/ahci.c                                 | 34 ++++++++----
 drivers/ata/ahci.h                                 |  1 +
 drivers/ata/libahci.c                              |  4 ++
 drivers/ata/libata-core.c                          | 42 ++++++++++++++-
 drivers/ata/libata-eh.c                            | 11 +++-
 drivers/ata/sata_via.c                             |  3 +-
 9 files changed, 141 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/fsl,pq-sata.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/fsl-sata.txt
