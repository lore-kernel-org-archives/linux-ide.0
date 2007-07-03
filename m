From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 9/15] ide: add PIO masks
Date: Tue, 3 Jul 2007 23:00:34 +0100
Message-ID: <20070703230034.233d0d7e@the-village.bc.nu>
References: <200706302107.42458.bzolnier@gmail.com>
	<468AA351.4090509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60217 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752691AbXGCVyx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 17:54:53 -0400
In-Reply-To: <468AA351.4090509@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

> >  		.bootable	= ON_BOARD,		\
> >  		.enablebits	= { {0x40, 1, 1}, {0x40, 0x10, 0x10} }, \
> > +		.pio_mask	= ATA_PIO5,		\
> >  	}
> 
>     Just noticed that this driver does nothing in its tuneproc() method. So, 
> this mask is unrealistic. The method needs to be dropped for now along with 
> config-jmicron_chipset_for_pio() 

It doesn't need to do anything. 
