From: Prashant Bhole <prashantsmailcenter@gmail.com>
Subject: Re: sata_mv: wrong EDMA error cause when disk unplugged
Date: Mon, 18 Jan 2010 16:20:45 +0530
Message-ID: <9ff69a5d1001180250w7bf5f749q1b15cc9c3113567@mail.gmail.com>
References: <9ff69a5d1001180147h643572e5m2e9db0361caeb334@mail.gmail.com>
	 <23044.87.210.74.220.1263810968.squirrel@ketsers.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:39202 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab0ARKuq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 05:50:46 -0500
Received: by qyk32 with SMTP id 32so66043qyk.4
        for <linux-ide@vger.kernel.org>; Mon, 18 Jan 2010 02:50:45 -0800 (PST)
In-Reply-To: <23044.87.210.74.220.1263810968.squirrel@ketsers.dhs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Caspar Smit <c.smit@truebit.nl>
Cc: linux-ide@vger.kernel.org

On Mon, Jan 18, 2010 at 4:06 PM, Caspar Smit <c.smit@truebit.nl> wrote:
> Hi Prashant,
>
> Same here, using 1.28 from the debian backports 2.6.30 kernel.
> Plug a disk =3D 0x00000010
> Unplug a disk =3D 0x00000020

Thanks Caspar.

Can somebody please tell me what could be the problem?

>
> Kind regards,
> Caspar
>
>> Hi,
>> I am using latest marvell sata driver version 1.28 for marvell chip
>> 88SX6081, I noticed following behavior:
>> 1) When I plug a disk, EDMA error cause value is: 0x00000010. This i=
s
>> correct.
>> 2) But when I unplug a disk, EDMA error cause value is: 0x00000020
>> (EDMA_ERR_SERR).
>> =A0 =A0 which is wrong. It should be 0x00000008 (EDMA_ERR_DEV_DCON).
>>
>> Please let me know if anybody experiencing the same problem.
>> --
>> ~p~r~a~s~h~a~n~t~
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
~p~r~a~s~h~a~n~t~
