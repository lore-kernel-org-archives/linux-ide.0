From: devzero@web.de
Subject: Re: Oops: 0000 [#1] SMP //// HPT raid card 1740
Date: Sat, 17 May 2008 12:49:05 +0200
Message-ID: <281179196@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate05.web.de ([217.72.192.243]:37259 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151AbYEQKtJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 May 2008 06:49:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org, Marc Rantanen <marcr@kth.se>

>Marc Rantanen wrote:
>> Can't get the new driver for HPT 1740 working in kernel gentoo-2.6.2=
4-r8
>>=20
>> module: rr174x (v.2.1)
>>=20
>> /marc
>> ------------------------
>> rr174x: module license 'Proprietary' taints kernel.
>> rr174x:RocketRAID 174x controller driver v2.1.08.0303 (May 16 2008=20
>> 15:58:03)
>> BUG: unable to handle kernel paging request at virtual address 64091=
fd0
>> printing eip: f8905688 *pde =3D 00000000
>> Oops: 0000 [#1] SMP
>> Modules linked in: rr174x(P) scsi_wait_scan
>
>There is nothing kernel developers can do about this, you will have to=
=20
>contact Highpoint. Do you really need to use that binary driver?

http://www.highpoint-tech.com/USA/bios_rr1740.htm
-> http://www.highpoint-tech.com/BIOS_Driver/rr1740/Linux/rr174x-linux-=
src-v2.1-080304-1512.tar.gz

they call that "Open Source" ?

/tmp/rr174x-linux-src-v2.1/lib/linux/free-i686-regparm0 # ls -la
total 212
drwxr-xr-x 2 root root   248 Mar  4 08:12 .
drwxr-xr-x 6 root root   208 Mar  4 08:12 ..
-rwxr--r-- 1 root root 54923 Mar  4 08:12 him_rr1740pm.o
-rwxr--r-- 1 root root  3220 Mar  4 08:12 jbod.o
-rwxr--r-- 1 root root 97186 Mar  4 08:12 ldm_raid_compat.o
-rwxr--r-- 1 root root  1685 Mar  4 08:12 partition.o
-rwxr--r-- 1 root root  3418 Mar  4 08:12 raid0.o
-rwxr--r-- 1 root root  5583 Mar  4 08:12 raid1.o
-rwxr--r-- 1 root root 39056 Mar  4 08:12 raid5.o

I don`t see Open Source.

Please ask for a true Open Source  driver or buy another controller.

Binary drivers doesn=B4t fit to Linux kernel development model.

See http://www.aquezada.com/staff/julian/journal/?p=3D156 for example.


There seems to be support for that card in sata_mv driver  ( http://cat=
eee.net/lkddb/web-lkddb/SATA_MV.html ), but i don=B4t know if it`s wort=
h a try.

 * sata_mv.c - Marvell SATA support
 *
 * Copyright 2008: Marvell Corporation, all rights reserved.
 * Copyright 2005: EMC Corporation, all rights reserved.
 * Copyright 2005 Red Hat, Inc.  All rights reserved.
 *
 * Please ALWAYS copy linux-ide@vger.kernel.org on emails.

CC`ing linux-ide

regards
roland
______________________________________________________
Bis 50 MB Dateianh=E4nge? Kein Problem!
http://freemail.web.de/club/landingpage.htm/?mc=3D025556

