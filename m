From: Borislav Petkov <bp@alien8.de>
Subject: Re: possible regression in kernel 3.6: system hangs during nightly
 tape backup
Date: Sun, 25 Nov 2012 22:34:24 +0100
Message-ID: <20121125213424.GA32348@x1.alien8.de>
References: <50AACB7E.8060601@imap.cc>
 <50B11D5C.2000802@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:49668 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449Ab2KYVeY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Nov 2012 16:34:24 -0500
Content-Disposition: inline
In-Reply-To: <50B11D5C.2000802@imap.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

+ linux-ide

On Sat, Nov 24, 2012 at 08:17:48PM +0100, Tilman Schmidt wrote:
> Any ideas on that? I'm currently avoiding the 3.6 series because
> of that problem but would be willing to reproduce the hang if I'd
> know what to do once it happens, ie. what kind of information to
> collect in order to identify the cause of the problem.
> I may also try 3.7-rc if there's any interest.
>=20
> Am 20.11.2012 01:14, schrieb Tilman Schmidt:
> > For the 4th time now after switching to kernel 3.6, my system becam=
e
> > unresponsive during the nightly Bacula backup run. It looks as if
> > all disk accesses are suddenly blocked:
> > - Desktop apps stop responding one after another, starting with
> >   Firefox followed by other "heavy" apps, while Konsole windows
> >   continue being usable for a while.
> > - "top" shows the load average steadily increasing with no process
> >   actually consuming relevant quantities of CPU.
> > - I can do "dmesg > /root/dmesg.out" followed by "less /root/dmesg.=
out"
> >   in a Konsole window just fine, but after the inevitable hard rese=
t
> >   the file /root/dmesg.out isn't there.
> > - The "sync" command hangs indefinitely.
> > - The "shutdown" command and ctrl/alt/Del emit "system going down"
> >   broadcast messages but never get anywhere.
> > - Killing processes manually works for some (bacula-sd even ejects
> >   the tape before exiting) but most remain in state D or Z.
> > - Eventually, all text consoles are blocked and a hardware reset is
> >   the only remaining option.
> > - After the reboot, a Bacula spool file is left behind in
> >   /var/spool/bacula, proof that the hang happened during the backup=
=2E
> >=20
> > This does not happen during every backup run, but frequently enough
> > to be annoying. (About once per week.) It never happened with kerne=
l
> > 3.5. For comparison went back to kernel 3.5.7 for a week and it
> > never happened during that time. Last night I booted 3.6.7 and the
> > very next backup caused the hang again. The last kernel message tha=
t
> > made it to the syslog on disk was
> >=20
> > Nov 19 23:05:04 xenon kernel: [73877.128546] st0: Block limits 256 =
-
> > 524288 bytes.
> >=20
> > triggered by the start of the backup. In dmesg the next message was
> >=20
> > [74401.249091] INFO: task flush-253:2:1320 blocked for more than 12=
0
> > seconds.
> >=20
> > followed by a backtrace. I have photos of the remaining dmesg outpu=
t
> > which I'll try to upload somewhere accessible tomorrow.
> >=20
> > Hardware configuration:
> > Intel Pentium D, Intel DQ965GF mainboard, 6 GB RAM
> > onboard S-ATA controller driving two 500 GB S-ATA disks
> > and a Pioneer DVR-216D DVD-RW drive
> > Adaptec 29160B Ultra160 SCSI adapter driving a
> > Tandberg TS400 LTO-2 tape drive
> >=20
> > Disk configuration: md RAID1, LVM, ext3 and ext4 volumes
> >=20
> > Software: Opensuse 11.4 64 bit, vanilla kernel 3.5.7 and 3.6.7,
> > Bacula 5.2.12
> >=20
> > HTH
> > T.
> >=20
>=20
>=20
> --=20
> Tilman Schmidt                    E-Mail: tilman@imap.cc
> Bonn, Germany
> Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
> Unge=C3=B6ffnet mindestens haltbar bis: (siehe R=C3=BCckseite)
>=20
>=20



--=20
Regards/Gruss,
Boris.
