From: Daniel Brahneborg <daniel.com@wtnord.net>
Subject: Re: siimage and two nics
Date: Sat, 27 Dec 2003 08:30:50 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031227083050.A8631@nettis.grimsta>
References: <20031226085450.A4045@nettis.grimsta> <34449.209.163.161.49.1072444479.squirrel@mail.clanhk.org> <20031226195705.B4045@nettis.grimsta> <3FEBAFA5.8020604@clanhk.org> <20031226232826.A7057@nettis.grimsta> <3FEBCA3C.5000803@clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 212-214-141-193.v-by.wtnord.net ([212.214.141.193]:28058 "EHLO
	ricercar.mine.nu") by vger.kernel.org with ESMTP id S265336AbTL0Haz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Dec 2003 02:30:55 -0500
Content-Disposition: inline
In-Reply-To: <3FEBCA3C.5000803@clanhk.org>; from heretic@clanhk.org on Fri, Dec 26, 2003 at 05:42:20AM +0000
List-Id: linux-ide@vger.kernel.org
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: Daniel Brahneborg <daniel.com@wtnord.net>, linux-ide@vger.kernel.org

On Fri, Dec 26, 2003 at 05:42:20AM +0000, J. Ryan Earl wrote:
> Daniel Brahneborg wrote:
> 
> >I guess I could, I just needed something to install to.
> >It's a file server, so it's the SATA disks that will take
> >the biggest hit.
>
> You should put your busiest disks on the southbridge (via_sata).

I'll keep that in mind, thanks.

> >I wouldn't mind using something else, but then I must first
> >understand how to get it to stop messing with my PATA hda.
> >Would that driver make the SATA disk suddenly appear as IDE
> >disks instead of SCSI?
>
> I don't understand why that matters.

It doesn't matter if they are IDE or SCSI, as long as they work.

What matters is that I still want to be able to access the small
IDE drive I have on the PATA connector.

> >Checking... oh, it's 1.06 in Linus 2.4.23 kernel.  The diff
> >doesn't seem to be very much, just a check for 3114 and a fix
> >for Seagate drives.
>
> Have you considered 2.6?

I tested it for a while, but had some problems with it.  I'll
try it again and see if it makes any difference.

> >SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> > sda: sda1 sda2
> >SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
> > sdb: sdb1 sdb2
> >SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
> > sdc: sdc1 sdc2
> >SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
> > sdd: sdd1 sdd2
> 
> OK.  So you have a 4 160GB SATA drives that show up as sda-sdd using 
> libata.

Exactly.  Or rather, 4 152GB drives, since Samsung seems to think
that K = 1000. *sigh*

> That's cool.  I had problems with the sata_sil driver though, 
> it wasn't stable for me.  I'd suggest using the IDE driver until it's 
> been worked on more.

How do I find out what happens with the PATA disk when I load the
siimage module?

> It's alpha right now, but the IDE driver is 
> production ready by my testing anyway.  You just have to modify your 
> raidtab to account for the new device location (hda/hdc or hde/hdg) of 
> using the IDE driver.

That's no problem.

Btw, what speed should I be able to get with the siimage module?

/Basic

