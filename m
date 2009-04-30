From: Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>
Subject: Re: [PATCH] m68k: Atari - leave out spurious request_irq for Falcon IDE
Date: Thu, 30 Apr 2009 07:21:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904300715330.7645@zirkon.biophys.uni-duesseldorf.de>
References: <20090326123822.GD8081@marenka.net>
 <alpine.DEB.1.00.0904160107540.4339@zirkon.biophys.uni-duesseldorf.de>
 <1239862075.12777.14.camel@petr>
 <alpine.DEB.1.00.0904160934480.19859@zirkon.biophys.uni-duesseldorf.de>
 <1239868903.12777.25.camel@petr>
 <alpine.DEB.1.00.0904170314220.18855@zirkon.biophys.uni-duesseldorf.de>
 <alpine.DEB.1.00.0904190308310.8939@zirkon.biophys.uni-duesseldorf.de>
 <alpine.DEB.1.00.0904260751590.30061@zirkon.biophys.uni-duesseldorf.de>
 <alpine.DEB.1.00.0904260909510.32441@zirkon.biophys.uni-duesseldorf.de>
 <alpine.DEB.1.00.0904280735550.18935@zirkon.biophys.uni-duesseldorf.de>
 <10f740e80904280027m307f5850u5373d80b0dfcb7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-m68k-owner@vger.kernel.org>
In-reply-to: <10f740e80904280027m307f5850u5373d80b0dfcb7f@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Stephen R Marenka <stephen@marenka.net>, debian-68k@lists.debian.org, linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Geert,

> > I found I need to have this patch in order to avoid doubly registering the
> > ST-DMA interrupt for IDE on Falcon.
> 
> But further it has no ill effects, as it works fine on ARAnyM? Or does
> it fail on real hardware?

IDE reports lost interrupts at the same time as SCSI locks up, but that did 
happen before the patch the same as after. I'll re-check that if you like ...

And yes, the IDE/SCSI combination fails on real hardware. IDE remains alive, 
SCSI offlines the timed out device. ARAnyM has no SCSI driver...

	Michael
