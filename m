From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA SB600
Date: Tue, 27 Mar 2007 11:39:55 +0900
Message-ID: <460883FB.1030000@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:60662 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933959AbXC0CkA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Mar 2007 22:40:00 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1767268wra
        for <linux-ide@vger.kernel.org>; Mon, 26 Mar 2007 19:39:59 -0700 (PDT)
In-Reply-To: <46088328.8070601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Cc: linux-ide@vger.kernel.org

Mat=ED=ADas Alejandro Torres wrote:
> Tejun Heo escribi=F3:
>> Hello,
>>
>>   Does 2.6.20 work?  Has any version ever worked?
>>
>>  =20
>=20
> No. Versions that I have probed:
>=20
> 2.10.17
>=20
> 2.6.20
>=20
> 2.6.20.4
>=20
> 2.6.21-rc6
>=20
> I'll reboot a few times and send the output of dmesg for each version=
=2E..
> in 15 minutes you'll have them.

Can you try with kernel parameter 'acpi=3Dnoirq' or 'irqpoll'?

--=20
tejun
