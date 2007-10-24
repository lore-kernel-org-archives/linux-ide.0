From: Tejun Heo <htejun@gmail.com>
Subject: Re: Warnings on shutdown (Debian Etch and Kernel 2.6.22.9)
Date: Wed, 24 Oct 2007 22:39:29 +0900
Message-ID: <471F4B11.9030206@gmail.com>
References: <47099C24.3010504@mandic.com.br> <471DAA1C.4070608@gmail.com> <471DC728.60705@mandic.com.br> <471DC8F1.9090501@gmail.com> <471DCA74.503@mandic.com.br> <471DCB33.5070108@gmail.com> <471DD288.7010902@mandic.com.br> <471DE866.7040908@gmail.com> <20071023234732.GA23598@jim.sh> <471F493C.8050804@mandic.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:63733 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758090AbXJXNjh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 09:39:37 -0400
Received: by wa-out-1112.google.com with SMTP id v27so226638wah
        for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2007 06:39:37 -0700 (PDT)
In-Reply-To: <471F493C.8050804@mandic.com.br>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Cc: Jim Paris <jim@jtan.com>, Jeff Garzik <jeff@garzik.org>, debian-devel@lists.debian.org, linux-ide@vger.kernel.org, miquels@cistron.nl

Renato S. Yamane wrote:
> Jim Paris escreveu:
>> Tejun Heo wrote:
>>> Ehh... I meant something along the line of...
>>>
>>> "Info for Debian VERSION users : if you see this warning there are
>>> several solutions... blah blah".
>>
>> For Debian, I don't think there are any complete solutions yet.
>> The related bug is  =20
>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D426224
>=20
> I think that we can fix this if someone can answer this:
>=20
> $ man halt
> "-h flag: This is important for IDE drives, since the kernel doesn=92=
t=20
> flush the write cache itself before power-off.."
>=20
> How can I know if kernel write cache itself? :-)

Kernel has been flushing write cache for many many years now.  Man page=
=20
needs update.  Also, flushing cache from halt is okay.  What's hurting=20
is spinning down the drive from halt.

--=20
tejun
