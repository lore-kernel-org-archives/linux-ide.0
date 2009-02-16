From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] libata: Don't trust current capacity values in identify
 words 57-58
Date: Mon, 16 Feb 2009 17:46:58 -0600
Message-ID: <4999FAF2.1000800@gmail.com>
References: <4999CA54.1060306@gmail.com> <4999F032.6060107@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:14443 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383AbZBPXrE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Feb 2009 18:47:04 -0500
In-Reply-To: <4999F032.6060107@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, =?UTF-8?B?SGFubm8gQsO2Y2s=?= <hanno@hboeck.de>

Mark Lord wrote:
> Robert Hancock wrote:
>> Hanno B=C3=B6ck reported a problem where an old Conner CP30254 240MB=
 hard=20
>> drive
>> was reported as 1.1TB in capacity by libata:
>>
>> http://lkml.org/lkml/2009/2/13/134
>>
>> This was caused by libata trusting the drive's reported current=20
>> capacity in sectors in identify words 57 and 58 if the drive does no=
t=20
>> support LBA and the
>> current CHS translation values appear valid. Unfortunately it seems =
older
>> ATA specs were vague about what this field should contain and a numb=
er=20
>> of drives
>> used values with wrong byte order or that were totally bogus. There'=
s no
>> unique information that it conveys and so we can just calculate the=20
>> number
>> of sectors from the reported current CHS values.
>>
>> Signed-off-by: Robert Hancock <hancockrwd@gmail.com>
> ..
>>      } else {
>>          if (ata_id_current_chs_valid(id))
>> -            return ata_id_u32(id, 57);
>> +            return id[54] * id[55] * id[56];
>>          else
>>              return id[1] * id[3] * id[6];
> ..
>=20
> NAK.  That's not quite correct, either.
>=20
> The LBA capacity can be larger than the CHS capacity,
> so we have to use the reported LBA values if at all possible.
>=20
> That's why ata_id_is_lba_capacity_ok() exists,
> and why it looks so peculiar.
>=20
> Some of those early drives really did require that kind of logic.

This is the !ata_id_has_lba code path. If the drive supports LBA then=20
the LBA capacity will always be used, that hasn't changed.
