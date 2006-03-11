From: Tejun Heo <htejun@gmail.com>
Subject: Re: gigabyte iRam not seen by linux
Date: Sat, 11 Mar 2006 17:58:43 +0900
Message-ID: <20060311085843.GA9067@htj.dyndns.org>
References: <20060310013604.1acac722.pegasus@nerv.eu.org> <4411BCB6.5080108@gmail.com> <44122FBD.9000909@tw.ibm.com> <20060311034630.4c12cf83.pegasus@nerv.eu.org> <20060311033143.GA12866@htj.dyndns.org> <20060311092013.487c1263.pegasus@nerv.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:25440 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932453AbWCKI6t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 03:58:49 -0500
Received: by zproxy.gmail.com with SMTP id 14so939442nzn
        for <linux-ide@vger.kernel.org>; Sat, 11 Mar 2006 00:58:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20060311092013.487c1263.pegasus@nerv.eu.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jure Pe??ar <pegasus@nerv.eu.org>
Cc: linux-ide@vger.kernel.org, albertl@mail.com, jgarzik@pobox.com

Hello, again.

On Sat, Mar 11, 2006 at 09:20:13AM +0100, Jure Pe??ar wrote:
> On Sat, 11 Mar 2006 12:31:43 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
> > Can you apply the following patch and try again?
> 
> OK, now we have this:
> 
> SCSI subsystem initialized
> libata version 1.20 loaded.
> sata_nv 0000:00:0e.0: version 0.8
> ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LSA0] -> GSI 23 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:0e.0 to 64
> ata_device_add: ENTER
> ata_host_add: ENTER
> ata_port_start: prd alloc, virt ffff810076c7e000, dma 76c7e000
> ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE482 bmdma 0xE000 irq 16
> ata_host_add: ENTER
> ata_port_start: prd alloc, virt ffff810074551000, dma 74551000
> ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE082 bmdma 0xE008 irq 16
> ata_device_add: probe begin
> ata_device_add: ata1: probe begin
> ata1: SATA link up 1.5 Gbps (SStatus 113)
> ata_bus_reset: ENTER, host 1, port 0
> ata_bus_reset: devmask=0x1
> ata_bus_softreset: ata1: bus reset via SRST
> ata_dev_try_classify: dev=0, TF 00 00:01:01:00:00 a0 50

It's reporting 0x00 for FEATURE when it should report 0x01 (indicates
diagnostic passed).

> ata_bus_reset: EXIT
> ata_dev_identify: ENTER/EXIT (host 1, dev 0) -- nodev
> ata_dev_identify: ENTER/EXIT (host 1, dev 1) -- nodev
> ata_device_add: ata1: probe end
> scsi0 : sata_nv

The patch at the tail of this mail makes ata_dev_try_classify() ignore
diagnostic code in FEATURE.  If the iRam successfully gets attached
with the patch, can you please post 'hdparm -I /dev/sdX' and 'hdparm
--Istdout /dev/sdX' of the iRam?  We're pretty curious.

Jeff, this reminds me that low level drivers which don't use
ata_dev_try_classify (ahci and sil24) currently don't check the
diagnostic codes.  Any ideas how this should be dealt with?

--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -477,7 +477,7 @@ ata_dev_try_classify(struct ata_port *ap
 	else if ((device == 0) && (err == 0x81))
 		/* do nothing */ ;
 	else
-		return ATA_DEV_NONE;
+		/*return ATA_DEV_NONE*/;
 
 	/* determine if device is ATA or ATAPI */
 	class = ata_dev_classify(&tf);
