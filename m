From: Stephan Linz <linz@li-pro.net>
Subject: [PATCH v4 6/7] parisc: use the new LED disk activity trigger
Date: Fri, 10 Jun 2016 08:00:01 +0200
Message-ID: <20160610060021.12382-6-linz@li-pro.net>
References: <20160610060021.12382-1-linz@li-pro.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:63068 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbcFJGCd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jun 2016 02:02:33 -0400
In-Reply-To: <20160610060021.12382-1-linz@li-pro.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Stephan Linz <linz@li-pro.net>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org

- platform: rename 'ide-disk' to 'disk-activity'

Signed-off-by: Stephan Linz <linz@li-pro.net>
---
 arch/parisc/configs/generic-32bit_defconfig | 2 +-
 arch/parisc/configs/generic-64bit_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/configs/generic-32bit_defconfig
index 5b04d70..8688ba7 100644
--- a/arch/parisc/configs/generic-32bit_defconfig
+++ b/arch/parisc/configs/generic-32bit_defconfig
@@ -214,7 +214,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_DMADEVICES=y
diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/configs/generic-64bit_defconfig
index e945c08..7e07926 100644
--- a/arch/parisc/configs/generic-64bit_defconfig
+++ b/arch/parisc/configs/generic-64bit_defconfig
@@ -231,7 +231,7 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_ONESHOT=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=m
 CONFIG_LEDS_TRIGGER_BACKLIGHT=m
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
-- 
2.8.4

