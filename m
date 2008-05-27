From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 04/22] ide: add ide_deprecated_find_port() helper
Date: Tue, 27 May 2008 20:36:10 +0200
Message-ID: <200805272036.10152.bzolnier@gmail.com>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain> <20080116232624.9166.73929.sendpatchset@localhost.localdomain> <483431E4.7020307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:33106 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926AbYEZTXO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 May 2008 15:23:14 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1646628mue.1
        for <linux-ide@vger.kernel.org>; Mon, 26 May 2008 12:23:13 -0700 (PDT)
In-Reply-To: <483431E4.7020307@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 21 May 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Factor out code for finding ide_hwifs[] slot from ide_register_hw()
> >   to ide_deprecated_find_port().
> 
> > * Convert bast-ide, ide-cs and delkin_cb host drivers to use ide_device_add()
> >   instead of ide_register_hw() (while at it drop doing "ide_unregister()" loop
> >   which tries to unregister _all_ IDE interfaces if useable ide_hwifs[] slot
> >   cannot be find).
> 
>     Er... this patch didn't actually drop that loop (late remark :-).
> 
> > This patch leaves us with only two ide_register_hw() users:
> > - drivers/macintosh/mediabay.c
> > - drivers/ide/ide.c
> 
>     I wonder whether ide_register_hw() was much good at all since it didn't 
> actually permit to register chips using MMIO: you couldn't pass that info via 
> 'hw' and it set 'hwif->noprobe' to 0, thus giving you no chance to skip 
> probing which wouldn't work anyway; for the same reason it was no good for DMA 
> capable chips since you had not time to install ide_dma_check() and other DMA 
> methods. Am I right here?

Yes but please remember that before we started the major surgeries
ide_register_hw() operated in two modes:

- "post-init-probe" which worked like described above

- "pre-init-probe" which allowed host drivers to do all setup
   (as the probing was done later by ide_generic host driver)

and the vast majority of host drivers used "pre-init-probe" mode
(which doesn't change the fact that ide_register_hw() was not good
anyway since it had a number of other problems).

Thanks,
Bart
