From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
Subject: [PATCH] Fix interface autodetection in legacy IDE driver (trial #2)
Date: Tue, 11 Oct 2016 22:12:45 -0300
Message-ID: <20161012011245.GA22684@giustizia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm27-vm3.bullet.mail.ne1.yahoo.com ([98.138.91.157]:38433 "EHLO
        nm27-vm3.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752109AbcJLBR4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 11 Oct 2016 21:17:56 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

This humble patch was sent one or two months before, and had no actions,
except for a colleague reply which friendly pointed out some formatting
problems (which were solved in a second message).

It relates to an old code, the legacy IDE driver, but the bug it
addresses is real. The code, although rarely used, is
still there to be compiled if one chooses to do so (like me).

Also, the fix has a very low risk of present collateral effects IMHO.
It is already compiled and tested in some embedded machines.

So, again IMHO, it is worth be fixed.

This email is a second trial with it. I hope it can help the one or two
guys out there which are still running the legacy IDE driver and
haven't noticed the former email.

Best regards,

Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
---
 drivers/ide/ide-generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
index 54d7c4685d23aa5e62ce606e7b994a57bb54b08a..419818a39c270d3ad219e8f7b5df56a9aea3d640 100644
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -96,10 +96,10 @@ static int __init ide_generic_init(void)
 		printk(KERN_INFO DRV_NAME ": please use \"probe_mask=0x3f\" "
 		     "module parameter for probing all legacy ISA IDE ports\n");
 
-		if (primary == 0)
+		if (primary)
 			probe_mask |= 0x1;
 
-		if (secondary == 0)
+		if (secondary)
 			probe_mask |= 0x2;
 	} else
 		printk(KERN_INFO DRV_NAME ": enforcing probing of I/O ports "
-- 
2.8.2

