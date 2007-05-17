From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Subject: RE: SATA intel High loads due to writes vs ata_piix switch
Date: Thu, 17 May 2007 10:42:20 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7033AB605@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
References: <8E8F647D7835334B985D069AE964A4F7028FE7F0@ECQCMTLMAIL1.quebec.int.ec.gc.ca> <20070516214236.08dd02c9@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:45102 "EHLO
	ecqcmtlbh.quebec.int.ec.gc.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753995AbXEQOm4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 May 2007 10:42:56 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux IDE <linux-ide@vger.kernel.org>

> -----Message d'origine-----
> De : Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]=20
> Envoy=E9 : 16 mai 2007 16:43
>=20
> > I made a fwe tests to try to point out when high loads happens (whi=
ch=20
> > are not really scientific :).  Note that between each tests I made=20
> > sure the load average got back below 0.15.
> >=20
> > But first, here are my 2 questions:
> > 1- Should I really expect loads that high using that driver?
>=20
> Remember that uptime type load also measure system wait so=20
> high disk I/O counts as load but not CPU usage. High CPU=20
> usage shouldn't be a problem for any DMA based disk
>=20
> With the newer ICH controllers and especially if your disk=20
> does NCQ you should see better performance with libata as the=20
> libata drivers support AHCI and NCQ which allows multiple=20
> outstanding commands.

Maybie I should have explain that, I found this problem while trying to=
 compile a single kernel with -j1 or -j2 on this dual core CPU and it m=
ade the load average climb to at least 10.  Doing more testing revealed=
 that most writes to disks made the load average climb seriously (Just =
dragging 400-500mb of MP3 made the load climb really heavilly making my=
 system unresponsive)...  Actually, just uncompressing kernel sources m=
akes my system unresponsive and that is not a heavy task?

However on my AMD 4200+ system at home with libata driver on a nforce c=
hipset I can compile 5 kernels at once using -j4 for each compilation a=
nd I get a load of around 10-12 and that is, I believe, a normal behavi=
our.

This is why I believe that there is a bug in the E-IDE driver and that =
switching to libata would greatly improve performances.
=20
> > "Multi-Platform E-IDE driver Revision: 7.00alpha2" and detected bot=
h=20
> > my hd & dvdrw as scsi devices BUT finally ended up in a oops:
> > pivot_root: No such file or directory
> > /sbin/init: 432: Cannot open dev/console: No such file Kernel panic=
 -=20
> > not syncing: Attempted to kill init
>=20
> Thats really for the Debian lists, it sounds as if Debian=20
> still isn't using disk labels in the initrd.

Yeah, I'll try to dig some more info on this.  I tought it would have b=
een easier switching from one to the other... :(

> > TEST 2: 10000 1mb files (medium size files):
> > Note that I stopped the test a the 4134th file)
> > -----------------------------------------------
> > Max load average (a simple while loop + sleep 5 + cat /proc/loadavg=
)
> > 16.36 12.64 7.86 2/122 3602
>=20
> If you are doing all the I/O in parallel then that isn't=20
> unexpected - disk performance is very very seek dependant snd=20
> a lot of parallel I/O will cause a lot of seeking. If they=20
> are occuring in serial then this is a bit odd and would=20
> warrant more investigating. I don't however think this is=20
> likely to be a disk layer problem so I doubt libata v oldIDE=20
> makes that much difference here - a bit because of NCQ but not a lot.

This was serial testing (wich makes this odd):

while [ $i -lt $MAX ]
do
   declare TMP_FILE=3D`mktemp ${TEST_DIR}/${i}.XXXXXX` || exit 1
   dd if=3D/dev/zero of=3D${TMP_FILE} bs=3D${BS} count=3D${COUNT} 2>/de=
v/null
   let i++
done

> Alan
>=20

Thnx for answering!

- vin
