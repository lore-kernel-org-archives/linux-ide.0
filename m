From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] libata, hddtemp + s2ram is racy
Date: Mon, 10 May 2010 10:04:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005100958430.1626-100000@iolanthe.rowland.org>
References: <20100507230732.5dd15e93@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100507230732.5dd15e93@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Cc: linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, 7 May 2010, Bruno [UTF-8] Pr=C3=A9mont wrote:

> Hi,
>=20
> On a SMP system I've hit a race condition between suspend and hddtemp
> checking disk's temperature.
>=20
> System details:
> - Dual-core AMD Turion CPU
> - 00:12.0 SATA controller [0106]: ATI Technologies Inc SB600 Non-Raid=
-5 SATA [1002:4380]
> - hddtemp-0.3_beta15 (Gentoo package app-admin/hddtemp-0.3_beta15-r3)
> - Linus' tree shortly after v2.6.34-rc6, at commit
>   be1066bbcd443a65df312fdecea7e4959adedb45 with some drm updates on
>   top of it.
>=20
>=20
> It looked like hddtemp had sent the SMART request to disk right befor=
e
> suspend and during suspend process ata2 did complain without aborting
> suspend (see below).
> After resume access to that disk was dead-locked (any further
> attempt to suspend timed-out freezing hddtemp and any access attempt
> towards that disk did put userspace tasks in uninterruptible state an=
d
> caused soft-raid to mark the disk failed).
>=20
> Is suspend not waiting on SG_IO ioctls to complete (at ata host level=
)?

If you use the libata driver then the ATA I/O is handled by the SCSI=20
midlayer.  The SCSI midlayer waits for the device's command queue to=20
drain completely before initiating a suspend.

=46urthermore, the hddtemp process has to get frozen before the suspend=
=20
can begin, and I believe a process cannot be frozen while it is waiting=
=20
for an SG_IO to complete.

At any rate, you should try posting this bug report on the linux-scsi=20
mailing list.

Alan Stern
