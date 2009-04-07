From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] at91_ide: remove unused ide_mm_{outb,inb}
Date: Tue, 07 Apr 2009 13:06:18 +0400
Message-ID: <49DB178A.8060508@ru.mvista.com>
References: <200904062341.59908.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:32051 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750703AbZDGJG0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Apr 2009 05:06:26 -0400
In-Reply-To: <200904062341.59908.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org

Hello.

Stanislaw Gruszka wrote:
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
>   
[...]
> diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
> index 4f3725d..c48dc61 100644
> --- a/drivers/ide/at91_ide.c
> +++ b/drivers/ide/at91_ide.c
> @@ -174,16 +174,6 @@ static void at91_ide_output_data(ide_drive_t *drive, struct ide_cmd *cmd,
>  	leave_16bit(chipselect, mode);
>  }
>  
> -static u8 ide_mm_inb(unsigned long port)
> -{
> -	return readb((void __iomem *) port);
> -}
> -
> -static void ide_mm_outb(u8 value, unsigned long port)
> -{
> -	writeb(value, (void __iomem *) port);
> -}
> -
>  static void at91_ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  {
>  	struct ide_timing *timing;
>   

   Oops, that should have been a part of my patch removing 
at91_ide_tf_{load|read}(). I'll recast...

MBR, Sergei


