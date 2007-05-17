From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH] ide.c: microscopic size and readability optimization
Date: Thu, 17 May 2007 13:25:54 +0200
Message-ID: <20070517112554.GA32183@zmei.tnic>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756879AbXEQL0s@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

-----
From: bbpetkov@yahoo.de

A very small size (object file 432 bytes smaller) and readability optimization of ide.c

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

--
Index: 22-rc1/drivers/ide/ide.c
===================================================================
--- 22-rc1/drivers/ide/ide.c.orig
+++ 22-rc1/drivers/ide/ide.c
@@ -568,10 +568,8 @@ void ide_unregister(unsigned int index)
 	ide_hwgroup_t *hwgroup;
 	int irq_count = 0, unit;

-	BUG_ON(index >= MAX_HWIFS);
+	BUG_ON(index >= MAX_HWIFS || in_interrupt() || irqs_disabled());

-	BUG_ON(in_interrupt());
-	BUG_ON(irqs_disabled());
 	down(&ide_cfg_sem);
 	spin_lock_irq(&ide_lock);
 	hwif = &ide_hwifs[index];
