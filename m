From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Mon, 19 Jan 2009 12:14:13 +0100
Message-ID: <200901191214.14115.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <49708C55.1020204@ru.mvista.com> <200901161758.38037.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:19545 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbZASLHo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jan 2009 06:07:44 -0500
In-Reply-To: <200901161758.38037.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org, ddaney@caviumnetworks.com

Witam :)

On Friday 16 January 2009 17:58, Bartlomiej Zolnierkiewicz wrote:
> Well... there shouldn't be much problem with:
>
> * adding ->irq_handler method to struct ide_port_info and struct ide_host
>
>   [ which reminds me that struct ide_port_info would be better named struct
>     ide_host_info and IIRC somebody has already noticed it in the past ;-)
> ]
>
> * exporting ide_intr()
>
> * adding ide_interrupt() wrapper around ide_intr() which will do sth like:
>
> 	if (host->irq_handler)
> 		return host->irq_handler()
> 	else
> 		return ide_intr()
>
IMHO (slightly) better way is requesting irq handler directly
in init_irq() e.g: 

irq_func = host->irq_handler;
if (!irq_func)
	irq_func =  &ide_intr;
if (request_irq(hwif->irq, irq_func, sa,hwif->name,hwgroup))
                        goto out_unlink;

Cheers
Stanislaw Gruszka
