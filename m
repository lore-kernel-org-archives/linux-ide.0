From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 00:24:48 +0900
Message-ID: <4469EEC0.4060907@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060405080208050302070809"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:40553 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751215AbWEPPY5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 11:24:57 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1043320ugc
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 08:24:56 -0700 (PDT)
In-Reply-To: <4469E0DB.1040709@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Ric Wheeler <ric@emc.com>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

This is a multi-part message in MIME format.
--------------060405080208050302070809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Ric Wheeler wrote:
>>
>> Jeff Garzik wrote:
>>
>>> TESTING:
>>> * Although most drivers by count received few operational changes, the
>>> common probe path was updated, so all drivers need fresh "yes, it sees
>>> all my disks" regression testing.
>>>
>>> * ahci and sata_sil24 were touched a lot, and so need additional
>>> testing.
>>>
>>> * sata_sil and ata_piix also need healthy re-testing of all basic
>>> functionality.
>>>
>>>
>>>  
>>>
>> I have been running a moderate write workload on this (built using 
>> linux-2.6.17-rc4 with your patch applied on top).  Last night, I ran 
>> on a set of clean AHCI based boxes (no bad drives) and got a serious 
>> of occasional spurious interrupts logged:
>>
>>
>> May 15 21:24:38 centera kernel: ReiserFS: sdd14: Using r5 hash to sort 
>> names
>> May 15 21:52:44 centera kernel: ata1: spurious interrupt (irq_stat 0x8 
>> active_tag -84148995 sactive 0x800)
>> May 15 22:00:02 centera run-crons[26837]: logrotate returned 1
>> May 15 22:16:00 centera kernel: ata1: spurious interrupt (irq_stat 0x8 
>> active_tag -84148995 sactive 0x4)
>> May 15 22:29:14 centera kernel: ata1: spurious interrupt (irq_stat 0x8 
>> active_tag -84148995 sactive 0x7e007fff)
>> May 15 22:35:04 centera kernel: ata3: spurious interrupt (irq_stat 0x8 
>> active_tag -84148995 sactive 0x4fffffff)
>>
>> Full messages file and lspci below, but note that this hardware has 
>> been running ahci with this config in production for over a year now.
> 
> Definitely new behavior.  In each case you have irq_stat == 0x8, which 
> indicates a Set Device Bits FIS has been received.
> 

Yeap, new behavior.  Though, one thing to note is that the original 
ahci_host_intr() never bothered to report spurious interrupt.  It always 
returned 1 telling ahci_interrupt() that the interrupt is handled.  But 
as this is SDB instead of D2H, my guess is that the drive is sending 
spurious NCQ completions with no new command completed.

Hmm.. Can you try the attached patch and report what the kernel says?

The message reminds me of several things...

* can we make tags int and use -1 for invalid tag?  ATA_TAG_POISON looks 
horrible when printed.

* it would be nice to have some framework to determine whether the 
controller is receiving too many consecutive spurious interrupts.  Say, 
32 irqs in a row without intervening valid interrupts is a good reason 
to be suspicious about stuck IRQ.  Freezing & resetting will resolve the 
situation in most cases.

* With NCQ, some drives generate spurious D2H FISes with I bit set as if 
it were executing non-NCQ commands.  So, regardless of controller, we're 
likely to see similar problems (but sil24 does all the protocol handling 
and ignores such FISes by itself).  This can be combined with the above 
freeze on too many spurious, I guess.

-- 
tejun

--------------060405080208050302070809
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 45fd71d..506f0df 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -916,10 +916,19 @@ static void ahci_host_intr(struct ata_po
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
+				"%08x:%08x ap->qc_active=%08x qc_active=%08x\n",
+				sdb_fis[0], sdb_fis[1], ap->qc_active, qc_active);
+		}
+	}
 }
 
 static void ahci_irq_clear(struct ata_port *ap)

--------------060405080208050302070809--
