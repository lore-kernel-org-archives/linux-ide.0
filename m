From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] ata: Clean up hard coded array size calculation.
Date: Fri, 20 Nov 2009 17:15:29 -0200
Message-ID: <a4c8a6d00911201115s276bb2a7i2a2c546356b71842@mail.gmail.com>
References: <1257708657-1232-1-git-send-email-tfransosi@gmail.com>
	 <4B0215E3.2020400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:41332 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027AbZKTTPZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Nov 2009 14:15:25 -0500
In-Reply-To: <4B0215E3.2020400@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jeff,

On Tue, Nov 17, 2009 at 1:17 AM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On 11/08/2009 02:30 PM, Thiago Farina wrote:
>>
>> Use ARRAY_SIZE macro of kernel api instead.
>>
>> Signed-off-by: Thiago Farina<tfransosi@gmail.com>
>> ---
>> =C2=A0drivers/ata/sata_mv.c | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>> index 6f5093b..a8a7be0 100644
>> --- a/drivers/ata/sata_mv.c
>> +++ b/drivers/ata/sata_mv.c
>> @@ -2217,7 +2217,7 @@ static unsigned int mv_qc_issue_fis(struct
>> ata_queued_cmd *qc)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D 0;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ata_tf_to_fis(&qc->tf, link->pmp, 1, (voi=
d *)fis);
>> - =C2=A0 =C2=A0 =C2=A0 err =3D mv_send_fis(ap, fis, sizeof(fis) / si=
zeof(fis[0]));
>> + =C2=A0 =C2=A0 =C2=A0 err =3D mv_send_fis(ap, fis, ARRAY_SIZE(fis))=
;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)
>
> applied

Was it applied to this tree
http://git.kernel.org/?p=3Dlinux/kernel/git/jgarzik/libata-dev.git?
