From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata-rb532-cf: read/write data in 4-byte blocks
Date: Wed, 12 Nov 2008 13:50:05 +0300
Message-ID: <491AB4DD.5080502@ru.mvista.com>
References: <1226448783-10047-1-git-send-email-n0-1@freewrt.org> <1226448821-10933-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:52747 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751006AbYKLKuN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Nov 2008 05:50:13 -0500
In-Reply-To: <1226448821-10933-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Florian Fainelli <florian@openwrt.org>

Hello.

Phil Sutter wrote:

> * rename the offset definition to avoid abiguity with the standard ATA
>   IO address
> * read and write four bytes at once like the original driver does
> * use writesl() and readsl() which implicitly iterate over the data
>
> This patch assumes buflen to be a multiple of four, which is true for
> ATA devices. ATAPI support is not known, though unlikely, as the
> original driver always transfers 512 Bytes at once.
>
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> Acked-by: Sergei Shtyltov <sshtylyov@ru.mvista.com>
>   

   The rb532_pata_data_xfer() prototype fix should've been preceding 
this one, as it was dealing with a real issue, and this one only 
enhances the driver performance.

> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
> index 7b11f40..b919012 100644
> --- a/drivers/ata/pata_rb532_cf.c
> +++ b/drivers/ata/pata_rb532_cf.c
>   
[...]
> @@ -74,19 +75,16 @@ static void rb532_pata_exec_command(struct ata_port *ap,
>  	rb532_pata_finish_io(ap);
>  }
>  
> -static void rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
> -				unsigned int buflen, int write_data)
> +static void rb532_pata_data_xfer(struct ata_device *adev,
> +		unsigned char *buf, unsigned int buflen, int write_data)
>   

   Please avoid doing the "collateral damage" to the code like this. The 
formatting was pretty good before.

WBR, Sergei


