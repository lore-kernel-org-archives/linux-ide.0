From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH] ATA: Debugging options for the ATA subsystem
Date: Wed, 8 Jun 2011 11:48:01 +0530
Message-ID: <1edabe459c04313f2e9bb4282a7bea208272e618.1307513666.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:39825 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752104Ab1FHGSY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2011 02:18:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@st.com>

This adds Kconfig options for DEBUG and VERBOSE_DEBUG to the ATA subsystem

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/ata/Kconfig  |   14 ++++++++++++++
 drivers/ata/Makefile |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 75afa75..d527fbe 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -30,6 +30,20 @@ menuconfig ATA
 
 if ATA
 
+config ATA_DEBUG
+        bool "ATA debugging"
+        help
+          This is an option for use by developers; most people should
+          say N here.  This enables ATA core and driver debugging.
+
+config ATA_VDEBUG
+        bool "ATA verbose debugging"
+        depends on ATA_DEBUG != n
+        help
+          This is an option for use by developers; most people should
+          say N here.  This enables deeper (more verbose) debugging of
+          the ATA core and drivers.
+
 config ATA_NONSTANDARD
        bool
        default n
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 8ac64e1..d0b95a7 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,3 +1,5 @@
+ccflags-$(CONFIG_ATA_DEBUG)  := -DDEBUG
+ccflags-$(CONFIG_ATA_VDEBUG) += -DVERBOSE_DEBUG
 
 obj-$(CONFIG_ATA)		+= libata.o
 
-- 
1.7.2.2

