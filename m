From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 12320] warn_on_slowpath when playing audio CD
Date: Sat, 24 Jan 2009 15:54:20 +0100
Message-ID: <200901241554.21294.bzolnier@gmail.com>
References: <20090124141937.3205910800F@picon.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:2419 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbZAXOyS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jan 2009 09:54:18 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1722817fkf.5
        for <linux-ide@vger.kernel.org>; Sat, 24 Jan 2009 06:54:16 -0800 (PST)
In-Reply-To: <20090124141937.3205910800F@picon.linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugme-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

On Saturday 24 January 2009, bugme-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=3D12320
>=20
>=20
> bbpetkov@yahoo.de changed:
>=20
>            What    |Removed                     |Added
> ---------------------------------------------------------------------=
-------
>          AssignedTo|io_ide@kernel-bugs.osdl.org |bbpetkov@yahoo.de
>              Status|NEW                         |ASSIGNED
>=20
>=20
>=20
>=20
> ------- Comment #23 from bbpetkov@yahoo.de  2009-01-24 06:19 -------
> Hi,
>=20
> here's a fix, finally. It is against 29-rc2 + current (24.01) pata-tr=
ee.
>=20
> @M=C3=A1rton: can you please apply and test, thanks. The patch applie=
s on plain
> 2.6.28 too, albeit with a little fuzz.
>=20
> @Bart: We should probably backport that one to 2.6.28 after enough te=
sting,
> right?

That's correct -- it is a regression and fix is rather non-invasive.

Thanks,
Bart
