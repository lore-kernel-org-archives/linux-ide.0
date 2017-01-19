From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 14/14] ARM: davinci: remove BUG_ON() from da850_register_sata()
Date: Thu, 19 Jan 2017 14:29:48 +0100
Message-ID: <1484832588-18413-15-git-send-email-bgolaszewski@baylibre.com>
References: <1484832588-18413-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484832588-18413-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-ide@vger.kernel.org

The ahci driver now supports other refclk clock rates.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index cfceb32..7cf529f 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -1080,9 +1080,6 @@ int __init da850_register_sata(unsigned long refclkpn)
 {
 	int ret;
 
-	/* please see comment in drivers/ata/ahci_da850.c */
-	BUG_ON(refclkpn != 100 * 1000 * 1000);
-
 	ret = da850_register_sata_refclk(refclkpn);
 	if (ret)
 		return ret;
-- 
2.9.3
