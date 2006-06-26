From: Tejun Heo <htejun@gmail.com>
Subject: Re: More information on ATI IXP failure in git9
Date: Mon, 26 Jun 2006 17:57:30 +0900
Message-ID: <449FA17A.3010804@gmail.com>
References: <200606252359.27671.ak@suse.de> <449F1AEE.700@pobox.com> <20060626021011.GB21435@htj.dyndns.org> <200606260818.46672.ak@suse.de> <449F9D78.7070503@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070001070800030904000805"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:44832 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964946AbWFZI5c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 04:57:32 -0400
Received: by nz-out-0102.google.com with SMTP id o37so748499nzf
        for <linux-ide@vger.kernel.org>; Mon, 26 Jun 2006 01:57:31 -0700 (PDT)
In-Reply-To: <449F9D78.7070503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070001070800030904000805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Hello, Andi.
> 
> Andi Kleen wrote:
>> Still doesn't work with it - see 
>> http://one.firstfloor.org/~andi/sata3.jpg
> 
> * SATA_IRQ bit is stuck (on all other sil controllers, this gets cleared 
> when SError is cleared)
> 
> * whenever interrupt occurs (from itself or from any other ones sharing 
> the IRQ), irq handler sees SATA_IRQ bit set and thus thinks it just 
> received phy status changed IRQ.
> 
> * phy status change aborts the active command, so no command gets 
> completed.
> 
> I'm attaching two patches.  The first one tries to clear SATA_IRQ by 
> writing 1 to it in thaw() assuming the bit is implemented as W1C (which 
> BTW is out of spec).  The second one kills SATA_IRQ handling completely. 
>  I wish the first one works but if not I'll update the second one such 
> that it applies only to ATI IXP.

And another one, just in case they were crazy enough to implement the 
bit as RW.

-- 
tejun

--------------070001070800030904000805
Content-Type: text/plain;
 name="patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch2"

diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index bc9f918..0f19645 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -474,6 +474,10 @@ static void sil_thaw(struct ata_port *ap
 	ata_chk_status(ap);
 	ata_bmdma_irq_clear(ap);
 
+	/* SATA_IRQ has to be cleared manually on some controllers */
+	writel(SIL_DMA_SATA_IRQ, mmio_base + sil_port[ap->port_no].bmdma2);
+	writel(0, mmio_base + sil_port[ap->port_no].bmdma2);
+
 	/* turn on SATA IRQ */
 	writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);
 

--------------070001070800030904000805--
