From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2/5] 2.6.21-rc4: known regressions (v2)
Date: Mon, 26 Mar 2007 19:01:26 +0900
Message-ID: <460799F6.5080508@gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <20070323184828.GP752@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:13445 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965042AbXCZKBe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Mar 2007 06:01:34 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1964467nze
        for <linux-ide@vger.kernel.org>; Mon, 26 Mar 2007 03:01:33 -0700 (PDT)
In-Reply-To: <20070323184828.GP752@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?B?TWF0?= =?UTF-8?B?aGlldSBCw6lyYXJk?= <Mathieu.Berard@crans.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Fabio Comolli <fabio.comolli@gmail.com>, Plamen Petrov <plamen.petrov@tk.ru.acad.bg>, Laurent Riffard <laurent.riffard@free.fr>, Lukas Hejtmanek <xhejtman@mail.muni.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Adrian Bunk wrote:
> Subject    : NCQ problem with ahci and Hitachi drive  (ACPI related)
> References : http://lkml.org/lkml/2007/3/4/178
>              http://lkml.org/lkml/2007/3/9/475
> Submitter  : Mathieu B=C3=A9rard <Mathieu.Berard@crans.org>
> Handled-By : Tejun Heo <htejun@gmail.com>
> Status     : problem is being debugged

Patch is available and whether to put it into mainline or not is being
discussed.  libata EH does the right thing after several errors so
things should work properly after several errors.

http://thread.gmane.org/gmane.linux.kernel/496524

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
>              Alan Cox <alan@lxorguk.ukuu.org.uk>
> Status     : Alan: Some cases should be fixed now but probably not al=
l
>                    (eg the Nvidia one)

=46urther patch submitted.

http://thread.gmane.org/gmane.linux.ide/17444

This should fix all regression cases.  sata_nv has been always broken s=
o
isn't a regression.  It needs acpi tricks and I don't think it fits
2.6.21 cycle.

Thanks.

--=20
tejun
