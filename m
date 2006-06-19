From: Aalderd Bouwman <aalderd.boac@wanadoo.nl>
Subject: Re: Seagate SATA 3GB/s drive connected to via vt8251 using
	ahci	module
Date: Mon, 19 Jun 2006 19:10:52 +0200
Message-ID: <1150737053.4220.7.camel@anja>
References: <1149787827.4180.8.camel@anja> <44890ACA.5070504@gmail.com>
	 <1150108974.4020.3.camel@anja> <448D474E.6020706@gmail.com>
	 <1150111457.4060.2.camel@anja>  <20060618025632.GE11755@htj.dyndns.org>
Reply-To: aalderd.boac@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp04.wanadoo.nl ([194.134.35.144]:39958 "EHLO
	smtp04.wanadoo.nl") by vger.kernel.org with ESMTP id S964808AbWFSRId
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jun 2006 13:08:33 -0400
In-Reply-To: <20060618025632.GE11755@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hm, I only have seen spurious interrupts when I have executed fdisk:

Now doing fdisk /dev/sda or mke2fs /dev/sda1: 
Kernel log:
Jun  8 18:52:19 server ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x2)
Jun  8 18:53:09 server ata1.00: qc timeout (cmd 0x2f)
Jun  8 18:53:09 server ata1: failed to read log page 10h (errno=-5)
Jun  8 18:53:09 server ata1.00: exception Emask 0x1 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
Jun  8 18:53:09 server ata1.00: (irq_stat 0x40000000)

Now I am unable to do fdisk because the drive is taken offline:

Jun 19 18:31:36 server ahci 0000:00:0f.0: version 1.3
Jun 19 18:31:36 server ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Jun 19 18:31:42 server ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA mode
Jun 19 18:31:42 server ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio slum part 
Jun 19 18:31:42 server ata21: SATA max UDMA/133 cmd 0xE0488D00 ctl 0x0 bmdma 0x0 irq 10
Jun 19 18:31:42 server ata22: SATA max UDMA/133 cmd 0xE0488D80 ctl 0x0 bmdma 0x0 irq 10
Jun 19 18:31:42 server ata23: SATA max UDMA/133 cmd 0xE0488E00 ctl 0x0 bmdma 0x0 irq 10
Jun 19 18:31:42 server ata24: SATA max UDMA/133 cmd 0xE0488E80 ctl 0x0 bmdma 0x0 irq 10
Jun 19 18:31:42 server ata21: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 19 18:31:42 server ata21.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:007f
Jun 19 18:31:42 server ata21.00: ATA-7, max UDMA/133, 156301488 sectors: LBA48 NCQ (depth 31/32)
Jun 19 18:31:42 server ata21.00: configured for UDMA/133
Jun 19 18:31:42 server scsi20 : ahci
Jun 19 18:31:42 server ata22: SATA link down (SStatus 0 SControl 300)
Jun 19 18:31:42 server scsi21 : ahci
Jun 19 18:31:43 server ata23: SATA link down (SStatus 0 SControl 300)
Jun 19 18:31:43 server scsi22 : ahci
Jun 19 18:31:43 server ata24: SATA link down (SStatus 0 SControl 300)
Jun 19 18:31:43 server scsi23 : ahci
Jun 19 18:31:43 server Vendor: ATA       Model: ST3808110AS       Rev: 3.AA
Jun 19 18:31:43 server Type:   Direct-Access                      ANSI SCSI revision: 05
Jun 19 18:31:43 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Jun 19 18:31:43 server sda: Write Protect is off
Jun 19 18:31:43 server sda: Mode Sense: 00 3a 00 00
Jun 19 18:31:43 server SCSI device sda: drive cache: write back
Jun 19 18:31:43 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Jun 19 18:31:43 server sda: Write Protect is off
Jun 19 18:31:43 server sda: Mode Sense: 00 3a 00 00
Jun 19 18:31:43 server SCSI device sda: drive cache: write back
Jun 19 18:31:43 server sda: sda1 sda2 sda3 sda4 < sda5 >
Jun 19 18:31:43 server sd 20:0:0:0: Attached scsi disk sda
Jun 19 18:31:43 server sd 20:0:0:0: Attached scsi generic sg0 type 0
Jun 19 18:32:13 server ata21.00: qc timeout (cmd 0x2f)
Jun 19 18:32:13 server ata21: failed to read log page 10h (errno=-5)
Jun 19 18:32:13 server ata21.00: exception Emask 0x1 SAct 0x7 SErr 0x0 action 0x2 frozen
Jun 19 18:32:13 server ata21.00: (irq_stat 0x40000000)
Jun 19 18:32:13 server ata21.00: tag 0 cmd 0x60 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun 19 18:32:13 server ata21.00: tag 1 cmd 0x60 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun 19 18:32:13 server ata21.00: tag 2 cmd 0x60 Emask 0x1 stat 0x41 err 0x4 (device error)
Jun 19 18:32:13 server ata21: soft resetting port
Jun 19 18:32:13 server ata21: softreset failed (1st FIS failed)
Jun 19 18:32:13 server ata21: softreset failed, retrying in 5 secs
Jun 19 18:32:18 server ata21: hard resetting port
Jun 19 18:32:26 server ata21: port is slow to respond, please be patient
Jun 19 18:32:49 server ata21: port failed to respond (30 secs)
Jun 19 18:32:49 server ata21: COMRESET failed (device not ready)
Jun 19 18:32:49 server ata21: hardreset failed, retrying in 5 secs
Jun 19 18:32:54 server ata21: hard resetting port
Jun 19 18:33:01 server ata21: port is slow to respond, please be patient
Jun 19 18:33:24 server ata21: port failed to respond (30 secs)
Jun 19 18:33:24 server ata21: COMRESET failed (device not ready)
Jun 19 18:33:24 server ata21: reset failed, giving up
Jun 19 18:33:24 server ata21.00: disabled
Jun 19 18:33:24 server ata21: EH complete
Jun 19 18:33:24 server sd 20:0:0:0: SCSI error: return code = 0x40000
Jun 19 18:33:24 server end_request: I/O error, dev sda, sector 20836243
Jun 19 18:33:24 server printk: 971 messages suppressed.
Jun 19 18:33:24 server Buffer I/O error on device sda3, logical block 19551043
Jun 19 18:33:24 server sd 20:0:0:0: SCSI error: return code = 0x40000
Jun 19 18:33:24 server end_request: I/O error, dev sda, sector 273039
Jun 19 18:33:24 server Buffer I/O error on device sda1, logical block 136488
Jun 19 18:33:24 server sd 20:0:0:0: SCSI error: return code = 0x40000

This is a log with the given patch.

Maybe I should reboot the machine? (note ata1 in first given log)

Aalderd.

On Sun, 2006-06-18 at 11:56 +0900, Tejun Heo wrote: 
> Can you apply the following patch and report back what the kernel
> says?  The following might generate quite a bit of log messages, but
> if your boot drive doesn't generate spurious interrupts, it should be
> bearable.
> 
> diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
> index e261b37..be3ee0d 100644
> --- a/drivers/scsi/ahci.c
> +++ b/drivers/scsi/ahci.c
> @@ -909,25 +909,18 @@ static void ahci_host_intr(struct ata_po
>  	}
>  
>  	/* hmmm... a spurious interupt */
> +	ata_port_printk(ap, KERN_INFO, "spurious interrupt "
> +			"(irq_stat 0x%x active_tag %x sactive 0x%x)\n",
> +			status, ap->active_tag, ap->sactive);
>  
> -	/* some devices send D2H reg with I bit set during NCQ command phase */
> -	if (ap->sactive && status & PORT_IRQ_D2H_REG_FIS)
> -		return;
> -
> -	/* ignore interim PIO setup fis interrupts */
> -	if (ata_tag_valid(ap->active_tag)) {
> -		struct ata_queued_cmd *qc =
> -			ata_qc_from_tag(ap, ap->active_tag);
> +	if (status & PORT_IRQ_SDB_FIS) {
> +		struct ahci_port_priv *pp = ap->private_data;
> +		u32 *sdb_fis = pp->rx_fis + 0x58;
>  
> -		if (qc && qc->tf.protocol == ATA_PROT_PIO &&
> -		    (status & PORT_IRQ_PIOS_FIS))
> -			return;
> +		ata_port_printk(ap, KERN_INFO, "spurious SDB FIS "
> +				"%08x:%08x ap->qc_active=%08x qc_active=%08x\n",
> +				sdb_fis[0], sdb_fis[1], ap->qc_active, qc_active);
>  	}
> -
> -	if (ata_ratelimit())
> -		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
> -				"(irq_stat 0x%x active_tag %d sactive 0x%x)\n",
> -				status, ap->active_tag, ap->sactive);
>  }
>  
>  static void ahci_irq_clear(struct ata_port *ap)
> 

