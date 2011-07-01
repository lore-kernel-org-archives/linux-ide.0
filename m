From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: report link resume failure as
 KERN_WARNING instead of ERR
Date: Fri, 1 Jul 2011 15:12:09 +0200
Message-ID: <20110701131209.GW3386@htj.dyndns.org>
References: <F2FB3B32-A380-40EB-B6DF-02AB30592E3D@jabberwocky.com>
 <20110630094937.GO3386@htj.dyndns.org>
 <438EE45C-A01E-4F77-8314-5DF9E8332E21@jabberwocky.com>
 <20110630163940.GT3386@htj.dyndns.org>
 <E0B7D7D8-74D4-4DE8-B161-A88E8CAC3D62@jabberwocky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:32858 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961Ab1GANMN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Jul 2011 09:12:13 -0400
Received: by fxd18 with SMTP id 18so3272410fxd.11
        for <linux-ide@vger.kernel.org>; Fri, 01 Jul 2011 06:12:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E0B7D7D8-74D4-4DE8-B161-A88E8CAC3D62@jabberwocky.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, David Shaw <dshaw@jabberwocky.com>

Link resume failure in itself isn't an error condition and may happen
regularly depending on hardware configuration.  Reporting it as
KERN_ERR makes the condition unnecessarily prominent (e.g. reported
during boot).  Use KERN_WARNING instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: David Shaw <dshaw@jabberwocky.com>
---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 736bee5..0044370 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3552,7 +3552,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 	} while ((scontrol & 0xf0f) != 0x300 && --tries);
 
 	if ((scontrol & 0xf0f) != 0x300) {
-		ata_link_printk(link, KERN_ERR,
+		ata_link_printk(link, KERN_WARNING,
 				"failed to resume link (SControl %X)\n",
 				scontrol);
 		return 0;
