From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Mon, 19 Jan 2009 13:52:26 +0100
Message-ID: <200901191352.27449.bzolnier@gmail.com>
References: <200901141345.42583.stf_xl@wp.pl> <200901161758.38037.bzolnier@gmail.com> <200901191214.14115.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:47681 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759967AbZASNAz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 08:00:55 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1387855muf.1
        for <linux-ide@vger.kernel.org>; Mon, 19 Jan 2009 05:00:53 -0800 (PST)
In-Reply-To: <200901191214.14115.stf_xl@wp.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org, ddaney@caviumnetworks.com

On Monday 19 January 2009, Stanislaw Gruszka wrote:
> Witam :)
> 
> On Friday 16 January 2009 17:58, Bartlomiej Zolnierkiewicz wrote:
> > Well... there shouldn't be much problem with:
> >
> > * adding ->irq_handler method to struct ide_port_info and struct ide_host
> >
> >   [ which reminds me that struct ide_port_info would be better named struct
> >     ide_host_info and IIRC somebody has already noticed it in the past ;-)
> > ]
> >
> > * exporting ide_intr()
> >
> > * adding ide_interrupt() wrapper around ide_intr() which will do sth like:
> >
> > 	if (host->irq_handler)
> > 		return host->irq_handler()
> > 	else
> > 		return ide_intr()
> >
> IMHO (slightly) better way is requesting irq handler directly
> in init_irq() e.g: 
> 
> irq_func = host->irq_handler;
> if (!irq_func)
> 	irq_func =  &ide_intr;
> if (request_irq(hwif->irq, irq_func, sa,hwif->name,hwgroup))
>                         goto out_unlink;

Agreed.
