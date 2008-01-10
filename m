From: Tejun Heo <htejun@gmail.com>
Subject: Re: [Fwd: Re: libata , Silicon Image 3124]
Date: Thu, 10 Jan 2008 13:08:26 +0900
Message-ID: <47859A3A.105@gmail.com>
References: <473A5B03.2020808@gmail.com> <4780B387.1050600@kasimir-mueller.de> <4782F243.6060606@gmail.com> <47850506.4040806@kasimir-mueller.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:29020 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136AbYAJEIf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 23:08:35 -0500
Received: by rv-out-0910.google.com with SMTP id k20so439406rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 20:08:32 -0800 (PST)
In-Reply-To: <47850506.4040806@kasimir-mueller.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-15?Q?Kasimir_M=FCller?= <kjm@kasimir-mueller.de>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, christian.kuehn@hamburg.de

Hello,

Kasimir M=FCller wrote:
> thanks very much again for your time and readiness to help.
>=20
> I applied the patch as you proposed without problem.
>=20
> I attach the kernel logs of the past few days. As far as I can see, w=
ith
> the patched kernel errors appear only under heavy load .
>=20
> If you want, I could provide a (temporary) ssh-login to my machine.
> Maybe it would make it easier for you to debug the problem.
> If you want to use it, I need your public ssh-certificate and your
> login-name and I would send the login-details to you.

Your log is pretty interesting.  Lots of timeouts are on FLUSH and
previously other non-data commands like CHECK POWER or SMART, which is
very unusual.  I wonder what's going on.  Yeap, I wanna log in and take
a look.  I'll send you my pubkey in a private mail.

Thanks.

--=20
tejun
