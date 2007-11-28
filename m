From: Dark Sylinc <dark_sylinc@yahoo.com.ar>
Subject: Re: SATA Shutdown issue confuses (sda)
Date: Wed, 28 Nov 2007 17:02:22 -0300 (ART)
Message-ID: <947127.83110.qm@web56306.mail.re3.yahoo.com>
References: <474CDB65.9050700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web56306.mail.re3.yahoo.com ([216.252.110.230]:37078 "HELO
	web56306.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754727AbXK1UCY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 15:02:24 -0500
In-Reply-To: <474CDB65.9050700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, hmh@debian.org

Thanks for the quick reply
Actually I managed to fix the issue by using the
patches here:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D436703
After using that patch, no more "clack"

> Don't have any debian around but apparently it's
> issuing spin down for
> /dev/sdX's too.

The patch still doesn't solve the missing flush-cache,
however after seeing the code, seems that the origin
of the problem was that shutdown was NOT issuing spin
down at all (for sdX).

> > 4) What everyone in forums is asking... are they
> SATA
> > drives being forced from long time ago, and they
> have
> > just found out by using the new kernel? That
> remains
> > unclear.
>=20
> I don't really get the question here.  Can you
> please elaborate?

Some people around the net is concerned about their
SATA drives. They're wondering if before kernel 2.6.22
their SATA HDDs were making emergency shutdowns and
didn't realize that they weren't normal shutdowns. And
they may have been using Linux in their SATAs from a
long time ago, just to realize now (thanks to the new
K2.6.22 warning) that they were damaging their HDDs
since years.
In summary: the emergency shutdowns issue appeared in
K2.6.22, and using previous kernels fixes it, or the
emergenct shutdown happens in any kernel version??
I can't answer that question by myself, because I've
just installed Linux in this HDD and upgraded
immediately.

> Sure way to tell is to look at emergency unload
> count int the output of
> 'smartctl -a'.  Basically, it should identical to
> 'hdparm -y'.

Thanks, but the idea that software can do such thing
gives me the creeps.


> Opcode 0x94 is retired now and it's probably not too
> good a idea to
> issue it to modern disks.  0xE0 should be good
> enough

Don't blame me, it's in Debian's src. I'm not an HDD
expert. :D

> and yes you
> definitely need to issue FLUSH before spinning down
> the disk.

Seems missing both in the official src and in the
patch provided...
May be I can submit a patch...
However the patch I'm using doesn't trigger FLUSH but
the problem is solved anyway.

Thanks again
Dark Sylinc


      Compart=ED video en la ventana de tus mensajes (y tambi=E9n tus f=
otos de Flickr).=20
Us=E1 el nuevo Yahoo! Messenger versi=F3n Beta. http://ar.beta.messenge=
r.yahoo.com/
