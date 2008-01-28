From: Gene Heskett <gene.heskett@gmail.com>
Subject: Re: Problem with ata layer in 2.6.24
Date: Mon, 28 Jan 2008 13:59:23 -0500
Message-ID: <200801281359.24050.gene.heskett@gmail.com>
References: <200801272122.21823.gene.heskett@gmail.com>
 <200801281156.28844.gene.heskett@gmail.com> <479E1CF4.7060706@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms040pub.verizon.net ([206.46.252.40]:48077 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbYA1TIe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jan 2008 14:08:34 -0500
In-reply-to: <479E1CF4.7060706@rtr.ca>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

On Monday 28 January 2008, Mark Lord wrote:
>> [   64.037975] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action=
 0x0
>> [   64.038102] ata1.00: BMDMA stat 0x65
>> [   64.038227] ata1.00: cmd c8/00:58:89:3d:07/00:00:00:00:00/e0 tag =
0 dma
>> 45056 in [   64.038229]          res 51/40:58:8b:3d:07/00:00:00:00:0=
0/e0
>> Emask 0x9 (media error) [   64.038432] ata1.00: status: { DRDY ERR }
>> [   64.038555] ata1.00: error: { UNC }
>> [   64.050125] ata1.00: configured for UDMA/100
>> [   64.050134] sd 0:0:0:0: [sda] Result: hostbyte=3D0x00 driverbyte=3D=
0x08
>> [   64.050138] sd 0:0:0:0: [sda] Sense Key : 0x3 [current] [descript=
or]
>> [   64.050142] Descriptor sense data with sense descriptors (in hex)=
:
>> [   64.050143]         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 =
00
>> [   64.050149]         00 07 3d 8b
>> [   64.050152] sd 0:0:0:0: [sda] ASC=3D0x11 ASCQ=3D0x4
>> [   64.050155] end_request: I/O error, dev sda, sector 474507
>
>..
>
>This error looks somewhat different from the samples posted earlier.
>This one is quite definitively a "bad sector".
>
>It should also show up in "smartctl -a -data /dev/sda" (near the botto=
m)
>if SMART was enabled on this drive at boot.
>
It does not unforch.

>You could try reading that specific sector again just to make sure.
>One way is to figure out how to use "dd" for this.
[root@coyote ~]# dd if=3D/dev/sda bs=3D512 skip=3D474506 count=3D3
=EF=BF=BD=EF=BF=BD=E2=96=926
{=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDlibkd=
ecorations.so.1.0.0=EF=BF=BD=EF=BF=BDc=EF=BF=BD=C2=AE=EF=BF=BD=EF=BF=BD=
=EF=BF=BDJ{=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=
=BDlibkfontinst.so.0.0.0=EF=BF=BD=EF=BF=BDc=EF=BF=BD=C2=AE=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD"=CA=82=EF=BF=BDGP=EF=BF=BD~GJ3G=20
6=EF=BF=BD7=EF=BF=BD8=EF=BF=BD#=EF=BF=BD=EF=BF=BDz;=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD{=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDG=EF=BF=BD=EF=BF=BD=
=EF=BF=BDlibkhotkeys_shared.so.1.0.0=EF=BF=BD=EF=BF=BDc=EF=BF=BD=C2=AE=EF=
=BF=BD=EF=BF=BD=EF=BF=BDN{=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDG=EF=BF=BD=
=EF=BF=BD=EF=BF=BDlibkickermain.so.1.0.0=EF=BF=BD=EF=BF=BDc=EF=BF=BD=C2=
=AE=EF=BF=BD=EF=BF=BD=EF=BF=BDY{=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDG=EF=
=BF=BD=EF=BF=BD=EF=BF=BDlibkonq.so.4.2.0=EF=BF=BD=EF=BF=BDc=EF=BF=BD=C2=
=AE=EF=BF=BD=EF=BF=BD=EF=BF=BDZ{=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDG=EF=
=BF=BD=EF=BF=BD=EF=BF=BDlibkonqsidebarplugin.so.1.2.0=EF=BF=BD=EF=BF=BD=
c=EF=BF=BD=C2=AE=EF=BF=BD=EF=BF=BD=EF=BF=BDd{=EF=BF=BDG=EF=BF=BD=EF=BF=BD=
=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDlibksgrd.so.1.2.0=EF=BF=BD=EF=BF=BD=
c=EF=BF=BD=C2=AE=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=E2=96=92=EF=BF=BD=EF=
=BF=BDG7=20
G=E2=96=92=EF=BF=BD=3DG=E2=96=92]=EF=BF=BD=EF=BF=BD^=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=E2=96=92?=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDe{=EF=BF=BDG=EF=BF=BD=
=EF=BF=BD=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDlibksplashthemes.so.0.0.0=
=EF=BF=BD=EF=BF=BDc=EF=BF=BD=C2=AE=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=
=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDlibtas=
kbar.so.1.2.0=EF=BF=BD=EF=BF=BDc=EF=BF=BD=C2=AE=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD{=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=
=BF=BDlibtaskmanager.so.1.0.0=EF=BF=BD=EF=BF=BDc=EF=BF=BD=C2=AE=EF=BF=BD=
3+0=20
records in
3+0 records out
1536 bytes (1.5 kB) copied, 6.1403e-05 s, 25.0 MB/s

>Another way is to use the "make_bad_sector" utility that
>is included in the source tarball for hdparm-7.7, as follows:
>
>   make_bad_sector --readback /dev/sda 474507
>
Apparently not in the rpm, darnit.

>(when invoked as above, it does *not* "make" a bad sector; no worries)=
=2E
>
>If it reports an I/O error consistently on that, then the sector is
>indeed faulty, and it's contents have long been lost.
>
>You can repair the bad sector (but not the original contents) like thi=
s:
>
>   make_bad_sector --rewrite /dev/sda 474507
>
>Cheers

I'm going up to Clarksburg this afternoon to see if I can find a couple=
 of=20
drives, one a 2.5" bigger than 40Gb for my 2.5" maxtor usb housing, and=
=20
another pata drive big enough to run this thing & just re-install the=20
December respin after I save as much of this as I can, there's nearly 5=
0GB=20
here now.

Maybe it won't be so fscking picky about the next drive.

I was hoping someone could look at that last dmseg I attached, but appa=
rently=20
everybody is blinded by unrelated details as that bad sector may have b=
een=20
transient, caused by the multiple hardware reset type reboots so far to=
day :(

The last 3 reboots have interrupted a 'smartctl -t long /dev/sda' in=20
progress. :(

If I reconvert to non libata, can I do that only for the pata drives of=
 which=20
there are 3 here including the dvd writer, and still use libata for the=
 lone=20
sata drive left?

And can I do that without mucking with the device map, which will make=20
amanda/tar attempt to do a level 0 on the whole system if its changed. =
 I see=20
the drives are at 254 again, when are they going to be given a stable d=
evice=20
address out of the LANANA experimental group so we can reboot without m=
ucking=20
with that and driving tar crazy?

Thanks everybody.

--=20
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
I just had my entire INTESTINAL TRACT coated with TEFLON!
