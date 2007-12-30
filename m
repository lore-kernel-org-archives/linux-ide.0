From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/9] piix: remove stale comments
Date: Sun, 30 Dec 2007 18:09:08 +0100
Message-ID: <200712301809.08385.bzolnier@gmail.com>
References: <20071227191153.1357.63211.sendpatchset@localhost.localdomain> <20071227191200.1357.71766.sendpatchset@localhost.localdomain> <4774E5C6.90506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:7436 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbXL3Rbk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Dec 2007 12:31:40 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2175194ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 30 Dec 2007 09:31:37 -0800 (PST)
In-Reply-To: <4774E5C6.90506@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 28 December 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > Index: b/drivers/ide/pci/piix.c
> > ===================================================================
> > --- a/drivers/ide/pci/piix.c
> > +++ b/drivers/ide/pci/piix.c
> > @@ -8,53 +8,8 @@
> >   *
> >   *  May be copied or modified under the terms of the GNU General Public License
> >   *
> > - *  PIO mode setting function for Intel chipsets.
> > - *  For use instead of BIOS settings.
> > + * Documentation:
> >   *
> > - * 40-41
> > - * 42-43
> > - * 
> > - *                 41
> > - *                 43
> > - *
> > - * | PIO 0       | c0 | 80 | 0 |
> > - * | PIO 2 | SW2 | d0 | 90 | 4 |
> > - * | PIO 3 | MW1 | e1 | a1 | 9 |
> > - * | PIO 4 | MW2 | e3 | a3 | b |
> > - *
> > - * sitre = word40 & 0x4000; primary
> > - * sitre = word42 & 0x4000; secondary
> > - *
> > - * 44 8421|8421    hdd|hdb
> > - *
> > - * 48 8421         hdd|hdc|hdb|hda udma enabled
> > - *
> > - *    0001         hda
> > - *    0010         hdb
> > - *    0100         hdc
> > - *    1000         hdd
> > - *
> > - * 4a 84|21        hdb|hda
> > - * 4b 84|21        hdd|hdc
> > - *
> > - *    ata-33/82371AB
> > - *    ata-33/82371EB
> > - *    ata-33/82801AB            ata-66/82801AA
> > - *    00|00 udma 0              00|00 reserved
> > - *    01|01 udma 1              01|01 udma 3
> > - *    10|10 udma 2              10|10 udma 4
> > - *    11|11 reserved            11|11 reserved
> > - *
> > - * 54 8421|8421    ata66 drive|ata66 enable
> 
>     You could have left te progarmming info intact...

Well, I thought about that but:

* It referenced ATA devices using hd[a-d] naming which while matches with
  most of use cases is not 100% correct (piix driver can be modular etc).

* Right below there is a note about the official Intel documentation
  (which is publically available).

* The piix.c code is self-documenting nowadays (in large parts thanks to
  your efforts). :)

Thanks,
Bart
