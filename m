From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 1/2] ide-tape: change IDE_AFLAG_IGNORE_DSC non-atomically
Date: Tue, 2 Jun 2009 15:08:27 +0200
Message-ID: <9ea470500906020608o14f8bc8dwaedabff70c1cb707@mail.gmail.com>
References: <1243926308-32385-1-git-send-email-petkovbb@gmail.com>
	 <1243926308-32385-2-git-send-email-petkovbb@gmail.com>
	 <200906021218.33787.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:43724 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbZFBNI0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jun 2009 09:08:26 -0400
In-Reply-To: <200906021218.33787.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 2, 2009 at 12:18 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:

=2E.

>> --- a/drivers/ide/ide-tape.c
>> +++ b/drivers/ide/ide-tape.c
>> @@ -656,15 +656,24 @@ static ide_startstop_t idetape_do_request(ide_=
drive_t *drive,
>>
>> =A0 =A0 =A0 if ((drive->dev_flags & IDE_DFLAG_DSC_OVERLAP) =3D=3D 0 =
&&
>> =A0 =A0 =A0 =A0 =A0 (rq->cmd[13] & REQ_IDETAPE_PC2) =3D=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 set_bit(IDE_AFLAG_IGNORE_DSC, &drive->atap=
i_flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 drive->atapi_flags |=3D IDE_AFLAG_IGNORE_D=
SC;
>>
>> =A0 =A0 =A0 if (drive->dev_flags & IDE_DFLAG_POST_RESET) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 set_bit(IDE_AFLAG_IGNORE_DSC, &drive->atap=
i_flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 drive->atapi_flags |=3D IDE_AFLAG_IGNORE_D=
SC;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 drive->dev_flags &=3D ~IDE_DFLAG_POST_RE=
SET;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 if (!test_and_clear_bit(IDE_AFLAG_IGNORE_DSC, &drive->atap=
i_flags) &&
>> - =A0 =A0 =A0 =A0 (stat & ATA_DSC) =3D=3D 0) {
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* This is a precaution for IDE_AFLAG_IGNORE_DSC being c=
onditionally set
>> + =A0 =A0 =A0* above. We don't need a stronger enforcement of orderi=
ng because the
>> + =A0 =A0 =A0* read below cannot precede the earlier write out-of-or=
der since it is
>> + =A0 =A0 =A0* to the same location. Also, since we have the ide por=
t locked during
>> + =A0 =A0 =A0* the ->do_request(), we only have to be aware of gcc r=
eordering stuff.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 barrier();
>
> Are you seeing a real problem with gcc here? =A0No sane compiler shou=
ld need
> a barrier() here (we would probably need zillions of them in kernel i=
f it
> really does).

No, this is just a precaution. The asm I checked looked fine but since
the flag is set and right afterwards checked, it will be bad if this
somehow got reordered. I actually haven't checked whether anything like
that would be possible, at all.

--=20
Regards/Gruss,
Boris
