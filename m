From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 3094] POOR I/O perfomance on VIA chipsets
Date: Thu, 20 May 2010 17:43:02 GMT
Message-ID: <201005201743.o4KHh2AO014801@demeter.kernel.org>
References: <bug-3094-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:35340 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831Ab0ETRnD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 13:43:03 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o4KHh2cO014803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 20 May 2010 17:43:02 GMT
In-Reply-To: <bug-3094-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D3094





--- Comment #30 from Artem S. Tashkinov <t.artem@mailcity.com>  2010-05=
-20 17:42:59 ---
In the second part of my message I referred to top/htop output which cl=
early
shows that IO wait is treated like it is _real_ CPU usage but you just =
ignored
it and now

(In reply to comment #29)
> I don't think this is going anywhere and am fairly sure that further =
bug
> reports on the subject won't lead anywhere.
>=20
> Let's meet again in a more productive discussion.  Thanks.

you sound like "even though most sane people trust their eyes, in Linux=
 you
should not trust your eyes, everything is so complicated we don't even =
have
utilities which can show real CPU usage".

And until we have such utilities and metrics which allow to instantly _=
see_ and
_not_ deduct real CPU usage people _will_ keep on bitching that Linux i=
s broken
with my motherboard/chipset/HDD Linux because IO wait OR Linux gobbles =
down my
precious CPU cycles.

Just run Windows and see how easier it's to _see_ whether system is bus=
y or
occupied. In Linux everything is such a way no layman (except kernel
developers) can really understand.

If you insist that everything is just fine and works correctly as inten=
ded I
have to resign and keep silent from now on and realize that Linux is on=
ly meant
for =C3=BCber geeks.

--=20
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=3Demai=
l
------- You are receiving this mail because: -------
You are watching the assignee of the bug.