From: Jeff Garzik <jeff@garzik.org>
Subject: [git patch] libata build fix
Date: Sat, 3 Mar 2007 10:39:17 -0500
Message-ID: <20070303153917.GA8938@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:36825 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030434AbXCCPjT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Mar 2007 10:39:19 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


A merge mistake slipped upstream.

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/pata_jmicron.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

Jeff Garzik (1):
      [libata] pata_jmicron: build fix

diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 033319e..43763c9 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -244,7 +244,6 @@ static void __exit jmicron_exit(void)
 {
 	pci_unregister_driver(&jmicron_pci_driver);
 }
-#endif
 
 module_init(jmicron_init);
 module_exit(jmicron_exit);
