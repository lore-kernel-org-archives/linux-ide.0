From: David Sims <dpsims@virtualdave.com>
Subject: Re: Small help or advice please....
Date: Sun, 23 Jan 2005 10:16:24 -0600 (CST)
Message-ID: <Pine.LNX.4.21.0501231006390.23012-100000@ernie.virtualdave.com>
References: <20050123003008.GD558606@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ernie.virtualdave.com ([198.216.116.246]:54284 "EHLO
	ernie.virtualdave.com") by vger.kernel.org with ESMTP
	id S261323AbVAWQQ2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 Jan 2005 11:16:28 -0500
In-Reply-To: <20050123003008.GD558606@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: jeremy@classic.engr.sgi.com, linux-ide@vger.kernel.org



On Sat, 22 Jan 2005, Jeremy Higdon wrote:

> On Sat, Jan 22, 2005 at 02:49:08PM -0600, David Sims wrote:
> > Hi,
> > 
> >   I am struggling a bit to get a Dell Powervault 745N (i.e., Intel
> > 31244/Vitesse 71714 (aka 7174) SATA controller) to run Linux.... I am
> > using Slackware with the 3.4.29 kernel.... the only module loaded is the
> > ethernet (e1000) and when I try to load sata_vsc it just hangs trying to
> > talk to disk 0.... If I unplug all the disks then the module will load and
> > all seems well, but without any disks, what's the point? ;)
> > 
> > 
> >   I have temporarly added a pci-ide controller in the expansion slot of
> > this box and have Linux running fine via that from a WD-800 pata
> > disk... So I have lots of tools, I just don't know how to troubleshoot
> > this SATA problem.....
> > 
> >   Any clues for me?? How can I troubleshoot this problem or get the intel
> > 31244 to work??
> 
> There's not a lot to go on here.  It's a PCI-X controller, but it uses a
> 32 bit DMA mask, due to having a fixed upper 32 bits.  I don't know if that
> would cause you a problem or not.
> 
> Also, the driver was originally developed for the Vitesse 7174 part.  I
> have heard of other problems with the Intel part (you'll see them if you
> search the archives).  I don't recall hearing whether anyone found the
> root cause.  They're supposed to be identical, but . . . .
> 
> jeremy
> 

Hi again,

  Here are some additional clues.... and word of partial success:
I have downloaded and built the 2.6.10 kernel.... with SATA support and
sata_vsc as a module... It boots and runs fine.... _AND_ after booting, I
can manually do a 'modprobe sata_vsc' and after some (repeated) fussing
about IRQ 3 it actually loads and sees all four SATA disks.... I think the
IRQ 3 fussing is proportional to the number of disks.... (would looking at
the log files that get generated here be useful to you???)

  So... using the above, I can fdisk the SATA disk and format it and mount
it and successfully read and write to it.... 

  Now, the clue part.... If I add 'modprobe sata_vsc' to rc.modules, it
loads at boot, but then the system hangs after trying to touch the first
disk..... This is the same behavior noted in the message above with the
2.4.29 kernel.... 

  What is the difference between manually loading sata_vsc after start up
and loading it at boot time?? Hmmmm.... Also, I built a kernel with
sata_vsc 'built in' as part of the monolithic kernel.... It behaves that
way just like the boot-time module insertion.... 

  Any ideas?? Or any ideas where to look for ideas?? ;)

TIA,

Dave Sims

