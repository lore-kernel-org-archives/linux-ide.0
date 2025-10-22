Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BBD26B08F;
	Wed, 22 Oct 2025 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761174272; cv=none; b=gzNGkbAxEmwK6+qnaxZenw0XT6AFNx1vGPP/aWtU/MLG7lMQf9Kw/nmknOulUm5GXqpBNqqXura0lOUUz/NJ0rXbk0SdDtajWd7ICgdKAUZec3hi/ZZCGoB+zfsdkKT2sB0ekX1wTPoBwbQxHIRNYKjoMBZlkX4rTuMezqo8GAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761174272; c=relaxed/simple;
	bh=7w/ZxsXTzQxxcfAjoetuQStQP2bHZ/+KT1DPSQY/Qic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7uEfJ6KFSp6JBFiwwrVyxC/XZZDOVBvJc2IrU1iEeCOB6NiblRy6qsrHaASu63GDdoBmgwSAyN3OoH6PsYuas6ywDWu9dqqYmLyLeHgqnZHqmqKjjv0ZqGuE5Elw1Nxc4xyVxdowlhnTouXUcKsJ5LLdpk2nDC+TpX2nelhOzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWDTSCqg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWDTSCqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B92C4CEE7;
	Wed, 22 Oct 2025 23:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761174271;
	bh=7w/ZxsXTzQxxcfAjoetuQStQP2bHZ/+KT1DPSQY/Qic=;
	h=From:To:Cc:Subject:Date:From;
	b=iWDTSCqg6MCNdlWH+DfN/IbQcvo9qYaMlkqso9av5hFO3pcNRbzY/3ZZobiq3Coe5
	 PDZVpKVpG0nRTGC/D/4lfa08O8f9yMPOLDVpUeGB25e3EYmIWSQWbad4Hy/fUR3gOI
	 WixrYywzV3+HVdQS3gWjI3XdWWBclTH1K1Rmh0qbhW2KuLGXeVG7vIC35WEKhRG8WB
	 MY7TpURwiw77Oe5no90nlV4fPS4qqkmLDBbI5csqRW8K+46UVKCn2S4OnHsLBOJ7RB
	 eflCzxtNaWpPD/dRKsaqnNWV2euM3upg85o9gw+WYSc82eC5SCAscepC8cu9ioY5ir
	 UPtIyJBqZEqPQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ata: snps,dwc-ahci: Allow 'iommus' property
Date: Wed, 22 Oct 2025 18:04:21 -0500
Message-ID: <20251022230422.423230-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AMD Seattle DWC AHCI is behind an IOMMU and has 1-3 entries, so add
the 'iommus' property. There's not a specific compatible, so we can't
limit it to Seattle.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
index 4c848fcb5a5d..7707cbed2260 100644
--- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
@@ -33,6 +33,10 @@ properties:
       - description: SPEAr1340 AHCI SATA device
         const: snps,spear-ahci
 
+  iommus:
+    minItems: 1
+    maxItems: 3
+
 patternProperties:
   "^sata-port@[0-9a-e]$":
     $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
-- 
2.51.0

