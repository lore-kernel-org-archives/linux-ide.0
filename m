From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata_piix: add Hercules EC-900 mini-notebook to ich_laptop
 short cable list
Date: Mon, 29 Sep 2008 00:34:31 -0400
Message-ID: <48E05AD7.2060501@garzik.org>
References: <200809171429.06187.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40953 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268AbYI2Eef (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 00:34:35 -0400
In-Reply-To: <200809171429.06187.herton@mandriva.com.br>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: linux-ide@vger.kernel.org

Herton Ronaldo Krzesinski wrote:
> Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> 
> diff -p -up linux-2.6.27/drivers/ata/ata_piix.c.orig linux-2.6.27/drivers/ata/ata_piix.c
> --- linux-2.6.27/drivers/ata/ata_piix.c.orig	2008-09-17 13:27:43.000000000 -0300
> +++ linux-2.6.27/drivers/ata/ata_piix.c	2008-09-17 13:28:42.000000000 -0300
> @@ -582,6 +582,7 @@ static const struct ich_laptop ich_lapto
>  	{ 0x27DF, 0x1025, 0x0110 },	/* ICH7 on Acer 3682WLMi */
>  	{ 0x27DF, 0x1043, 0x1267 },	/* ICH7 on Asus W5F */
>  	{ 0x27DF, 0x103C, 0x30A1 },	/* ICH7 on HP Compaq nc2400 */
> +	{ 0x27DF, 0x1071, 0xD221 },	/* ICH7 on Hercules EC-900 */
>  	{ 0x24CA, 0x1025, 0x0061 },	/* ICH4 on ACER Aspire 2023WLMi */
>  	{ 0x24CA, 0x1025, 0x003d },	/* ICH4 on ACER TM290 */
>  	{ 0x266F, 0x1025, 0x0066 },	/* ICH6 on ACER Aspire 1694WLMi */

applied


