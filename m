From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PROBLEM: I/O scheduler problem with an 8 SATA disks raid 5 under
 heavy load  ?
Date: Mon, 07 Jan 2008 18:29:15 -0600
Message-ID: <4782C3DB.1090201@shaw.ca>
References: <fa.NcJePXcdrF+7E7oXv5ULIxogTYI@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:62336 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948AbYAHA3u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jan 2008 19:29:50 -0500
In-reply-to: <fa.NcJePXcdrF+7E7oXv5ULIxogTYI@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Guillaume_Laur=E8s?= <guillaume-laures@neuf.fr>
Cc: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>

Laur=E8s wrote:
> Hello,
>=20
> Dear kernel developers, my dmesg asked me to report this, so here I g=
o ;)
> Here is what I found in my dmesg: "anticipatory: forced dispatching i=
s=20
> broken (nr_sorted=3D1), please report this".
>=20
> - First, let's talk about the machine: it's quite pushed so maybe the=
=20
> cause is me doing something wrong rather than a bug in the kernel.
>=20
> I got this alert on a dual core amd64 xen host. It has 8 SATA drives=20
> making a raid 5 array. This array makes a virtual block device for on=
e=20
> of the virtual machines:  an Openfiler appliance. Openfiler then mana=
ges=20
> logical volumes on this device including an XFS partition shared via=20
> NFS. 2 MythTV hosts continuously write MPEG2 tv shows on it (1 to 4Gb=
=20
> each).
> Still following ? Here is a summary: MPEG2 files -> NFS -> XFS -> LVM=
 ->=20
> Xen VBD -> RAID 5 -> 8x SATA disks.
>=20
> - Next, the symptoms.
>=20
> This setup is only 2 weeks old. Behavior was quite good, except for s=
ome=20
> unexplained failures from the sata_nv attached disks. Not always from=
=20
> the same disk. Never from any disks attached through the sata_sil HBA=
=2E
> Eventually a second disk would go down before the end of the raid=20
> reconstruction (still a sata_nv attached one).
> Since the disks showed nothing wrong with smartmontools I re-added th=
em=20
> each time. So far the raid array was strong enough to be fully=20
> recovered, mdadm --force and xfs_check are my friends ;-)
> It seems to happen more often now that the XFS partition is quite=20
> heavily fragmented, and I can't even run the defragmenter without a=20
> quick failure.
> I didn't payed big attention to the logs and quickly decided to buy a=
=20
> SATA Sil PCI card to get rid of the Nvidia SATA HBA.
>=20
> - Now the problem.
>=20
> Yesterday, however, the MPEG2 streams hanged for a few tens of second=
s=20
> just as usual. But there were no disk failure. The array was still in=
=20
> good shape, although dmesg showed the same "ata[56]: Resetting port",=
=20
> "SCSI errors" etc. fuss.
> However this was new in dmesg: "anticipatory: forced dispatching is=20
> broken (nr_sorted=3D1), please report this". Got 4 identical in a row=
=2E
> Maybe managing 8 block devices queues under load with the anticipator=
y=20
> scheduler is too much ? I immediately switched to deadline on the 8=20
> disks, and I'll see if it it happens again by stressing the whole sys=
tem=20
> more and more.
> I have no clue if anticipatory is a good choice or definitely not in =
my=20
> case, anyone can point some documentation or good advices ?
>=20
> - How to reproduce.
>=20
> Here is what I would do:
> Harness a small CPU with lots of sata/scsi drives.
> Do raid 5 with big block size (1-4Mb) on it.
> Make a 50G XFS file system with sunit/swidth options
> Trigger bonnie++ with 1G<files<4G and fill the FS to 80-95%, trying t=
o=20
> achieve 98%+ fragmentation.
> Defrag !
>=20
> - Finally the usual bug report stuff is attached.

 From your report:

ata5: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl 0x150100=
0=20
status 0x400
ata5: CPB 0: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 1: ctl_flags 0x1f, resp_flags 0x2
ata5: CPB 2: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 3: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 4: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 5: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 6: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 7: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 8: ctl_flags 0x1f, resp_flags 0x2
ata5: CPB 9: ctl_flags 0x1f, resp_flags 0x2
ata5: CPB 10: ctl_flags 0x1f, resp_flags 0x2
ata5: CPB 11: ctl_flags 0x1f, resp_flags 0x2
ata5: CPB 12: ctl_flags 0x1f, resp_flags 0x2
ata5: CPB 13: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 14: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 15: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 16: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 17: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 18: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 19: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 20: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 21: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 22: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 23: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 24: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 25: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 26: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 27: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 28: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 29: ctl_flags 0x1f, resp_flags 0x1
ata5: CPB 30: ctl_flags 0x1f, resp_flags 0x1
ata5: Resetting port
ata5.00: exception Emask 0x0 SAct 0x1f02 SErr 0x0 action 0x2 frozen
ata5.00: cmd 60/40:08:8f:eb:67/00:00:03:00:00/40 tag 1 cdb 0x0 data 327=
68 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5.00: cmd 60/08:40:17:eb:67/00:00:03:00:00/40 tag 8 cdb 0x0 data 409=
6 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5.00: cmd 60/18:48:47:eb:67/00:00:03:00:00/40 tag 9 cdb 0x0 data 122=
88 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5.00: cmd 60/08:50:77:eb:67/00:00:03:00:00/40 tag 10 cdb 0x0 data 40=
96 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5.00: cmd 60/08:58:87:eb:67/00:00:03:00:00/40 tag 11 cdb 0x0 data 40=
96 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5.00: cmd 60/48:60:d7:eb:67/00:00:03:00:00/40 tag 12 cdb 0x0 data=20
36864 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5: soft resetting port

The CPB resp_flags 0x2 entries are ones where the drive has been sent=20
the request and the controller is waiting for a response. The timeout i=
s=20
30 seconds, so that means the drive failed to service those queued=20
commands for that length of time.

It may be that your drive has a poor NCQ implementation that can starve=
=20
some of the pending commands for a long time under heavy load?

--=20
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

