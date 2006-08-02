From: Roger Oberholtzer <roger@opq.se>
Subject: Re: libata question
Date: Wed, 02 Aug 2006 10:06:17 +0200
Message-ID: <1154505978.25611.33.camel@acme>
References: <1154445491.18593.111.camel@acme>  <44CF7447.300@gmail.com>
	 <1154457583.4665.5.camel@shark.pacific>  <44CFA15C.8080109@gmail.com>
	 <1154458981.4665.9.camel@shark.pacific>  <44CFA618.2090204@gmail.com>
	 <1154502301.5691.23.camel@acme>  <44D0522E.6030905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [62.209.160.46] ([62.209.160.46]:17104 "EHLO stockholm.opq.se")
	by vger.kernel.org with ESMTP id S1751316AbWHBIGY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Aug 2006 04:06:24 -0400
In-Reply-To: <44D0522E.6030905@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, 2006-08-02 at 16:20 +0900, Tejun Heo wrote:
> Roger Oberholtzer wrote:
> > On Wed, 2006-08-02 at 04:06 +0900, Tejun Heo wrote:=20
> >> Roger Oberholtzer wrote:
> >>> On Wed, 2006-08-02 at 03:45 +0900, Tejun Heo wrote:
> >>>> Roger Oberholtzer wrote:
> >>>>> On Wed, 2006-08-02 at 00:33 +0900, Tejun Heo wrote:
> >>>>>> Roger Oberholtzer wrote:
> >>>>>>> Should hotplug work with Intel Corporation 82801GB/GR/GH (ICH=
7
> >>>>>>> Family) chipset? I am trying kernel 2.6.17.7
> >>>> Ah.. I should have spotted this earlier.  2.6.17.7 doesn't conta=
in=20
> >>>> updated EH and doesn't support any of new features including=20
> >>>> hot/warmplug.  Please try 2.6.18-rc3.
> >>> OK. But I think there are issues with 2.6.18 generally. But I can=
 try it
> >>> to see if this makes this better.
> >> If you're uncomfortable with -rcX, you can try libata-tj-stable pa=
tch.=20
> >> It contains most of new stuff.
> >>
> >> http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060=
710.tar.bz2
> >=20
> > Thanks for that. But it had no noticeable difference.
>=20
> Hmmm... That's weird. 'echo - - - > /sys/class/scsi_host/xxx.../scan'=
=20
> didn't do the right thing?  Care to post dmesg?

I thought maybe the detection of removal and insertion would work. I di=
d
not try the /sys stuff. I will look into that. I guess I can have them
be sure there is a disk in each bay when the system is powered up. I
will see if this hardware requires this.

> > I looked in the bios on my system to see if I could set the SATA di=
sks
> > to AHCI mode. I did not see anything like that. I could select to d=
o a
> > manual config, in which case I could set things like LBA mode, 32-b=
it
> > I/O (which defaults to off). So if hots wap require AHCI mode, I se=
em to
> > be screwed. It is a phoenix bios for the supermicro computer.
>=20
> The chipset might not support ahci mode.
>=20
> > Maybe I can try a different SATA card instead of the stuff on the
> > motherboard. What do you think is the best one re hots waping? Eith=
er
> > PCI or PCI-X.
>=20
> I primarily use sil3112/4, sil3124/32 and ahci for development.  So=20
> those tend to have better support for EH/hotplug stuff.
>=20
> >>>>> I bet the driver does the right thing. The trick is knowing wha=
t that is
> >>>>> supposed to be. And how to use the various commands on files in=
 /sys at
> >>>>> the correct time and in the correct order.
> >>>> Really, it's not that complicated.
> >>> Once you know what it is you need to do.
> >> I tried hard to make things just work.  If you find things unneces=
sarily=20
> >> complicated, please let me know.
> >=20
> > I have a system with an IDE disk with the OS that is fixed. I also =
have
> > 4 hot swappable SATA disk bays. My use will involve changing the SA=
TA
> > disks to do an analysis of the data they contain. There will be 4 d=
isks
> > in an analysis set. I need to make it easy for the user to insert a=
nd
> > remove disks. Rebooting each time is a bad alternative. So, if hot =
swap
> > does not work, I will have to get warm swap working. I think part o=
f the
> > confusion I have is how to deal with disks that are mounted. So I n=
eed
> > to get the steps well defined and make those that require user
> > interaction as few as possible.
>=20
> As far as libata is concerned, for warmplug, all you need to use are
>=20
>    echo 1 > /sys/class/scsi_device/xxxx/device/delete
>=20
> for removal, and for plugging
>=20
>    echo - - - > /sys/class/scsi_host/xxxxx/scan
>=20
> If you remove device before unmounting, the mounted fs will suffer fr=
om=20
> io errors and probably spit quite some error messages, so unmounting=20
> before is a good idea.
>=20
> In general, ata_piix doesn't respond very well to runtime device=20
> addition mainly due to problems with port enable.  So, if you boot wi=
th=20
> empty slot and put new device in there and issue scan, it might or mi=
ght=20
> not work, but ports which had a device attached on boot seem to alway=
s work.
>=20
> On any 2.6.17 kernel, without new EH, none of hot/warm plugging works=
=2E=20
> Please double check you have the correct kernel.  Kernel messages are=
=20
> very different.

It is 2.6.17.7 (current stable from kernel.org), with your suggested
patches.

--=20
Roger Oberholtzer

OPQ Systems AB
Ramb=C3=B6ll Sverige AB
Kapellgr=C3=A4nd 7
P.O. Box 4205
SE-102 65 Stockholm, Sweden

Tel: Int +46 8-615 60 20
=46ax: Int +46 8-31 42 23

