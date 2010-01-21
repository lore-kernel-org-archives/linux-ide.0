From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata-sff: remove CONFIG_NO_ATA_LEGACY
Date: Thu, 21 Jan 2010 09:14:02 +0900
Message-ID: <4B579C4A.3040907@gmail.com>
References: <20100120142943.GE3580@faui49.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:43938 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab0AUAS4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 19:18:56 -0500
In-Reply-To: <20100120142943.GE3580@faui49.informatik.uni-erlangen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Egger <siccegge@stud.informatik.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, Reinhard.Tartler@informatik.uni-erlangen.de

CONFIG_NO_ATA_LEGACY isn't used by anyone.  Drop it.

Reported-by: Christoph Egger <siccegge@stud.informatik.uni-erlangen.de>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
On 01/20/2010 11:29 PM, Christoph Egger wrote:
> 	That's the only place where it is checked for
> NO_ATA_LEGACY. As this Item does appear nowhere in KConfig and
> therefor is not selectable I'm wondering whether that small Code
> fragment should be dropped or a new KConfig option should be added?
> 
> 	Please keep me informed of this patch getting confirmed /
> merged so we can keep track of it.

It's supposed to be set by architecture code to prevent SFF controller
attach if it's in legacy mode.  There apparently is no user left.
Trying to find the last user... it seems it hasn't been unused for at
least two year.  I guess it can be removed then.

Thanks!

 drivers/ata/libata-sff.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 741065c..b9df435 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2945,15 +2945,6 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 		mask = (1 << 2) | (1 << 0);
 		if ((tmp8 & mask) != mask)
 			legacy_mode = 1;
-#if defined(CONFIG_NO_ATA_LEGACY)
-		/* Some platforms with PCI limits cannot address compat
-		   port space. In that case we punt if their firmware has
-		   left a device in compatibility mode */
-		if (legacy_mode) {
-			printk(KERN_ERR "ata: Compatibility mode ATA is not supported on this platform, skipping.\n");
-			return -EOPNOTSUPP;
-		}
-#endif
 	}
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
