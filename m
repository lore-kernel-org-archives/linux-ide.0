From: Raphael Bossek <raphael.bossek@gmx.de>
Subject: Re: Looking for support of Promise PDC40775 (SATA 300 TX2plus)
Date: Tue, 9 Aug 2005 08:01:05 +0200
Message-ID: <20050809080105.2dc892ba.raphael.bossek@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.net ([213.165.64.20]:34177 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932372AbVHIGBL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Aug 2005 02:01:11 -0400
Received: from localhost ([127.0.0.1] helo=imac.elena.home)
	by imac.elena.home with smtp (Exim 4.50)
	id 1E2NAf-0001D7-Lu
	for linux-ide@vger.kernel.org; Tue, 09 Aug 2005 08:01:05 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>

Date: Sun, 07 Aug 2005 18:14:25 +0200
From: Erik Slagter <erik@slagter.name>
To: Raphael Bossek <raphael.bossek@gmx.de>
Subject: Re: Looking for support of Promise PDC40775 (SATA 300 TX2plus)

On Sun, 2005-08-07 at 12:09 +0200, Raphael Bossek wrote:
> > > I'm looking for 2.6 support of this kind of Promise controller.
> > > Is there any progress ongoing to support this kind of hardware
> > > with SATA and PATA conectors?
> > > Promise released GPL source code Linux 2.4 driver for this
> > > controllers
> > > 
> > > PDC40518        Promise SATAII150 TX4
> > > PDC20575        Promise SATAII150 TX2plus
> >   ^^^^^^^^
> > 
> > I have this one working. It's as simple as adding the PCI id.
> If I understand the implementation of sata_promise.c you extended
> the pdc_ata_pci_tbl array. Which board do you seletected?
>  1. board_2037x
>  2. board_20319
>  3. board_20619

For the 20575 this should be the correct line to add:

    { PCI_VENDOR_ID_PROMISE, 0x3d75, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
      board_2037x },

Please check with lspci -n.
