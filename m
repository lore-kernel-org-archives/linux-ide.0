From: Harik <harik.attar@gmail.com>
Subject: Re: questions regarding possible violation of AHCI spec in AHCI driver
Date: Tue, 11 Jan 2011 19:45:56 -0500
Message-ID: <AANLkTinpWS4yzAoHE5nTPtQ3OAU1SvM1mN2tMjsur8BW@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62749 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210Ab1ALAp6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jan 2011 19:45:58 -0500
In-Reply-To: <E18F441196CA634DB8E1F1C56A50A874319FA7E37B@IRVEXCHCCR01.corp.ad.broadcom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jian Peng <jipeng@broadcom.com>
Cc: Tejun Heo <tj@kernel.org>, Robert Hancock <hancockrwd@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>

> + =A0 =A0 =A0 =A0 =A0 (tmp & 0x0f) !=3D 0x03) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "START bit was not se=
t in %s\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }

Are there defines for the mask and result that you could use instead of=
 raw hex?
