From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ay1xxx-ide: auide_{in|out}sw() should be static
Date: Fri, 6 Mar 2009 17:58:31 +0400
Message-ID: <200903061658.31139.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.79.90.228] ([213.79.90.228]:49509 "EHLO
	buildserver.ru.mvista.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754181AbZCFN6A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Mar 2009 08:58:00 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Make auide_{insw|outsw}() 'static' and mark them 'inline' as there's only one
call site for each: in the driver's {in|out}put_data() methods respectively...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent pata-2.6 series...

 drivers/ide/au1xxx-ide.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/ide/au1xxx-ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/au1xxx-ide.c
+++ linux-2.6/drivers/ide/au1xxx-ide.c
@@ -50,7 +50,7 @@ static _auide_hwif auide_hwif;
 
 #if defined(CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA)
 
-void auide_insw(unsigned long port, void *addr, u32 count)
+static inline void auide_insw(unsigned long port, void *addr, u32 count)
 {
 	_auide_hwif *ahwif = &auide_hwif;
 	chan_tab_t *ctp;
@@ -68,7 +68,7 @@ void auide_insw(unsigned long port, void
 	ctp->cur_ptr = au1xxx_ddma_get_nextptr_virt(dp);
 }
 
-void auide_outsw(unsigned long port, void *addr, u32 count)
+static inline void auide_outsw(unsigned long port, void *addr, u32 count)
 {
 	_auide_hwif *ahwif = &auide_hwif;
 	chan_tab_t *ctp;

