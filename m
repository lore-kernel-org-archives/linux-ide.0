From: Tejun Heo <htejun@gmail.com>
Subject: Re: Regression: kernel 2.6.24{,.1} ahci problem, does not boot (resend)
Date: Wed, 19 Mar 2008 12:24:18 +0900
Message-ID: <47E08762.9090704@gmail.com>
References: <20080214184700.0bd3837d@highlander.home.lan> <47B4D02E.9030101@gmail.com> <20080215191215.430ee2e0@highlander.home.lan> <47BCE71F.2000309@gmail.com> <20080221172757.44882428@highlander.home.lan> <20080317210045.GG3189@fi.muni.cz> <20080318140116.GC8480@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.185]:31567 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938604AbYCSVr0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Mar 2008 17:47:26 -0400
Received: by rn-out-0910.google.com with SMTP id v46so600865rnb.15
        for <linux-ide@vger.kernel.org>; Wed, 19 Mar 2008 14:47:24 -0700 (PDT)
In-Reply-To: <20080318140116.GC8480@fi.muni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: =?UTF-8?B?TWFsdGUgU2NocsO2ZGVy?= <maltesch@gmx.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jan Kasprzak wrote:
> Jan Kasprzak wrote:
> : Malte Schr=C3=B6der wrote:
> : : I "solved" the problem by updating the BIOS. It now works perfect=
ly. I
> : : thought I had mailed that .. maybe I forgot.
> :=20
> : 	I have the same problem (ASUS M2R32-MVP board with SB600 chipset,
> : Athlon64 X2), but I am already using the latest BIOS for this mainb=
oard.
>=20
> 	Sorry for the noise, there is even newer BIOS (dated Mar 01),
> and with this BIOS my mainboard works in AHCI mode even with 2.6.25-r=
c6.

Hmm... I still wanna know why it got broke in the first place.  The onl=
y
thing I can think of is IRQ routing problem in which case pci=3Dnomsi o=
r
irqpoll should help.  Any chance you can test the old BIOS?

--=20
tejun
