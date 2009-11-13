From: Robert Hancock <hancockrwd@gmail.com>
Subject: [PATCH] libata: remove experimental tag on PATA drivers
Date: Thu, 12 Nov 2009 20:13:40 -0600
Message-ID: <4AFCC0D4.9020708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:54351 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbZKMCNv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Nov 2009 21:13:51 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Remove the experimental tag on Parallel ATA drivers. Though some of the
individual PATA drivers are still marked as experimental, as a group they can
hardly be considered to be, given they've been used in various distros for some
time.

Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index f2df6e2..33133c6 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig ATA
-	tristate "Serial ATA (prod) and Parallel ATA (experimental) drivers"
+	tristate "Serial ATA and Parallel ATA drivers"
 	depends on HAS_IOMEM
 	depends on BLOCK
 	depends on !(M32R || M68K) || BROKEN
