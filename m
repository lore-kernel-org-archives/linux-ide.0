From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.23-rc1] ata_piix: EH pending after completion, repeating
 EH (cnt=4)
Date: Thu, 26 Jul 2007 15:31:10 +0900
Message-ID: <46A83FAE.9060205@gmail.com>
References: <200707241836.l6OIacth016478@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040401050803010409070301"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:22022 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbXGZGbQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 02:31:16 -0400
Received: by wa-out-1112.google.com with SMTP id v27so477589wah
        for <linux-ide@vger.kernel.org>; Wed, 25 Jul 2007 23:31:15 -0700 (PDT)
In-Reply-To: <200707241836.l6OIacth016478@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040401050803010409070301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Mikael Pettersson wrote:
> On Tue, 24 Jul 2007 17:32:29 +0900, Tejun Heo wrote:
>> Mikael Pettersson wrote:
>>> This machine has a known good Samsung SATA DVD on ICH8 [8086:2820].
>>> With kernel 2.6.23-rc1 I now get the following:
>>>
>>>> ata_piix 0000:00:1f.2: version 2.11
>>>> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
>>>> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
>>>> PCI: Setting latency timer of device 0000:00:1f.2 to 64
>>>> scsi2 : ata_piix
>>>> scsi3 : ata_piix
>>>> ata3: SATA max UDMA/133 cmd 0x0001ec00 ctl 0x0001e882 bmdma 0x0001e400 irq 19
>>>> ata4: SATA max UDMA/133 cmd 0x0001e800 ctl 0x0001e482 bmdma 0x0001e408 irq 19
>>>> ata4.00: ATAPI: TSSTcorpCD/DVDW SH-S183A, SB00, max UDMA/33
>>>> ata4.00: applying bridge limits
>>>> ata4.00: configured for UDMA/33
>>>> ata4: EH pending after completion, repeating EH (cnt=4)
>>>> scsi 3:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183A SB00 PQ: 0 ANSI: 5
>>> The "EH pending after completion" is new and did not occur with 2.6.22.
>>> Apart from that message, things seem fine.
>> Hmmm... That means someone requested EH while EH was in progress.
>> Weird.  Can you apply the attached patch and report what the kernel
>> says?  Thanks.
> 
> Here it is. As you can see from the traces, the machine also has a
> pdc20269 controller driven by pata_pdc2027x.

Hmm... I missed one path.  Can you please try the attached patch?  Thanks.

-- 
tejun

--------------040401050803010409070301
Content-Type: text/x-patch;
 name="debug-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug-1.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 88e2dd0..3a7c97e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6403,7 +6403,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 
 			ehi->probe_mask = (1 << ATA_MAX_DEVICES) - 1;
 			ehi->action |= ATA_EH_SOFTRESET;
-			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
+			ehi->flags |= ATA_EHI_NO_AUTOPSY/* | ATA_EHI_QUIET*/;
 
 			ap->pflags &= ~ATA_PFLAG_INITIALIZING;
 			ap->pflags |= ATA_PFLAG_LOADING;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 9aa62a0..c0ce3ce 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -536,6 +536,12 @@ void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
 	 * this function completes.
 	 */
 	scsi_req_abort_cmd(qc->scsicmd);
+
+	if (ap->pflags & ATA_PFLAG_LOADING) {
+		printk("EH scheduled with LOADING set cmd=%02x cdb=%02x emask=%02x\n",
+		       qc->tf.command, qc->cdb[0], qc->err_mask);
+		dump_stack();
+	}
 }
 
 /**
@@ -558,6 +564,11 @@ void ata_port_schedule_eh(struct ata_port *ap)
 	ap->pflags |= ATA_PFLAG_EH_PENDING;
 	scsi_schedule_eh(ap->scsi_host);
 
+	if (ap->pflags & ATA_PFLAG_LOADING) {
+		printk("EH scheduled with LOADING set\n");
+		dump_stack();
+	}
+
 	DPRINTK("port EH scheduled\n");
 }
 

--------------040401050803010409070301--
