From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: add drive_to_key functions
Date: Mon, 16 Aug 2004 18:38:18 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1092677889.20838.36.camel@localhost.localdomain>
References: <20040815145844.GA10778@devserv.devel.redhat.com>
	 <200408161912.26595.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:9445 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266257AbUHPSkt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Aug 2004 14:40:49 -0400
In-Reply-To: <200408161912.26595.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, torvalds@osdl.org

On Llu, 2004-08-16 at 18:12, Bartlomiej Zolnierkiewicz wrote:
> >  	hwif->atapi_dma = 0;		/* disable all atapi dma */
> >  	hwif->ultra_mask = 0x80;	/* disable all ultra */
> >  	hwif->mwdma_mask = 0x80;	/* disable all mwdma */
> >  	hwif->swdma_mask = 0x80;	/* disable all swdma */
> >
> > +	hwif->pci_dev = NULL;
> > +	hwif->remove = NULL;
> > +
> 
> not needed - memsetting to zero is done earlier

Ok fixed in my tree.

> > +EXPORT_SYMBOL_GPL(ide_drive_to_key);
> 
> AFAICS ide_drive_[from,to]_key are to be used only from ide-proc.c
> so EXPORT_SYMBOLs are not needed

Good point I forgot they were linked together. Fixed


