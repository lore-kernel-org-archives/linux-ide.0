From: "Jian Peng" <jipeng@broadcom.com>
Subject: RE: questions regarding possible violation of AHCI spec in AHCI
 driver
Date: Tue, 11 Jan 2011 16:51:46 -0800
Message-ID: <E18F441196CA634DB8E1F1C56A50A874319FE61FEE@IRVEXCHCCR01.corp.ad.broadcom.com>
References: <4CFF58D2.4040006@kernel.org>
 <E18F441196CA634DB8E1F1C56A50A874319FA38C43@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4CFFCD56.6050608@kernel.org>
 <E18F441196CA634DB8E1F1C56A50A874319FA7E36E@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4CFFD3EB.10800@kernel.org>
 <E18F441196CA634DB8E1F1C56A50A874319FA7E36F@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4CFFE29C.7080205@kernel.org>
 <E18F441196CA634DB8E1F1C56A50A874319FA38CD3@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4D000C8B.5040904@kernel.org>
 <E18F441196CA634DB8E1F1C56A50A874319FD72B23@IRVEXCHCCR01.corp.ad.broadcom.com>
 <20110111182323.GG15933@htj.dyndns.org>
 <E18F441196CA634DB8E1F1C56A50A874319FA7E37B@IRVEXCHCCR01.corp.ad.broadcom.com>
 <AANLkTinpWS4yzAoHE5nTPtQ3OAU1SvM1mN2tMjsur8BW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mms3.broadcom.com ([216.31.210.19]:4812 "EHLO MMS3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756359Ab1ALAwA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jan 2011 19:52:00 -0500
In-Reply-To: <AANLkTinpWS4yzAoHE5nTPtQ3OAU1SvM1mN2tMjsur8BW@mail.gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harik <harik.attar@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Robert Hancock <hancockrwd@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>

Unfortunately, no

-----Original Message-----
=46rom: Harik [mailto:harik.attar@gmail.com]=20
Sent: Tuesday, January 11, 2011 4:46 PM
To: Jian Peng
Cc: Tejun Heo; Robert Hancock; linux-kernel@vger.kernel.org; jgarzik@po=
box.com; ide
Subject: Re: questions regarding possible violation of AHCI spec in AHC=
I driver

> + =A0 =A0 =A0 =A0 =A0 (tmp & 0x0f) !=3D 0x03) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "START bit was not se=
t in %s\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }

Are there defines for the mask and result that you could use instead of=
 raw hex?


