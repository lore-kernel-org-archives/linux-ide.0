From: Chaitanya Lala <clala@riverbed.com>
Subject: [libata PATCH 1/1] libata: thaw port after maximum reset retries
Date: Fri, 11 Sep 2009 08:27:04 -0700
Message-ID: <20090911152703.GA5222@clala-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from autosupport.riverbed.com ([208.70.196.44]:61399 "EHLO
	smtp2.riverbed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbZIKPfx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Sep 2009 11:35:53 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, ajones@riverbed.com, rbecker@riverbed.com, clala@riverbed.com

The libata error recovery tries to reset a port a number
of times and if unsuccessful, gives up. The code does not
thaw the port before it exits. If the bad disk i.e. the disk
that could not be reset is removed and a healthy disk is
inserted, the new disk does not register, since the port is
frozen. This patch fixes the same.

Signed-off-by: Chaitanya Lala <clala@riverbed.com>
---
 drivers/ata/libata-eh.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 79711b6..724f86f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2637,8 +2637,12 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	    sata_scr_read(link, SCR_STATUS, &sstatus))
 		rc = -ERESTART;
 
-	if (rc == -ERESTART || try >= max_tries)
+	if (rc == -ERESTART || try >= max_tries) {
+		/* thaw the port */
+		if (ata_is_host_link(link))
+			ata_eh_thaw_port(ap);
 		goto out;
+	}
 
 	now = jiffies;
 	if (time_before(now, deadline)) {
-- 
1.6.0.4

