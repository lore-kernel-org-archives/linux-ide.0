Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F11528F4
	for <linux-ide@vger.kernel.org>; Mon,  6 Oct 2025 02:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759718345; cv=none; b=l/v5KiCIPxtQtIJiz/mK+kWrXAOkDD9OMJTfe3bBfQ5tlbsy2AbxPR9yQhzMozxPcAWlYZZtd5Gsedkpa6VZGeHx3OpRyojarpm2PKCMEATtIQwilxl/sr9yfL9zjdDOiywI8SaxWlzWkOfRMXlQzBSMQ94OBYqNXzQNn96wpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759718345; c=relaxed/simple;
	bh=x07I1wFG3WTJ7DphDZG+mkP405G8qpTLLxJ0NV+jxrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqxDl/5Qd1B24w3ZI7zV9iNVv7ymmuiZ2zCNMCVRe+z4bhGTqsVVIXReIvffLqS+Jtj0e/+xZcxmbxJsNduK0HyCmBVmunuosWa39cjAPTyaAm/R5JOfEmKY3R1vRX/upckBChcnqTBq3rSVx3zFmY3w5auo2EAy6dOAflgAL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVPoSjBZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVPoSjBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C9BC4CEF4;
	Mon,  6 Oct 2025 02:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759718345;
	bh=x07I1wFG3WTJ7DphDZG+mkP405G8qpTLLxJ0NV+jxrA=;
	h=From:To:Cc:Subject:Date:From;
	b=KVPoSjBZb3vTxuDcDMYbjnQmmjc95GuME0SP8bbQiFBNeaSEHcNqcUoP+V7GimqVt
	 KcBl67bcbbWE2PPcyhyaVyER8bidP3sxOz5zKRqxPG/lAMxHyP8qn/aAS2t/i82BMk
	 HNKRNZtCRQx1eRe4UFV9EByBXTMmCj5mmQ52rcpmK3vaDm/G4VEFUD6eEdjdIJBz/b
	 Cz6mRbNKSXKJnfLQSAN14DtmBe4nzJJi8mlNF5KYejv4JFLx5Kdrsg2+8EjB4cC+0g
	 nunWKs4ICPKHAeqGEfeB0A4ugo/dc1wVKsirvhchRLd+stBBEuOKGV28VHyuv3pJS2
	 DAbaSmykNudDQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata changes for 6.18-rc1
Date: Mon,  6 Oct 2025 11:35:43 +0900
Message-ID: <20251006023543.271842-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.18-rc1

for you to fetch changes up to f145845d8348c9b6288df41cb7904fd9fde566dc:

  dt-bindings: ata: apm,xgene-ahci: Add apm,xgene-ahci-v2 support (2025-09-22 18:11:59 +0900)

----------------------------------------------------------------
ata changes for 6.18

 - Improve the DT bindings documentation for the highbanck, imx and
   xgene-ahci controllers (Krzysztof, Fabio, Rob).

----------------------------------------------------------------
Fabio Estevam (1):
      dt-bindings: ata: imx: Document 'target-supply'

Krzysztof Kozlowski (1):
      dt-bindings: ata: highbank: Minor whitespace cleanup in example

Rob Herring (Arm) (1):
      dt-bindings: ata: apm,xgene-ahci: Add apm,xgene-ahci-v2 support

 .../devicetree/bindings/ata/apm,xgene-ahci.yaml     | 21 ++++++++++++++-------
 Documentation/devicetree/bindings/ata/imx-sata.yaml |  3 +++
 .../devicetree/bindings/ata/sata_highbank.yaml      |  2 +-
 3 files changed, 18 insertions(+), 8 deletions(-)
