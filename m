From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Bug 49151] New: NULL pointer dereference in pata_acpi
Date: Mon, 22 Oct 2012 22:27:34 +0200
Message-ID: <20121022202734.GA16169@liondog.tnic>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
 <20121020120047.GC17563@liondog.tnic>
 <50841CFC.2030802@talktalk.net>
 <20121021165756.GA20642@liondog.tnic>
 <50856AA8.1000607@talktalk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:59193 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756157Ab2JVU1i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2012 16:27:38 -0400
Content-Disposition: inline
In-Reply-To: <50856AA8.1000607@talktalk.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: phillip.wood@dunelm.org.uk
Cc: "Anton V. Boyarshinov" <boyarsh@altlinux.org>, bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

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
Regards/Gruss,
    Boris.
