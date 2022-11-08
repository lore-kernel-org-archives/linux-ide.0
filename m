Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A530BC433FE
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 07:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiKHHNn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiKHHNm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 02:13:42 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4C42EF52
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 23:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667891621; x=1699427621;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eo5Ossivt2NINgP0U1LKva2jpqv1jOLKaA9iTwBQEDE=;
  b=RSyEkRADULWVJ04p8mpQjlqQKvs8SXdjGgauy8wiwkk0GA9qEDrUobi0
   vNf4ORa6Y+WKSw/mdcUX3CCJ6g2bbeGx/L0cU43xU2uf0L/evZyFNYuh7
   u6bgwxT4yQzC4nDL1SiSk4Bwz46OOA26Ltlfk2ClUAM1jxtzLiD80o1Lu
   hipDoGkQiik+OfZGm9YWHtqkS24RmQVSGJHhm5H1Hs4VYfJZ1jzXy5+uK
   2xi8JDuY4eBnzHcPS0Abz4UTiAwajqyErLTRtSHYl81K9UJWeF139CL8S
   Uq+hEXTUgrvk4gBGY7u39Zh130U3YS9ONi+h91gw9C7IBpcBy2/nzZo9M
   A==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="220894878"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 15:13:41 +0800
IronPort-SDR: ibV8lGc6NbKCcxgPWSjHQXxYgl0ssN2Wi7u5EdYa8hxD3oMp1HH6giOltUMNz240aPJt0gZGDE
 //oTAcX4zfts1o/EfQ92E9ngUiN4vPgXfEaRUVaW28wqPHR/BT14fNxxgem1enHLq2TYqSwrD3
 IynAHrPqIGgy1QnYXUOR6B2JrjKoxTS3z7vPtHmoT4ZQCU/8llDDw8kNU8BYytIN/HTf4mq1zm
 pswrdeChLoy2CCZTgzq5YGnLeP09cVBRDrIVvRYj+iayUqlApuXyo6uh3vjeTmNoQ2rwBZU+VF
 SOM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:27:02 -0800
IronPort-SDR: Ss9WR3/DNv9WLb/algdbRcA4WIh0IZAzHiGMx6DvJ8H+LdF1lXLBH1zOhmaLyUR/7hUudynfzs
 r2m4u6Ko9bAxhnizS3808AMq0LjOtVONep0eVN//J/oR2iTQczlJfTjenNhjp93YiOdJYGG7oW
 EMxa4oN/R50nxQLjwoZ7LzBcoH77v2oJnu4IkwTTo36vEE8ulNzavc4+mLzLQTlKBdYqGJvkB/
 ZGvW0eeWf4FCheSbIerf0kG5/3G5JnXAMcYz5kte91gum5vagwMRF606tOMy6fSYFsA0SETVVw
 KJY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 23:13:41 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5zpq326mz1Rwrq
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 23:13:39 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667891618; x=1670483619; bh=eo5Ossivt2NINgP0U1LKva2jpqv1jOLKaA9
        iTwBQEDE=; b=esP8QHjJM1BCaV9+/bf7hGciQMGhBqFNK454sPEz5MylrZnWeLd
        Fc0OGZIFg7Rc2KwTZJov656xuefZ5SMFdAVPDnYa7sYKp2UnBe90dP99SVfW/V8R
        GCnLqvEbWZEsaVUfEqwD4RJxdGUTDGPwFjtzicow8RjcMtFLcnFCXKe7LzURFynM
        4n+eMBR1akJeWR0ujAVWMdkT3ahfOBedWTd5L7O1vS3g3p+wiHYWUeP8FNxFYPZg
        FMbDuhJH3N5/ASPXNxAS5UFfzCs9n9S5Eg2/CDJaJgsYRLHltfZoSWcTKVsRIFX3
        MANpy4Fpav1xpkNLsEFXoJq/Qs1Vm5CVuTQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jTDfo00NX68s for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 23:13:38 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5zpn3wSgz1RvLy;
        Mon,  7 Nov 2022 23:13:37 -0800 (PST)
Message-ID: <2c36f5ca-d7c7-ccd9-a6d3-72c677345c34@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 16:13:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] ata: libata-core: do not issue non-internal commands
 once EH is pending
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        John Garry <john.g.garry@oracle.com>
Cc:     "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20221107161036.670237-1-niklas.cassel@wdc.com>
 <5a4fa5db-c706-5cf2-1145-bf091445d20e@oracle.com>
 <Y2mbX8MvYrF0FHaI@x1-carbon> <00204846-726c-7fbc-fc4b-43ac432500f8@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <00204846-726c-7fbc-fc4b-43ac432500f8@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/8/22 16:10, Hannes Reinecke wrote:
> On 11/8/22 00:57, Niklas Cassel wrote:
>> On Mon, Nov 07, 2022 at 05:01:53PM +0000, John Garry wrote:
>>> On 07/11/2022 16:10, Niklas Cassel wrote:
>>>> scsi_queue_rq() will check if scsi_host_in_recovery() (state is
>>>> SHOST_RECOVERY), and if so, it will _not_ issue a command via:
>>>> scsi_dispatch_cmd() -> host->hostt->queuecommand()
>>>> (ata_scsi_queuecmd())
>>>> -> __ata_scsi_queuecmd() -> ata_scsi_translate() -> ata_qc_issue()
>>>>
>>>> Before commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
>>>> when receiving a TFES error IRQ, this was the call chain:
>>>> ahci_error_intr() -> ata_port_abort() -> ata_do_link_abort() ->
>>>> ata_qc_complete() -> ata_qc_schedule_eh() -> blk_abort_request() ->
>>>> blk_rq_timed_out() -> q->rq_timed_out_fn() (scsi_times_out()) ->
>>>> scsi_eh_scmd_add() -> scsi_host_set_state(shost, SHOST_RECOVERY)
>>>>
>>>> Which meant that as soon as the error IRQ was serviced, no additiona=
l
>>>> commands sent from the block layer (scsi_queue_rq()) would be sent d=
own
>>>> to the device. (ATA internal commands originating for ATA EH could o=
f
>>>> course still be sent.)
>>>>
>>>> However, after commit e494f6a72839 ("[SCSI] improved eh timeout
>>>> handler"),
>>>> scsi_times_out() would instead result in a call to
>>>> scsi_abort_command() ->
>>>> queue_delayed_work(). work function: scmd_eh_abort_handler() would c=
all
>>>> scsi_eh_scmd_add(), which calls scsi_host_set_state(shost,
>>>> SHOST_RECOVERY).
>>>>
>>>> (It was possible to get the old behavior if host->hostt->no_async_ab=
ort
>>>> was set, but libata never used it, and this option was completely
>>>> removed
>>>> in commit a06586325f37 ("scsi: make asynchronous aborts mandatory"))
>>>>
>>>> Additionally, later in commit 358f70da49d7 ("blk-mq: make
>>>> blk_abort_request() trigger timeout path"), blk_abort_request() was
>>>> changed
>>>> to also call the abort callback asynchronously.
>>>>
>>>> So now, after the TFES error irq has been serviced, we need to wait =
for
>>>> two different workqueues to run their work, before the SHOST_RECOVER=
Y
>>>> state gets set.
>>>>
>>>> While the ATA specification states that a device should return comma=
nd
>>>> aborted for all commands queued after the device has entered error
>>>> state,
>>>> since ATA only keeps the sense data for the latest command (in non-N=
CQ
>>>> case), we really don't want to send block layer commands to the devi=
ce
>>>> after it has entered error state. (Only ATA EH commands should be se=
nt,
>>>> to read the sense data etc.)
>>>>
>>>> While we could just call scsi_host_set_state(shost, SHOST_RECOVERY)
>>>> from
>>>> ata_qc_schedule_eh() directly, that might be a layering violation.
>>>> So instead of doing that, add an additional check against the
>>>> libata's own
>>>> EH flag(s) before calling the qc_defer callback.
>>>>
>>>> Fixes: e494f6a72839 ("[SCSI] improved eh timeout handler")
>>>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>>>> ---
>>>> Changes since v1:
>>>> -Implemented review comments from Damien.
>>>>
>>>> =C2=A0=C2=A0 drivers/ata/libata-scsi.c | 20 ++++++++++++++++++++
>>>> =C2=A0=C2=A0 1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>>> index 4cb914103382..383a208f5f99 100644
>>>> --- a/drivers/ata/libata-scsi.c
>>>> +++ b/drivers/ata/libata-scsi.c
>>>> @@ -1736,6 +1736,26 @@ static int ata_scsi_translate(struct
>>>> ata_device *dev, struct scsi_cmnd *cmd,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xlat_func(qc))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto ea=
rly_finish;
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * scsi_queue_rq() will defer commands when=
 in state
>>>> SHOST_RECOVERY.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * When getting an error interrupt, ata_por=
t_abort() will be
>>>> called,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * which ends up calling ata_qc_schedule_eh=
() on all QCs.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ata_qc_schedule_eh() will call ata_eh_se=
t_pending() and then
>>>> call
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * blk_abort_request() on the given QC. blk=
_abort_request() will
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * asynchronously end up calling scsi_eh_sc=
md_add(), which will
>>>> set
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the state to SHOST_RECOVERY and wake up =
SCSI EH.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * In order to avoid requests from being is=
sued to the device
>>>> from the
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * time ata_eh_set_pending() is called, to =
the time
>>>> scsi_eh_scmd_add()
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * sets the state to SHOST_RECOVERY, we def=
er requests here as
>>>> well.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (ap->pflags & (ATA_PFLAG_EH_PENDING |
>>>> ATA_PFLAG_EH_IN_PROGRESS)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D ATA_DEFER_LINK;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto defer;
>>>
>>> Could we move this check earlier? I mean, we didn't need to have the =
qc
>>> alloc'ed and xlat'ed for this check to be done, right?
>>
>> Sure, we could put it in e.g. ata_scsi_queuecmd() or
>> __ata_scsi_queuecmd().
>>
>>
>> Or, perhaps it is just time to accept that ATA EH is so interconnected
>> with
>> SCSI EH, so the simplest thing is just to do:
>>
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -913,6 +913,7 @@ void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qc->flags |=3D=
 ATA_QCFLAG_FAILED;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ata_eh_set_pending(ap=
, 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scsi_host_set_state(ap->scsi_hos=
t, SHOST_RECOVERY);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The followi=
ng will fail if timeout has already expired.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ata_scsi_erro=
r() takes care of such scmds on EH entry.
>>
>>
>> Which appears to work just as well as the patch in $subject.
>>
>> In commit ee7863bc68fa ("[PATCH] SCSI: implement
>> shost->host_eh_scheduled")
>> Tejun mentioned that "... libata is planning to depart from SCSI, so,
>> for the
>> time being, libata will be using SCSI EH to handle such exceptions."
>>
>> Now, 16 years later, ATA is still using SCSI EH (see
>> ata_port_schedule_eh() and
>> ata_std_sched_eh()) to schedule EH in the case when there are no QCs
>> to abort:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/ata/libata-eh.c?h=3Dv6.1-rc4#n1004
>>
>> Damien, thoughts?
>=20
> Yeah, that was the original idea. By the time libata was designed we
> still had quite a lot of drivers in drivers/ide, and it wasn't quite
> clear if managing everything via SATL was the way to go.
> So one idea was to allow libata to become stand-alone, and SATL working
> as a modular interface on top of libata.
> However, this never materialized, as everyone was quite happy having to
> deal with SCSI devices only, even if that meant to go via an additional
> layer of interpolation.
>=20
> With the introduction of libsas this idea became even more dubious, as
> libsas really called for a _tighter_ integration with SCSI.
> Plus ATA in general seems to be heading into the sunset, so I sincerely
> doubt anyone really wants to head that way.
>=20
> In fact, with the recent patches we should finally drop the pretension
> that libata will ever be standalone, and concentrate on making it more
> aligned with SCSI.

So you are saying you prefer the fix proposed by Niklas above, calling
scsi_host_set_state() from libata ? I feel OK-ish about it... But if it
is called in the right place, why not.

>=20
> Cheers,
>=20
> Hannes

--=20
Damien Le Moal
Western Digital Research

