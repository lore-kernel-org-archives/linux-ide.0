From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 7/9] dt-bindings: ata: ahci-platform: document port-supply
Date: Fri, 13 Jul 2018 11:03:04 +0000
Message-ID: <1531479786-4911-8-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, maxime.ripard@free-electrons.com, robh+dt@kernel.org, tj@kernel.org, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-sunxi@googlegroups.com, thierry.reding@gmail.com, Corentin Labbe <clabbe@baylibre.com>, linux-arm-kernel@lists.infradead.org, icenowy@aosc.io
List-Id: linux-ide@vger.kernel.org

This patch document the new optional port-supply

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 47652521a6ed..40a636b9851e 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -31,6 +31,7 @@ Optional properties:
 - dma-coherent      : Present if dma operations are coherent
 - clocks            : a list of phandle + clock specifier pairs
 - target-supply     : regulator for SATA target power
+- port-supply       : regulator for SATA port
 - phys              : reference to the SATA PHY node
 - phy-names         : must be "sata-phy"
 - ahci-supply       : regulator for AHCI controller
@@ -51,6 +52,7 @@ Sub-nodes required properties:
 And at least one of the following properties:
 - phys		    : reference to the SATA PHY node
 - target-supply     : regulator for SATA target power
+- port-supply       : regulator for SATA port
 
 Examples:
         sata@ffe08000 {
-- 
2.16.4
