From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 2/3] Documentation: bindings: Add the regulator property to the sub-nodes AHCI bindings
Date: Sat, 27 Dec 2014 11:34:42 +0100
Message-ID: <1419676483-10346-3-git-send-email-gregory.clement@free-electrons.com>
References: <1419676483-10346-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419676483-10346-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>
List-Id: linux-ide@vger.kernel.org

It is now possible to use a regulator property for each port of the
AHCI controller.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 4ab09f2202d4..6be531a328ae 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -38,8 +38,9 @@ Required properties when using sub-nodes:
 
 Sub-nodes required properties:
 - reg               : the port number
+And at least one of the following properties:
 - phys              : reference to the SATA PHY node
-
+- target-supply     : regulator for SATA target power
 
 Examples:
         sata@ffe08000 {
-- 
1.9.1
