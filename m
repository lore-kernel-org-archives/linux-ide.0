From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/1] ide: ide-generic, add another device exception
Date: Sat, 9 Jun 2007 00:42:50 +0200
Message-ID: <200706090042.50287.bzolnier@gmail.com>
References: <20601315171560711667@wsc.cz> <200706081418.56217.bzolnier@gmail.com> <20070608223505.3ff1a662@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:37436 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S971143AbXFHW23 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 18:28:29 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1055615ugf
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 15:28:28 -0700 (PDT)
In-Reply-To: <20070608223505.3ff1a662@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Ingo Korb <ml@akana.de>, linux-ide@vger.kernel.org

On Friday 08 June 2007, Alan Cox wrote:
> On Fri, 8 Jun 2007 14:18:55 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > On Monday 04 June 2007, Jiri Slaby wrote:
> > > ide-generic, add another device exception
> > 
> > ide-generic is a generic ISA IDE driver, this one is drivers/ide/pci/generic
> > (a generic IDE PCI driver) - fixed patch description to avoid confusion.
> 
> Nope ide-generic is a generic I/O based ST506 interface. It covers a bit
> more than just ISA bus.

If so then can we finally get rid of hd.c?

> > [ Yes, both drivers need a rename - patches are welcomed. ]
> 
> Good way to break everyones module settings

MODULE_ALIAS() should cover this up nicely.

Thanks,
Bart
