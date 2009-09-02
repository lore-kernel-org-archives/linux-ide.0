From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] Do not send RW commands to locked disks.
Date: Wed, 2 Sep 2009 14:43:35 -0700
Message-ID: <e7510f760909021443m26bee6b9y660f0c5fad89c705@mail.gmail.com>
References: <1251851285-9159-1-git-send-email-gwendal@google.com>
	 <4A9DCCC6.6040102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:27565 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbZIBVng convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Sep 2009 17:43:36 -0400
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id n82LhcFs002634
	for <linux-ide@vger.kernel.org>; Wed, 2 Sep 2009 14:43:38 -0700
Received: from pxi7 (pxi7.prod.google.com [10.243.27.7])
	by wpaz5.hot.corp.google.com with ESMTP id n82LhZjs014630
	for <linux-ide@vger.kernel.org>; Wed, 2 Sep 2009 14:43:36 -0700
Received: by pxi7 with SMTP id 7so1137570pxi.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Sep 2009 14:43:35 -0700 (PDT)
In-Reply-To: <4A9DCCC6.6040102@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

You have a point, but setting the flag LOCKED when an error happen
will mean that a braindead device [which always trigger
ata_id_locked()] will work until an internal disk error happens; that
will make debugging difficult.
Instead, I am working on adding the provision for a blacklist to allow
bad devices to bypass the test.

Gwendal.

On Tue, Sep 1, 2009 at 6:39 PM, Tejun Heo<tj@kernel.org> wrote:
> Gwendal Grignou wrote:
>> Send a Read/Write command to a locked disk triggers the error handle=
r.
>> Given the disk returns a generic device error code, the error handle=
r can come
>> to the conclusion of reducing the link speed, which is bad.
>> Also, if drives are still locked at boot, this fix speeds up the boo=
t process
>> by returning errors without invoquing the error handler thread.
>>
>> Signed-off-by: Gwendal Grignou <gwendal@google.com>
>> ---
>> =A0drivers/ata/libata-core.c | =A0 =A02 ++
>> =A0drivers/ata/libata-scsi.c | =A0 =A06 ++++++
>> =A0include/linux/ata.h =A0 =A0 =A0 | =A0 =A03 +++
>> =A03 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 072ba5e..3f80570 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -5023,6 +5023,8 @@ void ata_qc_complete(struct ata_queued_cmd *qc=
)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qc->tf.feature !=
=3D SETFEATURES_WC_OFF)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fall through */
>> + =A0 =A0 =A0 =A0 =A0 =A0 case ATA_CMD_SEC_UNLOCK: /* Read/Write acc=
ess now work */
>> + =A0 =A0 =A0 =A0 =A0 =A0 case ATA_CMD_SEC_ERASE_UNIT: /* Read/Write=
 access now work */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case ATA_CMD_INIT_DEV_PARAMS: /* CHS tra=
nslation changed */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case ATA_CMD_SET_MULTI: /* multi_count c=
hanged */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* revalidate device */
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index d0dfeef..8a41767 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -1658,6 +1658,12 @@ static unsigned int ata_scsi_rw_xlat(struct a=
ta_queued_cmd *qc)
>> =A0 =A0 =A0 u32 n_block;
>> =A0 =A0 =A0 int rc;
>>
>> + =A0 =A0 if (unlikely(ata_id_locked(qc->dev->id))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Terminate RW commands early when the di=
sk is locked */
>> + =A0 =A0 =A0 =A0 =A0 =A0 ata_scsi_set_sense(scmd, ABORTED_COMMAND, =
0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 if (cdb[0] =3D=3D WRITE_10 || cdb[0] =3D=3D WRITE_6 || c=
db[0] =3D=3D WRITE_16)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tf_flags |=3D ATA_TFLAG_WRITE;
>
> Hmmm... how sure are we that there aren't some braindead devices whic=
h
> incorrectly would trigger the ata_id_locked() condition? =A0I think i=
t
> would be safer to have an extra DFLAG, say ATA_DFLAG_LOCKED which get=
s
> set when EH detects unknown device error && ata_id_locked(); then, in
> the issue path, we can do
>
> =A0 =A0 =A0 =A0if (ATA_DFLAG_LOCKED is set) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ata_id_locked())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Terminate early;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Clear ATA_DFLAG_LOCKED=
;
> =A0 =A0 =A0 =A0}
>
> Thanks.
>
> --
> tejun
>
