From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 3/3] ide-{cd,floppy}: do not map all cmds to an sg
Date: Thu, 5 Mar 2009 14:53:28 +0100
Message-ID: <9ea470500903050553m6ab9dfa5hab340213388a4c67@mail.gmail.com>
References: <1236158216-23052-1-git-send-email-petkovbb@gmail.com>
	 <1236158216-23052-4-git-send-email-petkovbb@gmail.com>
	 <200903051312.29784.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.178]:16524 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbZCENxb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Mar 2009 08:53:31 -0500
In-Reply-To: <200903051312.29784.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 5, 2009 at 1:12 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
>
> Hi,
>
> On Wednesday 04 March 2009, Borislav Petkov wrote:
>> ... since some do not transfer any data from the drive and
>> rq->buffer is unset leading to an OOPS when checking VM translations
>> (CONFIG_DEBUG_VIRTUAL).
>>
>> Tested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
>
> Thanks for fixing it but I worry that the patch is not entirely corre=
ct
> (why o why did you have to throw in unrelated changes...?)

What unrelated changes? This is the ide-cd fix for when mapping a NULL
rq->buffer pointer to an sg. If you mean the [2/3] patch, I had to
remove the partial completions for ide-floppy because it was OOPSing on=
 NULL
rq-pointer in the interrupt handler. I sent you a pretty detailed OOPS =
along
with backtracking to the offending code line, remember? Also, for reaso=
ns of
bisectability.

> also ideally there should have been two patches:
> - minimal bugfix for the buggy patch
> - unification/cleanup of PIO sg setup
>
>> ---
>> =A0drivers/ide/ide-atapi.c =A0| =A0 =A09 ++++++++-
>> =A0drivers/ide/ide-cd.c =A0 =A0 | =A0 =A04 ----
>> =A0drivers/ide/ide-floppy.c | =A0 =A04 ----
>> =A03 files changed, 8 insertions(+), 9 deletions(-)
>>

=2E.

>> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
>> index 091d414..106cacb 100644
>> --- a/drivers/ide/ide-cd.c
>> +++ b/drivers/ide/ide-cd.c
>> @@ -916,10 +916,6 @@ static ide_startstop_t ide_cd_do_request(ide_dr=
ive_t *drive, struct request *rq,
>>
>> =A0 =A0 =A0 cmd.rq =3D rq;
>>
>> - =A0 =A0 ide_init_sg_cmd(&cmd,
>> - =A0 =A0 =A0 =A0 =A0 =A0 blk_fs_request(rq) ? (rq->nr_sectors << 9)=
 : rq->data_len);
>> - =A0 =A0 ide_map_sg(drive, &cmd);
>> -
>> =A0 =A0 =A0 return ide_issue_pc(drive, &cmd);
>> =A0out_end:
>> =A0 =A0 =A0 nsectors =3D rq->hard_nr_sectors;
>> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
>> index 2f8f453..b91deef 100644
>> --- a/drivers/ide/ide-floppy.c
>> +++ b/drivers/ide/ide-floppy.c
>> @@ -281,10 +281,6 @@ static ide_startstop_t ide_floppy_do_request(id=
e_drive_t *drive,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.tf_flags |=3D IDE_TFLAG_WRITE;
>>
>> =A0 =A0 =A0 cmd.rq =3D rq;
>> -
>> - =A0 =A0 ide_init_sg_cmd(&cmd, pc->req_xfer);
>
> There was a reason for using ->req_xfer.

Yeah, this is also one of those painful places where I cringe everytime=
 I have
to look at. We finally have to sit down and decide which is which; some=
times
pc->req_xfer _is_ rq->data_len (idefloppy_blockpc_cmd()) and sometimes =
obviously
not. I'll take a look at that whole mess next and try to come up with s=
omething
more clean.

> I don't see where rq->data_len is set for REQ_TYPE_SPECIAL requests
> (ide_queue_pc_tail() and friends)?

me neither :(.

>> - =A0 =A0 ide_map_sg(drive, &cmd);
>> -
>> =A0 =A0 =A0 pc->rq =3D rq;
>>
>> =A0 =A0 =A0 return ide_floppy_issue_pc(drive, &cmd, pc);

Man, this sucks!

--=20
Regards/Gruss,
Boris
