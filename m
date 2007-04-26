From: akpm@linux-foundation.org
Subject: [patch 09/10] SPIN_LOCK_UNLOCKED cleanup in drivers/ata/pata_winbond.c
Date: Thu, 26 Apr 2007 00:19:27 -0700
Message-ID: <200704260719.l3Q7JRe3023703@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:58903 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933265AbXDZHTi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Apr 2007 03:19:38 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, milindchoudhary@gmail.com, alan@redhat.com

From: Milind Arun Choudhary <milindchoudhary@gmail.com>

remove SPIN_LOCK_UNLOCKED, use DEFINE_SPINLOCK instead

Signed-off-by: Milind Arun Choudhary <milindchoudhary@gmail.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_winbond.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ata/pata_winbond.c~spin_lock_unlocked-cleanup-in-drivers-ata-pata_winbondc drivers/ata/pata_winbond.c
--- a/drivers/ata/pata_winbond.c~spin_lock_unlocked-cleanup-in-drivers-ata-pata_winbondc
+++ a/drivers/ata/pata_winbond.c
@@ -35,7 +35,7 @@ static int probe_winbond = 1;
 static int probe_winbond;
 #endif
 
-static spinlock_t winbond_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(winbond_lock);
 
 static void winbond_writecfg(unsigned long port, u8 reg, u8 val)
 {
_
