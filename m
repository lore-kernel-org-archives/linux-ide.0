From: Davin McCall <davmac@ozonline.com.au>
Subject: Re: [PATCH] various IDE patches/cleanups
Date: Fri, 30 Jan 2004 14:33:55 +1100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040130143355.630346cc.davmac@ozonline.com.au>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
	<200401051516.03364.bzolnier@elka.pw.edu.pl>
	<20040106135155.66535c13.davmac@ozonline.com.au>
	<200401061213.39843.bzolnier@elka.pw.edu.pl>
	<20040130142725.1a408f9e.davmac@ozonline.com.au>
	<20040130143041.1eb70817.davmac@ozonline.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040130143041.1eb70817.davmac@ozonline.com.au>
To: Davin McCall <davmac@ozonline.com.au>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

patch 3
-------
Simple patch to check the return of del_timer() in ide_intr(), to avoid
problems with marginal timeouts.

- (ide-io.c)
  - ide_intr()
    - check return from del_timer, exit if timer has expired.


diff -urN linux-2.6.0-patch2/drivers/ide/ide-io.c linux-2.6.0/drivers/ide/ide-io.c
--- linux-2.6.0-patch2/drivers/ide/ide-io.c	Wed Jan 28 22:55:00 2004
+++ linux-2.6.0/drivers/ide/ide-io.c	Wed Jan 28 23:49:17 2004
@@ -1303,8 +1303,12 @@
 		hwgroup->busy = 1;	/* paranoia */
 		printk(KERN_ERR "%s: ide_intr: hwgroup->busy was 0 ??\n", drive->name);
 	}
+	if (!del_timer(&hwgroup->timer)) {
+		/* timer has expired, ide_timer_expiry is waiting to get lock */
+		spin_unlock(&ide_lock);
+		return IRQ_HANDLED;
+	}
 	hwgroup->handler = NULL;
-	del_timer(&hwgroup->timer);
 	spin_unlock(&ide_lock);
 
 	if (drive->unmask)
