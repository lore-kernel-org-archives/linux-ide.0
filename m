From: "Peer Chen" <peerchen@gmail.com>
Subject: Re: Re: [PATCH] sata_nv,ahci: add the ahci legacy mode support to sata_nv
Date: Tue, 25 Sep 2007 17:08:23 +0800
Message-ID: <200709251708208579514@gmail.com>
References: <200709251323031982245@gmail.com>,
 <46F8B3F8.1050909@garzik.org>,
 <200709251552483357334@gmail.com>,
 <46F8C33A.3060601@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:35883 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbXIYJI3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Sep 2007 05:08:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2335230wah
        for <linux-ide@vger.kernel.org>; Tue, 25 Sep 2007 02:08:28 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff <jeff@garzik.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>

Yes,I hear what you are saying but user should know what they are setti=
ng in BIOS,there are lots of ways to change the BIOS setting result in =
unbootable system not only change AHCI/IDE mode. If they encounter boot=
ing failure after changing the BIOS setting,they should restore it.
Using legacy driver for legacy mode won't affect user to enjoy the feat=
ure of AHCI,just select AHCI/RAID mode will ok.
As I know, Intel did it in the same way,and I think it's reasonable.


------------------				=20
Peer Chen
2007-09-25

-------------------------------------------------------------
=B7=A2=BC=FE=C8=CB=A3=BAJeff Garzik
=B7=A2=CB=CD=C8=D5=C6=DA=A3=BA2007-09-25 16:13:52
=CA=D5=BC=FE=C8=CB=A3=BAPeer Chen
=B3=AD=CB=CD=A3=BAlinux-kernel; linux-ide; akpm
=D6=F7=CC=E2=A3=BARe: [PATCH] sata_nv,ahci: add the ahci legacy mode su=
pport to sata_nv

Peer Chen wrote:
> We have three mode for one controller - IDE/RAID/AHCI, we want sata_n=
v being load when user select the IDE mode in BIOS, load ahci driver if=
 RAID/AHCI being selected, which will verify if our legacy mode work we=
ll and have additional option if there is any
> bug for the ahci mode.

I understand that logic, but look at what happens in practice:

1) User installs new OS in AHCI mode.  Distro updates initramfs (loaded=
=20
at kernel boot time, with boot drivers) to include ahci driver.
2) User reboots into BIOS setup, and switches from AHCI mode to IDE mod=
e.
3) BIOS setup reboots computer.
4) OS kernel and initramfs image are loaded.  ahci driver load fails.
5) User is left without a bootable system.

The same situation happens in reverse, if you install in IDE mode=20
(sata_nv in initramfs), and then switch to AHCI/RAID mode.

Additionally, AHCI provides better performance and more direct exposure=
=20
to the SATA frames.  This is key for supporting many modern SATA=20
features that cannot be accessed via IDE legacy mode.  AHCI lacks=20
in-silicon simulation of an IDE interface, which time has shown is a=20
less stable, edge-case-prone approach to SATA.

I do not find the "verify nvidia's legacy mode works" argument=20
compelling; that is not the kernel's job, nor the user's.  And if there=
=20
is an AHCI silicon bug, let us deal with that when such a bug appears.

Overall, AFAICS this patch -introduces- new ways for the user to easily=
=20
render their systems unbootable.

	Jeff



