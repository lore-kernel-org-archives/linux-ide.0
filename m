From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 9/9] ARM: bcm63138: Enable SATA AHCI and PHY
Date: Thu, 20 Sep 2018 12:16:46 -0700
Message-ID: <20180920191646.18198-13-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kishon Vijay Abraham I <kishon@ti.com>, Al Cooper <alcooperx@gmail.com>, Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>, "open list:LIBATA SUBSYSTEM Serial and
        Parallel ATA drivers" <linux-ide@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org

The Broadcom BCM963138DVT board has an eSATA port which is fully
functional, turn on the AHCI controller and the companion SATA PHY.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm963138dvt.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/bcm963138dvt.dts b/arch/arm/boot/dts/bcm963138dvt.dts
index c61673638fa8..8dca97eeaf57 100644
--- a/arch/arm/boot/dts/bcm963138dvt.dts
+++ b/arch/arm/boot/dts/bcm963138dvt.dts
@@ -41,3 +41,11 @@
 		brcm,nand-oob-sectors-size = <16>;
 	};
 };
+
+&ahci {
+	status = "okay";
+};
+
+&sata_phy {
+	status = "okay";
+};
-- 
2.17.1
