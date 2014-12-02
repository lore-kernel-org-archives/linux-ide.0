From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA disks disabled on boot
Date: Tue, 2 Dec 2014 14:56:53 -0500
Message-ID: <20141202195653.GQ10918@htj.dyndns.org>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com>
 <20140714163641.GF31610@htj.dyndns.org>
 <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com>
 <20140817133942.GD7679@mtj.dyndns.org>
 <CADqA9ubrD1+Ri9d080X4xjrr7wsjqGGz5fjTC45QHjr4Fb1QJg@mail.gmail.com>
 <CADqA9uaj0MrpffnzE8xnhU57Hx9pv7O1sAhB+xS_4hi8z_dkMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:48296 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933377AbaLBT44 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Dec 2014 14:56:56 -0500
Received: by mail-qg0-f49.google.com with SMTP id a108so9690414qge.8
        for <linux-ide@vger.kernel.org>; Tue, 02 Dec 2014 11:56:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CADqA9uaj0MrpffnzE8xnhU57Hx9pv7O1sAhB+xS_4hi8z_dkMA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nuno =?iso-8859-1?Q?Magalh=E3es?= <nunomagalhaes@eu.ipp.pt>
Cc: linux-ide@vger.kernel.org

Hello,

On Fri, Oct 17, 2014 at 11:02:43PM +0100, Nuno Magalh=E3es wrote:
> The Toshibas would hold the OS in a RAID1 while the WDs would hold da=
ta in ZFS.
> At the moment T1 has the OS, T2 has a partition, the WDs are empty.
>=20
> My next test will be to move T2 to the bottom of the BIOS boot
> priority, so it'll become T1, W1, W2, T2 to see if it fails.

If you're still working on it, can you please try to reproduce the
failure with the debug patch applied and report the dmesg?

Thanks.

--=20
tejun
