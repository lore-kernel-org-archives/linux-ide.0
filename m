From: Laurent Riffard <laurent.riffard@free.fr>
Subject: Re: [2/5] 2.6.21-rc5: known regressions
Date: Wed, 28 Mar 2007 21:46:30 +0200
Message-ID: <460AC616.3050207@free.fr>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org> <20070327015936.GZ16477@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp23.orange.fr ([193.252.22.30]:29694 "EHLO smtp23.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965712AbXC1Tq0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Mar 2007 15:46:26 -0400
In-Reply-To: <20070327015936.GZ16477@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Fabio Comolli <fabio.comolli@gmail.com>, Plamen Petrov <plamen.petrov@tk.ru.acad.bg>, Lukas Hejtmanek <xhejtman@mail.muni.cz>

Le 27.03.2007 03:59, Adrian Bunk a =C3=A9crit :
> This email lists some known regressions in Linus' tree compared to 2.=
6.20.
=2E..=20
> Subject    : libata: PATA UDMA/100 configured as UDMA/33
> References : http://lkml.org/lkml/2007/2/20/294
>              http://www.mail-archive.com/linux-ide@vger.kernel.org/ms=
g04115.html
>              http://bugzilla.kernel.org/show_bug.cgi?id=3D8133
>              http://bugzilla.kernel.org/show_bug.cgi?id=3D8164
>              http://lkml.org/lkml/2007/3/21/330
> Submitter  : Fabio Comolli <fabio.comolli@gmail.com>
>              Plamen Petrov <plamen.petrov@tk.ru.acad.bg>
>              Laurent Riffard <laurent.riffard@free.fr>
>              Lukas Hejtmanek <xhejtman@mail.muni.cz>
> Handled-By : Tejun Heo <htejun@gmail.com>
> Patch      : http://thread.gmane.org/gmane.linux.ide/17444
> Status     : patch available

pata-via case is fixed for me in 2.6.21-rc5-mm2 (was already fixed in 2=
=2E6.21-rc4-mm1).

thanks
~~
laurent

