From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6 fix queue] hpt366: don't check enablebits for
 HPT36x
Date: Fri, 25 May 2007 00:23:25 +0400
Message-ID: <4655F43D.2090402@ru.mvista.com>
References: <200705042318.37367.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:2918 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752429AbXEXUVz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 16:21:55 -0400
In-Reply-To: <200705042318.37367.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, linas@austin.ibm.com, Andries.Brouwer@cwi.nl, michal.kepien@poczta.onet.pl

Hello, I wrote:
> HPT36x chip don't seem to have the channel enable bits, so prevent the IDE core
> from checking them...

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: linux-2.6/drivers/ide/pci/hpt366.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/pci/hpt366.c
> +++ linux-2.6/drivers/ide/pci/hpt366.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/drivers/ide/pci/hpt366.c		Version 1.02	Apr 18, 2007
> + * linux/drivers/ide/pci/hpt366.c		Version 1.03	May 4, 2007
>   *
>   * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
>   * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
> @@ -1527,7 +1527,12 @@ static int __devinit init_setup_hpt366(s
>  	if (rev > 2)
>  		goto init_single;
>  
> +	/*
> +	 * HPT36x chips are single channel and
> +	 * do not seem to have the channel enable bit...
> +	 */

    Actually it does, but the bit is different. :-/

>  	d->channels = 1;
> +	d->enablebits[0].reg = 0;

    Linas, Andries, Michal, cound you try this instead:

	d->enablebits[0].mask = d->enablebits[0].val = 0x10;

>  	if ((dev2 = pci_get_slot(dev->bus, dev->devfn + 1)) != NULL) {
>  	  	u8  pin1 = 0, pin2 = 0;

MBR, Sergei
