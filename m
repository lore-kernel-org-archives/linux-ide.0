From: Tejun Heo <htejun@gmail.com>
Subject: Re: More information on ATI IXP failure in git9
Date: Mon, 26 Jun 2006 17:40:24 +0900
Message-ID: <449F9D78.7070503@gmail.com>
References: <200606252359.27671.ak@suse.de> <449F1AEE.700@pobox.com> <20060626021011.GB21435@htj.dyndns.org> <200606260818.46672.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060708020804020604040600"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:24185 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964931AbWFZIkZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 04:40:25 -0400
Received: by nz-out-0102.google.com with SMTP id o37so745843nzf
        for <linux-ide@vger.kernel.org>; Mon, 26 Jun 2006 01:40:25 -0700 (PDT)
In-Reply-To: <200606260818.46672.ak@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060708020804020604040600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello, Andi.

Andi Kleen wrote:
> Still doesn't work with it - see http://one.firstfloor.org/~andi/sata3.jpg

* SATA_IRQ bit is stuck (on all other sil controllers, this gets cleared 
when SError is cleared)

* whenever interrupt occurs (from itself or from any other ones sharing 
the IRQ), irq handler sees SATA_IRQ bit set and thus thinks it just 
received phy status changed IRQ.

* phy status change aborts the active command, so no command gets completed.

I'm attaching two patches.  The first one tries to clear SATA_IRQ by 
writing 1 to it in thaw() assuming the bit is implemented as W1C (which 
BTW is out of spec).  The second one kills SATA_IRQ handling completely. 
  I wish the first one works but if not I'll update the second one such 
that it applies only to ATI IXP.

Thanks.

-- 
tejun

--------------060708020804020604040600
Content-Type: text/plain;
 name="patch0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch0"

diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index bc9f918..fca5333 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -474,6 +474,9 @@ static void sil_thaw(struct ata_port *ap
 	ata_chk_status(ap);
 	ata_bmdma_irq_clear(ap);
 
+	/* SATA_IRQ has to be cleared manually on some controllers */
+	writel(SIL_DMA_SATA_IRQ, mmio_base + sil_port[ap->port_no].bmdma2);
+
 	/* turn on SATA IRQ */
 	writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);
 

--------------060708020804020604040600
Content-Type: text/plain;
 name="patch1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch1"

diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index bc9f918..024ce28 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -343,6 +343,7 @@ static void sil_host_intr(struct ata_por
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	u8 status;
 
+#if 0
 	if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ)) {
 		u32 serror;
 
@@ -365,6 +366,7 @@ static void sil_host_intr(struct ata_por
 
 		goto freeze;
 	}
+#endif
 
 	if (unlikely(!qc || qc->tf.ctl & ATA_NIEN))
 		goto freeze;
@@ -438,7 +440,7 @@ static irqreturn_t sil_interrupt(int irq
 			continue;
 
 		if (bmdma2 == 0xffffffff ||
-		    !(bmdma2 & (SIL_DMA_COMPLETE | SIL_DMA_SATA_IRQ)))
+		    !(bmdma2 & (SIL_DMA_COMPLETE/* | SIL_DMA_SATA_IRQ*/)))
 			continue;
 
 		sil_host_intr(ap, bmdma2);
@@ -475,7 +477,7 @@ static void sil_thaw(struct ata_port *ap
 	ata_bmdma_irq_clear(ap);
 
 	/* turn on SATA IRQ */
-	writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);
+	/*writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);*/
 
 	/* turn on IRQ */
 	tmp = readl(mmio_base + SIL_SYSCFG);

--------------060708020804020604040600--
