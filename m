From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 with port multiplier
Date: Sun, 23 Sep 2007 12:36:00 +0900
Message-ID: <46F5DF20.2010300@gmail.com>
References: <FD6311B7ED175B4480F31633F6098B4D911C5F@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040400080605020606050208"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:15499 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbXIWDgK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Sep 2007 23:36:10 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1138104rvb
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 20:36:09 -0700 (PDT)
In-Reply-To: <FD6311B7ED175B4480F31633F6098B4D911C5F@ffpglobal_mail.corp.ffplus.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jon Chelton <jchelton@ffpglobal.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040400080605020606050208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Please apply without the previous patch.  Also, this is the correct version.

-- 
tejun

--------------040400080605020606050208
Content-Type: text/plain;
 name="fix-sata_sil24"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-sata_sil24"

[PATCH] sata_sil24: fix IRQ clearing race when PCIX_IRQ_WOC is used

When PCIX_IRQ_WOC is used, sil24 has an inherent race condition
between clearing IRQ pending and reading IRQ status.  If IRQ pending
is cleared after reading IRQ status, there's possibility of lost IRQ.
If IRQ pending is cleared before reading IRQ status, spurious IRQs
will occur.

sata_sil24 till now cleared IRQ pending after reading IRQ status thus
losing IRQs on machines where PCIX_IRQ_WOC was used.  Reverse the
order and ignore spurious IRQs if PCIX_IRQ_WOC.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This fixes a long-standing IRQ loss problem (and accompanying
timeouts) on sata_sil24.

 drivers/ata/sata_sil24.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

Index: work/drivers/ata/sata_sil24.c
===================================================================
--- work.orig/drivers/ata/sata_sil24.c
+++ work/drivers/ata/sata_sil24.c
@@ -889,6 +889,16 @@ static inline void sil24_host_intr(struc
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
@@ -896,9 +906,6 @@ static inline void sil24_host_intr(struc
 		return;
 	}
 
-	if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
-		writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
-
 	qc_active = slot_stat & ~HOST_SSTAT_ATTN;
 	rc = ata_qc_complete_multiple(ap, qc_active, sil24_finish_qc);
 	if (rc > 0)
@@ -911,7 +918,8 @@ static inline void sil24_host_intr(struc
 		return;
 	}
 
-	if (ata_ratelimit())
+	/* spurious interrupts are expected if PCIX_IRQ_WOC */
+	if (!(ap->flags & SIL24_FLAG_PCIX_IRQ_WOC) && ata_ratelimit())
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
 			"(slot_stat 0x%x active_tag %d sactive 0x%x)\n",
 			slot_stat, ap->link.active_tag, ap->link.sactive);

--------------040400080605020606050208--
