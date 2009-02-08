From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
Date: Sun, 08 Feb 2009 14:44:58 +0300
Message-ID: <498EC5BA.4080002@ru.mvista.com>
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:50640 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752506AbZBHLpH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Feb 2009 06:45:07 -0500
In-Reply-To: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

> This is the driver for the Toshiba TX4938 SoC EBUS controller ATA mode.
> It has custom set_pio_mode and some hacks for big endian.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>   
[...]
> +static void tx4938ide_input_data_swap(ide_drive_t *drive, struct request *rq,
> +				void *buf, unsigned int len)
> +{
> +	unsigned long port = drive->hwif->io_ports.data_addr;
> +	unsigned short *ptr = buf;
> +	unsigned int count = (len + 1) / 2;
> +
> +	while (count--)
> +		*ptr++ = cpu_to_le16(__raw_readw((void __iomem *)port));
> +	__ide_flush_dcache_range((unsigned long)buf, count * 2);
> +}
> +
> +static void tx4938ide_output_data_swap(ide_drive_t *drive, struct request *rq,
> +				void *buf, unsigned int len)
> +{
> +	unsigned long port = drive->hwif->io_ports.data_addr;
> +	unsigned short *ptr = buf;
> +	unsigned int count = (len + 1) / 2;
> +
> +	while (count--) {
> +		__raw_writew(le16_to_cpu(*ptr), (void __iomem *)port);
> +		ptr++;
> +	}
> +	__ide_flush_dcache_range((unsigned long)buf, count * 2);
> +}

   Atsushi, does TX49 really suffer from the issue that these flushes 
are trying to address?

MBR, Sergei


