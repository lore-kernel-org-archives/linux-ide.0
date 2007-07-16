From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 19/21] libata: clear HOTPLUG flag after a reset
Date: Mon, 16 Jul 2007 14:29:41 +0900
Message-ID: <11845637811188-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:11920 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764061AbXGPF3y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:54 -0400
Received: by nz-out-0506.google.com with SMTP id s18so736665nze
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:53 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

ATA_EHI_HOTPLUGGED is a hint for reset functions indicating the the
port might have gone through hotplug/unplug just before entering EH.
Reset functions modify their behaviors a bit to handle the situation
better - e.g. using longer debouncing delay.

Currently, once HOTPLUG is set, it isn't cleared till the end of EH.
This is unnecessary and makes EH take longer.  Clear the HOTPLUGGED
flag after a reset try (successful or not).

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1a4397a..a5a8f84 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1714,7 +1714,7 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 			} else
 				ata_port_printk(ap, KERN_ERR,
 					"prereset failed (errno=%d)\n", rc);
-			return rc;
+			goto out;
 		}
 	}
 
@@ -1727,7 +1727,8 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 		/* prereset told us not to reset, bang classes and return */
 		for (i = 0; i < ATA_MAX_DEVICES; i++)
 			classes[i] = ATA_DEV_NONE;
-		return 0;
+		rc = 0;
+		goto out;
 	}
 
 	/* did prereset() screw up?  if so, fix up to avoid oopsing */
@@ -1763,7 +1764,8 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 			ata_port_printk(ap, KERN_ERR,
 					"follow-up softreset required "
 					"but no softreset avaliable\n");
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
 
 		ata_eh_about_to_do(ap, NULL, ATA_EH_RESET_MASK);
@@ -1773,7 +1775,8 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 		    classes[0] == ATA_DEV_UNKNOWN) {
 			ata_port_printk(ap, KERN_ERR,
 					"classification failed\n");
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
 	}
 
@@ -1818,7 +1821,9 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 		ata_eh_done(ap, NULL, ehc->i.action & ATA_EH_RESET_MASK);
 		ehc->i.action |= ATA_EH_REVALIDATE;
 	}
-
+ out:
+	/* clear hotplug flag */
+	ehc->i.flags &= ~ATA_EHI_HOTPLUGGED;
 	return rc;
 }
 
-- 
1.5.0.3


