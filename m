From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] Re: ATIIXP and libata
Date: Tue, 20 Jun 2006 09:57:30 -0700
Message-ID: <20060620095730.8ec9b618.rdunlap@xenotime.net>
References: <20051105152756.86796.qmail@web86805.mail.ukl.yahoo.com>
	<447E11F9.1030804@seanodes.com>
	<20060612153231.a7e60b4a.rdunlap@xenotime.net>
	<44965C80.9050503@seanodes.com>
	<20060619102718.678b3170.rdunlap@xenotime.net>
	<4497B86E.9090104@seanodes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:18916 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751408AbWFTQyp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jun 2006 12:54:45 -0400
Received: from midway.site ([71.245.102.105]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 20 Jun 2006 09:54:42 -0700
In-Reply-To: <4497B86E.9090104@seanodes.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Velu Erwan <erwan@seanodes.com>
Cc: bzolnier@gmail.com, bruno_harbulot@yahoo.co.uk, linux-ide@vger.kernel.org, akpm@osdl.org

On Tue, 20 Jun 2006 10:57:18 +0200 Velu Erwan wrote:

> Randy.Dunlap a =E9crit :
> [..]
> > We can probably get the patch merged into -mm, but it's not
> > clear if that would help you.  At least it might give the patch
> > more testing/exposure.
>=20
> This could be a first step to check if this patch works fine for more=
=20
> than us (3 people which have tested it successfully).
>=20
> If this step is successfull (maybe 1 month or 2 without a bug), what=20
> could make it then merged upstream ?

I suggest that you send the patch (probably Bruno's patch)
to Andrew (akpm@osdl.org) and copy Bart and linux-ide mailing list
on it.  Andrew will likely include it in his -mm patchset.
However, if it causes a problem, he will probably drop it like
a hot potato.

---
~Randy
