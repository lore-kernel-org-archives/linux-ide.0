From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Wed, 17 Sep 2008 01:59:24 +0400
Message-ID: <48D02C3C.90705@ru.mvista.com>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:26193 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751717AbYIPV7b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Sep 2008 17:59:31 -0400
In-Reply-To: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

> This is the driver for the Toshiba TX4939 SoC ATA controller.
>
> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/port_ops routines.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>   
[...]
> diff --git a/drivers/ide/mips/tx4939ide.c b/drivers/ide/mips/tx4939ide.c
> new file mode 100644
> index 0000000..ba9776d
> --- /dev/null
> +++ b/drivers/ide/mips/tx4939ide.c
> @@ -0,0 +1,762 @@
>   
[...]
> +static int __tx4939ide_dma_setup(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	struct request *rq = HWGROUP(drive)->rq;
> +	unsigned int reading;
> +	u8 dma_stat;
> +	unsigned long base = TX4939IDE_BASE(hwif);
> +
> +	if (rq_data_dir(rq))
> +		reading = 0;
> +	else
> +		reading = 1 << 3;
> +
> +	/* fall back to pio! */
> +	if (!ide_build_dmatable(drive, rq)) {
> +		ide_map_sg(drive, rq);
> +		return 1;
> +	}
> +#ifdef __BIG_ENDIAN
> +	{
> +		unsigned int *table = hwif->dmatable_cpu;
>   

   s/unsigned int/__le32/ perhaps?

> +		while (1) {
> +			cpu_to_le64s((u64 *)table);
>   

   Wait, PRD is already already in LE format, so this should be 
le64_to_cpus().

> +			if (*table & 0x80000000)
>   

   Hum... you don't have to check that with ide_build_dmatable() 
returning the PRD count...

> +				break;
> +			table += 2;
> +		}
> +	}
> +#endif
>   

MBR, Sergei


