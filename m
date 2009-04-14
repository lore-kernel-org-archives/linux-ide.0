From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: Re: [PATCH] sata_sx4: speed up ECC initialization
Date: Wed, 15 Apr 2009 00:51:42 +0400
Message-ID: <a4423d670904141351o72c4c0acka87a00360f1a53eb@mail.gmail.com>
References: <1239675982-32584-1-git-send-email-a.beregalov@gmail.com>
	 <49E47A45.60902@garzik.org> <20090414200054.GB17134@orion>
	 <49E4F047.3030500@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:52691 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbZDNUvo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Apr 2009 16:51:44 -0400
Received: by ewy9 with SMTP id 9so2895051ewy.37
        for <linux-ide@vger.kernel.org>; Tue, 14 Apr 2009 13:51:42 -0700 (PDT)
In-Reply-To: <49E4F047.3030500@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

2009/4/15 Jeff Garzik <jeff@garzik.org>:
> Alexander Beregalov wrote:
>>
>> On Tue, Apr 14, 2009 at 07:57:57AM -0400, Jeff Garzik wrote:
>>>
>>> Alexander Beregalov wrote:
>>>>
>>>> ECC initialization takes too long. It writes zeroes by portions of=
 4
>>>> byte, it takes more than 6 minutes to initialize 512Mb DIMM module=
=2E
>>>> Change portion to 1Mb.
>>>>
>>>> before:
>>>> [10857.207576] pdc20621_dimm_init: Start ECC initialization
>>>> [11235.333118] pdc20621_dimm_init: Finish ECC initialization
>>>>
>>>> after:
>>>> [ 1005.126437] pdc20621_dimm_init: Local DIMM Speed =3D 100
>>>> [ 1005.128111] pdc20621_dimm_init: Local DIMM Size =3D 512MB
>>>> [ 1005.133508] Local DIMM ECC Enabled
>>>> [ 1005.236482] pdc20621_dimm_init: Start ECC initialization
>>>> [ 1031.278098] pdc20621_dimm_init: Finish ECC initialization
>>>>
>>> Comments:
>>>
>>> 1) on an older machine, where these things might be found, 1MB migh=
t be a
>>> lot -- particularly if there is a lot of VM fragmentation. =C2=A0Pl=
ease reduce
>>> the size a bit -- I suppose 128k is not unbearably slow?
>>>
>>> 2) Rather than repeating 'page size * 32' calculation multiple time=
s, put
>>> it into a named constant somewhere.
>>>
>>> Other than that, looks ok!
>>
>>
>>> From 00e980a4651ef12811fbe9a893a7e72510b955d1 Mon Sep 17 00:00:00 2=
001
>>
>> From: Alexander Beregalov <a.beregalov@gmail.com>
>> Date: Tue, 14 Apr 2009 23:55:52 +0400
>> Subject: [PATCH v2] sata_sx4: speed up ECC initialization
>>
>> ECC initialization takes too long. It writes zeroes by portions
>> of 4 byte, it takes more than 6 minutes on my machine to initialize
>> 512Mb ECC DIMM module. Change portion to 128Kb - it significantly
>> reduces initialization time.
>>
>> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
>> ---
>> =C2=A0drivers/ata/sata_sx4.c | =C2=A0 11 +++++++----
>> =C2=A01 files changed, 7 insertions(+), 4 deletions(-)
>
>
> Applied, to libata-dev.git#upstream
>
> Thanks!
>
> So... =C2=A0 the $64,000 question: =C2=A0does sata_sx4 work for you?

No, not yet! :)
It works without disks ;)
It has found disks, but got timeout from them.
Some specific functions should be added to ops structure.

At first I am trying to understand how to detect cable type.
I have two examples: from Promise partial source code and from FreeBSD.

But PGuide says the chip automatically detects cable type.
Does it mean the driver should not do anything with it? - I will try it=
=2E
