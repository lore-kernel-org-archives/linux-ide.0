From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: qc timeout on a marvell 88F6282 board
Date: Thu, 7 Jul 2011 09:44:02 +0300
Message-ID: <CAMAG_efH1mtxufi_p8La8Sk6N3HSF1jJGca0mEvgkqPTnydSbQ@mail.gmail.com>
References: <4E0AEAB1.4090106@malgn.com>
	<CAMAG_ef0y=Jg=8eQSWj_e8kwGAtFwJXsvPATiL1fkq57kVzubA@mail.gmail.com>
	<4E12CAD1.3030302@malgn.com>
	<CAMAG_efStJsEeZrdf-eSq89aHrji3t5+RYO+arrUYiAQpn7LgQ@mail.gmail.com>
	<4E14040F.9030503@malgn.com>
	<CAMAG_efiyOdFCs4TAe0NusQ7yxLFg6gyajqSX51a965jEPioJw@mail.gmail.com>
	<4E1553DE.5050504@malgn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35366 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab1GGGoD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2011 02:44:03 -0400
Received: by iwn6 with SMTP id 6so583571iwn.19
        for <linux-ide@vger.kernel.org>; Wed, 06 Jul 2011 23:44:02 -0700 (PDT)
In-Reply-To: <4E1553DE.5050504@malgn.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Kang <turquesa@malgn.com>
Cc: linux-ide@vger.kernel.org

On Thu, Jul 7, 2011 at 9:36 AM, Richard Kang <turquesa@malgn.com> wrote=
:
> 2011-07-06 =EC=98=A4=ED=9B=84 5:07, saeed bishara =EC=93=B4 =EA=B8=80=
:
>>
>> Richard,
>>
>> =C2=A0this board is supported by mainline kernel, can you try latest
>> version (3.0-rcX)?
>>>
>>> I can't find reason of not working. Please advise to me.
>>>
>>> Thank you.
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
> Dear saeed,
>
> I tested sata_sil24 driver with 3.0.0-rc6.
> At first booting, machine id was not supported in new kernel.
> And I replaced id(0x690) of DB-88F6281-BP with 0x20f.
> After changing machine id, booting was completed.
>
> I loaded "libata dma=3D0" and "sata_sil24".
> But result was same to before. -> qc timeout(0xec)
does this controller (sil24) works on different platfrom (PC)?
have you tried different disk?
>
> Thank you.
>
