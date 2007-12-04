From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil issue on 2.6.22
Date: Tue, 04 Dec 2007 11:54:20 +0900
Message-ID: <4754C15C.1020107@gmail.com>
References: <47434526.7010304@verizonbusiness.com> <474CC29E.8020102@gmail.com> <475032AF.6090001@verizonbusiness.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000105000500020409030408"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:3052 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbXLDCya (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 21:54:30 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2951804rvb
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2007 18:54:29 -0800 (PST)
In-Reply-To: <475032AF.6090001@verizonbusiness.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mark.paulus@verizonbusiness.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000105000500020409030408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Mark Paulus wrote:
> I applied the patch, and not much difference.  Still the same issue, and
> here
> is the new dmesg output.

Weird, okay, here's updated patch.  Please try this one and report the
dmesg.  FYI, it won't fix the problem.  It's just to find out what's
going on.

-- 
tejun

--------------000105000500020409030408
Content-Type: text/x-patch;
 name="debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug.patch"

---
 drivers/ata/libata-core.c |    1 +
 drivers/ata/libata-eh.c   |    2 ++
 drivers/ata/sata_sil.c    |    6 +++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

Index: tree0/drivers/ata/sata_sil.c
===================================================================
--- tree0.orig/drivers/ata/sata_sil.c
+++ tree0/drivers/ata/sata_sil.c
@@ -398,11 +398,15 @@ static void sil_host_intr(struct ata_por
 			ap->eh_info.serror |= serror;
 		}
 
+		ata_port_printk(ap, KERN_INFO, "XXX SATA_IRQ, serror=0x%x\n",
+				serror);
 		goto freeze;
 	}
 
-	if (unlikely(!qc))
+	if (unlikely(!qc)) {
+		ata_port_printk(ap, KERN_INFO, "XXX DMA completion w/o qc\n");
 		goto freeze;
+	}
 
 	if (unlikely(qc->tf.flags & ATA_TFLAG_POLLING)) {
 		/* this sometimes happens, just clear IRQ */
Index: tree0/drivers/ata/libata-core.c
===================================================================
--- tree0.orig/drivers/ata/libata-core.c
+++ tree0/drivers/ata/libata-core.c
@@ -1361,6 +1361,7 @@ unsigned ata_exec_internal_sg(struct ata
 	/* no internal command while frozen */
 	if (ap->pflags & ATA_PFLAG_FROZEN) {
 		spin_unlock_irqrestore(ap->lock, flags);
+		ata_dev_printk(dev, KERN_INFO, "XXX internal cmd on frozen port\n");
 		return AC_ERR_SYSTEM;
 	}
 
Index: tree0/drivers/ata/libata-eh.c
===================================================================
--- tree0.orig/drivers/ata/libata-eh.c
+++ tree0/drivers/ata/libata-eh.c
@@ -782,6 +782,8 @@ static void __ata_port_freeze(struct ata
 
 	ap->pflags |= ATA_PFLAG_FROZEN;
 
+	ata_port_printk(ap, KERN_INFO, "XXX freezing port\n");
+	dump_stack();
 	DPRINTK("ata%u port frozen\n", ap->print_id);
 }
 

--------------000105000500020409030408--
