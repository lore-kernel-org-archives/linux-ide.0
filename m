From: Tejun Heo <tj@kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaUmU=?= =?utf-8?Q?=3A?= [v1] ahci: imx:
 setup power saving methods
Date: Sun, 29 Sep 2013 08:51:28 -0400
Message-ID: <20130929125128.GA7599@htj.dyndns.org>
References: <1380269265-10821-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1380269265-10821-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130927131441.GA3205@htj.dyndns.org>
 <20130929073528.GE26156@S2101-09.ap.freescale.net>
 <1vugbd691bjfibh5crdihlrh.1380440262216@email.android.com>
 <20130929074817.GG26156@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:46400 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab3I2Mve (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Sep 2013 08:51:34 -0400
Received: by mail-qa0-f50.google.com with SMTP id j7so1619582qaq.2
        for <linux-ide@vger.kernel.org>; Sun, 29 Sep 2013 05:51:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130929074817.GG26156@S2101-09.ap.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Zhu Richard-R65037 <r65037@freescale.com>, Richard Zhu <richard.zhuhongxing@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sun, Sep 29, 2013 at 03:48:18PM +0800, Shawn Guo wrote:
> On Sun, Sep 29, 2013 at 07:40:57AM +0000, Zhu Richard-R65037 wrote:
> > Hi Shawn:
> > Thanks.
> > The hot-plug can=E2=80=99t be supported, if we support this method =
unconditionally.
>=20
> Ah, okay.  Then you should make this clear in the help text of the
> Kconfig option.

Yeah but it's still weird to require kernel build to flip this
feature, isn't it?  Shouldn't it be a module param or something?

Thanks.

--=20
tejun
