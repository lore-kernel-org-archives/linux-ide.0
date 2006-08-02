From: Roger Oberholtzer <roger@opq.se>
Subject: Re: libata question
Date: Wed, 02 Aug 2006 09:05:01 +0200
Message-ID: <1154502301.5691.23.camel@acme>
References: <1154445491.18593.111.camel@acme>  <44CF7447.300@gmail.com>
	 <1154457583.4665.5.camel@shark.pacific>  <44CFA15C.8080109@gmail.com>
	 <1154458981.4665.9.camel@shark.pacific>  <44CFA618.2090204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [62.209.160.46] ([62.209.160.46]:50655 "EHLO stockholm.opq.se")
	by vger.kernel.org with ESMTP id S1751285AbWHBHFG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Aug 2006 03:05:06 -0400
In-Reply-To: <44CFA618.2090204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, 2006-08-02 at 04:06 +0900, Tejun Heo wrote:=20
> Roger Oberholtzer wrote:
> > On Wed, 2006-08-02 at 03:45 +0900, Tejun Heo wrote:
> >> Roger Oberholtzer wrote:
> >>> On Wed, 2006-08-02 at 00:33 +0900, Tejun Heo wrote:
> >>>> Roger Oberholtzer wrote:
> >>>>> Should hotplug work with Intel Corporation 82801GB/GR/GH (ICH7
> >>>>> Family) chipset? I am trying kernel 2.6.17.7
> >> Ah.. I should have spotted this earlier.  2.6.17.7 doesn't contain=
=20
> >> updated EH and doesn't support any of new features including=20
> >> hot/warmplug.  Please try 2.6.18-rc3.
> >=20
> > OK. But I think there are issues with 2.6.18 generally. But I can t=
ry it
> > to see if this makes this better.
>=20
> If you're uncomfortable with -rcX, you can try libata-tj-stable patch=
=2E=20
> It contains most of new stuff.
>=20
> http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060710=
=2Etar.bz2

Thanks for that. But it had no noticeable difference.

I looked in the bios on my system to see if I could set the SATA disks
to AHCI mode. I did not see anything like that. I could select to do a
manual config, in which case I could set things like LBA mode, 32-bit
I/O (which defaults to off). So if hots wap require AHCI mode, I seem t=
o
be screwed. It is a phoenix bios for the supermicro computer.

Maybe I can try a different SATA card instead of the stuff on the
motherboard. What do you think is the best one re hots waping? Either
PCI or PCI-X.

> >>> I bet the driver does the right thing. The trick is knowing what =
that is
> >>> supposed to be. And how to use the various commands on files in /=
sys at
> >>> the correct time and in the correct order.
> >> Really, it's not that complicated.
> >=20
> > Once you know what it is you need to do.
>=20
> I tried hard to make things just work.  If you find things unnecessar=
ily=20
> complicated, please let me know.

I have a system with an IDE disk with the OS that is fixed. I also have
4 hot swappable SATA disk bays. My use will involve changing the SATA
disks to do an analysis of the data they contain. There will be 4 disks
in an analysis set. I need to make it easy for the user to insert and
remove disks. Rebooting each time is a bad alternative. So, if hot swap
does not work, I will have to get warm swap working. I think part of th=
e
confusion I have is how to deal with disks that are mounted. So I need
to get the steps well defined and make those that require user
interaction as few as possible.

--=20
Roger Oberholtzer

OPQ Systems AB
Ramb=C3=B6ll Sverige AB
Kapellgr=C3=A4nd 7
P.O. Box 4205
SE-102 65 Stockholm, Sweden

Tel: Int +46 8-615 60 20
=46ax: Int +46 8-31 42 23

