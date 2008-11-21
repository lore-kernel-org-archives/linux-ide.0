From: Tejun Heo <tj@kernel.org>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Fri, 21 Nov 2008 15:41:22 +0900
Message-ID: <49265812.3050902@kernel.org>
References: <491083CC.5050508@rtr.ca>	<49108AA0.1080507@rtr.ca>	<491090BC.5060403@rtr.ca>	<20081104185444.3BE721FDF7@chi.die-welt.net>	<4910A509.1030307@rtr.ca>	<49116811.5000109@kernel.org>	<873ai6cmio.fsf@denkblock.local>	<4911A8EA.8030605@kernel.org>	<87k5bhxerq.fsf@denkblock.local>	<4913BF3D.3090704@kernel.org>	<20081107074857.GA6461@dragonheart.kerker.die-welt.net>	<4917F822.5060204@kernel.org>	<20081110102607.094281FD7C@chi.die-welt.net>	<87r65ju83r.fsf@denkblock.local>	<20081113113345.12E2D1FD80@chi.die-welt.net>	<491FEA3C.4090906@kernel.org>	<20081117071552.D25291FD5F@chi.die-welt.net>	<49211B1F.7040900@kernel.org>	<20081117074825.322BE1FD5F@chi.die-welt.net>	<492218D1.5070904@kernel.org> <20081118073749.D84FD1FD6E@chi.die-welt.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080702050104050402010704"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43791 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926AbYKUGlp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Nov 2008 01:41:45 -0500
In-Reply-To: <20081118073749.D84FD1FD6E@chi.die-welt.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Evgeni Golov <sargentd@die-welt.net>
Cc: Elias Oltmanns <eo@nebensachen.de>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------080702050104050402010704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Evgeni Golov wrote:
> On Tue, 18 Nov 2008 10:22:25 +0900 Tejun Heo wrote:
> 
>> Can you please attach lspci -nn result and full boot log?
> 
> Done :)

Something strange is going on there.  Can you please apply the attached
patch and post resulting kernel log?

Thanks.

-- 
tejun

--------------080702050104050402010704
Content-Type: text/x-patch;
 name="ahci-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ahci-debug.patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a67b8e7..8500fd5 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2006,6 +2006,8 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
 	}
 
 	if (irq_stat & (PORT_IRQ_CONNECT | PORT_IRQ_PHYRDY)) {
+		ata_port_printk(ap, KERN_INFO, "XXX PHY event 0x%x\n",
+				irq_stat);
 		ata_ehi_hotplugged(host_ehi);
 		ata_ehi_push_desc(host_ehi, "%s",
 			irq_stat & PORT_IRQ_CONNECT ?
@@ -2044,6 +2046,7 @@ static void ahci_port_intr(struct ata_port *ap)
  	 */
 	if ((hpriv->flags & AHCI_HFLAG_NO_HOTPLUG) &&
 		(status & PORT_IRQ_PHYRDY)) {
+		ata_port_printk(ap, KERN_INFO, "XXX PHY event clearing 0x%x\n", status);
 		status &= ~PORT_IRQ_PHYRDY;
 		ahci_scr_write(&ap->link, SCR_ERROR, ((1 << 16) | (1 << 18)));
 	}
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 32da9a9..24b52aa 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2380,13 +2380,15 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	/*
 	 * Perform reset
 	 */
-	if (ata_is_host_link(link))
+	if (ata_is_host_link(link)) {
+		ata_port_printk(ap, KERN_INFO, "XXX FREEZING\n");
 		ata_eh_freeze_port(ap);
+	}
 
 	deadline = ata_deadline(jiffies, ata_eh_reset_timeouts[try++]);
 
 	if (reset) {
-		if (verbose)
+		//if (verbose)
 			ata_link_printk(link, KERN_INFO, "%s resetting link\n",
 					reset == softreset ? "soft" : "hard");
 
@@ -2440,6 +2442,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 				goto fail;
 			}
 
+			ata_port_printk(ap, KERN_INFO, "XXX follow-up SRST\n");
 			ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
 			rc = ata_do_reset(link, reset, classes, deadline, true);
 		}
@@ -2479,8 +2482,10 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		slave->sata_spd = (sstatus >> 4) & 0xf;
 
 	/* thaw the port */
-	if (ata_is_host_link(link))
+	if (ata_is_host_link(link)) {
+		ata_port_printk(ap, KERN_INFO, "XXX THAW\n");
 		ata_eh_thaw_port(ap);
+	}
 
 	/* postreset() should clear hardware SError.  Although SError
 	 * is cleared during link resume, clearing SError here is
@@ -2490,9 +2495,17 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	 * link onlineness and classification result later.
 	 */
 	if (postreset) {
+		ata_port_printk(ap, KERN_INFO, "XXX postreset start\n");
 		postreset(link, classes);
 		if (slave)
 			postreset(slave, classes);
+		{
+			u32 serror = 0;
+			sata_scr_read(link, SCR_ERROR, &serror);
+			ata_port_printk(ap, KERN_INFO,
+					"XXX postreset end, SError=0x%x\n",
+					serror);
+		}
 	}
 
 	/* clear cached SError */

--------------080702050104050402010704--
