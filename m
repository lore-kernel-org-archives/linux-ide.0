From: Hector Oron <hector.oron@gmail.com>
Subject: Re: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53 platforms
Date: Tue, 30 Aug 2011 11:43:29 +0100
Message-ID: <CAODfWeEm8bkySXxb1qopbH1VMu-V+33k5x+0+qjABzesT0amOA@mail.gmail.com>
References: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62000 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab1H3Kna convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2011 06:43:30 -0400
Received: by qwk3 with SMTP id 3so3900650qwk.19
        for <linux-ide@vger.kernel.org>; Tue, 30 Aug 2011 03:43:29 -0700 (PDT)
In-Reply-To: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, eric.miao@linaro.org, linux-ide@vger.kernel.org, eric@eukrea.com, avorontsov@ru.mvista.com, jgarzik@pobox.com

Hello,

2011/8/30 Richard Zhu <richard.zhu@linaro.org>:
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> ---
> =C2=A0arch/arm/mach-mx5/clock-mx51-mx53.c =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 19 ++++
> =C2=A0arch/arm/mach-mx5/devices-imx53.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 +
> =C2=A0arch/arm/plat-mxc/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0arch/arm/plat-mxc/ahci_sata.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0104 +++++++++++++++++++++++
> =C2=A0arch/arm/plat-mxc/devices/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 +
> =C2=A0arch/arm/plat-mxc/devices/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0arch/arm/plat-mxc/devices/platform-ahci-imx.c =C2=A0 | =C2=A0 6=
6 ++++++++++++++
> =C2=A0arch/arm/plat-mxc/include/mach/ahci_sata.h =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 33 +++++++
> =C2=A0arch/arm/plat-mxc/include/mach/devices-common.h | =C2=A0 10 ++
> =C2=A09 files changed, 242 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 arch/arm/plat-mxc/ahci_sata.c
> =C2=A0create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.=
c
> =C2=A0create mode 100644 arch/arm/plat-mxc/include/mach/ahci_sata.h

The good news are that I have tested this patch series on i.MX53 LOCO
board and it seems to work fine here. Thanks.


Tested-By: Hector Oron Martinez <hector.oron@gmail.com>

--=20
=C2=A0H=C3=A9ctor Or=C3=B3n =C2=A0-.. . -... .. .- -. =C2=A0 -.. . ...-=
 . .-.. --- .--. . .-.
