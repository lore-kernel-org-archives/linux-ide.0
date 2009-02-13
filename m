From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Very old IDE hard drive (240 MB) detected as 1.1 TB
Date: Fri, 13 Feb 2009 08:34:36 -0600
Message-ID: <499584FC.2050104@gmail.com>
References: <200902131428.40212.hanno@hboeck.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:16915 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbZBMOem (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Feb 2009 09:34:42 -0500
In-Reply-To: <200902131428.40212.hanno@hboeck.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?SGFubm8gQsO2Y2s=?= <hanno@hboeck.de>
Cc: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>

(ccing linux-ide)

Hanno B=C3=B6ck wrote:
> I was about to shred some old hard drives. On one Hard drive, identif=
ied as:
> Conner Peripherals 240MB - CP30254
>=20
> it was detected as 1.1 TB (!) and obviously throwing lots of errors a=
fter=20
> getting over 240 MB.
>=20
> Is this issue worth investigating further? System is ubuntu 8.10. If =
anyone=20
> wants to have a deeper look, I can obviously donate that harddrive if=
 you pay=20
> me shipping costs.

That would be worth investigating, yes.. If you can provide the dmesg=20
output from bootup, as well as the output of hdparm --Istdout on the=20
disk device, that would be useful..
