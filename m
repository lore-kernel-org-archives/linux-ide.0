From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.32.2 SATA link detect failed, 2.6.32.1 works fine
Date: Thu, 24 Dec 2009 16:33:43 +0900
Message-ID: <4B331957.7030906@kernel.org>
References: <alpine.LNX.2.00.0912211855460.1689@darkstar.example.net> <4B30134C.1050609@gmail.com> <alpine.LNX.2.00.0912220859060.1686@darkstar.example.net> <51f3faa70912211708j200ab584wa835ffe50981415e@mail.gmail.com> <alpine.LNX.2.00.0912220955341.1696@darkstar.example.net> <4B31DB17.4050509@kernel.org> <alpine.LNX.2.00.0912231719440.1694@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58378 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545AbZLXHaO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Dec 2009 02:30:14 -0500
In-Reply-To: <alpine.LNX.2.00.0912231719440.1694@darkstar.example.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: fengxiangjun <fengxiangjun@neusoft.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 12/23/2009 06:29 PM, fengxiangjun wrote:
>=20
> Hi,
>=20
> with this patch, the problem still exists.
>=20
> ata1.01: XXX debounce start, SStatus=3D4
> ata1.01: XXX debounce done, SStatus=3D4, DET stable for 520 msecs
> ata1.00: SATA link down (SStatus 0 SControl 301)
> ata1.01: SATA link down (SStatus 0 Scontrol 300)
> ...
> VFS; cannot open root device ...
>=20
> The kernel just panic, and I can't see what's the messege printing be=
fore=20
> that.
>=20
> So, I tried 'console=3DttyS0 console=3Dtty1'=EF=BC=8Cfull dmesg attac=
hed=E3=80=82

Can you please capture full failing log?  In the attached log, ata1.00
is detected successfully.

Thanks.

--=20
tejun
