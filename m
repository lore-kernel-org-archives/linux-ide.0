Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039366;
	b=uVSBvDRNWpWODBkFpH/SX3SKrUyi2GmA/VLYPNDNh26CslbGQKLNBnxgADdqbrML1vQN
	 DVU/2En088d0B8ZoWB7or65BA92WQg6TQQZYX7DNB7ScotWDHQDKM9fWskF0/59dynOOk
	 McPvgO4KfWGN+nLmSxkXsaoq2Jt83SHAsgSGlFUA/AEvV0TLo2EqEbfyTrbvq3L/ybVyf
	 uzqqJk4fPXbsl2RW4YOIiMgk4CSrGHrozphy65fEWc2lBlb6fDkIfh/Z5xg7ZjiN9zfAV
	 AP7wOIg12BHvCutMZDVJTOzpBdZPGuGF7eKexYxrud3PBLLbujC0V6efD5gRlNdzVww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039366;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=hGqeu2xbMnoE0Rt6DQ1E+iwd2CSMeKN+5rvls1JxyJk=;
	b=FEm1bY9p3UqnxC0zt268vRKljREeDQq2DpmN8k860BcT12yWCcEI38w7qTgeSKR6DTcP
	 Xs3GB8WVEwxZTANVtIDVAC5tSHeZde5VTfZ+Q/Bv5NKCryVGFySw6XhAfCmlWgI0lLhzN
	 2/Nplc+J4dSJYIHgEP1AlZrc5ykE0IuVkGO4YourvZlavsaAVOMpAGAi85umftzrv6dNT
	 s4ki4IreiXi/J6sKN6/YSf4QALjVzl9g1MW65VHHeYrkY7QBA+fmkRqsvCj5NTeP1teGQ
	 UtgeFNZ+OFqecLgfebmH7VU2J+LYan6OFf8pFGuZo/1af5B/bWMYIn0jKmJPcRCXOmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EkEknSoA;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37166606A31E
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 18:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37166606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EkEknSoA
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so1200421a12.2
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 11:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039365; x=1793644165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hGqeu2xbMnoE0Rt6DQ1E+iwd2CSMeKN+5rvls1JxyJk=;
        b=OkfR0UumdKztXC3ewzrUxb+9XKqvg/jUBTwJQFaOmBfYK2vqFV4ra7aJ+cjg/gMmUO
         9/qtU3SQwICo8CEnWsZHa/v7ZQ4G68QYcSkGjVylsNhG4CLggEjIRKrEh1520Pt5arhp
         SMkYLGW4s8rJ1NZm4+846ztaR7bTUmB10u7OAiXVVn233uzLFyHmiUOguzDmYjOmVu8F
         zOSQxizE2t8zPAqHjI9PaOYBOPbun3gOq0ByKxDVD7sbGJON5ejxw6KPa1vFtcmlyhfv
         Yd3fkHZj5DW4g9X0BJybMqNDcV2eBj8MOzeUsbzM/iUwttsdkJbvkKd0bbSKOZAGbn5o
         4r3A==
X-Forwarded-Encrypted: i=1; AKwUvBwwmWqI7hVdyHFEVkF+DjS8EUq2yb7efz+M36RFvlLmwleZPRxX4mQKIwZ6MyWvGABRDO9HI6rgeKA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbmFbD42WdBaThgK3MAR/sd2ZJA+3kuYZ9cyq0ceq2tVDk8pIl
	KRuFwFarKov/5gKL0dL2AFDPOthYVkMrW3rblwmqa0bMsOczuW4LbcPN9idRlkH3bSO7xvdnm7j
	60EfIDPx6QmIp174piv+s3oGkSxKlVe4X90r1a7fMTib4XmrTdYS1g3ouJaK3KgoFXDzg+7lfc7
	IX5gjNsjsI0aefvG+BnxegL/JYdK5Bd8E9pktASQlH7Kl4B3mfdwO1uP9MtjCLpCKb4c3p54OZF
	TftbYx6xdFrU3I+BiyzL1Y=
X-Gm-Gg: AYBFou1mqznIrXIDhVfAcbi7b1eCk0fiN1X5gujoU+73WKg8kB8iFb7eyzWSd2nKFUp
	L57rsGUvOGgm3wpQskrKYD8tzonNFOLuj1qikF057wMQblKTgxnJSEE9srlUYM/uZk43bzHI7KQ
	6HyWg+RVRr4tDAAQOIt/XrmhuJI8EYp6sRzhyPRBGzvce6/6nu+rQwytZZlwzEZYSahwIU7DPu7
	edN/GsnBvlgevYMbE7N9FExrJyizOF1Jo6irTjlnd5H9YwqPhXlockFtC7AJkZiHCBZ9rciXxl3
	aYP4jhJpOM7jRDySbKIjH6lSS21B71TEAVEV8yz50mfs028lcjlzLeeJUYk5bAUhwI98NnehbEP
	3GWWZMCc7UhSb39TXlifQR1Fq0vLFeYoDkhwgeQ7PLKegLALgIXyD178OhRLoNjtb/bj2b0hIfa
	5SFmOQqDwchc9ZKtyIwetVDcW4f2cI97E9D5ypv5hu
X-Received: by 2002:a17:90b:3141:b0:3ac:9a54:e3ce with SMTP id 98e67ed59e1d1-3adeafb073fmr6251539a91.63.1793039365343;
        Mon, 26 Oct 2026 11:29:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae4063d1e9sm260796a91.7.2026.10.26.11.29.24
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:29:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36998507c13so2392654eec.0
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793039364; x=1793644164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hGqeu2xbMnoE0Rt6DQ1E+iwd2CSMeKN+5rvls1JxyJk=;
        b=EkEknSoAd14g9rRGILFvsZzS5deAAhjeegEQlHVP21tfStxDdR1k3SA85rKQ7GtJPl
         exhJTSenUj0mOD3Oar+9yidiO0D4Dlx9DnKdeZJ0HJMQ84i2JEdK25RKzCvqCOb6BbSg
         InNAf4NO7MqUWJusyBxTZGL6+HVLPyEFjad54=
X-Forwarded-Encrypted: i=1; AKwUvBzLoUkEMauozslteTuKdNYLZsVywH6lhDUg0/gOtZgemjWISTWJ7GQlsQbyxwHYSUgbDrpjlY9KAQ8=@vger.kernel.org
X-Received: by 2002:a05:693c:8943:10b0:366:fbdb:2070 with SMTP id 5a478bee46e88-369e84c7e51mr11553949eec.34.1793039363647;
        Mon, 26 Oct 2026 11:29:23 -0700 (PDT)
X-Received: by 2002:a05:693c:8943:10b0:366:fbdb:2070 with SMTP id 5a478bee46e88-369e84c7e51mr11553896eec.34.1793039362799;
        Mon, 26 Oct 2026 11:29:22 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a01fa4c58sm24657259eec.21.2026.10.26.11.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:29:22 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
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
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM ARCHITECTURE),
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH v2 0/6] Fix SATA support for NSP SoCs
Date: Mon, 26 Oct 2026 11:28:50 -0700
Message-ID: <20261026182856.3168686-1-florian.fainelli@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

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

Changes in v2:

- addressed Damien's comment: comment line too long, imbalanced IDM call
  sequence in suspend/resume compared to probe

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

