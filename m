From: Tejun Heo <teheo@novell.com>
Subject: Re: Initio 1623 driver question
Date: Wed, 20 Aug 2008 13:20:40 +0900
Message-ID: <48AB9B98.6000105@novell.com>
References: <48AB0F54.5080900@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020000070100090407080509"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:34157 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011AbYHTEVR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Aug 2008 00:21:17 -0400
In-Reply-To: <48AB0F54.5080900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthieu Helder <matthieu.helder@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020000070100090407080509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Matthieu Helder wrote:
> I've compiled and installed the 2.6.26.2 kernel.

Can you please apply the attached patch and report the resulting
detection log?

Thanks.

-- 
tejun

--------------020000070100090407080509
Content-Type: text/x-patch;
 name="inic-reset-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inic-reset-debug.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9bef1a8..6670d4a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3451,6 +3451,7 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 
 		/* DET stable? */
 		if (cur == last) {
+			ata_link_printk(link, "XXX debounce: DET stable %x\n", cur);
 			if (cur == 1 && time_before(jiffies, deadline))
 				continue;
 			if (time_after(jiffies,
@@ -3459,6 +3460,7 @@ int sata_link_debounce(struct ata_link *link, const unsigned long *params,
 			continue;
 		}
 
+		ata_link_printk(link, "XXX debounce: DET unstable %x\n", cur);
 		/* unstable, start over */
 		last = cur;
 		last_jiffies = jiffies;
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 3ead02f..a215c2a 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -615,7 +615,8 @@ static int inic_hardreset(struct ata_link *link, unsigned int *class,
 	struct ata_port *ap = link->ap;
 	void __iomem *port_base = inic_port_base(ap);
 	void __iomem *idma_ctl = port_base + PORT_IDMA_CTL;
-	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
+	//const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
+	const unsigned long *timing = sata_deb_timing_long;
 	int rc;
 
 	/* hammer it into sane state */

--------------020000070100090407080509--
