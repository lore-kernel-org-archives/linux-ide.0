From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 07/11] libata-eh-fw: implement freeze/thaw
Date: Tue, 16 May 2006 19:17:15 +0800
Message-ID: <4469B4BB.7070707@tw.ibm.com>
References: <11473504441058-git-send-email-htejun@gmail.com> <4469A63F.3040705@tw.ibm.com> <4469A9D3.5030006@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:51905 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751780AbWEPLRW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 07:17:22 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4GBHLFb001135
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 07:17:21 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4GBHLrI178536
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 05:17:21 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4GBHK6k002656
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 05:17:21 -0600
In-Reply-To: <4469A9D3.5030006@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Albert Lee wrote:
> 
>> With the new ata_drive_probe_reset(), my old Acer 787E drive still got
>> "irq nobody cared"
>> when probed. (dmesg attached. The problem only seen on this drive;
>> other CD-ROM drives works ok.)
>> The pata_pdc2027x driver has been converted to the ->probe_reset()
>> interface.
>> Is there anything else I should do for pata_pdc2027x driver to avoid
>> the "irq nobody cared"?
> 
> 
> You need to implement both ->probe_reset() and ->error_handler() &
> friends to avoid "irq nobody cared".  Note that hotplug merges probing
> into ->error_handler() and removes ->probe_reset().
> 
> The actual part which helps avoiding "irq nobody cared" during
> initialization is proper implementation of ->freeze() and ->thaw().  If
> the controller can detect spurious interrupts, freezing on spurious
> interrupts can help avoiding screaming interrupts, too.
> 

Adding the required ->freeze() etc fixes the "irq nobody cares" problem.

Although the Acer 787E drive still failed to IDENTIFY and doesn't work,
the other two good drives are probed and work fine.
With the new EH, libata looks more robust with faulty hardware. :)

Thanks,

Albert


===

pata_pdc2027x 0000:02:05.0: version 0.74
ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 5 (level, low) -> IRQ 5
pata_pdc2027x 0000:02:05.0: PLL input clock 16728 kHz
ata5: PATA max UDMA/133 cmd 0xE0A917C0 ctl 0xE0A91FDA bmdma 0xE0A91000 irq 5
ata6: PATA max UDMA/133 cmd 0xE0A915C0 ctl 0xE0A91DDA bmdma 0xE0A91008 irq 5
ata5.00: cfg 49:0b00 82:0210 83:1000 84:0000 85:0000 86:0000 87:0000 88:0407
ata5.00: ATAPI, max UDMA/33
ata5.01: cfg 49:0f00 82:421c 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
ata5.01: ATAPI, max UDMA/33
ata5.00: configured for UDMA/33
ata5.01: configured for UDMA/33
scsi4 : pata_pdc2027x
ata6.00: cfg 49:0b00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata6.00: ATAPI, max MWDMA1
ata6.00: qc timeout (cmd 0xa1)
ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata6.00: revalidation failed (errno=-5)
ata6.00: limiting speed to MWDMA0
ata6.00: cfg 49:2020 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata6.00: ATAPI, max PIO0
ata6.00: failed to set xfermode (err_mask=0x1)
ata6.00: disabled
scsi5 : pata_pdc2027x
  Vendor: LITE-ON   Model: CD-RW SOHR-5238S  Rev: 4S07
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: HL-DT-ST  Model: DVDRAM GSA-4163B  Rev: A101
  Type:   CD-ROM                             ANSI SCSI revision: 05
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 4:0:0:0: Attached scsi CD-ROM sr0
sr1: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
sr 4:0:1:0: Attached scsi CD-ROM sr1

