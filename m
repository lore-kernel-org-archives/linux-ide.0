From: Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] Leave ata_probe_timeout in seconds
Date: Mon, 21 Jul 2008 12:30:31 -0600
Message-ID: <20080721183030.GF24246@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:59116 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbYGUSar (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jul 2008 14:30:47 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org


ata_probe_timeout is documented to be in seconds.  It's confusing to
turn it into a count in jiffies in the init routine, then convert it
to milliseconds in the only place in which it is used.  It also makes
/sys/module/libata/parameters/ata_probe_timeout report the wrong value.

Signed-off-by: Matthew Wilcox <willy@linux.intel.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 303fc0d..94ab77b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1685,7 +1685,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	if (!timeout)
-		timeout = ata_probe_timeout * 1000 / HZ;
+		timeout = ata_probe_timeout * 1000;
 
 	rc = wait_for_completion_timeout(&wait, msecs_to_jiffies(timeout));
 
@@ -6073,8 +6073,6 @@ static void __init ata_parse_force_param(void)
 
 static int __init ata_init(void)
 {
-	ata_probe_timeout *= HZ;
-
 	ata_parse_force_param();
 
 	ata_wq = create_workqueue("ata");

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
