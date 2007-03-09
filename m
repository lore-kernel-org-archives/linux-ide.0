From: Robert Hancock <hancockr@shaw.ca>
Subject: [PATCH] sata_nv: revert use of notifiers for now
Date: Thu, 08 Mar 2007 18:02:18 -0600
Message-ID: <45F0A40A.4050508@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:33462 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbXCIACw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 19:02:52 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
Cc: s0348365@sms.ed.ac.uk

Commit 721449bf0d51213fe3abf0ac3e3561ef9ea7827a added support for using the
ADMA notifier bits to determine which commands to check for completion.
However there have been reports that this causes command timeouts in certain
cases. This is still being investigated. In addition, apparently the notifiers
won't work if ADMA is disabled on the other port as a result of an ATAPI device
being connected, and we don't handle this case properly.

For now, just restore the previous behavior of checking all active commands
to see if they are complete, without relying on the notifiers.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>

--- linux-2.6.21-rc3-git3/drivers/ata/sata_nv.c	2007-03-08 17:15:25.000000000 -0600
+++ linux-2.6.21-rc3-git3edit/drivers/ata/sata_nv.c	2007-03-08 17:19:42.000000000 -0600
@@ -874,8 +874,14 @@
 
 			if (status & (NV_ADMA_STAT_DONE |
 				      NV_ADMA_STAT_CPBERR)) {
-				u32 check_commands = notifier | notifier_error;
+				u32 check_commands;
 				int pos, error = 0;
+
+				if(ata_tag_valid(ap->active_tag))
+					check_commands = 1 << ap->active_tag;
+				else
+					check_commands = ap->sactive;
+
 				/** Check CPBs for completed commands */
 				while ((pos = ffs(check_commands)) && !error) {
 					pos--;

