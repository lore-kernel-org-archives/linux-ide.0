From: Tejun Heo <tj@kernel.org>
Subject: Re: Intermittent SATA failures ("link offline, clearing class 1 to
 NONE")
Date: Tue, 01 Dec 2009 17:31:16 +0900
Message-ID: <4B14D454.7010300@kernel.org>
References: <1258054583-sup-4108@utwig> <4B14B207.9010208@kernel.org> <1259652273-sup-686@utwig> <4B14D003.30407@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040300040901050704020002"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45462 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244AbZLAIc1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 03:32:27 -0500
In-Reply-To: <4B14D003.30407@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
Cc: linux-ide <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040300040901050704020002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

Can you please apply the attached patch and post the good and bad boot
logs?

Thanks.

-- 
tejun

--------------040300040901050704020002
Content-Type: text/x-patch;
 name="debounce-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="debounce-debug.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dc72690..c501e1e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3731,7 +3731,7 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 	unsigned long interval = params[0];
 	unsigned long duration = params[1];
 	unsigned long last_jiffies, t;
-	u32 last, cur;
+	u32 last, cur, xxx;
 	int rc;
 
 	t = ata_deadline(jiffies, params[2]);
@@ -3740,7 +3740,9 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 
 	if ((rc = sata_scr_read(link, SCR_STATUS, &cur)))
 		return rc;
+	xxx = cur;
 	cur &= 0xf;
+	ata_link_printk(link, KERN_INFO, "XXX debounce start, SStatus=%x\n", xxx);
 
 	last = cur;
 	last_jiffies = jiffies;
@@ -3749,6 +3751,7 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 		msleep(interval);
 		if ((rc = sata_scr_read(link, SCR_STATUS, &cur)))
 			return rc;
+		xxx = cur;
 		cur &= 0xf;
 
 		/* DET stable? */
@@ -3756,8 +3759,12 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 			if (cur == 1 && time_before(jiffies, deadline))
 				continue;
 			if (time_after(jiffies,
-				       ata_deadline(last_jiffies, duration)))
+				       ata_deadline(last_jiffies, duration))) {
+				ata_link_printk(link, KERN_INFO,
+						"XXX debounce done, SStatus=%x, DET stable for %u msecs\n",
+						xxx, jiffies_to_msecs(jiffies - last_jiffies));
 				return 0;
+			}
 			continue;
 		}
 

--------------040300040901050704020002--
