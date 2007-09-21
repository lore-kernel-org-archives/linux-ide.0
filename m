From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 with port multiplier
Date: Fri, 21 Sep 2007 19:55:21 +0900
Message-ID: <46F3A319.2010806@gmail.com>
References: <FD6311B7ED175B4480F31633F6098B4D911C41@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070204040009020405080608"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:43152 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbXIUKz3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Sep 2007 06:55:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so944551wah
        for <linux-ide@vger.kernel.org>; Fri, 21 Sep 2007 03:55:28 -0700 (PDT)
In-Reply-To: <FD6311B7ED175B4480F31633F6098B4D911C41@ffpglobal_mail.corp.ffplus.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jon Chelton <jchelton@ffpglobal.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070204040009020405080608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jon Chelton wrote:
> Hello,
> 
>  
> 
> I am having issues using kernel 2.6.22.1 with your latest patch
> applied.  I am using a Addonics 4 port SATA card with an external
> enclosure  and port multiplier connected to 4 250GB western digital SATA
> drives.   I am receiving this error frequently (on 2 systems with
> identical kernels and hardware). 

Does the attached patch fix the problem?

-- 
tejun

--------------070204040009020405080608
Content-Type: text/x-patch;
 name="sil24-irq-woc-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sil24-irq-woc-fix.patch"

---
 drivers/ata/sata_sil24.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: work/drivers/ata/sata_sil24.c
===================================================================
--- work.orig/drivers/ata/sata_sil24.c
+++ work/drivers/ata/sata_sil24.c
@@ -1138,6 +1138,9 @@ static inline void sil24_host_intr(struc
 	u32 slot_stat, qc_active;
 	int rc;
 
+	if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
+		writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
+
 	slot_stat = readl(port + PORT_SLOT_STAT);
 
 	if (unlikely(slot_stat & HOST_SSTAT_ATTN)) {
@@ -1145,9 +1148,6 @@ static inline void sil24_host_intr(struc
 		return;
 	}
 
-	if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
-		writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
-
 	qc_active = slot_stat & ~HOST_SSTAT_ATTN;
 	rc = ata_qc_complete_multiple(ap, qc_active, sil24_finish_qc);
 	if (rc > 0)

--------------070204040009020405080608--
