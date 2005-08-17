From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: UDMA modes
Date: Wed, 17 Aug 2005 11:00:16 +0200
Message-ID: <58cb370e05081702001d648b2d@mail.gmail.com>
References: <311601c9050816081331a39ac9@mail.gmail.com>
	 <42D7AAD50004A80D@mail-6.mail.tiscali.sys>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.203]:40762 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750998AbVHQJAR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Aug 2005 05:00:17 -0400
Received: by nproxy.gmail.com with SMTP id x37so25868nfc
        for <linux-ide@vger.kernel.org>; Wed, 17 Aug 2005 02:00:16 -0700 (PDT)
In-Reply-To: <42D7AAD50004A80D@mail-6.mail.tiscali.sys>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "sampei02@tiscali.it" <sampei02@tiscali.it>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org

On 8/17/05, sampei02@tiscali.it <sampei02@tiscali.it> wrote:
> I updated Kernel at 2.6.12-1.1372_FC3 by rpm package.
> 
> Kernel reconized Controller IDE, infact dmesg command gets:
> 
> Uniform Multi-PLatform E-IDE driver revision: 7.00alpha2
> VP_IDE: IDE controller at PCI slot 0000:00:07.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt82c686b (rev.40) IDE UDMA100 controller on pci0000:00:07.1
> probing IDE interface ide0
> ....
> 
> What do you think ?

This show only *controller* capabilities, nothing about drive.

Please post *full* dmesg.

> 
> >-- Messaggio Originale --
> >Date:  Tue, 16 Aug 2005 09:13:25 -0600
> >From:  "Eric D. Mudama" <edmudama@gmail.com>
> >To:    "sampei02@tiscali.it" <sampei02@tiscali.it>
> >Subject: Re: UDMA modes
> >Cc:    Erik Slagter <erik@slagter.name>, linux-ide@vger.kernel.org
> >
> >
> >we'd need to see the dmesg output I am sure
> >
> >On 8/16/05, sampei02@tiscali.it <sampei02@tiscali.it> wrote:
> >> My Maxtor Hard Disk supports UDMA <= 6 (133)
> >> How can I control BITS options in controller ? What's line command ?
> >> How can I verify controller is properly configured in my kernel ?
> >>
> >>
> >> >-- Messaggio Originale --
> >> >Subject: Re: UDMA modes
> >> >From: Erik Slagter <erik@slagter.name>
> >> >To: sampei02@tiscali.it
> >> >Cc: linux-ide@vger.kernel.org
> >> >Date: Tue, 16 Aug 2005 11:05:17 +0200
> >> >
> >> >
> >> >On Tue, 2005-08-16 at 09:02 +0200, sampei02@tiscali.it wrote:
> >> >> I have motherboard which supports DMA ATA 66/100/133 and I connect
> HD
> >> with
> >> >> new 80-wire cable.
> >> >> I have FC3 with Kernel 2.6.9
> >> >> With hdparm -i /dev/hda I get:
> >> >>
> >> >> DMA modes: udma0 udma1 udma2
> >> >> UDMA modes: udma0 udma1 *udma2
> >> >>
> >> >> Why udma is 2 and not udma 5 ?
> >> >
> >> >Controller not explicitly supported by linux or not configured in the
> >> >kernel? Controller needs BITS option? (see IDE config). Harddisk doesn't
> >> >support > udma2?
