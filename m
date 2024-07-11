Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52AC15217E;
	Thu, 11 Jul 2024 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686612; cv=none; b=VrojCJ4KkYzwhVEaIKtt3Mt0prtNa3TaAfHGSMdFmwDosRESaHfQlw5OSCSnoPwgOg8gLDQjA2NiO8FWKorESS+ybkNwok6gThn2oELo949wS3VOvJXFLic+hazXUu2FTt80xtTt3N9rGSbqSRiBI78Ka3Uup7Szaor/Gy9evAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686612; c=relaxed/simple;
	bh=xat3hFJf8nzs6IJ6JPKIRo7EhEkdfMnU6EmQBLqdZkc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RIZxuzn1B4IFfO9PZ1Jhxxl8W4beAOyLOAZ0N5jq48NselfpNe0HbSU0HlrCUeWhX9xGexTOO8p/25uxR08J1DnzT9Nb8GNeoGzVC+ZqKmHNNao5Nu2IXK71Wah47VZM+NGaLcwjPt/9PUDOGXdQvr/4hzVKd/yqM13aYlh0OGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 209661A0300;
	Thu, 11 Jul 2024 10:30:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DBE651A1BE2;
	Thu, 11 Jul 2024 10:30:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0839E183ACAF;
	Thu, 11 Jul 2024 16:30:06 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: tj@kernel.org,
	dlemoal@kernel.org,
	cassel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v1 0/4] Refine i.MX8QM SATA based on generic PHY callbacks
Date: Thu, 11 Jul 2024 16:11:54 +0800
Message-Id: <1720685518-20190-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Based on i.MX8QM HSIO PHY driver, refine i.MX8QM SATA driver by using PHY
interface.

[PATCH v1 1/4] dt-bindings: ata: Add i.MX8QM AHCI compatible string
[PATCH v1 2/4] ata: ahci_imx: Clean up code by using i.MX8Q HSIO PHY
[PATCH v1 3/4] ata: ahci_imx: Enlarge RX water mark for i.MX8QM SATA
[PATCH v1 4/4] ata: ahci_imx: Correct the email address

Documentation/devicetree/bindings/ata/imx-sata.yaml |  47 +++++++++++
drivers/ata/ahci_imx.c                              | 404 ++++++++++++++++++++++++-----------------------------------------------------------------
2 files changed, 155 insertions(+), 296 deletions(-)

