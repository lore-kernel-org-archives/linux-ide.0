From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Tue, 16 Aug 2005 22:42:07 +0200
Message-ID: <58cb370e050816134270b445ea@mail.gmail.com>
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <200508151507.22776.bjorn.helgaas@hp.com>
	 <58cb370e050816023845b57a74@mail.gmail.com>
	 <200508161316.32602.bjorn.helgaas@hp.com>
	 <1124223946.22924.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.207]:17892 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932437AbVHPUmL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 16:42:11 -0400
Received: by nproxy.gmail.com with SMTP id x37so6313nfc
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 13:42:08 -0700 (PDT)
In-Reply-To: <1124223946.22924.4.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org

On 8/16/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > >   * non-functional HDIO_REGISTER_HWIF ioctl (ain't really working either)
> >
> > HDIO_SCAN_HWIF - I don't know about this one.  How are we supposed to
> > follow the "new ports shouldn't define IDE_ARCH_OBSOLETE_INIT" injunction
> > if we lose all this functionality without it?  ia64 is about as close to
> > a new port as you get :-)
> 
> It allows you to register interfaces from user space.
> 
> As to IDE_ARCH_OBOSOLETE_INIT, its a red herring. It's not worth the
> trouble to avoid it given the expected short remaining life time of the
> old IDE layer. Far better would be to help get the new SATA layer doing
> PATA so drivers/ide can be deleted.

My opinion on this matter differ, I want to:
* finish rewriting IDE code
* deprecate crap
* (later) drop crap and merge rest with libata

I will write precised TODO (w/ status) soon.

IMO this is much better solution as:
* you go from working code into small steps (evolution)
* you don't have to maintain both libata and IDE driver
   for X years (deleting drivers/ide anytime soon is a pipedream)
* as IDE becomes less popular testing gets harder
  (especially when developing new code - you don't
   have previous state)
* it shouldn't be that hard - I have many parts of the stuff
  done (they need some polishing)

Bjorn, thanks for working on this, IDE_ARCH_OBSOLETE_INIT
( -> ide_init_hwif_ports() ) needs to be fixed in order to make REAL
improvements.

Bartlomiej
