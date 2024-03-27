Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694BD1514EF;
	Wed, 27 Mar 2024 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561783; cv=none; b=iecwDBlhFnBVBD1kS1ZGW/gDmDn9VoNr3zTqqHpZRYa0gXzozlN9oABHraBkEggxLoctHfVoi36UqONemTge3M9Q69fdElmwR2LYkrmm8Z4irbn6zW3XJboPtXJ1wLM6Pdbid/CuiU/8e1adpf5resOyy0GSYEmn96TTrEbufoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561783; c=relaxed/simple;
	bh=bHf3VadEp8hRcPYkpL8BQU6tGmuBex1DtcWENsPTlQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ghr4S2z7721hEVoSZwHNAYrRZmYKIR01mWOaF6SOYb9UoKgzrjSPWGI/vTSO4/q23eUQeF5tT4iraT2VH+kKPcVwsuVMWrXMBUdWzIp8PTW/GmY/Lly7QPgJiIcMyYxTcl0K3Zrey7M6WkOApXeI57Sjb41QJqy3Vta3z6CLMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC54C433C7;
	Wed, 27 Mar 2024 17:49:40 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ata: pata_macio: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:49:36 +0100
Message-Id: <20240327174936.519861-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI core in pci_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/ata/pata_macio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 4ac854f6b057..88b2e9817f49 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1371,9 +1371,6 @@ static struct pci_driver pata_macio_pci_driver = {
 	.suspend	= pata_macio_pci_suspend,
 	.resume		= pata_macio_pci_resume,
 #endif
-	.driver = {
-		.owner		= THIS_MODULE,
-	},
 };
 MODULE_DEVICE_TABLE(pci, pata_macio_pci_match);
 
-- 
2.34.1

