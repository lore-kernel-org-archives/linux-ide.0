From: "Dominic ES. Ijichi" <dom@ijichi.org>
Subject: Re: AHCI driver for ICH6M
Date: Wed, 1 Feb 2006 11:33:48 +0000 (GMT)
Message-ID: <25396560.2171138793628353.JavaMail.root@willow.ijichi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from willow.ijichi.org ([217.206.220.50]:21965 "EHLO
	willow.ijichi.org") by vger.kernel.org with ESMTP id S932450AbWBALdt
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Feb 2006 06:33:49 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org, Michael Spiegle <mike@nauticaltech.com>


----- Erik Slagter <erik@slagter.name> wrote:
> > I was trying to use the AHCI driver included in kernel 2.6.15 to
> drive
> > the SATA controller on my Asus Z71V laptop which supposedly has an
> ICH6M
> > controller.  I noticed that the PCI ID of my controller shows up in
> the
> > AHCI source code, so I assume that means I should have support.  I'm
> not
> > terribly good with linux or C, but I think I was able to
> troubleshoot my
> > issue down to a specific line of code.  Ultimately, I get the
> error:
> > 
> > ahci: probe of 0000:00:1f.2 failed with error -12
> 
> A very familiar problem. It means that your bios configures your ICH
> chipset for legacy (or whatever name it has) mode, which means it
> will
> respond to the old-fashioned IDE ports and IRQs. This also means you
> cannot drive it in AHCI mode :-( unless there is an option in your
> BIOS
> to switch between legacy and ahci mode, but afaik no single laptop
> has
> this option. So you're on your own here :-( (just like me, btw).

i had same problem - fujitsu laptop with ich6 sata controller but with pata disk putting it into 'legacy/ide' mode.  ahci module would drive the controller/disk but suspend didn't work.  removing ahci module and adding ata_piix module resolved this issue for me, now i get full s3 suspend as well :)  device naming stays the same so you might just get away with removing ahci module and redoing mkinitrd.

dom

