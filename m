From: Elias Oltmanns <oltmanns@uni-bonn.de>
Subject: How to activate pata support of ata_piix in vanilla 2.6.18?
Date: Thu, 28 Sep 2006 14:11:46 +0200
Message-ID: <87slicw5q5.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.uni-bonn.de ([131.220.15.112]:52205 "EHLO uni-bonn.de")
	by vger.kernel.org with ESMTP id S1751795AbWI1MMC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Sep 2006 08:12:02 -0400
Received: from [217.232.122.133] (account oltmanns HELO denkblock.local)
  by uni-bonn.de (CommuniGate Pro SMTP 5.0.8)
  with ESMTPSA id 37048668 for linux-ide@vger.kernel.org; Thu, 28 Sep 2006 14:12:00 +0200
Received: from eo by denkblock.local with local (Exim 4.62)
	(envelope-from <eo@denkblock.local>)
	id 1GSujz-00029N-07
	for linux-ide@vger.kernel.org; Thu, 28 Sep 2006 14:11:48 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

sorry for bothering you with an ordinary user question.

Although I've applied the mini patch shown below to vanilla 2.6.18,
ata_piix apparently couldn't handle my hard drive on an IBM X40 with
ICH4-M chipset.

--8<---------------cut here---------------start------------->8---
diff -Nur linux-2.6.18/include/linux/libata.h linux/include/linux/libata.h
--- linux-2.6.18/include/linux/libata.h
+++ linux/include/linux/libata.h
@@ -44,7 +44,7 @@
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */
-#undef ATA_ENABLE_PATA		/* define to enable PATA support in some
+#define ATA_ENABLE_PATA	/* define to enable PATA support in some
 				 * low-level drivers */
 
 
--8<---------------cut here---------------end--------------->8---

A git checkout of libata-dev.git worked out of the
box. My question is whether pata support in ata_piix was intentionally
not included in mainline as of 2.6.18 (even when ATA_ENABLE_PATA is
set), or if there may be a bug.

Regards,

Elias
