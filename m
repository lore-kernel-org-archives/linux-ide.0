From: =?iso-8859-1?Q?S=E9bastien?= <willy_the_cat@yahoo.com>
Subject: Re : Re : dvd-9 trouble with TSSTcorp SH-S203D
Date: Sun, 3 Aug 2008 14:53:36 +0000 (GMT)
Message-ID: <547246.1958.qm@web26202.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web26202.mail.ukl.yahoo.com ([217.12.10.239]:28898 "HELO
	web26202.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758074AbYHCOxi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Aug 2008 10:53:38 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org


Hi,


> S=E9bastien wrote:
> > Here's attached file of config 2.6.27-rc1 and System-map 2.6.27-rc1
> > and lspci -nn and dmesg before mount and after mount (-t udf /dev/s=
r0
> > fool)
> >=20
> > I re-compile a fresh kernel : HW Bug re-appear. It had been
> > diseappered with 2.6.26 and re-appeared with that new fresh kern
> > 2.6.27-rc1 : perhaps a mistaken comipile option. However with that
> > 2.6.26, HW Bug only disappeared when "Native IDE" was set in Bios
> > SATA OnChip option.
>=20
> That message is harmless and it showing up or not probably means your
> controller is behaving slightly differently and is most likely random=
=2E
> As long as the detection works out, it's okay.  Maybe we need to make
> the message friendlier.

Agreed.
Oops, the right bios option is "Legacy IDE" and NOT "Native IDE" as I w=
rote, among "Legacy IDE" and "Native IDE" and "RAID" and "AHCI".
I'm nearly sure that it is an kernel option i.e. take only sata modules=
 and get rid of all pata modules. I should make modules only for my box=
 indead.

> > Changed nearly nothing when compiling that new kern, i.e. :
> >=20
> > make mrproper make menuconfig
> >=20
> > --> Change Generic x86_64 to Opteron/Athlon64/Hammer/K8
> >=20
> > --> Exit
> >=20
> > then, make-kpg with initrd enabled.
> >=20
> > I was pretty sure that the trouble would still appear with
> > 2.6.27-rc1, but didn't exept HW Bug again. error message is part of
> > diff before-mount after-mount, i.e. : end_request: I/O error, dev
> > sr0, sector 11697200
>=20
> Hmm.. Strange, no ATA error message nor past the end of the device
> message.  I wonder where that error comes from.  Is the DVD accessibl=
e
> at all after mounting?  We had several UDF related reports and IIRC
> those haven't been resolved.  Maybe you're seeing the same problem.

yes, no errors before real access.

=46irst.
I read that it was because Linux were to fast to do the job, from A. Co=
x, if I remember correctly and concern many CD-DVD Cumbo and other devi=
ce of that kind.
It is probably not the case here because It was an old message.
Look, it is appear when DVD-9 are inserted and not other ones (DVD-5, C=
D* good).
I suspect a different way to attack the TSST Corp in case of DVD-9 and =
perhaps at "low speed", like suggested.
The first message I read about that particular material was again from =
A. Cox and he resumed that we must know the way to talk with the device=
=2E He even conclude by a list of things to do with etc. like it was re=
ally often to be in front of that we were in presence of such kind of p=
rocess with many others material.
Really don't know any of the command send.

Second.
I read that we must update the firmware from L. Torvalds and probably m=
any others. This was done before I wrote my first message, the up to da=
te firmware is from may (SB001).
I even read that there were a kernel patch for that particular problem =
but didn't find it.
Compile libata in kernel to have a better access to the dma and pio con=
trol : nothing.
Modify kernel source to blacklisted the device : nothing.

Third.
Yes, you right, it seems that some others have the same trouble with th=
at sort of device.
I didn't irc but I saw some similar message and no real kernel post abo=
ut the progress on that trouble execpt that there were a patch.

=46ourth.
DVD-5 and CD*, as I said, works fine : mounting and access.
DVD-9 is mount with an end_request I/O error. (2.6.27-rc1-git4 change n=
othing :))
I can access through the directory of the disk.

Here's a file * of VIDEO_TS contents of it :

$ file *
VIDEO_TS.BUP: Video manager, v11
VIDEO_TS.IFO: Video manager, v11
VIDEO_TS.VOB: ERROR: cannot read `VIDEO_TS.VOB' (Input/output error)
VTS_01_0.BUP: Video title set, v11
VTS_01_0.IFO: Video title set, v11
VTS_01_0.VOB: ERROR: cannot read `VTS_01_0.VOB' (Input/output error)
VTS_01_1.VOB: ERROR: cannot read `VTS_01_1.VOB' (Input/output error)
VTS_01_2.VOB: MPEG sequence, v2, program multiplex
VTS_01_3.VOB: MPEG sequence, v2, program multiplex
VTS_01_4.VOB: MPEG sequence, v2, program multiplex
VTS_01_5.VOB: ERROR: cannot read `VTS_01_5.VOB' (Input/output error)
VTS_01_6.VOB: MPEG sequence, v2, program multiplex
VTS_02_0.BUP: Video title set, v11
VTS_02_0.IFO: Video title set, v11
VTS_02_0.VOB: empty
VTS_02_1.VOB: ERROR: cannot read `VTS_02_1.VOB' (Input/output error)

And Here's the dmesg of the input/output errors :
=46rom mount :
[ 2002.943737] end_request: I/O error, dev sr0, sector 11697200
[ 2003.112690] UDF-fs: Partition marked readonly; forcing readonly moun=
t
[ 2003.138034] UDF-fs INFO UDF: Mounting volume 'BROKEN_ARROW', timesta=
mp 1999/12/29 19:42 (1078)

=46rom file * :
[ 2034.392665] end_request: I/O error, dev sr0, sector 1220
[ 2034.392705] Buffer I/O error on device sr0, logical block 305
[ 2034.392740] Buffer I/O error on device sr0, logical block 306
[ 2034.392771] Buffer I/O error on device sr0, logical block 307
[ 2034.392801] Buffer I/O error on device sr0, logical block 308
[ 2034.392832] Buffer I/O error on device sr0, logical block 309
[ 2034.392862] Buffer I/O error on device sr0, logical block 310
[ 2034.392892] Buffer I/O error on device sr0, logical block 311
[ 2034.392923] Buffer I/O error on device sr0, logical block 312
[ 2034.392953] Buffer I/O error on device sr0, logical block 313
[ 2034.392983] Buffer I/O error on device sr0, logical block 314
[ 2034.416025] end_request: I/O error, dev sr0, sector 1220
[ 2034.833477] end_request: I/O error, dev sr0, sector 2456
[ 2034.855230] end_request: I/O error, dev sr0, sector 2456
[ 2034.954243] end_request: I/O error, dev sr0, sector 224624
[ 2034.976313] end_request: I/O error, dev sr0, sector 224624
[ 2036.034252] end_request: I/O error, dev sr0, sector 7356612
[ 2036.058234] end_request: I/O error, dev sr0, sector 7356612
[ 2037.287468] end_request: I/O error, dev sr0, sector 11464736
[ 2037.311031] end_request: I/O error, dev sr0, sector 11464736

As you can see, we have partial access of file in the device.
Really seems it's nearly nothing to have a good right access, but didn'=
t be able to guess what since 6 month !
ok, see ya.


> > You can have an ssh -l root on that Debian unstable GNU/linux box i=
f
> > it can help you.
>=20
> Yeah, I'm attaching my public key.  Please send me the login informat=
ion.

Hmm, don't know how to deal with that, I will learn.
I think you'll receive, in the worse case, login connexion in cupple fe=
w days.

> Thanks.

You're welcome.

Best regards.
S=E9bastien


----- Message d'origine ----
De : Tejun Heo <tj@kernel.org>
=C0 : S=E9bastien <willy_the_cat@yahoo.com>
Cc : jgarzik@pobox.com; linux-ide@vger.kernel.org
Envoy=E9 le : Dimanche, 3 Ao=FBt 2008, 5h27mn 41s
Objet : Re: Re : dvd-9 trouble with TSSTcorp SH-S203D

S=E9bastien wrote:
> Here's attached file of config 2.6.27-rc1 and System-map 2.6.27-rc1
> and lspci -nn and dmesg before mount and after mount (-t udf /dev/sr0
> fool)
>=20
> I re-compile a fresh kernel : HW Bug re-appear. It had been
> diseappered with 2.6.26 and re-appeared with that new fresh kern
> 2.6.27-rc1 : perhaps a mistaken comipile option. However with that
> 2.6.26, HW Bug only disappeared when "Native IDE" was set in Bios
> SATA OnChip option.

That message is harmless and it showing up or not probably means your
controller is behaving slightly differently and is most likely random.
As long as the detection works out, it's okay.  Maybe we need to make
the message friendlier.

> Changed nearly nothing when compiling that new kern, i.e. :
>=20
> make mrproper make menuconfig
>=20
> --> Change Generic x86_64 to Opteron/Athlon64/Hammer/K8
>=20
> --> Exit
>=20
> then, make-kpg with initrd enabled.
>=20
> I was pretty sure that the trouble would still appear with
> 2.6.27-rc1, but didn't exept HW Bug again. error message is part of
> diff before-mount after-mount, i.e. : end_request: I/O error, dev
> sr0, sector 11697200

Hmm.. Strange, no ATA error message nor past the end of the device
message.  I wonder where that error comes from.  Is the DVD accessible
at all after mounting?  We had several UDF related reports and IIRC
those haven't been resolved.  Maybe you're seeing the same problem.

> You can have an ssh -l root on that Debian unstable GNU/linux box if
> it can help you.

Yeah, I'm attaching my public key.  Please send me the login informatio=
n.

Thanks.

--=20
tejun



      _________________________________________________________________=
____________=20
Envoyez avec Yahoo! Mail. Une boite mail plus intelligente http://mail.=
yahoo.fr
