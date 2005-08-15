From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
Subject: Re: IDENTIFY DEVICE not working any more?
Date: Mon, 15 Aug 2005 15:54:13 +0200
Message-ID: <43009E85.40606@conterra.de>
References: <43005B4D.1090801@conterra.de> <1124102095.8189.45.camel@localhost.localdomain> <43009642.40805@conterra.de> <4300998D.6000205@dtbb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vvv.conterra.de ([212.124.44.162]:43729 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S964772AbVHONyR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Aug 2005 09:54:17 -0400
Received: from localhost (unknown [127.0.0.1])
	by conterra.de (-) with ESMTP id 4CCB71C88E2
	for <linux-ide@vger.kernel.org>; Mon, 15 Aug 2005 15:54:16 +0200 (CEST)
In-Reply-To: <4300998D.6000205@dtbb.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tyler wrote:
> Were the 2.6.11 kernels you have included with a distribution such as=
=20
> ubuntu, fedora, etc?  If it was, there's a good chance that it has th=
e=20
> passthru libata patch, that allows you to access drives using smartct=
l,=20
> with the special ata flag.

That may be the explanation: I used prebuild kernels from SuSE and got =
the
illusion the SMART enabled libata went into the recent kernels since 2.=
6.9
by default. So I'll try with the libata patch explicitely again.

Thanks for the tip.

Dieter.
--=20
Dieter St=FCken, con terra GmbH, M=FCnster
     stueken@conterra.de
     http://www.conterra.de/
     (0)251-7474-501
