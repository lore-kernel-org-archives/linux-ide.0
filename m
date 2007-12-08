From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc4-git5: Reported regressions from 2.6.23
Date: Sat, 8 Dec 2007 01:36:31 -0800
Message-ID: <20071208013631.3147986a.akpm@linux-foundation.org>
References: <200712080340.49546.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44254 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756185AbXLHJgo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Dec 2007 04:36:44 -0500
In-Reply-To: <200712080340.49546.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On Sat, 8 Dec 2007 03:40:49 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wro=
te:

> This message contains a list of some regressions from 2.6.23 which ha=
ve been
> reported since 2.6.24-rc1 was released and for which there are no fix=
es in the
> mainline that I know of. =A0If any of them have been fixed already, p=
lease let me
> know.
>=20
> If you know of any other unresolved regressions from 2.6.23, please l=
et me know
> either and I'll add them to the list.
>=20
>=20
> Subject		: PATA scan: ACPI Exception AE_AML_PACKAGE_LIMIT... is beyon=
d end of object
> Submitter	: Hans de Bruin <bruinjm@xs4all.nl>
> References	: http://bugzilla.kernel.org/show_bug.cgi?id=3D9320
> Handled-By	: Robert Moore <Robert.Moore@intel.com>
> 		  Tejun Heo <htejun@gmail.com>
> 		  Fu Michael <michael.fu@intel.com>
> Patch		:=20
>=20

A number of other people are seeing the same thing and Tejun is putting=
 in
a blacklist of machines which cannot use libata+acpi.  That patch is no=
t
yet in any git tree which I pull.

AFACIT the machines kepe working OK - there's just some nasty dmesg spe=
w.

If any machines _are_ breaking then this could cause real problems and =
I'd
prefer that we either go for a whitelist or arrange to detect the condi=
tion
and fall back to non-acpi ata.

