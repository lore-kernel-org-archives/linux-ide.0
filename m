From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PROBLEM: I/O scheduler problem with an 8 SATA disks raid 5 under
 heavy load  ?
Date: Tue, 08 Jan 2008 18:00:50 -0600
Message-ID: <47840EB2.2010300@shaw.ca>
References: <fa.NcJePXcdrF+7E7oXv5ULIxogTYI@ifi.uio.no>
 <4782C3DB.1090201@shaw.ca> <2A722A49-F024-44E9-9FC8-7B714FB25626@neuf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:11463 "EHLO
	pd3mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbYAIABB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 19:01:01 -0500
In-reply-to: <2A722A49-F024-44E9-9FC8-7B714FB25626@neuf.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Guillaume_Laur=E8s?= <guillaume-laures@neuf.fr>
Cc: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>



Guillaume Laur=E8s wrote:
>=20
> Le 8 janv. 08 =E0 01:29, Robert Hancock a =E9crit :
>=20
>> From your report:
>>
>> ata5: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl=20
>> 0x1501000 status 0x400
>> ata5: CPB 0: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 1: ctl_flags 0x1f, resp_flags 0x2
>> ata5: CPB 2: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 3: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 4: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 5: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 6: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 7: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 8: ctl_flags 0x1f, resp_flags 0x2
>> ata5: CPB 9: ctl_flags 0x1f, resp_flags 0x2
>> ata5: CPB 10: ctl_flags 0x1f, resp_flags 0x2
>> ata5: CPB 11: ctl_flags 0x1f, resp_flags 0x2
>> ata5: CPB 12: ctl_flags 0x1f, resp_flags 0x2
>> ata5: CPB 13: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 14: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 15: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 16: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 17: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 18: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 19: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 20: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 21: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 22: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 23: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 24: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 25: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 26: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 27: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 28: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 29: ctl_flags 0x1f, resp_flags 0x1
>> ata5: CPB 30: ctl_flags 0x1f, resp_flags 0x1
>> ata5: Resetting port
>> ata5.00: exception Emask 0x0 SAct 0x1f02 SErr 0x0 action 0x2 frozen
>> ata5.00: cmd 60/40:08:8f:eb:67/00:00:03:00:00/40 tag 1 cdb 0x0 data=20
>> 32768 in
>>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>> ata5.00: cmd 60/08:40:17:eb:67/00:00:03:00:00/40 tag 8 cdb 0x0 data=20
>> 4096 in
>>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>> ata5.00: cmd 60/18:48:47:eb:67/00:00:03:00:00/40 tag 9 cdb 0x0 data=20
>> 12288 in
>>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>> ata5.00: cmd 60/08:50:77:eb:67/00:00:03:00:00/40 tag 10 cdb 0x0 data=
=20
>> 4096 in
>>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>> ata5.00: cmd 60/08:58:87:eb:67/00:00:03:00:00/40 tag 11 cdb 0x0 data=
=20
>> 4096 in
>>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>> ata5.00: cmd 60/48:60:d7:eb:67/00:00:03:00:00/40 tag 12 cdb 0x0 data=
=20
>> 36864 in
>>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>> ata5: soft resetting port
>>
>> The CPB resp_flags 0x2 entries are ones where the drive has been sen=
t=20
>> the request and the controller is waiting for a response. The timeou=
t=20
>> is 30 seconds, so that means the drive failed to service those queue=
d=20
>> commands for that length of time.
>>
>> It may be that your drive has a poor NCQ implementation that can=20
>> starve some of the pending commands for a long time under heavy load=
?
>=20
> Thanks for your answer. That could very well be the problem, as all 4=
=20
> drives on the sata_nv HBA are older than the sata_sil ones.
> I'm going to swap them to see if the problem is reproducible on the=20
> sata_sil HBA. (see test #2)
>=20
> - Test #1
> I switched the scheduler to CFQ on all disks and ran the file=20
> reorganizer all night. In the morning I ended with a drive missing in=
=20
> the array. And lots of SATA port resets, with plenty of 0x2 again, se=
e=20
> the attached log.

> BTW, you can see around "md2: recovery done" a second disk failed bef=
ore the first was completely rebuilt.
>=20
>=20
>=20
> - Test #2
>=20
> I swapped all the drives with this scheme: sda->sdh, sdb->sdg, sdc->s=
df,..., sdg->sdb, sdh->sda. So now all the newer drives are attached th=
rough sata_nv (ata5:8), the oldest through sata_sil (ata1:4)
>=20
> I kept the scheduler to anticipatory and ran xfs_frs. 60 seconds late=
r it hanged. Still on ata5/ata6, i.e. sata_nv. Drive reconstruction...
>=20
> Then I switched the scheduler to CFQ. xfs_fsr + 10 seconds: another f=
reeze. No drive loss from the array though. See the dmesg below.
>=20
> ---------------------------------------------------------------------=
---
>=20
> So it seems to be either a cabling problem or a bug with sata_nv ? I'=
m running gentoo's 2.6.20-xen, and maybe my problem looks like the sata=
_nv/adma/samsung problems reports I can see on the net ?
>=20

I don't think it's the same problem. In that case the controller appear=
s=20
to indicate that it didn't even start processing the command. In this=20
case it's indicating that the command was sent to the drive and is stil=
l=20
waiting for it to indicate completion.

It could be a cabling problem, yes. Also, are you sure your power suppl=
y=20
is able to handle the power draw of that many drives?
