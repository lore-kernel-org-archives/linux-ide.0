Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309128;
	b=ychEDqHBRA/cRHN7zQBrAe4oLCPILCcRZEuwWMYTA7j3xFMzU3cz8/6h3TLNviRy7Jcz
	 KH+heasa/pk9e5dvqOyPnWIl4/BKQfH+KQvQoJRzWz/2W/ULPEurYG7rpy8RVaNzA9ks0
	 zmd5xXvNY6ibIxkoBTtpZFFXadS4ph9m7ZlqQeMp9EBJ2nXiG38VCsDlhdqBDa/O5hnF3
	 kOi74S0HVuPwvkVo/bfeXxDV0XJtEx541cqu42QwiOZGEN6ZeVWiXi9+WBhGvu+V7uIMy
	 nP6GQSN1kmxwLcWQ17lt4gu93WbeG5nQWK0zfP9gOZX5C1Fh0Ty1hiX/we9Ny7UKmOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309128;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=Hsj4il6cwMzAfFBtIiOor6rUHPJ7kpQPufbre1PFxQc=;
	b=GMuxq3hm0mX476IYWD75hY1q3ysZNdyBTYZU5IEur3xJiLe4D+b1vFtzJCsDos85pWaS
	 zfv5SPNsCzuf0DQW9P/xNWwHZSVa4Y5UOlb/9qVCjQm4FYTEI/+tyRvZX3gDY7X0Be+p0
	 F+OtHlkaDYfNKMqEHB2BDiVNPIgiIds7VHjZLYqBIdy9AfKDxTOdgaRO35nk6bxeB5TEi
	 BEumAChyBNk2jUvv9Wp7KxMMTTLXGbQcDpHJcsH10CFZZg7NggmzUfPMXiun4WngcPSCW
	 VZCFWw4ojMKNzEL1+lbf5IQe7OEp9qy6BSKKkDTtzLIRhgWa/cVgvv0SVRafM7DZmhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VqBP6e8V;
	arc=none smtp.remote-ip=74.125.82.99
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F91606A32E
	for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 21:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39F91606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VqBP6e8V
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-1a3c08d6928so37489c88.0
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 14:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309127; x=1793913927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hsj4il6cwMzAfFBtIiOor6rUHPJ7kpQPufbre1PFxQc=;
        b=ygnA5xWro1QKZSSVhNSuznhENbvU/XuH+ITD9juNg9347OxXBhk8SDLB99nfQAsMLC
         suyGtiMomhsziuMgs7ZymS2fREQnfkRKIBEdUfoDPIgWvZAWIEDhN6tSIUM9IpX0NP9D
         witZca+fm0bbWBlcq9nsVSMhukUbtEtDdMf6Dyc4iL+3lNh6B/uvm4zn011ger/gq15l
         V+oq7Leor9hFtQ1baZyAQoqiLj1lbSExy2blLUgdWYrWYh4JF+/rFIQfv4WDoRGOAIX1
         EpOzHWV7cLjHRobddrCWPipcDqdeqDrJNlV2P2jAonZC3bKBs3IsQUtmKr1RmMwFMK4l
         A+xQ==
X-Forwarded-Encrypted: i=1; AKwUvByLzIouKeTEgl4zzMj/gcq04y7yuy4wy8cNbYJNtqQTXwSWYGp3Z1XMZ8nt085EFwVOhNgNP+3722Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7uT8AcBYZc+xy3c96jw+AKelNHzJA9V6aly3smAUjbOsxJ1FD
	+X76e7zWmHKMCNUPiEE3aTWTWBt3qxlQv1/KZb5fY7OCmWBkTe+Gn2Q6KgSmZYHDGtXy0Ann42n
	kic7gOSZTkuUAHNQcoXXw1l4y1Bw+PY8hOMq8HaEVH5vmkdxYQ61tuyvKB6YM/63myY8dgHxcBs
	QGqvr8MoS9gfdw98X+91Yg5YO9GUAQvHKSiM8LuGa/72qtnbQSzLgMB7gZBMlONcaAYbLfax6Y8
	K3MZ91q487p6rkRCrKjeHI=
X-Gm-Gg: AYBFou12HHqdntUE5KHzhpOUg4BHFCOELSDNaOSP+m14VBR3EO5n1C/MfQg5zPNPAB6
	Tet6+7t+DWQZWE2Stbo8+anWmPPnQgtymCbeWnF1MM45oovhUiUB1E9eG2H2fY/DsotKTN8EPip
	gJz6GD29GGWFCUr4PWYQF8Wnxdr5jfUf6DO/ziZQLJqTFQyTTiZT/0xrkxT4A0jzpBZRiiBah3S
	kIo9fmy+elNy5T6NKlg5O5PCWWKZgvxs4L9uW63nJlgpyEiz2G1vM8V4go7DSJL7pTqABbBssxF
	YfLcxFPEc1bsLxixw80k/ib1/UjNQ6YTIsaOaEuJ0kRPK0jUIuyAKqhz8dGXbLS2dB8vh/aCBgH
	URqhkQ7grd5wTIFLTebbGN3lk02IiV9W6RJGWZUmzQYbPvVzh9LmslgEIk1xO/VVnjzb3RBLx7R
	cORqmA/VmkYk0wU95D9q8yxWX0ZnwwcMaS7FewMJR0
X-Received: by 2002:a05:7023:904:b0:1a1:8974:593f with SMTP id a92af1059eb24-1ac5ceeff9emr356787c88.30.1793309125656;
        Thu, 29 Oct 2026 14:25:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1ac1b19c30fsm11291c88.17.2026.10.29.14.25.25
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:25:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c7a26f892so1919686d6.0
        for <linux-ide@vger.kernel.org>; Thu, 29 Oct 2026 14:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793309124; x=1793913924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hsj4il6cwMzAfFBtIiOor6rUHPJ7kpQPufbre1PFxQc=;
        b=VqBP6e8VEQ2KEiAgBWT6S1gLO6pIB9FkID86wAbT75o2ugVvv/tDkJ62/ahYWSTiRz
         9rI5s5UpE9IW6LMP9RXLg5z3/AI28Someu0k7JsQSpWDAhD9HGIb6UHIyoyEDs4Ud2NU
         UKDDGlGhb2xXVR4eQDvul39j/4vMhcCNREuLw=
X-Forwarded-Encrypted: i=1; AKwUvBzTBokWDO8eydQr8vgKP6Qn1/W1oVRrHas65SRQlAEsLccjsqCCSkV4Oy287t3cdthH8ZFNh4CHeY8=@vger.kernel.org
X-Received: by 2002:a05:6214:ca2:b0:91b:d948:c415 with SMTP id 6a1803df08f44-91ca4b78b78mr3774466d6.44.1793309124168;
        Thu, 29 Oct 2026 14:25:24 -0700 (PDT)
X-Received: by 2002:a05:6214:ca2:b0:91b:d948:c415 with SMTP id 6a1803df08f44-91ca4b78b78mr3774056d6.44.1793309123730;
        Thu, 29 Oct 2026 14:25:23 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca314fb6csm6384936d6.34.2026.10.29.14.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:25:23 -0700 (PDT)
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
Subject: [PATCH v4 0/6] Fix SATA support for NSP SoCs
Date: Thu, 29 Oct 2026 14:25:07 -0700
Message-ID: <20261029212513.4126083-1-florian.fainelli@broadcom.com>
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

Changes in v4:

- move entire allOf to the bottom, before "unevaluatedProperties" per
  Krzysztof's feedback

Changes in v3:

- actually submit the addressed feedback

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

 .../bindings/ata/brcm,sata-brcm.yaml          | 57 ++++++++++++-------
 arch/arm/boot/dts/broadcom/bcm-nsp.dtsi       |  7 ++-
 arch/arm/boot/dts/broadcom/bcm958625hr.dts    |  5 ++
 drivers/ata/ahci_brcm.c                       | 36 ++++++++++++
 drivers/phy/broadcom/phy-brcm-sata.c          |  5 +-
 5 files changed, 85 insertions(+), 25 deletions(-)

-- 
2.53.0

