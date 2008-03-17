From: Jan Kasprzak <kas@fi.muni.cz>
Subject: Re: Regression: kernel 2.6.24{,.1} ahci problem, does not boot (resend)
Date: Mon, 17 Mar 2008 22:00:45 +0100
Message-ID: <20080317210045.GG3189@fi.muni.cz>
References: <20080214184700.0bd3837d@highlander.home.lan> <47B4D02E.9030101@gmail.com> <20080215191215.430ee2e0@highlander.home.lan> <47BCE71F.2000309@gmail.com> <20080221172757.44882428@highlander.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:34867 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753382AbYCQVAw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Mar 2008 17:00:52 -0400
Content-Disposition: inline
In-Reply-To: <20080221172757.44882428@highlander.home.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Malte =?iso-8859-1?Q?Schr=F6der?= <maltesch@gmx.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Malte Schr=C3=B6der wrote:
: I "solved" the problem by updating the BIOS. It now works perfectly. =
I
: thought I had mailed that .. maybe I forgot.

	I have the same problem (ASUS M2R32-MVP board with SB600 chipset,
Athlon64 X2), but I am already using the latest BIOS for this mainboard=
=2E

2.6.22.19 works
2.6.24.3 does not work
2.6.25-rc6 does not work

	I can try to bisect it (maybe tomorrow).
I use AHCI mode, maybe I should try the legacy mode as well.

-Yenya

--=20
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - privat=
e}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18=
A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/bl=
og/ |
>>  If you find yourself arguing with Alan Cox, you=E2=80=99re _probabl=
y_ wrong.  <<
>>     --James Morris in "How and Why You Should Become a Kernel Hacker=
"  <<
