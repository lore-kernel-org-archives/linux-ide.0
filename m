From: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Subject: Re: SATA drive keeps hard resetting
Date: Wed, 12 Dec 2007 08:23:04 -0300
Message-ID: <475FC498.5080105@gmail.com>
References: <475E08FC.9010809@gmail.com> <475E5D51.8010902@msgid.tls.msk.ru> <475F9B8F.1050208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:5895 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbXLLLXG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 06:23:06 -0500
Received: by an-out-0708.google.com with SMTP id d31so45469and.103
        for <linux-ide@vger.kernel.org>; Wed, 12 Dec 2007 03:23:05 -0800 (PST)
In-Reply-To: <475F9B8F.1050208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-ide@vger.kernel.org

Tejun Heo escribi=F3:
> Michael Tokarev wrote:
>  =20
>> Mat=ED=ADas Alejandro Torres wrote:
>>    =20
>>> Hi all,
>>>
>>> I have a SATA drive in a motherboard with an ATI SB600 chipset that
>>> until now worked just fine.
>>> The disk seems fine but after a while it start making noises (like
>>> spinning up) and the computer freezes during 2 or 3 seconds. I thin=
k my
>>> SATA drive is broken, or maybe the motherboard. This is what dmesg =
says:
>>>
>>> [  229.096000] ata4: exception Emask 0x10 SAct 0x0 SErr 0x90200 act=
ion 0x6 frozen
>>>      =20
>> See http://marc.info/?l=3Dlinux-ide&m=3D119707355016060&w=3D2
>> ...
>>    =20
>>> I'm using Ubuntu 7.10 with kernel 2.6.22-14-generic in a dual proce=
ssor
>>> computer. Below there's some hardware information. The output of dm=
esg
>>> is attached. Thanks!
>>>      =20
>> That patch will not apply cleanly to 2.6.22 - it will show rejects
>> in libata-core.c.  Those are OK - it's a cleanup of wrongly blacklis=
ted
>> drives.  The main part - in ahci.c - is the one that's needed.
>>    =20
>
> Matias's problem doesn't have anything to do with spurious completion=
=2E
> PHY RDY changed and HSM violation are completely different error cond=
itions.
>
> I think either the harddrive or power supply is dying.  smartctl -a
> might show something but I'm not too hopeful.  The surest way is to
> connect the drive to a different PSU and see whether the problem goes
> away but if all other drives on the system is fine, I would just thro=
w
> away the harddrive.
>
> Thanks.
>
>  =20
I tried the drive in anotcher PC and it didn't work. I'll see how far I=
=20
can throw it away! Thanks!
