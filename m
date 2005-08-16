From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Tue, 16 Aug 2005 21:25:46 +0100
Message-ID: <1124223946.22924.4.camel@localhost.localdomain>
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <200508151507.22776.bjorn.helgaas@hp.com>
	 <58cb370e050816023845b57a74@mail.gmail.com>
	 <200508161316.32602.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:3265 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932402AbVHPT6x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 15:58:53 -0400
In-Reply-To: <200508161316.32602.bjorn.helgaas@hp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org

> >   * non-functional HDIO_REGISTER_HWIF ioctl (ain't really working either)
> 
> HDIO_SCAN_HWIF - I don't know about this one.  How are we supposed to
> follow the "new ports shouldn't define IDE_ARCH_OBSOLETE_INIT" injunction
> if we lose all this functionality without it?  ia64 is about as close to
> a new port as you get :-)

It allows you to register interfaces from user space.

As to IDE_ARCH_OBOSOLETE_INIT, its a red herring. It's not worth the
trouble to avoid it given the expected short remaining life time of the
old IDE layer. Far better would be to help get the new SATA layer doing
PATA so drivers/ide can be deleted.

> IDE on ia64 is little-used, so I'm OK with leaving it alone, but
> I do think it's wrong for an architecture with no real restriction
> to specify MAX_HWIFS in ide.h.  Better to have the config option,
> and make the default there larger if necessary.

In the ideal world - its a historical inheritance that its not dynamic -
you probably should set it to 10 though - just for plug in IDE cards.


