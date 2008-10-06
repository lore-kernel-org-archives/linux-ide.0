From: "Gwendal Grignou" <gwendal@google.com>
Subject: [PATH 0/2] [sata_mv] enable FIS Based Switching when a Port Multiplier is connected
Date: Sun, 5 Oct 2008 18:07:40 -0700
Message-ID: <e7510f760810051807kcfb6099r4a3ea4934a2ad499@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:50374 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbYJFBHz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Oct 2008 21:07:55 -0400
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id m9617hFJ013991
	for <linux-ide@vger.kernel.org>; Mon, 6 Oct 2008 02:07:44 +0100
Received: from fg-out-1718.google.com (fgg19.prod.google.com [10.86.7.19])
	by zps37.corp.google.com with ESMTP id m9617fbW006534
	for <linux-ide@vger.kernel.org>; Sun, 5 Oct 2008 18:07:42 -0700
Received: by fg-out-1718.google.com with SMTP id 19so1949950fgg.42
        for <linux-ide@vger.kernel.org>; Sun, 05 Oct 2008 18:07:40 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

This patchset enabled FBS in 2 steps:
- add a flag in libata to allow storing ATA task file [tf] while still
on the data path. Today tf is retrieve during error handling, so the
driver must store it somewhere or the HBA operation must have stopped.
- enable FBS in sata_mv.

Thanks Tejun for the review, my comments inline.

Gwendal.

On Sat, Oct 4, 2008 at 12:19 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Gwendal.
>
> Patch was line wrapped.  Can you please repost?
Sure.
>
> Gwendal Grignou wrote:
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 79e3a8e..fcc7ce2 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -4607,8 +4607,11 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
>>  {
>>       struct ata_port *ap = qc->ap;
>>
>> -     qc->result_tf.flags = qc->tf.flags;
>> -     ap->ops->qc_fill_rtf(qc);
>> +     if ((qc->flags & ATA_QCFLAG_RTF_VALID) == 0) {
>> +             qc->result_tf.flags = qc->tf.flags;
>> +             qc->flags |= ATA_QCFLAG_RTF_VALID;
>> +             ap->ops->qc_fill_rtf(qc);
>> +     }
>>  }
>
> Please separate out RTF_VALID changes into a separate patch and if
> possible please update other LLDs too.  I think I posted RTF_VALID
> patch sometime ago and it probably contains changes for other drivers.
I am not sure other drivers needs it. It is not necessary when NCQ is disabled.
(ATA devices have a special log for NCQ where they store the ATA
registers of the first
offending command).
>
>>  static void ata_verify_xfer(struct ata_queued_cmd *qc)
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index c1db2f2..b5d753e 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -1518,6 +1518,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
>>       memcpy(&qc->result_tf, &tf, sizeof(tf));
>>       qc->result_tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
>>       qc->err_mask |= AC_ERR_DEV | AC_ERR_NCQ;
>> +     qc->flags |= ATA_QCFLAG_RTF_VALID;
>>       ehc->i.err_mask &= ~AC_ERR_DEV;
>>  }
>
> Ditto.
>
>> @@ -1642,23 +1643,24 @@ static void mv_pmp_error_handler(struct ata_port *ap)
>>       struct mv_port_priv *pp = ap->private_data;
>>
>>       if (pp->pp_flags & MV_PP_FLAG_DELAYED_EH) {
>> -             /*
>> -              * Perform NCQ error analysis on failed PMPs
>> -              * before we freeze the port entirely.
>> -              *
>> -              * The failed PMPs are marked earlier by mv_pmp_eh_prep().
>> -              */
>> -             pmp_map = pp->delayed_eh_pmp_map;
>>               pp->pp_flags &= ~MV_PP_FLAG_DELAYED_EH;
This line is the only one remaining.

>> -             for (pmp = 0; pmp_map != 0; pmp++) {
>> -                     unsigned int this_pmp = (1 << pmp);
>> -                     if (pmp_map & this_pmp) {
>> -                             struct ata_link *link = &ap->pmp_link[pmp];
>> -                             pmp_map &= ~this_pmp;
>> -                             ata_eh_analyze_ncq_error(link);
>> +             if (pp->pp_flags & MV_PP_FLAG_NCQ_EN) {
>> +                     /*
>> +                      * Perform NCQ error analysis on failed PMPs
>> +                      * before we freeze the port entirely.
>> +                      *
>> +                      * The failed PMPs are marked earlier by mv_pmp_eh_prep().
>> +                      */
>> +                     pmp_map = pp->delayed_eh_pmp_map;
>> +                     for (pmp = 0; pmp_map != 0; pmp++) {
>> +                             unsigned int this_pmp = (1 << pmp);
>> +                             if (pmp_map & this_pmp) {
>> +                                     struct ata_link *link = &ap->pmp_link[pmp];
>> +                                     pmp_map &= ~this_pmp;
>> +                                     ata_eh_analyze_ncq_error(link);
>> +                             }
>
> I don't have much idea what's going on here but it looks like
> DELAYED_EH clearing is gone.  Is this intended?
See above, it is the only one remaining...
>
> I'll try to review deeper on your next posting.  If I can tell it's
> gonna be okay, I'll include it into #tj-upstream.  Don't depend on it
> as I don't know much about sata_mv but Mark will be away for several
> more weeks, so I'll try my best but if I can't tell whether it's okay
> or not I'll put it into a separate branch and push it to #linux-next.
>
> Thanks.
>
> --
> tejun
>
