From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 25/68] it8213: always program control bits
Date: Fri, 29 Jan 2010 20:36:08 +0300
Message-ID: <4B631C88.2020307@ru.mvista.com>
References: <20100129160308.21495.14120.sendpatchset@localhost> <20100129160551.21495.52656.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-2929.mvista.com ([206.112.117.47]:35164 "HELO
	gateway-2929.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754119Ab0A2R41 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2010 12:56:27 -0500
In-Reply-To: <20100129160551.21495.52656.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] it8213: always program control bits
>
> This matches behavior of libata pata_it8213 host driver.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/it8213.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> Index: b/drivers/ide/it8213.c
> ===================================================================
> --- a/drivers/ide/it8213.c
> +++ b/drivers/ide/it8213.c
> @@ -55,15 +55,13 @@ static void it8213_set_pio_mode(ide_hwif
>  	if (is_slave) {
>  		master_data |=  0x4000;
>  		master_data &= ~0x0070;
> -		if (pio > 1)
> -			master_data = master_data | (control << 4);
> +		master_data = master_data | (control << 4);
>   

    master_data |= control << 4; /* it's C after all */

>  		pci_read_config_byte(dev, slave_port, &slave_data);
>  		slave_data = slave_data & 0xf0;
>  		slave_data = slave_data | (timings[pio][0] << 2) | timings[pio][1];
>  	} else {
>  		master_data &= ~0x3307;
> -		if (pio > 1)
> -			master_data = master_data | control;
> +		master_data = master_data | control;
>   

    master_data |= control;

>  		master_data = master_data | (timings[pio][0] << 12) | (timings[pio][1] << 8);
>   

MBR, Sergei

