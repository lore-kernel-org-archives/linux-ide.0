From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata atapi work #2.1
Date: 17 May 2004 13:24:24 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084821864.4452.2.camel@patibmrh9>
References: <1084721991.3085.6.camel@patibmrh9> <40A7F757.9020200@pobox.com>
	<1084805767.3083.10.camel@patibmrh9>  <40A8FD19.8050906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:36494 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262175AbUEQTYo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 May 2004 15:24:44 -0400
Received: from royntex01.iomegacorp.com (franklin [10.1.1.83])
	by email.iomega.com (Postfix) with ESMTP id 861BF169B
	for <linux-ide@vger.kernel.org>; Mon, 17 May 2004 13:24:43 -0600 (MDT)
In-Reply-To: <40A8FD19.8050906@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

(-: Be warned, this from me is all ack, ack, ack - no substance. :-)

> -bk4 should include everything
> except the obvious ... define ...

Yes, -bk4 works great here now, same as the collected patches did
before.

> Last night's -bk4

Thanks for the hint.

Independently at http://kernel.org I saw notice of 2004-05-17 11:46 UTC
-bk4 appear.  The actual patch did not arrive in the view I have here of
http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/ til later, maybe
16:00 UTC.  Now is past 19:00 UTC.

Pat LaVarre

P.S. "Same as" "before" is of course my destructive exercise:

plscsi /dev/sg0 -i 0x12 -x "03 00:00:00 12 00" -v
plscsi /dev/sg0 -i 0x12 -x "03 00:00:00 12 00" -v
time pldd of if=/dev/sg0 bs=64k sbs=2k skip=0 count=1600
time pldd of=/dev/sg0 if bs=64k sbs=2k seek=0 count=1600

--- linux-2.6.6-bk4/include/linux/libata.h	2004-05-17 12:50:20.000000000 -0600
+++ linux-2.6.6-bk4-pel/include/linux/libata.h	2004-05-17 13:11:16.315019408 -0600
@@ -33,14 +33,14 @@
  * compile-time options
  */
 #undef ATA_FORCE_PIO		/* do not configure or use DMA */
-#undef ATA_DEBUG		/* debugging output */
-#undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
+#define ATA_DEBUG		/* debugging output */
+#define ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */
-#undef ATA_ENABLE_ATAPI		/* define to enable ATAPI support */
+#define ATA_ENABLE_ATAPI		/* define to enable ATAPI support */
 #undef ATA_ENABLE_PATA		/* define to enable PATA support in some
 				 * low-level drivers */
-#undef ATAPI_ENABLE_DMADIR	/* enables ATAPI DMADIR bridge support */
+#define ATAPI_ENABLE_DMADIR	/* enables ATAPI DMADIR bridge support */
 
 
 /* note: prints function name for you */


