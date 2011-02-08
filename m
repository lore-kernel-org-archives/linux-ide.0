From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 21/20] ata_piix: add new PIIX_FLAG_* flags
Date: Tue, 08 Feb 2011 20:12:12 +0300
Message-ID: <4D51796C.8020008@ru.mvista.com>
References: <201102081652.36752.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34919 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab1BHRNl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 12:13:41 -0500
In-Reply-To: <201102081652.36752.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Turn open-coded checks in piix_set_timings() into PIIX_FLAG_* flags
> per suggestion from Alan Cox.

> Suggested-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
[...]

> Index: b/drivers/ata/ata_piix.c
> ===================================================================
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -133,6 +133,8 @@ enum {
>  
>  	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
>  	PIIX_FLAG_SIDPR		= (1 << 29), /* SATA idx/data pair regs */
> +	PIIX_FLAG_NO_SITRE	= (1 << 30), /* no SITRE register */

    The register in question is called SIDETIM, SITRE is a bit that enables its use.

WBR, Sergei

