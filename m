From: Daniel Brahneborg <daniel.com@wtnord.net>
Subject: Re: siimage and two nics
Date: Sat, 27 Dec 2003 23:40:52 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031227234052.A2433@nettis.grimsta>
References: <20031226085450.A4045@nettis.grimsta> <34449.209.163.161.49.1072444479.squirrel@mail.clanhk.org> <20031226195705.B4045@nettis.grimsta> <3FEBAFA5.8020604@clanhk.org> <20031226232826.A7057@nettis.grimsta> <3FEBCA3C.5000803@clanhk.org> <20031227083050.A8631@nettis.grimsta> <3FECD15B.1010004@clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 212-214-141-209.v-by.wtnord.net ([212.214.141.209]:41088 "EHLO
	ricercar.mine.nu") by vger.kernel.org with ESMTP id S264830AbTL0WlG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Dec 2003 17:41:06 -0500
Content-Disposition: inline
In-Reply-To: <3FECD15B.1010004@clanhk.org>; from heretic@clanhk.org on Sat, Dec 27, 2003 at 12:24:59AM +0000
List-Id: linux-ide@vger.kernel.org
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: Daniel Brahneborg <daniel.com@wtnord.net>, linux-ide@vger.kernel.org

On Sat, Dec 27, 2003 at 12:24:59AM +0000, J. Ryan Earl wrote:
> Daniel Brahneborg wrote:
> 
> >What matters is that I still want to be able to access the small
> >IDE drive I have on the PATA connector.
>
> That should not be a problem.  If you build the via82cxxx into the 
> kernel and use siimage as a module, the two sata drives should be hde 
> and hdg, but you could build the siimage into the kernel and boot of the 
> RAID if you wanted too.

I'm making progress!  I'm using Linus kernel 2.6, have via82cxxx
and siimage built in, no scsi stuff at all, and set the ports and
irq's for ide0, ide1, ide2 and ide3 with Grub.  This makes the
siimage drives end up nicely as ide4 and ide5, or hdi and hdk.
It even allows me to have two network cards without crashing.

When the machine boots I always get a handful of "irq 12: nobody
cared", but most things seem to work fine anyway.  Except, of
course, that I now get corrupt files when reading or writing large
files.  It only seems to appear on the raid system, not the disks
themselves, so I'll check with the raid guys.

I'll try the -mm tree and see if it makes any difference.

> >Btw, what speed should I be able to get with the siimage module?
>
> You have to consider I'm using WD360GD "Raptors" and not whatever drive 
> you have.  I get 35-55 MB/sec sequential read/write throughput on a 
> single disk.

Ok, that's the same as me.  Around 55MB/sec on the Via interface,
around 35MB/sec on the siimage interface, and 25-30MB/sec on the
Raid5 disk.  This is with just a Duron 800MHz, so that's cool.

Tons of thanks for all your help and your suggestions.

/Basic

