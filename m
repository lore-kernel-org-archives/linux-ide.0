From: =?ISO-8859-15?Q?Stefan_/*St0fF*/_H=FCbner?=
	<stefan.huebner@stud.tu-ilmenau.de>
Subject: Re: Maybe a bug in libata-core
Date: Thu, 09 Sep 2010 07:42:12 +0200
Message-ID: <4C8873B4.70808@stud.tu-ilmenau.de>
References: <4C71C645.8050007@stud.tu-ilmenau.de> <4C723C65.6080303@kernel.org> <4C72F929.6090401@stud.tu-ilmenau.de> <4C73747D.7090305@kernel.org>
Reply-To: stefan.huebner@stud.tu-ilmenau.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wega.rz.tu-ilmenau.de ([141.24.4.159]:57584 "EHLO
	wega.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab0IIFpN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Sep 2010 01:45:13 -0400
In-Reply-To: <4C73747D.7090305@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Dear list,

I'm very sorry I didn't find the time earlier to pursue this matter.
Indeed it was a coding error on my side.  I sat up sg_io_hdr_t correctl=
y
except for one thing: dxfer_len was set to the amount of blocks instead
of block*logical_blocksize - so it was all my bad.

Thank you for the suggestions, it helped finding the error quickly.

Greetings,
Stefan


Am 24.08.2010 09:27, schrieb Tejun Heo:
> Hello,
>=20
> On 08/24/2010 12:41 AM, Stefan /*St0fF*/ H=FCbner wrote:
>> As far as I know my code I thought I did send enough data.  Maybe I'=
m
>> misunderstanding something: I valloc'ated block_count*logical_block_=
size
>> bytes, filled them with data and presented this buffer to the
>> sg_io_hdr_t structure by setting dxfer_len to the length of the buff=
er,
>> setting dxferp to a pointer to the buffer and setting the
>> dxfer_direction to SG_DXFER_TO_DEV.
>>
>> The only thing coming to my mind would be overflow of dxfer_len, but=
 as
>> this is a unsigned int - wouldn't it be 32 bits wide? (and by that
>> accepting f.e. 64k*512 bytes =3D 33 554 432 bytes (32M, needing 25 b=
its))
>>
>> Any other suggestions, or do I have to present the code?
>=20
> Yeah, posting a simple test case would be the best way to proceed
> here.
>=20
> Thanks.
>=20

