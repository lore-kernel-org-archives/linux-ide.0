From: Maciej Grela <maciej.grela@gmail.com>
Subject: Re: How to perform SECURITY ERASE on a SEC4 (security enabled/locked)
 PATA drive ?
Date: Wed, 4 May 2011 21:43:18 +0200
Message-ID: <BANLkTikyMQSiNCB10mqR6+0fWoeYc8o2JQ@mail.gmail.com>
References: <BANLkTikZt4Nr3DK3CkZXZ_ORgqjy-MGOUA@mail.gmail.com>
	<4DBAC18A.20407@teksavvy.com>
	<BANLkTimFg_=KmCRVL=QoO9s-4+T3DmbNQw@mail.gmail.com>
	<4DBB7341.1070600@teksavvy.com>
	<BANLkTi==R1tb-oNp4Sf5DJHS3wjZyC_wLg@mail.gmail.com>
	<4DC01744.6040206@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37259 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab1EDTnU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 May 2011 15:43:20 -0400
Received: by vxi39 with SMTP id 39so1496659vxi.19
        for <linux-ide@vger.kernel.org>; Wed, 04 May 2011 12:43:19 -0700 (PDT)
In-Reply-To: <4DC01744.6040206@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: linux-ide@vger.kernel.org

2011/5/3 Mark Lord <kernel@teksavvy.com>:
> On 11-04-30 04:10 AM, Maciej Grela wrote:
>> 2011/4/30 Mark Lord <kernel@teksavvy.com>:
>>>
>>> Okay. =C2=A0Now please do exactly this (and I mean EXACTLY):
>>>
>>> 1. shut down and completely power off the system.
>>> 2. boot up again, and immediately do "hdparm --Istdout /dev/sdb
>>> and post the results here.
>>>
>>> I want to see what the default security state of the drive is,
>>> and that sequence above will tell all.
>>>
>>
>> Hi,
>>
>> Here is the data:
> ..
>
>> Security:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Master password revision code =3D 65534
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 supported
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enabled
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 locked
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 not =C2=A0 =C2=A0 frozen
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 not =C2=A0 =C2=A0 expired: security coun=
t
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 not =C2=A0 =C2=A0 supported: enhanced er=
ase
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Security level high
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 42min for SECURITY ERASE UNIT.
> ..
>
> Okay, your drive already has a password set on it.
> So to do a --security-erase, you will likely need to
> know and supply that exact password on the command line:
>
> =C2=A0 =C2=A0hdparm --security-erase XXXXXXXX /dev/sdb
>
> If you don't know the password, then you can try this:
>
> =C2=A0 =C2=A0hdparm --security-set-pass NULL --user-master m /dev/sdb
> =C2=A0 =C2=A0hdparm --security-erase =C2=A0 =C2=A0NULL --user-master =
m /dev/sdb
>
> If that also fails, then you'll have to read through the ATA
> security feature documentation (from the t13 standards),
> and try and understand how the quirky state machine model
> for it is supposed to work. =C2=A0And then puzzle it out from there.
>

Hi,

Thanks for all the info, I already did try that approach after
studying the t13 document. I tried to invoke all the state transitions
from SEC4 mentioned there without any progress. So I'll take a break
from trying to solve this problem as it's not very urgent.

Best regards,
Maciej Grela
