From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] ide: note that IDE generic may prevent other drivers from
 attaching
Date: Fri, 12 Sep 2008 10:38:56 +0200
Message-ID: <48CA2AA0.8000302@kernel.org>
References: <WorldClient-F200808221729.AA29360172@butn.net> <48B92399.6010808@kernel.org> <WorldClient-F200808302142.AA42270030@butn.net> <48BBB248.7090904@kernel.org> <WorldClient-F200809062012.AA12270277@butn.net> <WorldClient-F200809062331.AA31030286@butn.net> <48C50E1F.9040407@kernel.org> <WorldClient-F200809081343.AA43510194@butn.net> <48C51258.5080307@kernel.org> <WorldClient-F200809120953.AA53480062@butn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51028 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613AbYILIkr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Sep 2008 04:40:47 -0400
In-Reply-To: <WorldClient-F200809120953.AA53480062@butn.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: xerces8 <xerces8@butn.net>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, stein@hermes.si

Enabling IDE generic may prevent ATA controllers located on legacy
ports from being attached to more proper driver or can prevent other
controllers which share the IRQ from working.  Note it in the help
message.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ide/Kconfig |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index fc735ab..5e5b2d3 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -292,6 +292,20 @@ config IDE_GENERIC
 	tristate "generic/default IDE chipset support"
 	depends on ALPHA || X86 || IA64 || M32R || MIPS
 	help
+	  This is the generic IDE driver.  This driver attaches to the
+	  fixed legacy ports (e.g. on PCs 0x1f0/0x170, 0x1e8/0x168 and
+	  so on).  Please note that if this driver is built into the
+	  kernel or loaded before other ATA (IDE or libata) drivers
+	  and the controller is located at legacy ports, this driver
+	  will grab those ports and thus can prevent the controller
+	  specific driver from attaching.
+
+	  Also, currently, IDE generic doesn't allow IRQ sharing
+	  meaning that the IRQs it grabs won't be available to other
+	  controllers sharing those IRQs which usually makes drivers
+	  for those controllers fail.  Generally, it's not a good idea
+	  to load IDE generic driver on modern systems.
+
 	  If unsure, say N.
 
 config BLK_DEV_PLATFORM
