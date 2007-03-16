From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: DVD drive fails in 2.6.20.2
Date: Sat, 17 Mar 2007 00:34:04 +0800
Message-ID: <45FAC6FC.4020105@tw.ibm.com>
References: <45F631F7.6020106@mail.utexas.edu> <45F7760B.10102@gmail.com> <45F81177.9070106@mail.utexas.edu> <45F8E628.2010004@gmail.com> <45F9516D.4090008@mail.utexas.edu> <45F98923.1040601@tw.ibm.com> <45FA07E2.6080008@mail.utexas.edu>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:44617 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965571AbXCPQeW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 12:34:22 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l2GGWlfo010494
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 12:32:47 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2GGYMIO040962
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 10:34:22 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2GGYLnj028537
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 10:34:21 -0600
In-Reply-To: <45FA07E2.6080008@mail.utexas.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vlad Codrea <VladCodrea@mail.utexas.edu>
Cc: albertl@mail.com, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Vlad Codrea wrote:

> 
> Hi,
> 
> I've attached the full dmesg after applying Albert's patch. The new
> messages seem to be:
> 
> ata2: protocol 7 task_state 4
> ata2: protocol 7 task_state 4 (dev_stat 0x58)
> ata2: protocol 7 task_state 2
> ata2: protocol 7 task_state 2 (dev_stat 0x58)
> ata2: protocol 7 task_state 3 (dev_stat 0x58)
> 
 
<snip>

> libata version 2.00 loaded.
> ata_piix 0000:00:07.1: version 2.00ac7
> ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFCF0 irq 14
> ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xFCF8 irq 15
> scsi0 : ata_piix
> PM: Adding info for No Bus:host0
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> USB Universal Host Controller Interface driver v3.0
> ata1.00: ATA-4, max UDMA/33, 12685680 sectors: LBA 
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: configured for UDMA/33
> scsi1 : ata_piix
> PM: Adding info for No Bus:host1
> ata2.00: ATAPI, max MWDMA2, CDB intr
> ata2.00: configured for MWDMA2
> PM: Adding info for No Bus:target0:0:0
> scsi 0:0:0:0: Direct-Access     ATA      IBM-DADA-26480   AD6O PQ: 0 ANSI: 5
> PM: Adding info for scsi:0:0:0:0
> PM: Adding info for No Bus:target1:0:0
> ata2: protocol 7 task_state 4
> ata2: protocol 7 task_state 4 (dev_stat 0x58)
> ata2: protocol 7 task_state 2
> ata2: protocol 7 task_state 2 (dev_stat 0x58)
> ata2: protocol 7 task_state 3 (dev_stat 0x58)
> ata2.00: ata_eh_analyze_tf, AC_ERR_HSM, 0x58
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (BMDMA stat 0x5)
> ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
>          res 58/00:02:00:24:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
> ata2: soft resetting port
> ata2: port is slow to respond, please be patient (Status 0xd8)
> ata2: port failed to respond (30 secs, Status 0xd8)
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177

ata2: protocol 7 task_state 4   <=== The device interrupts to receive CDB
ata2: protocol 7 task_state 4 (dev_stat 0x58)  <== Good, DRQ seen. CDB sent.
ata2: protocol 7 task_state 2   <=== interrupt. We expect DMA complete.
ata2: protocol 7 task_state 2 (dev_stat 0x58) <== What? DRQ set? No good.
ata2: protocol 7 task_state 3 (dev_stat 0x58) <== HSM violation.
(BMDMA stat 0x5) <=== Interrupted, DMA active.

Still no clue why the device wrongly sets DRQ here for a DMA transfer...
Possibilities:
1. HSM sent all CDB to the device, but the device is waiting for more CDB data?
2. HSM asked the drive to do ATAPI DMA, but the drive is doing PIO?

Hi Vlad,

Could you please turn off ATAPI DMA and see if the drive works under PIO,
thanks.

--
albert

(This is not a patch. Please edit drivers/ata/libata-core.c as below.)

int ata_check_atapi_dma(struct ata_queued_cmd *qc)
{
	struct ata_port *ap = qc->ap;
	int rc = 0; /* Assume ATAPI DMA is OK by default */

	if (ap->ops->check_atapi_dma)
		rc = ap->ops->check_atapi_dma(qc);

 rc = 1; (<==== Please add "rc = 1;" here to turn off ATAPI DMA. )

	return rc;
}

