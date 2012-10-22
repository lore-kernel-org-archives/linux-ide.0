From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Mon, 22 Oct 2012 20:40:44 +0000 (UTC)
Message-ID: <20121022204044.F361511FAE1@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44714 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab2JVUks convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Oct 2012 16:40:48 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 78D86203AC
	for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 20:40:47 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id F40CB203B2
	for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 20:40:44 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D49151


Borislav Petkov <bp@alien8.de> changed:

           What    |Removed                     |Added
-----------------------------------------------------------------------=
-----
                 CC|                            |bp@alien8.de




--- Comment #11 from Borislav Petkov <bp@alien8.de>  2012-10-22 20:40:4=
4 ---
(In reply to comment #7)
[ =E2=80=A6 ]

> 00:09.0 IDE interface: NVIDIA Corporation MCP65 IDE (rev a1) (prog-if=
 8a
> [Master SecP PriP])
>     Subsystem: Micro-Star International Co., Ltd. Device 7369
>     Flags: bus master, 66MHz, fast devsel, latency 0
>     [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=3D8=
]
>     [virtual] Memory at 000003f0 (type 3, non-prefetchable)
>     [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=3D8=
]
>     [virtual] Memory at 00000370 (type 3, non-prefetchable)
>     I/O ports at ffa0 [size=3D16]
>     Capabilities: [44] Power Management version 2
>     Kernel driver in use: pata_acpi
>=20
> 00:0a.0 IDE interface: NVIDIA Corporation MCP65 SATA Controller (rev =
a3)
> (prog-if 85 [Master SecO PriO])
>     Subsystem: Micro-Star International Co., Ltd. Device 7369
>     Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 21
>     I/O ports at 0f80 [size=3D8]
>     I/O ports at 0f00 [size=3D4]
>     I/O ports at 0e80 [size=3D8]
>     I/O ports at 0e00 [size=3D4]
>     I/O ports at b800 [size=3D16]
>     Memory at f9efc000 (32-bit, non-prefetchable) [size=3D8K]
>     Capabilities: [44] Power Management version 2
>     Capabilities: [b0] MSI: Enable- Count=3D1/8 Maskable- 64bit+
>     Capabilities: [cc] HyperTransport: MSI Mapping Enable- Fixed+
>     Kernel driver in use: pata_acpi

can you try blacklisting pata_acpi and booting the box then (provided
this is a distro kernel and it has all sata drivers as modules and in
the initrd - basically what Phillip did).

=46rom the looks of it, yours should be supported by sata_nv so that yo=
u
don't need to use pata_acpi at all.

All IMHO, of course.

Thanks.

--=20
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=3Demai=
l
------- You are receiving this mail because: -------
You are watching the assignee of the bug.