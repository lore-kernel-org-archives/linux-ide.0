From: sivaji <rameshmrm@gmail.com>
Subject: Re: Ultra DMA problem
Date: Sat, 26 Jul 2008 01:44:41 -0700 (PDT)
Message-ID: <18664647.post@talk.nabble.com>
References: <18664594.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kuber.nabble.com ([216.139.236.158]:39693 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbYGZIom (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jul 2008 04:44:42 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KMfOL-0005PU-Un
	for linux-ide@vger.kernel.org; Sat, 26 Jul 2008 01:44:41 -0700
In-Reply-To: <18664594.post@talk.nabble.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi,
We are using MCF5253 procesoor. In this processor we have dedicated ATA DMA
controller.  Right now we are testing the ATA interface using the  PIO and
UDMA modes. PIO modes works perfectly. When moving to the  UDMA mode,  First
we configured the ATA DMA controller registers,  then we are setting the
command in the command register.

Before configuring the ATA DMA Misccr Reigster the value of Device status
and Alternate status registers is 0x50. After configuring the Misccr
Registers the values of status and Alternate status register is 0x0. I don't
know why the STATUS register and ALTSTATUS register values are changing when
configuring the ATADMA Controller Register.  Due to this i am facing HSM
violation. Here i have attached the log. 

scsi0 : pata_fsl
ata1: PATA max UDMA/44 cmd 0x800008a0 ctl 0x800008d8 bmdma 0x00000000 irq
147
feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
hob&LBA48: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata1.00: ATA-7: ST380215A, 3.AAD, max UDMA/100
ata1.00: 156301488 sectors, multi 0: LBA48
xfer_mode:c
xfer_mode:43
feat 0x3 nsect 0x43 lba 0x0 0x0 0x0
feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
hob&LBA48: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata1.00: configured for UDMA/44
scsi 0:0:0:0: Direct-Access     ATA      ST380215A        3.AA PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
 sda:feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
sg->address:80020000
Before Setting ATADMA Device Alternate Status Register:50
Source address :18
DMA count register:1000
After setting ATADMA Device Alternate Status Register:50
pata_fsl_bmdma_start starts     qc->flags:11
pata_fsl_bmdma_start Read mode  Dma Control Register:100
pata_fsl_bmdma_start Read mode Dma Control Register:107
Alternate status Register:0
pata_fsl_bmdma_start ends
ata_host_intr: Alternate status register:0
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata1.00: BMDMA stat 0x0
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
         res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
ata1: soft resetting port
feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata1.00: revalidation failed (errno=-2)
ata1: failed to recover some devices, retrying in 5 secs
ata1: soft resetting port
feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata1.00: revalidation failed (errno=-2)
ata1: failed to recover some devices, retrying in 5 secs
ata1: soft resetting port
feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata1.00: revalidation failed (errno=-2)
ata1.00: disabled
ata1: EH pending after completion, repeating EH (cnt=4)
ata1: soft resetting port
ata1: EH complete
sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
 unable to read partition table
sd 0:0:0:0: [sda] Attached SCSI disk


Linux Version : 2.6.23-uc1

Thanks and Regards
Sivaji


sivaji wrote:
> 
> Hi,
> We are using MCF5253 procesoor. In this processor we have dedicated ATA
> DMA controller.  Right now we are testing the ATA interface using the  PIO
> and UDMA modes. PIO modes works perfectly. When moving to the  UDMA mode, 
> First we configured the ATA DMA controller registers,  then we are setting
> the command in the command register. 
> 
> Before configuring the ATA DMA Misccr Reigster the value of Device status
> and Alternate status registers is 0x50. After configuring the Misccr
> Registers the values of status and Alternate status register is 0x0. I
> don't know why the STATUS register and ALTSTATUS register values are
> changing when configuring the ATADMA Controller Register.  Due to this i
> am facing HSM violation. Here i have attached the log. Give some idea to
> fix this issue.
> 
> Linux Version : 2.6.23-uc1
> 
> Thanks and Regards
> Sivaji
> 

-- 
View this message in context: http://www.nabble.com/Ultra-DMA-problem-tp18664594p18664647.html
Sent from the linux-ide mailing list archive at Nabble.com.

