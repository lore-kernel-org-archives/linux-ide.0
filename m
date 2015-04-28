From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 3/9] mfd: syscon: Add Atmel MC (Memory Controller)
 registers definition
Date: Tue, 28 Apr 2015 18:59:37 +0100
Message-ID: <20150428175937.GH9169@x1>
References: <1427138955-3617-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1427138955-3617-4-git-send-email-alexandre.belloni@free-electrons.com>
 <20150428123058.GC9169@x1>
 <20150428125558.GD3687@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34989 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030577AbbD1R7n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Apr 2015 13:59:43 -0400
Received: by widdi4 with SMTP id di4so150262992wid.0
        for <linux-ide@vger.kernel.org>; Tue, 28 Apr 2015 10:59:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150428125558.GD3687@piout.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org

On Tue, 28 Apr 2015, Alexandre Belloni wrote:

> Hi,
>=20
> On 28/04/2015 at 13:30:58 +0100, Lee Jones wrote :
> > On Mon, 23 Mar 2015, Alexandre Belloni wrote:
> >=20
> > > From: Boris Brezillon <boris.brezillon@free-electrons.com>
> > >=20
> > > The at91rm9200 SoC embeds a Memory Controller block which is used=
 to
> > > configure several aspects of the platform:
> > > - AHB/APB Bus behavior
> > > - SDRAM Controller
> > > - EBI (External Bus Interface) and SMC (Static Memory Controller)=
 config
> > >=20
> > > Those registers might be accessed by different drivers, hence we =
need to
> > > define it as a syscon device.
> > >=20
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.co=
m>
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electron=
s.com>
> > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > ---
> > >  include/linux/mfd/syscon/atmel-mc.h | 144 ++++++++++++++++++++++=
++++++++++++++
> > >  1 file changed, 144 insertions(+)
> > >  create mode 100644 include/linux/mfd/syscon/atmel-mc.h
> >=20
> > I've lost context here.
> >=20
> > Is it okay to take this now?
> >=20
>=20
> I'd say that it would be better to get that one through the AT91 tree
> along with the following patches as they depend on it. Is that okay w=
ith
> you?

Yes, no problem.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
