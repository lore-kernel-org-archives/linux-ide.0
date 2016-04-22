From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 5/5] dt-bindings: ata: add compatible string for Armada 8K to ahci-platform
Date: Fri, 22 Apr 2016 16:32:41 +0200
Message-ID: <1461335561-18363-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41763 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754379AbcDVOcu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Apr 2016 10:32:50 -0400
In-Reply-To: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>
Cc: linux-ide@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

In order to support the AHCI controller found in the Marvell Armada
7K/8K, a new compatible string is introduced in the Device Tree
binding for AHCI platform controllers.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 30df832..6b5acb7 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -15,6 +15,7 @@ Required properties:
   - "ibm,476gtr-ahci"
   - "marvell,armada-380-ahci"
   - "marvell,armada-3700-ahci"
+  - "marvell,armada-8k-ahci"
   - "snps,dwc-ahci"
   - "snps,exynos5440-ahci"
   - "snps,spear-ahci"
-- 
2.6.4

