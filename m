From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: legacy VLB drivers housekeeping
Date: Mon, 7 Feb 2011 13:58:47 +0100
Message-ID: <AANLkTikjwjvHXMqYaVpHH3pkxM-Uo_C+kn0DLY2NfTzi@mail.gmail.com>
References: <201102071153.37633.bzolnier@gmail.com>
	<4D4FE1D6.5050507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50192 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab1BGM6r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Feb 2011 07:58:47 -0500
In-Reply-To: <4D4FE1D6.5050507@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 7, 2011 at 1:13 PM, Sergei Shtylyov <sshtylyov@mvista.com> =
wrote:
> Hello.

Hi,

> On 07-02-2011 13:53, Bartlomiej Zolnierkiewicz wrote:
>
>> * remove stale documentation
>> * remove dead ALWAYS_SET_DTC2278_PIO_MODE code from dtc2278
>> * remove legacy debugging code from ht6560b
>
>> There should be no functional changes caused by this patch.
>
>> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
>
> [...]
>
>> Index: b/drivers/ide/ali14xx.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- a/drivers/ide/ali14xx.c
>> +++ b/drivers/ide/ali14xx.c
>> @@ -7,32 +7,7 @@
>> =A0 *
>> =A0 * Works for ALI M1439/1443/1445/1487/1489 chipsets.
>> =A0 *
>> - * Adapted from code developed by derekn@vw.ece.cmu.edu. =A0-ml
>> - * Derek's notes follow:
>> - *
>> - * I think the code should be pretty understandable,
>> - * but I'll be happy to (try to) answer questions.
>> - *
>> - * The critical part is in the setupDrive function. =A0The initRegi=
sters
>> - * function doesn't seem to be necessary, but the DOS driver does i=
t, so
>> - * I threw it in.
>> - *
>> - * I've only tested this on my system, which only has one disk. =A0=
I posted
>> - * it to comp.sys.linux.hardware, so maybe some other people will t=
ry it
>> - * out.
>> - *
>> - * Derek Noonburg =A0(derekn@ece.cmu.edu)
>> - * 95-sep-26
>> - *
>> - * Update 96-jul-13:
>> - *
>> - * I've since upgraded to two disks and a CD-ROM, with no trouble, =
and
>> - * I've also heard from several others who have used it successfull=
y.
>> - * This driver appears to work with both the 1443/1445 and the 1487=
/1489
>> - * chipsets. =A0I've added support for PIO mode 4 for the 1487. =A0=
This
>> - * seems to work just fine on the 1443 also, although I'm not sure =
it's
>> - * advertised as supporting mode 4. =A0(I've been running a WDC AC2=
1200 in
>> - * mode 4 for a while now with no trouble.) =A0-Derek
>> + * Adapted from code developed by Derek Noonburg<derekn@vw.ece.cmu.=
edu>.
>> =A0-
>> ml
>
> =A0 The patch is line-wrapped...

[...]

> =A0 And above...

Sorry for that,  I somehow managed to not notice it until now..
(ah, the joys of fresh OS installation)..
