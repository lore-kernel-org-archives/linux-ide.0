From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 6/8] dt-bindings: ata: document ability to disable
 spread-spectrum clock
Date: Tue, 24 Jun 2014 11:19:53 +0100
Message-ID: <E1WzNpR-0005e1-0Y@rmk-PC.arm.linux.org.uk>
References: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Add documentation of the fsl,no-spread-spectrum option.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 Documentation/devicetree/bindings/ata/imx-sata.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/imx-sata.txt b/Documentation/devicetree/bindings/ata/imx-sata.txt
index a13f0f603776..fa511db18408 100644
--- a/Documentation/devicetree/bindings/ata/imx-sata.txt
+++ b/Documentation/devicetree/bindings/ata/imx-sata.txt
@@ -20,6 +20,8 @@ with some special extensions at integration level.
 - fsl,receive-eq-mdB : receive equalisation, in milli-decibels
   Please refer to the technical documentation or the driver source code
   for the list of legal values for these options.
+- fsl,no-spread-spectrum : disable spread-spectrum clocking on the SATA
+  link.
 
 Examples:
 
-- 
1.8.3.1

