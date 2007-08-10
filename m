From: akpm@linux-foundation.org
Subject: [patch 16/25] Fix libata warnings with CONFIG_PM=n
Date: Fri, 10 Aug 2007 13:59:44 -0700
Message-ID: <200708102059.l7AKxifI008614@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52010 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756133AbXHJVPv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:15:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, nix.or.die@googlemail.com

From: Gabriel C <nix.or.die@googlemail.com>

drivers/ata/libata-core.c:5993: warning: 'ata_host_disable_link_pm' defined but not used
drivers/ata/libata-core.c:6004: warning: 'ata_host_enable_link_pm' defined but not used

Signed-off-by: Gabriel Craciunescu <nix.or.die@googlemail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/ata/libata-core.c~fix-libata-warnings-with-config_pm=n drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~fix-libata-warnings-with-config_pm=n
+++ a/drivers/ata/libata-core.c
@@ -5923,6 +5923,7 @@ int ata_flush_cache(struct ata_device *d
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static void ata_host_disable_link_pm(struct ata_host *host)
 {
 	int i;
@@ -5944,7 +5945,7 @@ static void ata_host_enable_link_pm(stru
 	}
 }
 
-#ifdef CONFIG_PM
+
 static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
 			       unsigned int action, unsigned int ehi_flags,
 			       int wait)
_
