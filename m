From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH Resend] ATA: Debugging options for the ATA subsystem
Date: Thu, 9 Jun 2011 09:26:44 +0530
Message-ID: <e6eda088c6d3761ac4f5d1719489be61356e3a8a.1307591731.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:54206 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756365Ab1FID45 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2011 23:56:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: sshtylyov@mvista.com, Viresh Kumar <viresh.kumar@st.com>

This adds Kconfig options for DEBUG and VERBOSE_DEBUG to the ATA subsystem

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/ata/Kconfig  |   14 ++++++++++++++
 drivers/ata/Makefile |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 5dd1e4c..e1ac908 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -22,6 +22,20 @@ menuconfig ATA
 
 if ATA
 
+config ATA_DEBUG
+        bool "ATA debugging"
+        help
+          This is an option for use by developers; most people should
+          say N here.  This enables ATA core and driver debugging.
+
+config ATA_VDEBUG
+        bool "ATA verbose debugging"
+        depends on ATA_DEBUG
+        help
+          This is an option for use by developers; most people should
+          say N here.  This enables deeper (more verbose) debugging of
+          the ATA core and drivers.
+
 config ATA_NONSTANDARD
        bool
        default n
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 0da42cb..6dfaeb9 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,3 +1,5 @@
+ccflags-$(CONFIG_ATA_DEBUG)  := -DDEBUG
+ccflags-$(CONFIG_ATA_VDEBUG) += -DVERBOSE_DEBUG
 
 obj-$(CONFIG_ATA)		+= libata.o
 
-- 
1.7.2.2

