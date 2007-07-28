From: Gabriel C <nix.or.die@googlemail.com>
Subject: [PATCH -mm] Fix libata warnings with CONFIG_PM=n
Date: Sat, 28 Jul 2007 21:32:42 +0200
Message-ID: <46AB99DA.6050402@googlemail.com>
References: <20070725040304.111550f4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:46514 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbXG1Tgv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jul 2007 15:36:51 -0400
Received: by ug-out-1314.google.com with SMTP id j3so862142ugf
        for <linux-ide@vger.kernel.org>; Sat, 28 Jul 2007 12:36:49 -0700 (PDT)
In-Reply-To: <20070725040304.111550f4.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi Jeff,

I noticed this warnings when CONFIG_PM=n 

...

drivers/ata/libata-core.c:5993: warning: 'ata_host_disable_link_pm' defined but not used
drivers/ata/libata-core.c:6004: warning: 'ata_host_enable_link_pm' defined but not used

...

Signed-off-by: Gabriel Craciunescu <nix.or.die@googlemail.com>

---

--- linux-2.6.23-rc1/drivers/ata/libata-core.c.orig	2007-07-28 21:17:31.000000000 +0200
+++ linux-2.6.23-rc1/drivers/ata/libata-core.c	2007-07-28 21:17:48.000000000 +0200
@@ -5989,6 +5989,7 @@ int ata_flush_cache(struct ata_device *d
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static void ata_host_disable_link_pm(struct ata_host *host)
 {
 	int i;
@@ -6011,7 +6012,7 @@ static void ata_host_enable_link_pm(stru
 	}
 }
 
-#ifdef CONFIG_PM
+
 static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
 			       unsigned int action, unsigned int ehi_flags,
 			       int wait)

