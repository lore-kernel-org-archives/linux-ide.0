From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
Subject: Re: The never enfind DRDY saga
Date: Fri, 9 May 2008 01:23:09 +0200
Message-ID: <20080509012309.13666199@werewolf.home>
References: <20080509005111.7cf55350@werewolf.home>
	<48238ADA.5060206@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ono.com ([62.42.230.12]:14933 "EHLO resmaa02.ono.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752626AbYEHXXR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 May 2008 19:23:17 -0400
In-Reply-To: <48238ADA.5060206@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus-IDE <linux-ide@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>

On Thu, 08 May 2008 19:20:58 -0400, Jeff Garzik <jeff@garzik.org> wrote=
:

> J.A. Magall=C3=B3n wrote:
> > Hi all...
> >=20
> > I'm getting again my friendly DRDY errors, this time on the new dis=
k I got
> > to replace the old one (that fortunately was still under warranty..=
=2E).
> > This is a brand new disk, it came perfectly packaged...
> > Now it is not a Seagate, but a WD:
>=20
> Note that DRDY is not an error:
>=20
> 	http://ata.wiki.kernel.org/index.php/Libata_error_messages
>=20
> But moreover, for Serial ATA, timeouts are generally due to platform=20
> problems, irq problems, or driver problems.  When we see timeouts, we=
=20
> generally do not look at the hard drive as the primary cause.
>=20
> Have you gone through the debugging process for irq problems -- turni=
ng=20
> off ACPI, noapic, etc.?
>=20

Thanks, will look at that page and see if I can debug some more info.

--=20
J.A. Magallon <jamagallon()ono!com>     \               Software is lik=
e sex:
                                         \         It's better when it'=
s free
Mandriva Linux release 2008.1 (Cooker) for i586
Linux 2.6.23-jam05 (gcc 4.2.2 20071128 (4.2.2-2mdv2008.1)) SMP PREEMPT
