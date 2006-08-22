From: Kevin Hilman <khilman@mvista.com>
Subject: Re: PCI SATA controllers on embedded, no-BIOS targets
Date: Tue, 22 Aug 2006 14:58:43 -0700
Message-ID: <44EB7E13.5090807@mvista.com>
References: <44EB32E4.8080706@mvista.com> <44EB33BB.4090101@gmail.com> <44EB3650.1080404@mvista.com> <44EB3E2F.4040504@gmail.com> <44EB3F70.6000702@gmail.com> <44EB40DA.3010904@mvista.com> <44EB4658.3060207@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010602000703030108050701"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:31814 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750704AbWHVV6o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Aug 2006 17:58:44 -0400
In-Reply-To: <44EB4658.3060207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Deepak Saxena <dsaxena@mvista.com>

This is a multi-part message in MIME format.
--------------010602000703030108050701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Kevin Hilman wrote:
>>>> I've personally seen it working on XScale and ATI's mips.
>>
>> OK, that's good to know.
>>
>>> For the record, for ATI's new mips platform, sata_sil needs some 
>>> modifications.  Their PCI bridge can't handle byte-aligned mmio and 
>>> the driver had to be modified to use IO address space.
>>
>> I'm using 2.6.18-rc4 on this XScale IXP425 (big endian) and both the 
>> legacy driver (drivers/ide/pci/siimage.c) and the libata driver 
>> (drivers/scsi/sata_sil.c) cause crashes during probing due to bad 
>> memory accesses.
> 
> So, that one can't do byte-aligned mmio either?
> 
>> Switching the legacy driver into PIO mode makes the probing work well, 
>> but still can't figure out what's happening in the libata driver, 
>> AFICT, it can't do PIO.
> 
> By PIO, you mean accessing registers via IO address space instead of 
> memory address space, right?  Not PIO as opposed to DMA.

yes, I mean using PCI IO address space.

>> Any chance you can share the changes to use IO address space?  Maybe 
>> the PCI on this XScale has similar limitations.
> 
> Sure, I've just got okay for releasing the code and am going to post the 
> patches on my website anyway.  I'm attaching a patch.  This might not 
> apply cleanly to your kernel but it should give enough idea.  Oh the 
> code kills 4 ports support for 3114 too.

OK, tweaking your patch onto 2.6.18-rc4, I've got it to work using IO 
address space.  My patch attached for reference.  FYI, in addition to 
your changes, I also had to change the data_xfer method to use 
ata_pio_data_xfer instead of ata_mmio_data_xfer which was faulting since 
  my arch doesn't have direct memory access to IO space.

Kevin

--------------010602000703030108050701
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="sata_sil-use-pio-instead-of-mmio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_sil-use-pio-instead-of-mmio.patch"

Index: dev/drivers/scsi/sata_sil.c
===================================================================
--- dev.orig/drivers/scsi/sata_sil.c
+++ dev/drivers/scsi/sata_sil.c
@@ -57,7 +57,7 @@ enum {
 	SIL_FLAG_MOD15WRITE	= (1 << 30),
 
 	SIL_DFL_HOST_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_HRST_TO_RESUME,
+				  ATA_FLAG_HRST_TO_RESUME,
 
 	/*
 	 * Controller IDs
@@ -200,7 +200,7 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_mmio_data_xfer,
+	.data_xfer		= ata_pio_data_xfer,
 	.freeze			= sil_freeze,
 	.thaw			= sil_thaw,
 	.error_handler		= ata_bmdma_error_handler,
@@ -670,13 +670,35 @@ static int sil_init_one (struct pci_dev 
 
 	base = (unsigned long) mmio_base;
 
-	for (i = 0; i < probe_ent->n_ports; i++) {
-		probe_ent->port[i].cmd_addr = base + sil_port[i].tf;
-		probe_ent->port[i].altstatus_addr =
-		probe_ent->port[i].ctl_addr = base + sil_port[i].ctl;
-		probe_ent->port[i].bmdma_addr = base + sil_port[i].bmdma;
-		probe_ent->port[i].scr_addr = base + sil_port[i].scr;
-		ata_std_ports(&probe_ent->port[i]);
+	if (ent->driver_data == sil_3114) {
+		for (i = 0; i < probe_ent->n_ports; i++) {
+			probe_ent->port[i].cmd_addr = base + sil_port[i].tf;
+			probe_ent->port[i].altstatus_addr =
+			probe_ent->port[i].ctl_addr = base + sil_port[i].ctl;
+			probe_ent->port[i].bmdma_addr = base + sil_port[i].bmdma;
+			probe_ent->port[i].scr_addr = base + sil_port[i].scr;
+			ata_std_ports(&probe_ent->port[i]);
+		}
+	} else {
+		/* Use PIO for 3112/3512.  Some platforms barf on
+		 * byte-wide mmio on odd boundary.
+		 */
+		probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
+		probe_ent->port[0].altstatus_addr =
+			probe_ent->port[0].ctl_addr =
+			pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
+		probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
+		probe_ent->port[0].scr_addr = base + sil_port[0].scr;
+		ata_std_ports(&probe_ent->port[0]);
+ 
+		probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
+		probe_ent->port[1].altstatus_addr =
+			probe_ent->port[1].ctl_addr =
+			pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
+		probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
+		probe_ent->port[1].scr_addr = base + sil_port[1].scr;
+		ata_std_ports(&probe_ent->port[1]);
+
 	}
 
 	sil_init_controller(pdev, probe_ent->n_ports, probe_ent->host_flags,

--------------010602000703030108050701--
