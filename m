From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: linux: sata_nv: adma support
Date: Sat, 1 Aug 2015 19:45:32 -0600
Message-ID: <CADLC3L01LMS4yTXBMj7Xke90aP=LK-HhUH9vM80_sMgLk+sg_w@mail.gmail.com>
References: <201412232051.07067@pali>
	<CADLC3L2N2TcO4FR1Bqt2n=g5G+i=dv_y_OhYHA9yXg79Bb6JPg@mail.gmail.com>
	<201508012209.27974@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:33029 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbbHBBpe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Aug 2015 21:45:34 -0400
In-Reply-To: <201508012209.27974@pali>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Sat, Aug 1, 2015 at 2:09 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
> On Thursday 25 December 2014 07:22:13 Robert Hancock wrote:
>> On Tue, Dec 23, 2014 at 1:51 PM, Pali Roh=C3=A1r <pali.rohar@gmail.c=
om>
>> wrote:
>> > Hello,
>> >
>> > I have nvidia nforce4 motherboard with nvidia sata controller:
>> >
>> > 00:07.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA
>> > Controller [10de:0054] (rev f3)
>> > 00:08.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA
>> > Controller [10de:0055] (rev f3)
>> >
>> > I manually enabled adma mode (which is disabled by default) by
>> > adding sata_nv.adma=3D1 to grub cmdline. In git history I found
>> > that enabling adma mode includes NCQ support and reduced CPU
>> > overhead. It looks like adma mode is working, but at every boot I
>> > see one same error message in dmesg:
>> >
>> > [   16.823514] ata1.00: exception Emask 0x1 SAct 0x0 SErr 0x0
>> > action 0x0
>> > [   16.823520] ata1.00: CPB resp_flags 0x11: , CMD error
>> > [   16.823524] ata1.00: failed command: SET FEATURES
>> > [   16.823530] ata1.00: cmd ef/05:fe:00:00:00/00:00:00:00:00/40
>> > tag 16
>> > [   16.823530]          res 51/04:fe:00:00:00/00:00:00:00:00/40
>> > Emask 0x1 (device error)
>> > [   16.823533] ata1.00: status: { DRDY ERR }
>> > [   16.823535] ata1.00: error: { ABRT }
>> >
>> > When adma is disabled then this error message is not generated.
>>
>> It looks like something is trying to issue a command to disable APM
>> power management on the drive, and the command fails (likely because
>> it doesn't support that command). I'm not sure where that would be
>> coming from - I'm pretty sure the kernel doesn't issue that command
>> itself. Something that's part of your distro perhaps?
>>
>> I don't know why it would only be failing in ADMA mode either, thoug=
h
>> depending on where the command is coming from, maybe it's not being
>> issued otherwise for some reason?
>>
>> > What does that error message means? It is critical? What is that
>> > command SET FEATURES doing? Are there any problems with adma mode
>> > on nforce4 motherboards? Because I did not see any problems
>> > (except that one error message).
>> >
>> > --
>> > Pali Roh=C3=A1r
>> > pali.rohar@gmail.com
>
> Hello,
>
> now after long time I did more investigation and that error is report=
ed
> for every connected HDD. I identified that it comes from udev script
>
>  /lib/udev/rules.d/85-hdparm.rules
>
> which just call script /lib/udev/hdparm for every one connected HDD.
>
> Script /lib/udev/hdparm just call:
>
>  /sbin/hdparm -B254 $DRIVE
>
> And that -B254 cause above error message in dmesg log. Output from
> hdparm is:
>
>  /dev/sda:
>   setting Advanced Power Management level to 0xfe (254)
>   APM_level      =3D not supported
>
> Any idea why in ADMA mode it cause above error (APM unsupported) and =
in
> non ADMA mode it is working fine? Maybe APM ATA commands should not b=
e
> sent via ADMA?
>
> Here is another output:
>
>  $ sudo hdparm -I /dev/sda | grep -i power
>             *    Power Management feature set
>                  Power-Up In Standby feature set
>             *    SET_FEATURES required to spinup after power up
>             *    Host-initiated interface power management

The "set features" command is a non-data command so based on our
current knowledge, it should work in ADMA mode. However, these NVIDIA
SATAs are black boxes, and rather buggy ones at that, so it's possible
there's an unknown issue there.

The easiest way to test that would be to take out the condition check
for qc->tf.protocol =3D=3D ATA_PROT_NODATA in nv_adma_use_reg_mode in
drivers/ata/sata_nv.c. That would force it to disable ADMA for all
non-data commands.

I really don't know why Ubuntu is disabling APM on all drives on
bootup however. Especially for laptops, that seems like a silly thing
to do explicitly. Sounds like one of the silly things Ubuntu is known
to do without consulting people.
