From: Tejun Heo <tj@kernel.org>
Subject: Re: libata error/reset
Date: Tue, 09 Sep 2008 13:28:36 +0200
Message-ID: <48C65DE4.206@kernel.org>
References: <48C17EB1.2020206@isomerica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57021 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645AbYIILaA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Sep 2008 07:30:00 -0400
In-Reply-To: <48C17EB1.2020206@isomerica.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Dan_No=E9?= <dpn@isomerica.net>
Cc: linux-ide@vger.kernel.org

Dan No=E9 wrote:
> Just after midnight last night, during an rsync job which copies a lo=
t
> of data onto my backup disk (half of a Linux software RAID 1), I
> received the following:
>=20
> -- SNIP --
> ata3.00: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0xe frozen
> ata3.00: irq_stat 0x00400000, PHY RDY changed
> ata3: SError: { PHYRdyChg }
> ata3.00: cmd 35/00:10:3f:00:34/00:00:22:00:00/e0 tag 0 dma 8192 out
>          res 50/00:00:4e:01:18/00:00:22:00:00/e0 Emask 0x10 (ATA bus =
error)
> ata3.00: status: { DRDY }
> ata3: hard resetting link
> ata3: link is slow to respond, please be patient (ready=3D0)
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: qc timeout (cmd 0xec)
> ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x5)
> ata3.00: revalidation failed (errno=3D-5)
> ata3: failed to recover some devices, retrying in 5 secs
> ata3: hard resetting link
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: configured for UDMA/100
> ata3: EH complete
> sd 2:0:0:0: [sdc] 625142448 512-byte hardware sectors (320073 MB)
> sd 2:0:0:0: [sdc] Write Protect is off
> sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> -- SNIP --
>=20
> The system seems to be working fine now, and there was not even a RAI=
D
> failure reported by the md system.  Is this something I should be
> concerned about? Hardware issue, software bug?
>=20
> Linux colobus 2.6.26.3 #1 SMP Thu Aug 21 10:15:38 EDT 2008 i686 Intel=
(R)
> Pentium(R) 4 CPU 3.20GHz GenuineIntel GNU/Linux
>=20
> 00:1f.2 SATA controller: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW)
> SATA Controller (rev 03)
>=20
> I am using the libata ahci driver.  There are four drives crammed int=
o a
> 1U with hotplug trays, but AFAIK no one was poking around the system.

Transmission errors do occur occassionally on perfectly healthy
machines so if it doesn't happen regularly, you can just ignore it and
the kernel will do the right thing.  However, there have been
non-insignificant number of cases where sucky power supply fail to
maintain voltage under high IO load and make harddrive go offline
briefly which would also show up as PHYRdyChg.  In these cases, you
can usually hear the drive doing emergency unloading (clicking) and
smartctl -a is likely to show increased values for start/stop count
and/or emergency unload count.  In these cases, the drive loses data
in its buffer and filesystem gets corrupted and you really should get
a better power supply.

Thanks.

--=20
tejun
