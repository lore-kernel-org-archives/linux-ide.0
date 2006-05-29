From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: sata_mv with Adaptec AIC-8130/Marvell 88SX6041 ("Badness in __msleep")
Date: Mon, 29 May 2006 12:51:34 -0700
Message-ID: <23F9027D-7161-43A5-A2FE-1F355F79C53A@develooper.com>
References: <5D6C23F5-B03E-4C3D-8BC6-A009E51122D8@develooper.com> <447A614B.3050603@rtr.ca>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from x8.develooper.com ([216.52.237.208]:56533 "EHLO
	x8.develooper.com") by vger.kernel.org with ESMTP id S1751254AbWE2Tvg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 15:51:36 -0400
In-Reply-To: <447A614B.3050603@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On May 28, 2006, at 7:49 PM, Mark Lord wrote:

> Ask Bj=F8rn Hansen wrote:
>> Hi everyone,
>> I have a box with a Adaptec AIC-8130/Marvell 88SX6041 chip =20
>> integrated.  I am using the latest FC5 kernel (~2.6.16.1) with the =20
>> sata_mv 0.5 driver (which is the same as in 2.6.16.18).   The arch =20
>> is x86_64 (dual Opteron something).
>
> The current 2.6.16.xx sata_mv drivers is known buggy.
> Don't rely on it for anything important.
>
> The attached patch is an untested backport of the latest sata_mv,
> which should be more reliable than what you've been using.
[...]

Thanks!

I built a new set of kernel rpms and put them in my kickstart tree.  =20
It will be a few days before I get to where the box is, but I will =20
try it then and report back.


  - ask

--=20
http://askask.com/  - http://develooper.com/


