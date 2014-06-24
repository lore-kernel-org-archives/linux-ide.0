From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH v3 4/8] dt-bindings: ata: add ahci_imx electrical properties
Date: Tue, 24 Jun 2014 11:19:42 +0100
Message-ID: <E1WzNpG-0005ds-P3@rmk-PC.arm.linux.org.uk>
References: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140624101901.GL32514-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Add the documentation for the electrical properties for the iMX SATA
controller.  There are many values for these, and listing them would
be error prone.  Refer readers to the device documentation and driver
source code for these details.

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 Documentation/devicetree/bindings/ata/imx-sata.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/imx-sata.txt b/Documentation/devicetree/bindings/ata/imx-sata.txt
index aeb99dd986b0..a13f0f603776 100644
--- a/Documentation/devicetree/bindings/ata/imx-sata.txt
+++ b/Documentation/devicetree/bindings/ata/imx-sata.txt
@@ -13,6 +13,14 @@ with some special extensions at integration level.
   required entry in clock-names
 - clock-names : should include "sata", "sata_ref" and "ahb" entries
 
+Optional properties:
+- fsl,transmit-level-mV : transmit voltage level, in millivolts.
+- fsl,transmit-boost-mdB : transmit boost level, in milli-decibels
+- fsl,transmit-atten-16ths : transmit attenuation, in 16ths
+- fsl,receive-eq-mdB : receive equalisation, in milli-decibels
+  Please refer to the technical documentation or the driver source code
+  for the list of legal values for these options.
+
 Examples:
 
 sata@02200000 {
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
