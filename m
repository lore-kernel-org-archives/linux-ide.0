From: Hector Oron <hector.oron@gmail.com>
Subject: Re: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53 platforms
Date: Thu, 22 Sep 2011 10:30:33 +0100
Message-ID: <CAODfWeFPwUa++=Bz6503KJS9dNhmkjNuWF_g==MaFKydqRRX3A@mail.gmail.com>
References: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
	<CAODfWeEm8bkySXxb1qopbH1VMu-V+33k5x+0+qjABzesT0amOA@mail.gmail.com>
	<CAJNCFV+XFGEba1J2dXDa4YVwqduAPV5y=5JYEXAZ0uv+S60vvw@mail.gmail.com>
	<CAODfWeEueF45_yvPV5Zxbva6K2gEfKZbY2qoqySYFPZWnSgLsg@mail.gmail.com>
	<CAJNCFVLP7gA_7vBjwVNkQaSg8LZ4hROLdNCx8SBVah=F1ptrhQ@mail.gmail.com>
	<CAODfWeHTRuFZtnYZOD-mFonyjBvjhid4=0=a_mYXdjXAOQYejA@mail.gmail.com>
	<CAMPhdO-f2RHtZ0RdV_wGZvohMT85Q3JzTePaD9w73shGpWkP6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62434 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab1IVJaf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2011 05:30:35 -0400
Received: by qyk30 with SMTP id 30so5908938qyk.19
        for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2011 02:30:34 -0700 (PDT)
In-Reply-To: <CAMPhdO-f2RHtZ0RdV_wGZvohMT85Q3JzTePaD9w73shGpWkP6g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eric Miao <eric.miao@linaro.org>
Cc: Richard Zhu <richard.zhu@linaro.org>, eric@eukrea.com, Wolfram Sang <w.sang@pengutronix.de>, linux-ide@vger.kernel.org, kernel@pengutronix.de, avorontsov@ru.mvista.com, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org

Hello,

  Apologies for late reply.

2011/9/6 Eric Miao <eric.miao@linaro.org>:
> On Tue, Sep 6, 2011 at 1:46 AM, Hector Oron <hector.oron@gmail.com> w=
rote:
>> 2011/9/1 Richard Zhu <richard.zhu@linaro.org>:

>> Here is my complete dmesg. The system seems to work fine, it is a
>> 1.0TB WD10TPVT SATA disk in a case which provides eSATA and connecte=
d
>> to mx53 LOCO with eSATA-to-SATA cable.

> Is it possible that it's caused by this converter? Do you have a sepa=
rate
> SATA power supply that could help test the disk directly connected to
> mx53loco?

I think I had a bad configuration setup for my kernel. I have rebuilt
3.1.0-rc6 from Sascha's master git with this patches and now SATA is
working properly I do not see any issue as I did. So, from my side all
is OK now, and I assume I had some missing or conflicting module
setup.

Kind regards and apologies for inconveniences,
--=20
=C2=A0H=C3=A9ctor Or=C3=B3n =C2=A0-.. . -... .. .- -. =C2=A0 -.. . ...-=
 . .-.. --- .--. . .-.
