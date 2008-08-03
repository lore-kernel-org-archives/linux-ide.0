From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] ide: add proper PCI PM support
Date: Sun, 3 Aug 2008 16:15:38 +0200
Message-ID: <200808031615.38477.bzolnier@gmail.com>
References: <200808021917.04847.bzolnier@gmail.com> <200808022249.38969.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:17363 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421AbYHCOSj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 10:18:39 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1485809fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 03 Aug 2008 07:18:37 -0700 (PDT)
In-Reply-To: <200808022249.38969.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>

On Saturday 02 August 2008, Rafael J. Wysocki wrote:
> On Saturday, 2 of August 2008, Bartlomiej Zolnierkiewicz wrote:
> > * Keep pointer to ->init_chipset method also in
> >   struct ide_host and set it in ide_host_alloc_all().
> > 
> > * Add ide_pci_suspend() and ide_pci_resume() helpers
> >   (default ->suspend and ->resume implementations).
> > 
> > * ->init_chipset can no longer be marked __devinit.
> > 
> > * Add proper PCI PM support to IDE PCI host drivers
> >   (rz1000.c and tc86c001.c are skipped for now since
> >   they need to be converted from using ->init_hwif
> >   to use ->init_chipset instead).
> 
> Well, first, the work on improving the PCI PM support by IDE drivers is much
> appreciated.
> 
> Still, since you're adding new routines etc., it may be a good time to
> implement them using the new PM framework, as defined in
> include/linux/pm.h (please also have a look at drivers/pci/pci-driver.c for the
> PCI bus type's PM callbacks implementation details).  Unfortunately, it's not
> been well documented yet, so if you have any questions, please ask.
> 
> In fact, we need some example implementations of the new PM callbacks and
> since you know the drivers in question very well, we could use your
> implementations as examples, if you don't mind.  [Certainly, they would be
> better than PM callbacks written by me for any driver. ;-) ]

Thanks for reviewing the patch.  I'll take a look into converting it to
use new PM infrastructure (it may take a while so please be patient).
