From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 21/20] ata_piix: add new PIIX_FLAG_* flags
Date: Tue, 8 Feb 2011 19:18:12 +0100
Message-ID: <AANLkTikyV579TRSMw_g_rTB7C641fWbdSELP9mpa30bG@mail.gmail.com>
References: <201102081652.36752.bzolnier@gmail.com>
	<4D51796C.8020008@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36039 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173Ab1BHSSN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 13:18:13 -0500
In-Reply-To: <4D51796C.8020008@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi,

On Tue, Feb 8, 2011 at 6:12 PM, Sergei Shtylyov <sshtylyov@mvista.com> =
wrote:
> Hello.
>
> Bartlomiej Zolnierkiewicz wrote:
>
>> Turn open-coded checks in piix_set_timings() into PIIX_FLAG_* flags
>> per suggestion from Alan Cox.
>
>> Suggested-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>
> [...]
>
>> Index: b/drivers/ata/ata_piix.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- a/drivers/ata/ata_piix.c
>> +++ b/drivers/ata/ata_piix.c
>> @@ -133,6 +133,8 @@ enum {
>> =A0 =A0 =A0 =A0PIIX_FLAG_CHECKINTR =A0 =A0 =3D (1 << 28), /* make su=
re PCI INTx enabled
>> */
>> =A0 =A0 =A0 =A0PIIX_FLAG_SIDPR =A0 =A0 =A0 =A0 =3D (1 << 29), /* SAT=
A idx/data pair regs */
>> + =A0 =A0 =A0 PIIX_FLAG_NO_SITRE =A0 =A0 =A0=3D (1 << 30), /* no SIT=
RE register */
>
> =A0 The register in question is called SIDETIM, SITRE is a bit that e=
nables
> its use.

ICH4-M databook that I have at hand (Intel IDE PRM seems to be gone
from Intel's website, though I'm sure I have a backup _somewhere_) it
is called SLV_IDETIM so lets just stick with the current naming for
now..

Thanks,
Bartlomiej
