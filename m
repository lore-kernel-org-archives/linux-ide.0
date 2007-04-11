From: Milind Arun Choudhary <milindchoudhary@gmail.com>
Subject: [KJ][PATCH] SPIN_LOCK_UNLOCKED cleanup in drivers/ata/pata_winbond.c
Date: Wed, 11 Apr 2007 20:58:46 +0530
Message-ID: <20070411152846.GA11449@arun.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:5618 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbXDKP0z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Apr 2007 11:26:55 -0400
Received: by ug-out-1314.google.com with SMTP id 44so142447uga
        for <linux-ide@vger.kernel.org>; Wed, 11 Apr 2007 08:26:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kernel-janitors@lists.osdl.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, alan@redhat.com

remove SPIN_LOCK_UNLOCKED, use DEFINE_SPINLOCK instead

Signed-off-by: Milind Arun Choudhary <milindchoudhary@gmail.com>

---
 pata_winbond.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 6c11103..cfcd2a5 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -36,7 +36,7 @@ static int probe_winbond = 1;
 static int probe_winbond;
 #endif
 
-static spinlock_t winbond_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(winbond_lock);
 
 static void winbond_writecfg(unsigned long port, u8 reg, u8 val)
 {

-- 
Milind Arun Choudhary
