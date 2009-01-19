From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/6] ide: move SFF I/O code to ide-io-sff.c
Date: Mon, 19 Jan 2009 15:23:15 +0100
Message-ID: <200901191523.15240.bzolnier@gmail.com>
References: <20090119130309.24745.40877.sendpatchset@localhost.localdomain> <20090119130322.24745.76137.sendpatchset@localhost.localdomain> <49748B95.9080105@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f18.google.com ([209.85.218.18]:46946 "EHLO
	mail-bw0-f18.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbZASOXt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 09:23:49 -0500
In-Reply-To: <49748B95.9080105@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 19 January 2009, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
>     Gah, what in the world is that SFF I/O code?
> 
> > Index: b/drivers/ide/ide-io-sff.c
> > ===================================================================
> > --- /dev/null
> > +++ b/drivers/ide/ide-io-sff.c
> > @@ -0,0 +1,314 @@
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/ide.h>
> > +
> > +/*
> > + *	Conventional PIO operations for ATA devices
> > + */
> > +
> > +static u8 ide_inb(unsigned long port)
> > +{
> > +	return (u8) inb(port);
> > +}
> > +
> > +static void ide_outb(u8 val, unsigned long port)
> > +{
> > +	outb(val, port);
> > +}
> > +
> > +/*
> > + *	MMIO operations, typically used for SATA controllers
> > + */
> > +
> > +static u8 ide_mm_inb(unsigned long port)
> > +{
> > +	return (u8) readb((void __iomem *) port);
> > +}
> > +
> > +static void ide_mm_outb(u8 value, unsigned long port)
> > +{
> > +	writeb(value, (void __iomem *) port);
> > +}
> 
>     Ah, I see. Can we finally stop abusing the SFF name? Or are we bound to 
> copy every mistake that libata has made? :-/

Please suggest a better name. :)

[ I'm also not happy with the naming but couldn't think of a better one. ]
