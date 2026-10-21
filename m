Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.19.144.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601759;
	b=ij60FdnOrnYZJghagZuKCa4bmJhgnZaoszJaBO1WigkdRyIVcRa1FWHiFUcUoEmHFT0t
	 i95GcVDQn5zI8Je/Kc7yPTXR1KPonbwr1UbHL2wVWcRojgghdhcaz6031oF9+Jn9MbHMv
	 DovqNXiVfOz3EEQcJUUc8/MrjbgpGMZcj4ueXxg2ZqZuXOkF7Q/0LAE3lPAO8NY7IYMeA
	 W6511HQB4LjHDUUc0gpQzlXw0djdbJ9/61h1NMUeY3o1+Bb+84iDYfZwMu/zrMbJCXOOe
	 InfRmztImUHme+KwIyyj+FXtojhFyespwIRsG4mLlpVuLXL+gI0KTa9mFUzuComEVqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601759;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JsGFtawqsKcZKjgYGXtTlVyL42CYc0myKT+LrgiBl7U=;
	b=q4VO9kKNol5N1iurnCpBXV4qlERA/jTRSeaXC0r948gHf1sI/Bvapcc5spOVPqHRdxh/
	 U18LRDdnosch94CjPwF5uQvTkR5BneY+XSRWFrSow9M/GzdfF6l7b6s4qbbkOexPGuAGf
	 qyokjpmcYcutV3ctfR2Sc4hQSVg1PdD2Z7iz0x2eWBiiuhhEeT/X5MEJfdkCElQ+GsV16
	 piEUr0kPQmm6gZgajf0+0bGN9AA67G9t0hWhOe3xYMtDCTA31+A8y0D0hpY1YvQUXziW/
	 Uvz98pCMgHZviHPwDMStAL5L+hd08EaXoJALzIVkYsVqyPh1uh/MCGRad+eA4ABBD0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b="lJ/apH5L";
	arc=none smtp.remote-ip=192.19.144.205
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1E606A320;
	Wed, 21 Oct 2026 16:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FC1E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=dkimrelay header.b=lJ/apH5L
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 53DE7C0003DA;
	Wed, 21 Oct 2026 09:55:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 53DE7C0003DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1792601757;
	bh=2Gk3979aBXNVBj7Y718ck3B0Va4qrBwWxdpekp7wxa8=;
	h=From:To:Cc:Subject:Date:From;
	b=lJ/apH5LbBrddqVyp7a8W3CR1qjMCNwGhakgOqdxFkzcL22UM8qDbFzXC+1Px1u7J
	 PS9KVBqRFbuZO9ahTse8LLPXMGAanozR+CyuSQH8WBSgf7/NB+MFh7g7iqhonnw4QO
	 B9aZ4+ZV7vLxivCZ2fjL3a+wLtef5udMhHE4VRZQ=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id DD662A83;
	Wed, 21 Oct 2026 09:55:56 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>,
	linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH 0/6] Fix SATA support for NSP SoCs
Date: Wed, 21 Oct 2026 09:55:47 -0700
Message-ID: <20261021165555.652102-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes SATA on the Northstar Plus (BCM58xxx/8831x)
which was broken due to a number of things:

- the SATA PHY assumed separate PCB windows when a shared one is used
  for this generation of SoCs
- the clock/reset (IDM) was not being configured by the driver which
  meant that depending upon what the boot loader did, or did not, we
  could have had the AHCI controller still in reset by then
- on some reference boards, the AHCI controller is not DMA coherent,
  assuming so leads to all sorts of timeouts, data corruption, etc.

Since this touches several subsystems: DT, PHY, AHCI and DTS, I would be
keen on having Damien merge all of those via his tree if acceptable by
the DT and PHY maintainers, I am OK either way for Broadcom SoC.

Thanks!

Florian Fainelli (6):
  phy: broadcom: brcm-sata: Keep NSP ports in the shared PCB window
  dt-bindings: ata: sata-brcm: Describe the NSP IDM registers
  ata: ahci_brcm: Initialize the NSP interface clock and reset
  ARM: dts: broadcom: Add the NSP SATA IDM registers
  ARM: dts: broadcom: Use noncoherent SATA DMA on BCM958625HR
  ARM: dts: broadcom: Enable SATA on BCM958625HR

 .../bindings/ata/brcm,sata-brcm.yaml          | 20 ++++++++++-
 arch/arm/boot/dts/broadcom/bcm-nsp.dtsi       |  7 ++--
 arch/arm/boot/dts/broadcom/bcm958625hr.dts    |  5 +++
 drivers/ata/ahci_brcm.c                       | 34 +++++++++++++++++++
 drivers/phy/broadcom/phy-brcm-sata.c          |  5 +--
 5 files changed, 65 insertions(+), 6 deletions(-)

-- 
2.53.0

