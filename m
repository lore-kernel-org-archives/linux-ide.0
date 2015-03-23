From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 03/10] ata: at91: use syscon to configure the smc
Date: Mon, 23 Mar 2015 17:38:57 +0100
Message-ID: <20150323163857.GA20732@piout.net>
References: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1426545886-19162-4-git-send-email-alexandre.belloni@free-electrons.com>
 <550FE6D7.6000107@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57629 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752144AbbCWQjC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Mar 2015 12:39:02 -0400
Content-Disposition: inline
In-Reply-To: <550FE6D7.6000107@atmel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Lee Jones <lee.jones@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 23/03/2015 at 11:11:35 +0100, Nicolas Ferre wrote :
> Le 16/03/2015 23:44, Alexandre Belloni a =E9crit :
> > Use syscon/regmap to configure the smc. This allows to avoid using
> > at91sam9_smc.h and to compile the driver in a multiplatform configu=
ration.
> >=20
> > The driver will still not probe until the proper DT bindings are ad=
ded.
>=20
> Alexandre, just for the record, can you describe the DT node that wil=
l
> match this?
> Is it one that will be added to
> Documentation/devicetree/bindings/mfd/atmel-smc.txt?
>=20

I believe it should be documented when the full binding will be defined=
=2E
This binding will include a mandatory property:
 atmel,smc: phandle to the smc

and will look like:
 atmel,smc =3D <&smc>;


--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
