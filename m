From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/12] usb: use IRQ watching
Date: Sun, 13 Jun 2010 17:31:38 +0200
Message-ID: <1276443098-20653-13-git-send-email-tj@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37770 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754251Ab0FMPcT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Jun 2010 11:32:19 -0400
In-Reply-To: <1276443098-20653-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.orglinux
Cc: Tejun Heo <tj@kernel.org>

Ask IRQ subsystem to watch HCD IRQ line after initialization.  This at
least keeps USB ports which are occupied on initialization working and
eases bug reporting and debugging.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/usb/core/hcd.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 12742f1..383875f 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2270,6 +2270,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 					"request interrupt %d failed\n", irqnum);
 			goto err_request_irq;
 		}
+		watch_irq(irqnum, hcd);
 		hcd->irq = irqnum;
 		dev_info(hcd->self.controller, "irq %d, %s 0x%08llx\n", irqnum,
 				(hcd->driver->flags & HCD_MEMORY) ?
-- 
1.6.4.2

