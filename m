From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 02/14] ARM: davinci_all_defconfig: enable SATA modules
Date: Tue, 17 Jan 2017 13:26:04 +0100
Message-ID: <1484655976-25382-3-git-send-email-bgolaszewski@baylibre.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37425 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbdAQM0p (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2017 07:26:45 -0500
Received: by mail-wm0-f42.google.com with SMTP id c206so220265110wme.0
        for <linux-ide@vger.kernel.org>; Tue, 17 Jan 2017 04:26:45 -0800 (PST)
In-Reply-To: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the da850-ahci driver to davinci defconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 8806754..a1b9c58 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -78,6 +78,8 @@ CONFIG_IDE=m
 CONFIG_BLK_DEV_PALMCHIP_BK3710=m
 CONFIG_SCSI=m
 CONFIG_BLK_DEV_SD=m
+CONFIG_ATA=m
+CONFIG_AHCI_DA850=m
 CONFIG_NETDEVICES=y
 CONFIG_NETCONSOLE=y
 CONFIG_TUN=m
-- 
2.9.3

