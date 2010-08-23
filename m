From: =?ISO-8859-15?Q?Stefan_/*St0fF*/_H=FCbner?=
	<stefan.huebner@stud.tu-ilmenau.de>
Subject: Re: Maybe a bug in libata-core
Date: Tue, 24 Aug 2010 00:41:45 +0200
Message-ID: <4C72F929.6090401@stud.tu-ilmenau.de>
References: <4C71C645.8050007@stud.tu-ilmenau.de> <4C723C65.6080303@kernel.org>
Reply-To: stefan.huebner@stud.tu-ilmenau.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wega.rz.tu-ilmenau.de ([141.24.4.159]:57838 "EHLO
	wega.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab0HWWo2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Aug 2010 18:44:28 -0400
In-Reply-To: <4C723C65.6080303@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, jgarzik@pobox.com

Am 23.08.2010 11:16, schrieb Tejun Heo:
> On 08/23/2010 02:52 AM, Stefan /*St0fF*/ H=FCbner wrote:
>> Hi Jeff and list,
>>
>> maybe this mail was wrong on the linux-scsi list.  So here we go aga=
in:
>>
>> -------- Original-Nachricht --------
>> Betreff: Maybe a bug in libata-core
>> Datum: Fri, 20 Aug 2010 23:48:09 +0200
>> Von: Stefan H=FCbner  <stefan.huebner@stud.tu-ilmenau.de>
>> Antwort an: stefan.huebner@stud.tu-ilmenau.de
>> Organisation: TU-Ilmenau
>> An: linux-scsi@vger.kernel.org
>>
>>  Hi List!
>>
>> After sending a WRITE_DMA_FUA_EXT ATA-command via SG_IO Passthru to =
a
>> harddisk (here: /dev/sdd), my kernel panics.  The is what I find in =
syslog:
>=20
> You're sending down data command w/o data.  Panicking probably isn't
> the best response here.  Maybe the BUG_ON() should be changed to
> WARN_ON_ONCE() + goto sg_err.
>=20
> Thanks.
>=20

As far as I know my code I thought I did send enough data.  Maybe I'm
misunderstanding something: I valloc'ated block_count*logical_block_siz=
e
bytes, filled them with data and presented this buffer to the
sg_io_hdr_t structure by setting dxfer_len to the length of the buffer,
setting dxferp to a pointer to the buffer and setting the
dxfer_direction to SG_DXFER_TO_DEV.

The only thing coming to my mind would be overflow of dxfer_len, but as
this is a unsigned int - wouldn't it be 32 bits wide? (and by that
accepting f.e. 64k*512 bytes =3D 33 554 432 bytes (32M, needing 25 bits=
))

Any other suggestions, or do I have to present the code?

Thanks,
Stefan
