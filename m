From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ATIIXP support (SATA, ATA133)
Date: Sat, 15 Jan 2005 03:06:45 +0100
Message-ID: <58cb370e0501141806616af43@mail.gmail.com>
References: <878y7x2qhq.fsf@kosh.ultra.csn.tu-chemnitz.de>
	 <58cb370e041217034449d1b2a9@mail.gmail.com>
	 <87is6whfv0.fsf@londo.ultra.csn.tu-chemnitz.de>
	 <87is6e5rhr.fsf@kosh.ultra.csn.tu-chemnitz.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.203]:33821 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262065AbVAOEx0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2005 23:53:26 -0500
Received: by wproxy.gmail.com with SMTP id 67so720938wri
        for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2005 20:53:26 -0800 (PST)
In-Reply-To: <87is6e5rhr.fsf@kosh.ultra.csn.tu-chemnitz.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Cc: linux-ide@vger.kernel.org

On Mon, 03 Jan 2005 18:53:20 +0100, Enrico Scholz
<enrico.scholz@informatik.tu-chemnitz.de> wrote:
> Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de> writes:
> 
> >>> * PCI 1002:4376 which is an ATA133 controller; this should probably
> >>>   work with the already existing drivers/ide/pci/atiixp.c driver
> >>
> >> Have you tested it?
> >
> > Yes, but with mixed results:
> >
> > * a harddisk works fine and without problems
> >
> > * reading from a DVD/CD-ROM drives with DMA mode gives read-errors
> >   (position not reproducible, no single-bit errors). I will have to
> >   make further tests to see if it is caused by the drive, the system
> >   (see below) or the driver. There are no kernel-messages regarding
> >   read-errors. In PIO mode, data are read correctly.

there is confirmation from ATI now, patch applied

> Ok, I did some testings; here the results:
> 
> * things are fine with another CD drive (PLEXTOR CD-R PX-W4824A)
> 
> * the previously mentioned one (LG HL-DT-STDVDRRW GWA-4083B) works after
>   executing
> 
>   | hdparm -a 64 /dev/hda
> 
>   Any number above 64 makes it fail.
 
weird
