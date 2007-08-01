From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Wed, 01 Aug 2007 17:40:51 +0400
Message-ID: <46B08D63.4040205@ru.mvista.com>
References: <1185880124.3483.25.camel@localhost> <46AF76D7.8050800@ru.mvista.com> <1185916925.8484.23.camel@orchid.arb.net> <200707312332.10820.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:23891 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760821AbXHANiw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 09:38:52 -0400
In-Reply-To: <200707312332.10820.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Bob Ham <rah@bash.sh>, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>>I've had a Highpoint Rocket 1540 (not "RocketRAID") SATA controller for
>>>>>a while now, using a proprietary binary driver from Highpoint in a linux
>>>>>2.4 kernel.  The chipset is an hpt374.  The hpt366 driver freezes on
>>>>>boot, as reported by others.

>>>>   Can we see a bootlog please?

>>>    ... and the output of 'lspci -v' too.

    If possible, turn off that driver, rebuild the kernel, and reboot using 
some other IDE driver (or NFS), then post that output...

>>The machine locks hard when the driver is loaded so I can't give a full
>>transcription, but here is the driver's output:

>>HPT374: IDE controller at PCI slot 0000:00:0d.0
>>ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
>>HPT374: chipset revision 7
>>HPT374: DPLL base: 48 MHz, f_CNT: 141, assuming 33 MHz PCI
>>HPT374: using 50 MHz DPLL clock
>>HPT374: 100% native mode on irq 16
>>    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:DMA, hdf:pio
>>    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
>>ACPI: PCI Interrupt 0000:00:0d.1[A] -> GSI 16 (level, low) -> IRQ 16
>>HPT374: no clock data saved by BIOS
>>HPT374: DPLL base: 48 MHz, f_CNT: 93, assuming 33 MHz PCI
>>HPT374: using 50 MHz DPLL clock
>>    ide4: BM-DMA at 0xed00-0xed07, BIOS settings: hdi:DMA, hdj:pio
>>    ide5: BM-DMA at 0xed08-0xed0f, BIOS settings: hdk:DMA, hdl:pio

    That "f_CNT: 93" on the 2nd HPT374 function looks *very* suspicious -- at 
first I thought that DPLL is shared between 2 functions but the datasheet 
denied it...
    Well, the 1st function doesn't complain about the clock data being unsaved 
by BIOS, so I guess it's only saved for this function, and for 2nd one the 
driver resorts to reading the f_CNT register itself -- which is already spoilt 
by the HPT BIOS' own DPLL calibration. Will post a patch to try soon...

>>The pata_hpt37x driver is refusing to work as well but it doesn't crash
>>the machine.  Here is the relevant error message:

>>hpt37x: DPLL did not stabilize.
>>pata_hpt37x: BIOS has not set timing clocks.
>>hpt37x: DPLL did not stabilize.

> Does this patch change anything?

    Heh, did you *really* hope it will? :-D

> [PATCH] hpt366: always tune PIO

> Index: b/drivers/ide/pci/hpt366.c
> ===================================================================
> --- a/drivers/ide/pci/hpt366.c
> +++ b/drivers/ide/pci/hpt366.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/drivers/ide/pci/hpt366.c		Version 1.10	Jun 29, 2007
> + * linux/drivers/ide/pci/hpt366.c		Version 1.11	Jul 29, 2007
>   *
>   * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
>   * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
> @@ -1265,10 +1265,10 @@ static void __devinit init_hwif_hpt366(i
>  	if (new_mcr != old_mcr)
>  		pci_write_config_byte(dev, hwif->select_data + 1, new_mcr);
>  
> -	if (!hwif->dma_base) {
> -		hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
> +	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
> +
> +	if (hwif->dma_base == 0)
>  		return;
> -	}
>  
>  	hwif->ultra_mask = hwif->cds->udma_mask;
>  	hwif->mwdma_mask = 0x07;

    Concerning the patch (I lacked time to look at the driver to refresh my 
memory before -- was looking at the new Disk-on-chip H3 driver to be submitted 
for comments soon, BTW): it makes little sense in its current form since 
setting any DMA mode also sets 8-bit PIO timings now (and if DMA can't be set, 
the driver will fallback to PIO anyway)
    I have a patch that changes this behavior and switches to always 
auto-tuning PIO but I've changed my mind on how the DMA/PIO timing register 
sharing should be handled now -- however, since I was unable to come up with 
anything better all that time, I'll consider pushing out this version when I 
have a spare time...

WBR, Sergei
