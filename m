From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 08:44:54 +0900
Message-ID: <446A63F6.5030706@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050705070605000101030605"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:63295 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932288AbWEPXoP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 19:44:15 -0400
Received: by nz-out-0102.google.com with SMTP id 8so113257nzo
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 16:44:15 -0700 (PDT)
In-Reply-To: <446A1A21.80501@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ric@emc.com
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

This is a multi-part message in MIME format.
--------------050705070605000101030605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ric Wheeler wrote:
> c001n01: 0: [  OK  ]
> ata3: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
> 0x2000000f)
> ata3: spurious SDB FIS 004040a1:10000000 ap->qc_active=2000000f 
> qc_active=2000000f
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
> 0xfffc0)
> ata1: spurious SDB FIS 004040a1:00000020 ap->qc_active=000fffc0 
> qc_active=000fffc0
> ata2: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
> 0x7fffff3f)
> ata2: spurious SDB FIS 004040a1:00000080 ap->qc_active=7fffff3f 
> qc_active=7fffff3f
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
> 0x7fffff9f)
> ata1: spurious SDB FIS 004040a1:00000040 ap->qc_active=7fffff9f 
> qc_active=7fffff9f
> c001n03: 0: [  OK  ]
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
> 0x7ffe7fff)
> ata1: spurious SDB FIS 004040a1:00010000 ap->qc_active=7ffe7fff 
> qc_active=7ffe7fff
> c001n04: 0: [  OK  ]
> ata3: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x31)
> ata3: spurious SDB FIS 004040a1:00000008 ap->qc_active=00000031 
> qc_active=00000031
> ata3: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
> 0x7fff800f)
> ata3: spurious SDB FIS 004040a1:00004000 ap->qc_active=7fff800f 
> qc_active=7fff800f
> c001n06: 1: [ FAIL ]
> c001n07: 0: [  OK  ]
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
> 0x7ffffcff)
> ata1: spurious SDB FIS 004040a1:00000200 ap->qc_active=7ffffcff 
> qc_active=7ffffcff
> c001n08: 0: [  OK  ]
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 
> 0x4fffffff)
> ata1: spurious SDB FIS 004040a1:20000000 ap->qc_active=4fffffff 
> qc_active=4fffffff

Hmmm.. The drive is issuing SDB FIS which completes already completed 
tags.  This could be dangerous.  Depending on timing, it might end up 
finishing a command which occupied the slot which hasn't been processed 
yet.  If a drive does this, NCQ shouldn't be enabled for it.  Can you 
post full boot dmesg?

I'm attaching slightly modified version of the debug patch just in case. 
  It will probably show the same thing.

-- 
tejun

--------------050705070605000101030605
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 45fd71d..f9eeb15 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -876,6 +876,7 @@ static void ahci_host_intr(struct ata_po
 	struct ata_eh_info *ehi = &ap->eh_info;
 	u32 status, qc_active;
 	int rc;
+	u32 orig_qc_active = ap->qc_active;
 
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
@@ -916,10 +917,19 @@ static void ahci_host_intr(struct ata_po
 			return;
 	}
 
-	if (ata_ratelimit())
+	if (ata_ratelimit()) {
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
 				"(irq_stat 0x%x active_tag %d sactive 0x%x)\n",
 				status, ap->active_tag, ap->sactive);
+		if (status & PORT_IRQ_SDB_FIS) {
+			struct ahci_port_priv *pp = ap->private_data;
+			u32 *sdb_fis = pp->rx_fis + 0x58;
+
+			ata_port_printk(ap, KERN_INFO, "spurious SDB FIS "
+				"%08x:%08x orig_qc_active=%08x qc_active=%08x\n",
+				sdb_fis[0], sdb_fis[1], orig_qc_active, qc_active);
+		}
+	}
 }
 
 static void ahci_irq_clear(struct ata_port *ap)

--------------050705070605000101030605--
