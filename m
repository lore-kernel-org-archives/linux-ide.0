From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] scc_pata.c: Workaround	for errata A308
Date: Fri, 13 Jul 2007 20:50:10 +0400
Message-ID: <4697AD42.9090506@ru.mvista.com>
References: <200707100929.l6A9T9xp007196@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:45049 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932136AbXGMQsK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 12:48:10 -0400
In-Reply-To: <200707100929.l6A9T9xp007196@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: bzolnier@gmail.com, kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org

Hello.

Akira Iguchi wrote:
> Workaround for errata A308: turn down the UDMA mode and retry
> the DMA command when the data lost condition is detected.

> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
> ---

> diff -purN -X linux-powerpc-git/Documentation/dontdiff linux-powerpc-git/drivers/ide/pci/scc_pata.c linux-powerpc-git.mod/drivers/ide/pci/scc_pata.c
> --- linux-powerpc-git/drivers/ide/pci/scc_pata.c	2007-05-22 13:08:32.000000000 +0900
> +++ linux-powerpc-git.mod/drivers/ide/pci/scc_pata.c	2007-07-10 17:10:10.000000000 +0900
> @@ -278,6 +278,13 @@ static int scc_tune_chipset(ide_drive_t 
>  		offset = 0; /* 100MHz */
>  	}
>  
> +	/* errata A308 workaround: limit non ide_disk drive to UDMA4 */
> +	if (drive->media != ide_disk && speed > XFER_UDMA_4) {
> +		printk(KERN_INFO "%s: limit drive(media=%x) to UDMA4\n",
> +		       SCC_PATA_NAME, drive->media);
> +		speed = XFER_UDMA_4;
> +	}
> +

    The same comment as Alan had to the libata driver: use the new 
udma_filter() method for this.

> @@ -401,6 +408,33 @@ static int scc_ide_dma_end(ide_drive_t *
>  	ide_hwif_t *hwif = HWIF(drive);
>  	unsigned long intsts_port = hwif->dma_base + 0x014;
>  	u32 reg;
> +	int dma_stat, data_lost = 0;
> +	static int retry = 0;
> +
> +	/* errata A308 workaround: Step5 (check data lost) */
> +	/* We don't check non ide_disk because it is limited to UDMA4 */
> +	if (!(in_be32((void __iomem *)IDE_ALTSTATUS_REG) & ERR_STAT) &&
> +	    drive->media == ide_disk && drive->current_speed > XFER_UDMA_4) {
> +		reg = in_be32((void __iomem *)intsts_port);
> +		if (!(reg & INTSTS_ACTEINT)) {
> +			printk(KERN_WARNING "%s: data lost occurred. (ACTEINT==0, retry:%d)\n",

    Should be "data loss" -- if this indeed means that data was lost *on the 
media*.

> +			       drive->name, retry);
> +			data_lost = 1;
> +			if (retry++) {
> +				struct request *rq = HWGROUP(drive)->rq;
> +				int unit;
> +				/* ERROR_RESET and drive->crc_count are needed
> +				 * to reduce DMA transfer mode in retry process.
> +				 */
> +				if (rq)
> +					rq->errors |= ERROR_RESET;
> +				for (unit = 0; unit < MAX_DRIVES; unit++) {
> +					ide_drive_t *drive = &hwif->drives[unit];
> +					drive->crc_count++;
> +				}
> +			}
> +		}
> +	}
>  
>  	while (1) {
>  		reg = in_be32((void __iomem *)intsts_port);
> @@ -469,27 +503,25 @@ static int scc_ide_dma_end(ide_drive_t *
>  		break;
>  	}
>  
> -	return __ide_dma_end(drive);
> +	dma_stat = __ide_dma_end(drive);
> +	if (data_lost)
> +		dma_stat |= 2; /* emulate DMA error (to retry command) */
> +	return dma_stat;
>  }
>  
>  /* returns 1 if dma irq issued, 0 otherwise */
>  static int scc_dma_test_irq(ide_drive_t *drive)
>  {
> -	ide_hwif_t *hwif	= HWIF(drive);
> -	u8 dma_stat		= hwif->INB(hwif->dma_status);
> +	ide_hwif_t *hwif = HWIF(drive);
> +	u32 int_stat = in_be32((void __iomem *)hwif->dma_base + 0x014);
>  
> -	/* return 1 if INTR asserted */
> -	if ((dma_stat & 4) == 4)
> +	/* SCC errata A252,A308 workaround: Step4 */
> +	if (in_be32((void __iomem *)IDE_ALTSTATUS_REG) & ERR_STAT &&

    Enclose bitwise AND expression into parens, please.

> +	    int_stat & INTSTS_INTRQ)
>  		return 1;
>  
> -	/* Workaround for PTERADD: emulate DMA_INTR when
> -	 * - IDE_STATUS[ERR] = 1
> -	 * - INT_STATUS[INTRQ] = 1
> -	 * - DMA_STATUS[IORACTA] = 1
> -	 */
> -	if (in_be32((void __iomem *)IDE_ALTSTATUS_REG) & ERR_STAT &&
> -	    in_be32((void __iomem *)(hwif->dma_base + 0x014)) & INTSTS_INTRQ &&
> -		dma_stat & 1)
> +	/* SCC errata A308 workaround: Step5 (polling IOIRQS) */
> +	if (int_stat & INTSTS_IOIRQS)
>  		return 1;
>  
>  	if (!drive->waiting_for_dma)

MBR, Sergei
