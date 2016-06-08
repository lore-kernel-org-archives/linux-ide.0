From: Stephan Linz <linz@li-pro.net>
Subject: [PATCH v3 7/7] unicore32: use the new LED disk activity trigger
Date: Thu,  9 Jun 2016 00:29:42 +0200
Message-ID: <20160608223000.433-7-linz@li-pro.net>
References: <20160608223000.433-1-linz@li-pro.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:34989 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425651AbcFHWb6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2016 18:31:58 -0400
In-Reply-To: <20160608223000.433-1-linz@li-pro.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Stephan Linz <linz@li-pro.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org

- platform: rename 'ide-disk' to 'disk-activity'
- defconfig: rename 'LEDS_TRIGGER_IDE_DISK' to 'LEDS_TRIGGER_DISK'

Signed-off-by: Stephan Linz <linz@li-pro.net>
---
 arch/unicore32/configs/unicore32_defconfig | 2 +-
 arch/unicore32/kernel/gpio.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/unicore32/configs/unicore32_defconfig b/arch/unicore32/configs/unicore32_defconfig
index 45f47f8..aebd01f 100644
--- a/arch/unicore32/configs/unicore32_defconfig
+++ b/arch/unicore32/configs/unicore32_defconfig
@@ -161,7 +161,7 @@ CONFIG_LEDS_GPIO=y
 #	LED Triggers
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 
 #	Real Time Clock
diff --git a/arch/unicore32/kernel/gpio.c b/arch/unicore32/kernel/gpio.c
index 49347a0..bf164bb 100644
--- a/arch/unicore32/kernel/gpio.c
+++ b/arch/unicore32/kernel/gpio.c
@@ -27,7 +27,7 @@ static const struct gpio_led puv3_gpio_leds[] = {
 	{ .name = "cpuhealth", .gpio = GPO_CPU_HEALTH, .active_low = 0,
 		.default_trigger = "heartbeat",	},
 	{ .name = "hdd_led", .gpio = GPO_HDD_LED, .active_low = 1,
-		.default_trigger = "ide-disk", },
+		.default_trigger = "disk-activity", },
 };
 
 static const struct gpio_led_platform_data puv3_gpio_led_data = {
-- 
2.8.4

