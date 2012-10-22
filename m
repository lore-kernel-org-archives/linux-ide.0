From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Mon, 22 Oct 2012 20:27:38 +0000 (UTC)
Message-ID: <20121022202738.4AEAE11FB02@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44154 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756157Ab2JVU1m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Oct 2012 16:27:42 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 008F72037C
	for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 20:27:41 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 50FF22036F
	for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 20:27:39 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D49151





--- Comment #10 from Borislav Petkov <bp@alien8.de>  2012-10-22 20:27:3=
7 ---
On Mon, Oct 22, 2012 at 04:47:52PM +0100, Phillip Wood wrote:
> 00:04.0 IDE interface: ULi Electronics Inc. M5229 IDE (rev c3) (prog-=
if f0)
> 	Subsystem: Toshiba America Info Systems Device 0004
> 	Flags: bus master, medium devsel, latency 64, IRQ 255
> 	[virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=3D8]
> 	[virtual] Memory at 000003f0 (type 3, non-prefetchable)
> 	[virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=3D8]
> 	[virtual] Memory at 00000370 (type 3, non-prefetchable)
> 	I/O ports at eff0 [size=3D16]
> 	Capabilities: [60] Power Management version 2
> 	Kernel driver in use: pata_ali

Ok, your IDE interface is supported by pata_ali...

[ =E2=80=A6 ]

> If I blacklist pata_acpi and remove it from the initrd image then my
> unpatched distro kernel boots and seems to run fine (I've not checked
> if the hard drive power management is affected though). I've attached
> the dmesg from the patched kernel which was built with a minimal
> config.

Right, as it looks above, pata_ali should be able to support your IDE
interface, so you might not be needing the pata_acpi thing after all.

So yes, blacklisting it and verifying that your system still operates
normally would be something to do. If it does, you could also build a
kernel with pata_acpi disabled (that is, provided you build your own
kernels).

HTH.

--=20
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=3Demai=
l
------- You are receiving this mail because: -------
You are watching the assignee of the bug.