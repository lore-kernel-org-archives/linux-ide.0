Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F5F9F5;
	Mon, 12 Aug 2024 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429282; cv=none; b=upLnRpVZuFwGidwafasaSpqC7Kd984fLAn5T6jSxH1rO5KwcPH42IjFn4+OCZckMnXkg+WDpMXPAOTKK2kAD/goVmdyqhBS1JAQAQfKD3iSz+TK0I8fDLUGkkWeHdjniACPnI7YP1h9KO98HxNvebPM1pWlsx3GWKIX5BK7SD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429282; c=relaxed/simple;
	bh=BdlZO5l8sbl7H0gKrxwN/dhF+Q5IRWfupxidwr/qYxs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=b6VKf72fxJXe8c8S7CBTI3yfrPS9j8Yx/SI4T//Ot1RXs18t+Ym5AU67WubIyHL4+R9gWAGCoZZnTfN8s96eGYU3LVMPV78NflQ06cHEc5Oz9Bt+ZumUzGF9zwchkcGSRhqnpdD5rOF39+4iMk0nPC9zM5cLeh3Ge7bHeexhZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 63324200FDD;
	Mon, 12 Aug 2024 04:21:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 295FA200FCA;
	Mon, 12 Aug 2024 04:21:13 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 377FA183ACAC;
	Mon, 12 Aug 2024 10:21:11 +0800 (+08)
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
Subject: [PATCH v6 0/5] Refine i.MX8QM SATA based on generic PHY callbacks
Date: Mon, 12 Aug 2024 10:00:50 +0800
Message-Id: <1723428055-27021-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

V6 main changes:
- Add Frank's reviewed tag.
- Drop 32bit DMA limit commit, since the "dma-ranges" of DT can overcome
  this limitation.
- Correct the email-lists, incorrect used in v5.

V5 main changes:
Thanks for Niklas' kind help.
- Drop 32bit DMA limit commit, since the "dma-ranges" of DT can overcome
  this limitation.

V4 main changes:
Thanks for Niklas' comments.
- Update the commit message in #2 patch of v4.
- Split the clean up unrelated codes to #3 and #4 of v4.
- Remove the Cc: stable@vger.kernel.org and Fixes tag in #5 of v4.

V3 main changes:
- Use GENMASK() macro to define the _MASK.
- Refine the macro names.

V2 main changes:
- Add Rob's reviewed-by in the binding patch.
- Re-name the error out lables and new RXWM macro more descriptive.
- In #3 patch, add one fix tag, and CC stable kernel.

Based on i.MX8QM HSIO PHY driver, refine i.MX8QM SATA driver by using PHY
interface.

[PATCH v6 1/5] dt-bindings: ata: Add i.MX8QM AHCI compatible string
[PATCH v6 2/5] ata: ahci_imx: Clean up code by using i.MX8Q HSIO PHY
[PATCH v6 3/5] ata: ahci_imx: AHB clock rate setting is not required
[PATCH v6 4/5] ata: ahci_imx: Enlarge RX water mark for i.MX8QM SATA
[PATCH v6 5/5] ata: ahci_imx: Correct the email address

Documentation/devicetree/bindings/ata/imx-sata.yaml |  47 +++++++++++
drivers/ata/ahci_imx.c                              | 403 +++++++++++++++++++++++------------------------------------------------------------------
2 files changed, 152 insertions(+), 298 deletions(-)
