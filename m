From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 14/64] pata_cypress: fix PIO timings underclocking
Date: Mon, 18 Jan 2010 22:05:25 +0300
Message-ID: <4B54B0F5.1040405@ru.mvista.com>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118171547.14623.54536.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:15570 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755902Ab0ARTHM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 14:07:12 -0500
In-Reply-To: <20100118171547.14623.54536.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_cypress: fix PIO timings underclocking
>
> Timing registers should be programmed with the desired number of clocks
> minus one clock.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ata/pata_cypress.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> Index: b/drivers/ata/pata_cypress.c
> ===================================================================
> --- a/drivers/ata/pata_cypress.c
> +++ b/drivers/ata/pata_cypress.c
>   
[...]
> @@ -79,7 +81,7 @@ static void cy82c693_set_piomode(struct
>  		pci_read_config_dword(pdev, CY82_IDE_ADDRSETUP, &addr);
>  
>  		addr &= ~0xF0;	/* Mask bits */
> -		addr |= (clamp_val(t.setup, 0, 15) << 4);
> +		addr |= (clamp_val(t.setup - 1, 0, 15) << 4);
>   

   You could drop the unneeded parens while at it...

MBR, Sergei

