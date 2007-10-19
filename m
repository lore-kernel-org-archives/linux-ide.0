From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: New CD/DVD drive - 80-wire cable detection failure
Date: Fri, 19 Oct 2007 23:44:27 +0200
Message-ID: <200710192344.27312.bzolnier@gmail.com>
References: <200710181832.42906.nick@ukfsn.org> <20071019210743.GI4003@csclub.uwaterloo.ca> <200710192212.30533.nick@ukfsn.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:13860 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108AbXJSVjK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 17:39:10 -0400
Received: by fk-out-0910.google.com with SMTP id z23so556340fkz
        for <linux-ide@vger.kernel.org>; Fri, 19 Oct 2007 14:39:08 -0700 (PDT)
In-Reply-To: <200710192212.30533.nick@ukfsn.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: nick@ukfsn.org
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Friday 19 October 2007, Nick Warne wrote:
> On Friday 19 October 2007 22:07:43 Lennart Sorensen wrote:
> > On Fri, Oct 19, 2007 at 10:03:09PM +0100, Nick Warne wrote:
> > > No change:
> > >
> > > ide_setup: hdd=ide-cd
> > >     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
> > > hdd: TSSTcorp CDDVDW SH-S202J, ATAPI CD/DVD-ROM drive
> > > hdd: drive side 80-wire cable detection failed, limiting max speed to
> > > UDMA33 hdd: selected mode 0x42
> > > hdd: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
> >
> > Did you try another cable?  DId you try using both the old IDE drivers
> > and the new PATA libata drivers?  What is the hdd=ide-cd supposed to
> > do?  Do you have a device present as hdc and if not, then why not?
> > (Hint: ATA spec requires a master before you can have a slave, even
> > though it frequently does work with just a slave.  Of course cable
> > select seems even nicer since then the device at the end of an 80 wire
> > cable is automatically master, and any additional device added to the
> > middle connector on the cable becomes slave, and you should not connect
> > a device to the middle connector without one on the end).
> >
> > Also make sure the right end of the cable is connected to the mainboard,
> > just in case that matters.
> 
> I have (since 2.6.15 at least) hda, hdb, hdc, and hdd.
> 
> hda and hdb are mounted at boot.  hdc is not mounted, as I leave that drive 
> for backups and mount as needed.
> 
> All I done was replace a duff cd/dvd drive (hdd) with a new one.

Ah, so the patch won't help (sorry, I didn't pay enough attention).

Len's advices are worth the try, also please send the output
of hdparm -I /dev/hdd.

Thanks,
Bart
