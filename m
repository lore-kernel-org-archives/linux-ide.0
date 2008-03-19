From: Jan Kasprzak <kas@fi.muni.cz>
Subject: Re: Regression: kernel 2.6.24{,.1} ahci problem, does not boot (resend)
Date: Wed, 19 Mar 2008 07:19:58 +0100
Message-ID: <20080319061958.GK3189@fi.muni.cz>
References: <20080214184700.0bd3837d@highlander.home.lan> <47B4D02E.9030101@gmail.com> <20080215191215.430ee2e0@highlander.home.lan> <47BCE71F.2000309@gmail.com> <20080221172757.44882428@highlander.home.lan> <20080317210045.GG3189@fi.muni.cz> <20080318140116.GC8480@fi.muni.cz> <47E08762.9090704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:39813 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760767AbYCSTyj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Mar 2008 15:54:39 -0400
Content-Disposition: inline
In-Reply-To: <47E08762.9090704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Malte =?iso-8859-1?Q?Schr=F6der?= <maltesch@gmx.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
: Hmm... I still wanna know why it got broke in the first place.  The o=
nly
: thing I can think of is IRQ routing problem in which case pci=3Dnomsi=
 or
: irqpoll should help.  Any chance you can test the old BIOS?

	Yes, I can. What data are you interested in? Boot logs with
pci=3Dnomsi and irqpoll ? Anything else?

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
