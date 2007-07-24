From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.23-rc1] ata_piix: EH pending after completion, repeating
 EH (cnt=4)
Date: Tue, 24 Jul 2007 17:32:29 +0900
Message-ID: <46A5B91D.403@gmail.com>
References: <200707231047.l6NAlKdt003284@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010600000706040703090007"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:43428 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbXGXIcg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jul 2007 04:32:36 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2306636wah
        for <linux-ide@vger.kernel.org>; Tue, 24 Jul 2007 01:32:36 -0700 (PDT)
In-Reply-To: <200707231047.l6NAlKdt003284@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010600000706040703090007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Mikael Pettersson wrote:
> This machine has a known good Samsung SATA DVD on ICH8 [8086:2820].
> With kernel 2.6.23-rc1 I now get the following:
> 
>> ata_piix 0000:00:1f.2: version 2.11
>> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
>> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
>> PCI: Setting latency timer of device 0000:00:1f.2 to 64
>> scsi2 : ata_piix
>> scsi3 : ata_piix
>> ata3: SATA max UDMA/133 cmd 0x0001ec00 ctl 0x0001e882 bmdma 0x0001e400 irq 19
>> ata4: SATA max UDMA/133 cmd 0x0001e800 ctl 0x0001e482 bmdma 0x0001e408 irq 19
>> ata4.00: ATAPI: TSSTcorpCD/DVDW SH-S183A, SB00, max UDMA/33
>> ata4.00: applying bridge limits
>> ata4.00: configured for UDMA/33
>> ata4: EH pending after completion, repeating EH (cnt=4)
>> scsi 3:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183A SB00 PQ: 0 ANSI: 5
> 
> The "EH pending after completion" is new and did not occur with 2.6.22.
> Apart from that message, things seem fine.

Hmmm... That means someone requested EH while EH was in progress.
Weird.  Can you apply the attached patch and report what the kernel
says?  Thanks.

-- 
tejun

--------------010600000706040703090007
Content-Type: text/x-patch;
 name="debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6001aae..0b03a6f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6425,7 +6425,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 
 			ehi->probe_mask = (1 << ATA_MAX_DEVICES) - 1;
 			ehi->action |= ATA_EH_SOFTRESET;
-			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
+			ehi->flags |= ATA_EHI_NO_AUTOPSY/* | ATA_EHI_QUIET*/;
 
 			ap->pflags &= ~ATA_PFLAG_INITIALIZING;
 			ap->pflags |= ATA_PFLAG_LOADING;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ac6ceed..e61c1e0 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -715,6 +715,11 @@ void ata_port_schedule_eh(struct ata_port *ap)
 	ata_eh_set_pending(ap, 1);
 	scsi_schedule_eh(ap->scsi_host);
 
+	if (ap->pflags & ATA_PFLAG_LOADING) {
+		printk("EH scheduled with LOADING set\n");
+		dump_stack();
+	}
+
 	DPRINTK("port EH scheduled\n");
 }
 

--------------010600000706040703090007--
