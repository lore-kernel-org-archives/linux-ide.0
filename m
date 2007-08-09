From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] pata_hpt37x: actually clock HPT374 by 50 MHz DPLL
Date: Fri, 10 Aug 2007 01:52:32 +0200
Message-ID: <200708100152.32753.bzolnier@gmail.com>
References: <200708052245.16406.sshtylyov@ru.mvista.com> <200708092248.44675.bzolnier@gmail.com> <20070809235213.391ab6c9@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:48209 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbXHIXxV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 19:53:21 -0400
Received: by mu-out-0910.google.com with SMTP id i10so862020mue
        for <linux-ide@vger.kernel.org>; Thu, 09 Aug 2007 16:53:20 -0700 (PDT)
In-Reply-To: <20070809235213.391ab6c9@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, rah@bash.sh

On Friday 10 August 2007, Alan Cox wrote:
> >  * This driver is heavily based upon:
> >  *
> >  * linux/drivers/ide/pci/hpt366.c               Version 0.36    April 25, 2003
> >  *
> > reference to hpt366 version should also be updated (or removed)
> 
> 
> Disagree - its not based on the newer hpt366 driver. Its based on the old

But this patch has just updated copyright references to match with the new
driver while the version still matches the old one!

> one. Actually by now it bears almost no resemblence any of them

Indeed, unfortunately...

Bart
