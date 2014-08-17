From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA disks disabled on boot
Date: Sun, 17 Aug 2014 09:39:42 -0400
Message-ID: <20140817133942.GD7679@mtj.dyndns.org>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com>
 <20140714163641.GF31610@htj.dyndns.org>
 <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:59054 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbaHQNjq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2014 09:39:46 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so3748232qgf.34
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2014 06:39:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nuno =?iso-8859-1?Q?Magalh=E3es?= <nunomagalhaes@eu.ipp.pt>
Cc: linux-ide@vger.kernel.org

Hello,

Sorry about the late reply.

On Tue, Jul 15, 2014 at 12:24:21AM +0100, Nuno Magalh=E3es wrote:
> > Can you please try the followings?
>=20
> This doesn't happen every-time i boot, only sometimes (about 50/50).
> Once i booted and the disk was disabled, i created dmesg1.nodisk
>
> > 1. After boot is complete, re-trigger device attach by doing
> >
> >    echo - - - > /sys/class/scsi_host/hostN/scan
>=20
> Partial dmesg2.reset (i just wanted to see what this output to dmesg,
> i didn't reboot)

Does this always work?  ie. can you do it repeatedly and the device is
always detected correctly?  Or, if you issue rescanning after the
device fails detection during boot, does it always work?

> > 2. Boot with libata.force=3Ddump_id and report full dmesg after boo=
t.
>=20
> dmesg3.dump_id
>
> > 3. Boot with libata.force=3Dnohrst and see whether anything changes=
=2E
>=20
> dmesg4.nohrst
>=20
> > Thanks.
>=20
> Thank you for your time.
>=20
> Both dump_id and nohrst detected the drive the first time i used them=
=2E
> Should i keep trying one or the other until the disk is dropped again
> (or not)? Should i specify both boot options simultaneously?

dump_id shouldn't affect anything but should give us more data about
the failure.  Can you please try to reproduce the problem with dump_id
specified?  nohrst may make the problem go away.  Can you please try
to reproduce the issue with the parameter specified.

Thanks.

--=20
tejun
