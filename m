From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ST3120026A working in 2.4.30 w sata_sil
Date: Mon, 18 Apr 2005 04:26:31 -0400
Message-ID: <42636F37.3050300@pobox.com>
References: <426352FB.1070507@nsr500.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23966 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261904AbVDRI0x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Apr 2005 04:26:53 -0400
In-Reply-To: <426352FB.1070507@nsr500.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Moore <tim.moore@nsr500.net>
Cc: linux-ide@vger.kernel.org

Tim Moore wrote:
> FYI;
> 
> Applied the v0.9 patch to sata_sil.c:
> 
> # ChangeSet
> # 2005/03/24 23:32:42-05:00 Carlos.Pardo@xxxxxxxxxxxxxxxx
> # [PATCH] sata_sil: Fix FIFO PCI Bus Arbitration
> 
> Applied this Brian Kuschak hack to libata-core.c:
> 
> --- libata-core.c.orig    2005-02-23 17:41:03.831836464 -0800
> +++ libata-core.c    2005-02-23 17:54:51.287044152 -0800
> @@ -3158,6 +3158,11 @@
>      if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
>          handled |= ata_host_intr(ap, qc);
>      }
> +    else {
> +        /* bk - just ack spurious interrupt here - temp workaround */
> +        ata_irq_ack(ap, 0);        
> +        printk(KERN_WARNING "ata%d: irq trap\n", ap->id);
> +    }
> 
> Added "pci=biosirq ide2=0 ide3=0" to boot params,
> some combination of which reliabily and repeatedly works:
> ...
> bata version 1.10 loaded.
> sata_sil version 0.9
> ata1: SATA max UDMA/100 cmd 0xF880F080 ctl 0xF880F08A bmdma 0xF880F000 
> irq 11
> ata2: SATA max UDMA/100 cmd 0xF880F0C0 ctl 0xF880F0CA bmdma 0xF880F008 
> irq 11
> ata1: irq trap
> ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3468 86:3c01 87:4003 
> 88:003f
> ata1: dev 0 ATA, max UDMA/100, 234441648 sectors: lba48
> ata1: dev 0 configured for UDMA/100
> ata2: no device found (phy stat 00000000)
> scsi2 : sata_sil
> scsi3 : sata_sil
>   Vendor: ATA       Model: ST3120026A        Rev: 3.01
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> ...
> 
> Prior to making all three of these changes, boot attempts with the sata_sil
> driver when any PATA disk was connected to the bridge would hard lock 
> just after:
> ...
> ata2: SATA max UDMA/100 cmd 0xF880F0C0 ctl 0xF880F0CA bmdma 0xF880F008 
> irq 11
> 
> The ide driver generated errors at each access and was removed:
> ...
> kernel: hde: sata_error = 0x00000000, watchdog = 0, 
> siimage_mmio_ide_dma_test_irq
> last message repeated 10 times
> 
> Hope this sheds some light.

Are you running two drivers for the same hardware, at the same time? 
(siimage and sata_sil)

That would certainly create a problem.

	Jeff



