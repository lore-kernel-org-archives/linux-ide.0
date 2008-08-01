From: Tejun Heo <tj@kernel.org>
Subject: Re: dvd-9 trouble with TSSTcorp SH-S203D
Date: Fri, 01 Aug 2008 13:50:40 +0900
Message-ID: <48929620.4090208@kernel.org>
References: <896186.53858.qm@web26202.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39375 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450AbYHAEvH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 00:51:07 -0400
In-Reply-To: <896186.53858.qm@web26202.mail.ukl.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?S=E9bastien?= <willy_the_cat@yahoo.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

S=E9bastien wrote:
> Hi,
>=20
> First, thanks for what you done with libata.
>=20
> I've got trouble with reading dvd9 (simple face, dual layer)  on my T=
SSTcorp SH-S203D : end_request : I/O error, bad sector ...
>=20
> Really don't were to get help, try google many times : no success.
> It works under Windows XP64, trial edition.
>=20
> Dvd5 (simple face, simple layer) work fine.

-ENEEDMOREINFO.  Please report the result of "lspci -nn" and full kerne=
l
boot log and error messages.

--=20
tejun
