From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: siimage card causes repeated oopses and panics on a PowerMac
	G4 running 2.6.12.1
Date: Thu, 30 Jun 2005 09:21:38 +1000
Message-ID: <1120087299.31924.9.camel@gaston>
References: <9c1484f205062702203936d7ca@mail.gmail.com>
	 <42BFE177.1050007@pobox.com>
	 <6A4A6C03-7A2D-45BE-AE66-4CF38F8607EC@gmail.com>
	 <58cb370e050629031277d13798@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:5548 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262728AbVF2X1L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jun 2005 19:27:11 -0400
In-Reply-To: <58cb370e050629031277d13798@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Steven Schlansker <stevenschlansker@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Wed, 2005-06-29 at 12:12 +0200, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On 6/28/05, Steven Schlansker <stevenschlansker@gmail.com> wrote:
> > I turned off preempt and compiled the sata_sil driver.  Loading it
> > did not seem to cause any troubles, but dmesg had nothing but a
> > version message.  No discovery of hardware seemed to happen with the
> > sata driver (this is not a sata card as far as I know?) and no /dev/
> > sd? or /dev/hd? entries appeared at all.
> 
> Yep, SiI680 is a PATA chipset, sata_sil won't help.
> 
> > The old kernel module, recompiled without preempt, still causes
> > crashing and general badness.
> > 
> > Thank you for the suggestions, got anything else to try?
> 
> Disabling PMAC IDE driver - actual OOPS comes from it (weird).
> 
> Please also send full dmesg output.

Can you send me the backtrace of the oops ?

Ben.


