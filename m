From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problems with "frozen drives" on sil3124 + sil3726
Date: Mon, 22 Oct 2007 10:44:27 +0900
Message-ID: <471C007B.30006@gmail.com>
References: <471A0070.2080403@jogback.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090604000705040509030004"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:63659 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbXJVBoe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Oct 2007 21:44:34 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1132831wah
        for <linux-ide@vger.kernel.org>; Sun, 21 Oct 2007 18:44:34 -0700 (PDT)
In-Reply-To: <471A0070.2080403@jogback.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Lars_Michael_Jogb=E4ck?= <lm@jogback.se>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090604000705040509030004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Lars Michael Jogbäck wrote:
> Hi Tejun et. al.
> 
> I'm running a server with Linux 2.6.18.1+Debian's Xen-patches and the
> sata+pmp-patches from
> http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.18.1-20061020.tar.bz2
> 
> Unfortunately I can't upgrade to anything newer than 2.6.18 since there
> is no Xen Dom0-patches that I'm aware of to anything newer.
> 
> I have successfully for a long time together, but a couple of weeks ago
> my motherboard gave in, and I installed a new one (along with new
> processor/memory).
> I'm running the very same kernel, the same sil3124-controller and the
> same sil3726-PMP-board. The only difference is that instead of a
> Supermicro P4SC8 w/ Intel P4 (and PCI-X slot of 66MHz) I'm currently
> using Supermicro PDSME+ w/ E6600 (and PCI-X slot of 133MHz)

There was a bug in PCI-X irq loss quirk code which went unnoticed for
quite some time bug was fixed recently.  Patch attached.  Patch might
not apply directly.  Just hand edit and move WOC clearing before
SLOT_STAT reading.

-- 
tejun

--------------090604000705040509030004
Content-Type: text/x-patch;
 name="0001-sata_sil24-fix-IRQ-clearing-race-when-PCIX_IRQ_WOC.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-sata_sil24-fix-IRQ-clearing-race-when-PCIX_IRQ_WOC.patc";
 filename*1="h"

>From 228f47b959a0cf2e24c9696757c7e6510334e499 Mon Sep 17 00:00:00 2001
From: Tejun Heo <htejun@gmail.com>
Date: Sun, 23 Sep 2007 12:37:05 +0900
Subject: [PATCH] sata_sil24: fix IRQ clearing race when PCIX_IRQ_WOC is used

When PCIX_IRQ_WOC is used, sil24 has an inherent race condition
between clearing IRQ pending and reading IRQ status.  If IRQ pending
is cleared after reading IRQ status, there's possibility of lost IRQ.
If IRQ pending is cleared before reading IRQ status, spurious IRQs
will occur.

sata_sil24 till now cleared IRQ pending after reading IRQ status thus
losing IRQs on machines where PCIX_IRQ_WOC was used.  Reverse the
order and ignore spurious IRQs if PCIX_IRQ_WOC.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index ef83e6b..233e886 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -881,43 +881,51 @@ static void sil24_finish_qc(struct ata_queued_cmd *qc)
 	if (qc->flags & ATA_QCFLAG_RESULT_TF)
 		sil24_read_tf(ap, qc->tag, &pp->tf);
 }
 
 static inline void sil24_host_intr(struct ata_port *ap)
 {
 	void __iomem *port = ap->ioaddr.cmd_addr;
 	u32 slot_stat, qc_active;
 	int rc;
 
+	/* If PCIX_IRQ_WOC, there's an inherent race window between
+	 * clearing IRQ pending status and reading PORT_SLOT_STAT
+	 * which may cause spurious interrupts afterwards.  This is
+	 * unavoidable and much better than losing interrupts which
+	 * happens if IRQ pending is cleared after reading
+	 * PORT_SLOT_STAT.
+	 */
+	if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
+		writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
+
 	slot_stat = readl(port + PORT_SLOT_STAT);
 
 	if (unlikely(slot_stat & HOST_SSTAT_ATTN)) {
 		sil24_error_intr(ap);
 		return;
 	}
 
-	if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
-		writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
-
 	qc_active = slot_stat & ~HOST_SSTAT_ATTN;
 	rc = ata_qc_complete_multiple(ap, qc_active, sil24_finish_qc);
 	if (rc > 0)
 		return;
 	if (rc < 0) {
 		struct ata_eh_info *ehi = &ap->eh_info;
 		ehi->err_mask |= AC_ERR_HSM;
 		ehi->action |= ATA_EH_SOFTRESET;
 		ata_port_freeze(ap);
 		return;
 	}
 
-	if (ata_ratelimit())
+	/* spurious interrupts are expected if PCIX_IRQ_WOC */
+	if (!(ap->flags & SIL24_FLAG_PCIX_IRQ_WOC) && ata_ratelimit())
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
 			"(slot_stat 0x%x active_tag %d sactive 0x%x)\n",
 			slot_stat, ap->active_tag, ap->sactive);
 }
 
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance)
 {
 	struct ata_host *host = dev_instance;
 	void __iomem *host_base = host->iomap[SIL24_HOST_BAR];
 	unsigned handled = 0;
-- 
1.5.2.4


--------------090604000705040509030004--
