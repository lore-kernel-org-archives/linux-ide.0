From: =?UTF-8?B?TWFydGluIFBvdm9sbsO9?= <martin.povolny@solnet.cz>
Subject: Re: Promise TX4200 support?
Date: Mon, 18 Jul 2005 22:01:29 +0200
Message-ID: <42DC0A99.2010304@solnet.cz>
References: <42DBFC9E.1040607@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.solnet.cz ([193.165.198.50]:54230 "EHLO solnet.cz")
	by vger.kernel.org with ESMTP id S261586AbVGRUE6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jul 2005 16:04:58 -0400
Received: from mail by solnet.cz with scanned-ok (Exim 3.35 #1 (Debian))
	id 1DubrF-0001Gy-00
	for <linux-ide@vger.kernel.org>; Mon, 18 Jul 2005 22:04:57 +0200
In-Reply-To: <42DBFC9E.1040607@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Hi,
>=20
> I recieved an email from someone claiming to be stuck with Linux 2.4,
> due to relying on a Promise TX4200 disk controller (using the fdsata
> driver from promise's website, which is 2.4-only):
>=20
> 0000:01:09.0 RAID bus controller: Promise Technology, Inc.: Unknown
> device 3519 (rev 02)
>         Subsystem: Promise Technology, Inc.: Unknown device 3519
>         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 9
>         I/O ports at dc00 [size=3D128]
>         I/O ports at d800 [size=3D256]
>         Memory at ff8ff000 (32-bit, non-prefetchable) [size=3D4K]
>         Memory at ff8c0000 (32-bit, non-prefetchable) [size=3D128K]
>         Expansion ROM at ff8e0000 [disabled] [size=3D64K]
>         Capabilities: [60] Power Management version 2
>=20
> What is the status of this on 2.6? I found a blank changeset (??) in =
the
> mail below, from 24th May:
>=20
> Jeff Garzik wrote:
>> Please pull the 'new-ids' branch from
>>
>> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev=
=2Egit
>>
>> This add new PCI ids to some SATA drivers.
> <snip>
>> commit 37c15447c565ab458ee3778e198d08f4041caa99
>> tree 2eda289903e3bf19eebce7d5f9aaed2240a02479
>> parent 9422e59ddf6cae68e46d7a2c3afe1ce4e739d3eb
>> author Martin Povolny <martin.povolny@solnet.cz> Mon, 16 May 2005
> 02:41:00 -0400
>> committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 02:41:00 =
-0400
>>
>> [PATCH] sata_promise: new PCI ID for TX4200
>>
>> [note - blank changeset]
>>
>=20
> Was this accidently removed, or is the sata_promise driver actually
> incompatible with this hardware?
>=20

We are succesfully running patched sata_promise with 3 disks in a
raid5/raid1 setup. (Patched against ubuntu linux-image 2.6.11-1-686
package.)

# check_partitions
disk: [8.0] =3D> '/dev/sda', 279.4 GB
         1 : /dev/sda1 : Linux raid autodetect     (      55 MB)
         2 : /dev/sda2 : Linux raid autodetect     (  285640 MB)
         3 : /dev/sda3 : Linux swap                (     486 MB)
disk: [8.16] =3D> '/dev/sdb', 279.4 GB
         1 : /dev/sdb1 : Linux raid autodetect     (      55 MB)
         2 : /dev/sdb2 : Linux raid autodetect     (  285640 MB)
         3 : /dev/sdb3 : Linux swap                (     486 MB)
disk: [8.32] =3D> '/dev/sdc', 279.4 GB
         1 : /dev/sdc1 : Linux raid autodetect     (      55 MB)
         2 : /dev/sdc2 : Linux raid autodetect     (  285640 MB)
         3 : /dev/sdc3 : Linux swap                (     486 MB)
disk: [9.0] =3D> '/dev/md',
         0 : /dev/md0  : raid1                     (      55 MB)
                uuid: db3bdcf4:3e4774c7:b2541959:eeef67e0
                0 active sync   /dev/sda1
                1 active sync   /dev/sdb1
                2 active sync   /dev/sdc1
         1 : /dev/md1  : raid5                     (  571280 MB)
                uuid: b9562e24:8a095e31:40702712:19009a40
                0 active sync   /dev/sda2
                1 active sync   /dev/sdb2
                2 active sync   /dev/sdc2

'lspci -v' says:

02:02.0 RAID bus controller: Promise Technology, Inc.: Unknown device
3519 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 3519
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 18
        I/O ports at dc00 [size=3D128]
        I/O ports at d800 [size=3D256]
        Memory at feaff000 (32-bit, non-prefetchable) [size=3D4K]
        Memory at feac0000 (32-bit, non-prefetchable) [size=3D128K]
        Expansion ROM at feae0000 [disabled] [size=3D64K]
        Capabilities: [60] Power Management version 2

No problems at all.

Regards,

--=20
Mgr. Martin Povoln=C3=BD, soLNet, s.r.o.,
+420777714458, martin.povolny@solnet.cz

