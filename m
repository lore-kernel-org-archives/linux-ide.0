From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Sun, 18 Mar 2007 16:54:00 +0100
Message-ID: <200703181654.00829.bzolnier@gmail.com>
References: <45F873AC.6010204@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FD5927.7080104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:33701 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbXCRPqj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 11:46:39 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1101176uga
        for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 08:46:37 -0700 (PDT)
In-Reply-To: <45FD5927.7080104@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: YUP <yupadmin@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org


On Sunday 18 March 2007, YUP wrote:
> Hello Bartek,
> 
>  >
>  > Thanks, does reading from CD/DVD media also work fine now?
> 
> Yes, drives can read all media cd and dvd I have.

OK, thanks for testing.

The conclusion here is that the problem experienced by Yarema
is clearly some libata regression wrt drivers/ide.

> > It seems that the drive works just fine in PIO mode with pdc202xx_new
> > IDE driver (it doesn't support ATAPI DMA at the moment) and fails
> > with pata_pdc2027x libata (even with DMA blacklist patch from Albert).
> 
> Does it mean that I have to recompile all the time kernels from ubuntu 
> repositories? Is there any possibility to blacklist pata_pdc2027x 
> module and enable pdc202xx_new (just to compile one and add to the list 
> of modules) ?

Adding "blacklist pata_pdc2027xx" line to /etc/modprobe.conf should do this.
You may also want to bring up this problem with Ubuntu developers.

Bart
