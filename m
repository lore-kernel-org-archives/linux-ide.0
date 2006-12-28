From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive
 0x0) r0xj0
Date: Thu, 28 Dec 2006 12:30:27 +0900
Message-ID: <45933A53.1090702@gmail.com>
References: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040406010202020601080905"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:4299 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964900AbWL1Dak (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Dec 2006 22:30:40 -0500
Received: by wx-out-0506.google.com with SMTP id h27so4435545wxd
        for <linux-ide@vger.kernel.org>; Wed, 27 Dec 2006 19:30:40 -0800 (PST)
In-Reply-To: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lyon <andrew.lyon@gmail.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040406010202020601080905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Lyon wrote:
> Hi,
> 
> My system is gigabyte ds3 motherboard with onboard SATA JMicron
> 20360/20363 AHCI Controller (rev 02), drive connected is WDC
> WD740ADFD-00 20.0, I am running 2.6.18.6 32 bit, under heavy i/o I get
> the following messaegs:
> 
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> 
> Is this condition dangerous?

Not usually.  Might indicate something is going wrong in some really
rare cases.  I think vendors are getting NCQ right these days.  Maybe
it's time to remove that printk.

> I plan to upgrade to 2.6.19 soon as I have problems with a sata dvd
> writer but I have to wait for a driver that I need to catch up, this
> system cannot be down for long as it runs mythtv.

Can you apply the attached patch and report what the kernel says?
Please include full dmesg.

Thanks.

-- 
tejun

--------------040406010202020601080905
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b517d24..13f5853 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1162,10 +1162,21 @@ static void ahci_host_intr(struct ata_port *ap)
 	if (ata_tag_valid(ap->active_tag) && (status & PORT_IRQ_PIOS_FIS))
 		return;
 
-	if (ata_ratelimit())
+	if (ata_ratelimit()) {
+		struct ahci_port_priv *pp = ap->private_data;
+		const u32 *f = pp->rx_fis + 0x58;
+
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
-				"(irq_stat 0x%x active_tag %d sactive 0x%x)\n",
+				"(irq_stat 0x%x active_tag 0x%x sactive 0x%x)\n",
 				status, ap->active_tag, ap->sactive);
+		if (status & PORT_IRQ_SDB_FIS) {
+			ata_port_printk(ap, KERN_INFO, "issue=0x%x SAct=0x%x "
+					"SDB_FIS=%08x:%08x\n",
+					readl(port_mmio + PORT_CMD_ISSUE),
+					readl(port_mmio + PORT_SCR_ACT),
+					f[0], f[1]);
+		}
+	}
 }
 
 static void ahci_irq_clear(struct ata_port *ap)

--------------040406010202020601080905--
