Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587930;
	b=Wz+FdJuFmC5QP0NmxlHpGwj25sfLXECZHUma31otMewtPjFFxTzu10L6wPpwTQsMXkNB
	 WpEQq6RpKf+Q+dzIq4P7QGRyrM4cC4u/+IKJBpMKAtGoUBWFdamNYzBoI53zKHqQ4axYw
	 VkQaB8YFmGiNyAn+RoQqTVa4ExKhNwvJNdVEbTuNSfCmFOwqT6YBFPckM68S7eOtgXtIM
	 mP9THCG3wdjcBlK+iYYHtd4Sbg58X6TKXASrc13dmgcQmTyXjOWhqvrTvCG2E0X4jZKnn
	 4L+QQ6f2SprnNE/YSObPjnW4tH51pOMlzTEzuwB30VcYE3XWzHba92FybNKNLpXs+OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587930;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=GLd3QVwK7lA3DRraSPd91wrloby7B/AUObiRFqJYDz8=;
	b=mrJasB+ZO2K7Bof3Hgu8IyzLMjc1yxoraHFI0GrAb1PFzfybEYk7ZAbfFrzIEvK8QUES
	 NzQF62QKPQn+xidghpkg3x7OpliZ8OiVcxxFRXMw0EblTFXkuEshTPWtICLiu6+0SPi/4
	 OM+MTBwLu4ipc1TIJyrikV9RSUd2zJ3XCYImtjzfv6bXLt1qVplvNtWXeVGS048oKShkM
	 Jfcd2wzv//JZBXm+0wIsK7IejVjGvdjgkbjAEV51bLLOPV6nU6D4AcwQtvq/F+AVZBn8U
	 4x3j1CyyMbz1ScMuCaNnWx49I6Tq2gKIoy59jS7W91ujRR/0RCcA8en3HOWdopUB8Yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRwcOVz1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7F1606A332;
	Fri, 13 Nov 2026 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRwcOVz1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794587929;
	b=vIFO0eZ54QPWGfaNZhX33Toxy3+hzM9n425eI5fZ+YKcwyRdMDgCVFTVbMZxW90VvC/9
	 pS6XJZHWboZQpYTpncBs1Zueg9pDJ8Z44zFn7alHHeqiMD0AleGQ91sfPDNjX8vqhdpA7
	 v8iMcbnDMtd717Sc+TrWWLEyGPzIRJODtM6qgfgwXgToCR9m+VTlXqv0ESrOprfNU1tS8
	 OQCXDuR8ablSpTwGzB9E7veNq7dGtgPdv0CsL3XbjPWGS5F1WTQ81o6fimTi/Jeis3tuk
	 /f6VTKJKequYDw2OiuRbvfXeiwE+unx070ns02p7q18ovtmatufhAeFbht/B8iqA2/Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794587929;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=GLd3QVwK7lA3DRraSPd91wrloby7B/AUObiRFqJYDz8=;
	b=yUdc6Oqd8oiXL+Wc37Xg5B71J4/xILt6aH3ZRvUOZf05uBjDUzREqWFOFhzN1ym3t7vZ
	 BX0AGOhZRcgjrF94AAn3vTFaGey53kAdstaGn3srCwlwnDsYhOHJJmQvx043HYA8cZ3Aa
	 qrE7hW6YFT5G4hFC9otjCzKEV3TBqeGET9MZdJiawInBUKKIWCLv6YeXFgpc+8a35xiqn
	 m0mTQTJ0GcdnxFZpBaBxw7P72HqHbEdnwwUuI69V/7nAXLXOz0o4ujilsumMsVIXfW/Rc
	 dDcwMAb58HVbCn6ZzZ1cKlTCsEeAKYOOorh01Y+yHVkFTufmkRkwzGfRd8wQkwSSyJA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C77C91F000C4;
	Fri, 13 Nov 2026 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587929;
	bh=GLd3QVwK7lA3DRraSPd91wrloby7B/AUObiRFqJYDz8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ZRwcOVz1fTopoSdNnFEhZoXufHagEPWvoDZv5OZ/sLPhIqApJHa25I0VL/FCYKGpp
	 Q3wmUdk8AygRE+nlYBJ9M9ROcQsHnwuvdZuGhzD8N8bM7rTpOrD2W5gQWb4TjQy5P1
	 2ZsKQsCW7S9xDd2nJ7U7rgJJWeyP3YrWfTPx5gVWSDUNtF/iSHm6Ob47iEWhOonZm0
	 KYr/lYx0l3DZMOyvOV7iBvO03tEUOpynq+cGyBCVa6g3o00FIkjENy6nXuOWuLJuId
	 zd6xgJ8F8CzbQcP4ZZeKEcf9CTrRXRklPp+MlJNd7xXz47P7HNCtRN0Bu3jNStbxPH
	 f9JDXBQtD7qSA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 223A949992;
	Fri, 13 Nov 2026 16:38:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH 0/9] RK3588: Enable the PHP SMMU
Date: Fri, 13 Nov 2026 16:38:46 +0000
Message-Id: <20261113-mmu600-php-v1-0-231196049a3b@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2N0W4CIRBFf2XDc6dhQDBsTON/GB8GGJSmKF12T
 RPjv5fVpm9zkjvn3EXjKXMT43AXE99yy9dLB3wbRDjT5cSQY2ehpLKIqKGUxUoJ9VxBartNvE1
 opRP9oU6c8s9Tdji+uC3+k8O8Gv4WE38vvTK/ZqJwa/SsjMPuP9J6BW4aasgMNa6nBO3Yb5JDZ
 5Tbnwrlr/dwLR+r11Nj6FDyPA5BeyI2CQmN3ZgQI8XglXfkY+RkYlIOk3Hi+Hj8Aj6BXwAAAQA
 A
X-Change-ID: 20261113-mmu600-php-0367fe7f1609
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Serge Semin <fancer.lancer@gmail.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
 Pranjal Shrivastava <praan@google.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794587927; l=2938;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=Jmo5oZh4/PhZlA1l9HdDGiyc/oiQRtE0uFFYTpbR1r8=;
 b=LclplOwvlOIHkFOlOW5OQnvIF078toyrzCc0cl4+5/NgniHUdg1bY9c9ymu8UBH1xAs51lm01
 A+/isLOIibdBFDd0lHBhlsHMVBXeTuzftGlgXghFJ5QxBCWx6E4SoAH
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

The RK3588 PHP SMMU (MMU600_PHP) is disabled because nothing programs
the StreamIDs of its masters (GMAC0/1, SATA0-2, USB3OTG_2) in the PHP
GRF. Program them, attach the masters and enable the SMMU.

Shawn Lin asked whether mmu600_php should be enabled too; Heiko asked
for the same handling as the PCIe SMMU [3].

Patch 7 needs [1]. Please hold the last patch until [2] is merged:
PD_PHP is off in deep suspend and the SMMU resumes in bypass (GBPA read
as 0).

Tested on an Orange Pi 5 (RK3588S), 7.3-based with [2] (my Tested-by
is [4]):
- SATA0 root, GMAC1 and a USB3 disk translated: 1 GiB sha256-checked
  on each; three reboots; no SMMU events or bus errors;
- deep suspend 3/3 with all three translated; s2idle 3/3 with USB3OTG_2
  and GMAC1. TF-A v2.15 kept the StreamIDs; patch 6 restored six zeroed
  for the test (pm_test=core).
Not tested: GMAC0, SATA1/2, the series without [2], the reset (no
driver uses it).

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

[1] https://lore.kernel.org/r/20261113-smmu-v3-pcie-pd-v3-0-39eb4f919529@gmail.com
[2] https://lore.kernel.org/r/20260929034510.2023173-1-praan@google.com
[3] https://lore.kernel.org/r/9_7qTfdNSViwtNUGq9D13w@sntech.de
[4] https://lore.kernel.org/r/179455903885.2418534.14656921897583011972@gmail.com

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Arun Iyengar (9):
      dt-bindings: net: rockchip-dwmac: Allow iommus
      dt-bindings: ata: rockchip,dwc-ahci: Allow iommus
      dt-bindings: soc: rockchip: grf: Allow a clock for the RK3588 PHP GRF
      soc: rockchip: grf: Assign the StreamIDs of the RK3588 PHP SMMU masters
      arm64: dts: rockchip: Add the PHP GRF clock on RK3588
      soc: rockchip: grf: Restore the RK3588 PHP StreamIDs after system suspend
      arm64: dts: rockchip: Add the clock and reset of the RK3588 PHP SMMU
      arm64: dts: rockchip: Attach the masters of the RK3588 PHP SMMU
      arm64: dts: rockchip: Enable the RK3588 PHP SMMU

 .../devicetree/bindings/ata/rockchip,dwc-ahci.yaml |   3 +
 .../devicetree/bindings/net/rockchip-dwmac.yaml    |   3 +
 .../devicetree/bindings/soc/rockchip/grf.yaml      |  12 ++-
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |   8 +-
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi     |   2 +
 drivers/soc/rockchip/grf.c                         | 103 +++++++++++++++++++++
 6 files changed, 128 insertions(+), 3 deletions(-)
---
base-commit: c3baae5f1a15645cddadcb2b9abddef5df291f59
change-id: 20261113-mmu600-php-0367fe7f1609
prerequisite-message-id: <20261113-smmu-v3-pcie-pd-v3-0-39eb4f919529@gmail.com>
prerequisite-patch-id: 51134fb38514fa92f20d3831e7905b02c7fbaae6
prerequisite-patch-id: c59ab0be12ec964dc1698dfa3e0d5bfae82d0c54
prerequisite-patch-id: 845e9980a7e0de45c746b7d8b6fd439033e08fdd

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


