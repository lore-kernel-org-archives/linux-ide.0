Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042284;
	b=n5+BoudG5RlTJ/Wwjre3JLxeAQU01N9oHxsnntpjPxQM+0ei0oGgUH/A+/3sKja7N+gd
	 0Kg0HjuerE9200QJw0ZmS9d7pda5KzCu3uHqDHuMEKCEiGZStptElfiSAzuBnAb/1DCV9
	 /VHSCf67uzYOaOtuTQDbbezYrROuhuXB2oP9n2KUsbUBtJzyV7KxYYhWMRDjUxN9jt03m
	 6E5ieSWW8iAiGGIJIfJQtp9Rsh09eO9SE2QKsyQgKDDHjUcGN/V73M7TERHRAxeL3QMLh
	 Iy+1LLzT+UfcBEFxHY6v4Fyu0V4ysukzlS67JD6IcUoUMc8X0hMZpd60fPXsnoM0SjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042284;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=0p/mlaTn2+IjGPmTD4Eg87y9QseS3N0pAeXCuAryT24=;
	b=SMLq7ZWVF1qG/gU2YOHkLd3TacECiEUQsEXe4TiwfydKeZtDNMqv/5rJgZhlGYquwBSf
	 IgXmWL64u1veaYdbW2BcM+JWC3Aq9CTSsUyM5sHXyCYIjADfu3f1zTrzqlzre7Ug07Hla
	 wLiUWMRv6xInhxDLoobhO3tpLwCmuH+JbvdMjOYyGNckw1FnGi4N5A7SRajmxtzWX4frl
	 +909LGYEWGpD/81zp2yh97s1moLE7q/Yo2/m+ht4kwgBc0FY25NtbhH3N8RuCWsPEynA6
	 FRclKfUHHi6Ntri4p24HqZH0bQ/OxRJ0XAMUZYnZZgET8YhOMMRiXj1ArgyvoLq/ZlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VnXo6gFW;
	arc=none smtp.remote-ip=209.85.214.225
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D043606A31A
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 19:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D043606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=VnXo6gFW
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2e9d1114320so25773765ad.3
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793042283; x=1793647083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0p/mlaTn2+IjGPmTD4Eg87y9QseS3N0pAeXCuAryT24=;
        b=q03XUxi5uCE6ynzTiFaS57XMBZmZUS4p+MiyjXl4KBkVfCmdaZgqx9ZDwtici/yYGD
         /P1ySSjF8y6YsWbf9WweyYo1gSAInE5b+uYWuG/MUFIFWo5i4zstOPsuxdOXVWTRemrG
         v53sINgKrIOFvvUKuay7ZnCdqSr2W0/bbHYV1cEQwAZFQQSUejtHFhJXBX3CIVpUvbVZ
         AN1rZjhcf+a/kXiW/p8S4Gyt3uNw8jHbm8z1BqY1l6hiXpTi2jQ1Ru5et9GROP3t4dMY
         ThuZ0Em+0FxJ7rnBAYBBbagKJG+I5mgGsbMFC+hufTL8KRcYSZBa7w9Zw/6JTtzk0z/Q
         AWPQ==
X-Forwarded-Encrypted: i=1; AKwUvByhTaDzdu0NINeHYHhKlKzvCLDQ4wmftJrhYUz51rQp5vdZdMc96qWSwQQwyAor46XO+CS5bohyXJs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJArRXYT8IU23D6NHNeRemvFg+lmbmRVh4qsSUhKh1KV99wicSb
	X+4Ecwa/PoyBNDImwLC37QlQNRNSVtzex/9xHW9ySsa6KP/Dal5kSNLe52BiPHNB9Gdg+CZYHLd
	qcQ3BQykXWHOOP/KvrhiGKuT/jGkTawav2XQM3TGHzYKU1q7XioPDbp8FsPFOAc+1xltMtozC75
	pCS1xirtSH5Ezx2wnyhXzmE0BG3tozmCI/TadJZKQhnQPp9hfVoSxolcYkzR8O0uTBJYFux2xKB
	gaUBjYgWFjTWwQxDeM+MFM=
X-Gm-Gg: AYBFou1GVEX8KQGNswDz1eso/5EhKRb4KheJY1lGO3CQtvgBz4bXr7NztUgTbCBD24N
	JzCJq6GRWMrq/XWf0rKYgNfzidJCX2VT0pdqvW/qCt8ptO/MBynCZbrkOUZtwV6yt7vXRENtvnf
	YaW+u71qBSBNRXMGFt59u7KJtD84WsFVAlxR1hYJ7Ov8j3AOPQY9FABBS/iLTAihmrSNoJ0E2Iu
	C9oNjAXFTvq5SoSoGINR7Ia6q+YnE62EcQSBR1yoG8O9ZXMU4+S/F5dGvtGzVN3u+2j3V/VUtwI
	+Dqu9cHLA2R5Qns4MUmW6yHhrXO1eKQlW5h2nzRqakq5NTV9JZEtKxm4p6CvwV8lpaR2hJ/tCiq
	mPtCFm6fYHGwSYd0zrNB4kDPY9TPUQNfGuDhL3J2pGxLMT0Dj0yM3bv+em/k1KIx8ml2bwl185Y
	UzfVgzENxPgz569K/AJup+lRndVNfAHnvIjgGgZUffg84=
X-Received: by 2002:a17:90a:dfcc:b0:3a8:6045:5a19 with SMTP id 98e67ed59e1d1-3adeafd0bb1mr6724174a91.37.1793042282937;
        Mon, 26 Oct 2026 12:18:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae40784dfasm317542a91.3.2026.10.26.12.18.02
        for <linux-ide@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:18:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91bb074ed1aso73704316d6.2
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793042282; x=1793647082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0p/mlaTn2+IjGPmTD4Eg87y9QseS3N0pAeXCuAryT24=;
        b=VnXo6gFWH9nAhmmymggKFZZTI+AkfpYAmNp7DrWbikPLFr5SiGjsQSuc3lllB84tLx
         dU+FbJGy7NMcOM/jvc4SaDcmLF4tVSFZGlYo8fUhVgOhQbZy6B4BMivewgIGGiYs1Yg2
         zNE2mrl698m/8EOSJjbcGWdoAKk85g98j9OAA=
X-Forwarded-Encrypted: i=1; AKwUvBxHgChdzAbm/6yV5IRuiwtGowJCnZRgTye5cGiaXMS9x3eOG647dmkKskC7LwwAmoLs20G4SB7tOb0=@vger.kernel.org
X-Received: by 2002:ac8:5f82:0:b0:536:11c5:1dc1 with SMTP id d75a77b69052e-5383b653983mr109739601cf.76.1793042281625;
        Mon, 26 Oct 2026 12:18:01 -0700 (PDT)
X-Received: by 2002:ac8:5f82:0:b0:536:11c5:1dc1 with SMTP id d75a77b69052e-5383b653983mr109739171cf.76.1793042281166;
        Mon, 26 Oct 2026 12:18:01 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c62063dacsm33430996d6.37.2026.10.26.12.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:18:00 -0700 (PDT)
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
Subject: [PATCH v3 0/6] Fix SATA support for NSP SoCs
Date: Mon, 26 Oct 2026 12:16:12 -0700
Message-ID: <20261026191618.3178830-1-florian.fainelli@broadcom.com>
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

 .../bindings/ata/brcm,sata-brcm.yaml          | 20 ++++++++++-
 arch/arm/boot/dts/broadcom/bcm-nsp.dtsi       |  7 ++--
 arch/arm/boot/dts/broadcom/bcm958625hr.dts    |  5 +++
 drivers/ata/ahci_brcm.c                       | 36 +++++++++++++++++++
 drivers/phy/broadcom/phy-brcm-sata.c          |  5 +--
 5 files changed, 67 insertions(+), 6 deletions(-)

-- 
2.53.0

