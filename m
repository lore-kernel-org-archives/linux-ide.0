From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15941] Thinkpad T61 after suspend to ram ide cdrom doesn't work
Date: Tue, 18 Jan 2011 05:44:11 GMT
Message-ID: <201101180544.p0I5iBRZ026838@demeter1.kernel.org>
References: <bug-15941-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:35936 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab1ARFoM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2011 00:44:12 -0500
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p0I5iBJ1026839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 18 Jan 2011 05:44:11 GMT
In-Reply-To: <bug-15941-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D15941





--- Comment #14 from Ivan Volosyuk <ivan.volosyuk@gmail.com>  2011-01-1=
8 05:44:06 ---
With libata the bug is not reproducible, no hang processes, but
current read fails with:

[  332.456512] sr 0:0:0:0: [sr0] Media Changed
[  332.456514] sr 0:0:0:0: [sr0]  Result: hostbyte=3D0x00 driverbyte=3D=
0x08
[  332.456517] sr 0:0:0:0: [sr0]  Sense Key : 0x6 [current]
[  332.456521] sr 0:0:0:0: [sr0]  ASC=3D0x28 ASCQ=3D0x0
[  332.456524] sr 0:0:0:0: [sr0] CDB: cdb[0]=3D0x28: 28 00 00 00 51 60 =
00 00 40
00
[  332.456532] end_request: I/O error, dev sr0, sector 83328

This is probably expected behavior.

It could be fine with me, but AFAIR the libsata driver had pretty
fragile error handling on sense errors. When using 'safecopy' program
the kernel or device often get stuck in some weird state. Could you
take a look at it? I can try to reproduce it, but I'm not sure what
information will be useful for a bug report...

On Tue, Jan 18, 2011 at 9:58 AM,  <bugzilla-daemon@bugzilla.kernel.org>=
 wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D15941
>
>
>
>
>
> --- Comment #13 from Rafael J. Wysocki <rjw@sisk.pl> =C2=A02011-01-17=
 22:58:48 ---
> Yes, it is. =C2=A0The new driver is cdrom depending on sr_mod (SCSI s=
tack).
>
> Can you try this one, please? =C2=A0You'll need the right PATA driver=
 for
> your controller too.
>
> --
> Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=3Dem=
ail
> ------- You are receiving this mail because: -------
> You reported the bug.
>

--=20
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=3Demai=
l
------- You are receiving this mail because: -------
You are watching the assignee of the bug.