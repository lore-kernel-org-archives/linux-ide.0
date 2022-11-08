Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7BBC433FE
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 03:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiKHDuw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Nov 2022 22:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiKHDuv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Nov 2022 22:50:51 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239262DABA
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 19:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667879449; x=1699415449;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zWCZlBV0Du560Hsw2iMyyo75APBF5iv+MkGPs81UfQQ=;
  b=cvCsNHQ+MnQdF9q3N82dz5mStt/eEaTgKKr1nSSYpFD/yAGu0gYJZRry
   LMyFRDciyPvfnPs5E2wIfYliINIGBor7w3pW5hdGZmfQ/NLJlUTG74ZSb
   zTc/lmvB19ur+nMMAKZemNGEk83ykU1ImINpNrLtpVou5rqNA5dYnLi5c
   D5c+xgftPQPnjdy1setbMYghpCFBoUIhg9FlXSLMrK3tFSgS9my7vTr5k
   I1gLH6aCWIJW3RwY04cu1yCB4VXgOvYaL30GN+6d67Yhi82/zUcwqOCoR
   osuzSx0DYnU2pVG7+dVO/mBQDHTSI4OarN5dd7TCQ0xglsklTdRcFFcuQ
   w==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="327823949"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 11:50:49 +0800
IronPort-SDR: MrgXa9B/emWgpwEXAuRVcVzLvyQLmU5voDJUhM2tliheImFdVgW5C3YpLV0Uyda2T2+RoOzaqO
 Xik3C46C+PJX1CYzTPkH5iVwLe0NsOkMeJnRloS/gkQJ0D9Z4WHHIm31vQSSITRSVhH35Aj9rB
 bhdZYj02slILHeGbadtQqQrqDQz3uGx8WEC9RysmRA8mIoIz5BiLjobKD1MaUKQBL4HFu30abp
 qIpdXvffSKJ8rtcKmFD5qvbMPtj4ywVZLdJ6V1NPiJjmU7H2QtOKLskbKUvQDh4n0GjF9dUt4x
 mXc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 19:04:10 -0800
IronPort-SDR: NzTAJIXn7xH/g9qGRhVlVH22mn3dN5+vFKpDqH7JSPVV3xyNaBadlwjBHf0MgaUZO/0RPtHhgy
 b+yFBS8o6SZV75RsLns/hFf9Z2BmTj/b1ZmMeDw7RQHppRtWERzukXkFsrZW4qA8iUiMnX5FbV
 gDzJc0ItLld1AiNY4I5elVCTkTWccNuMQavtoDAGIcoGUaxCBptKM+XdFbPlHedo5KzLrxQMuI
 b/hERfP0XKbWay4cAxS7HswIx64Q/bnoEIW1OyKwbGBjfThKM15m7T40gfh5hsnCTHDvYbrpML
 WrU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 19:50:49 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5vJm4kWSz1RvTp
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 19:50:48 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667879447; x=1670471448; bh=zWCZlBV0Du560Hsw2iMyyo75APBF5iv+MkG
        Ps81UfQQ=; b=QCilGdrE2aqDwoWOvbH52jTJfkeMCBflDkaj0Js77GIbKVdlBcw
        tR5EWa9P2qVUoQYhuPLk6tBtnY13AY1/6UFMKIfdVNamHY7Aryi3FY26Mu30sn8j
        vuDIHLkJHIqLI70cC/VoIXrY3H1mherXZTE1gj3YnCAGPnwNXO8gVCvV+tAGCYZr
        kCnh0ivYjfQ0WkwGYTX6XWXW9UonMiSNE6UDebYNeoa62jXggA4T3A6f6FagFwkt
        nYYtie9usTK87JbsVd6HQSq7fDhpRgGiMdeMy/UJOP9Zh0Xg4Pc43oDoPxNe/unC
        2htXozfsunTwF4QYCRZ61lUAszCClE/XufQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wppdwPShKPbL for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 19:50:47 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5vJk311nz1RvLy;
        Mon,  7 Nov 2022 19:50:46 -0800 (PST)
Message-ID: <976bdcb7-cb97-9332-2bcc-5d98bc41871b@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 12:50:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] ata: libata-core: do not issue non-internal commands
 once EH is pending
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        John Garry <john.g.garry@oracle.com>
Cc:     "tj@kernel.org" <tj@kernel.org>, "hare@suse.de" <hare@suse.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20221107161036.670237-1-niklas.cassel@wdc.com>
 <5a4fa5db-c706-5cf2-1145-bf091445d20e@oracle.com>
 <Y2mbX8MvYrF0FHaI@x1-carbon>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y2mbX8MvYrF0FHaI@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


+ linux-scsi, Martin and James

On 11/8/22 08:57, Niklas Cassel wrote:
> On Mon, Nov 07, 2022 at 05:01:53PM +0000, John Garry wrote:
>> On 07/11/2022 16:10, Niklas Cassel wrote:
>>> scsi_queue_rq() will check if scsi_host_in_recovery() (state is
>>> SHOST_RECOVERY), and if so, it will _not_ issue a command via:
>>> scsi_dispatch_cmd() -> host->hostt->queuecommand() (ata_scsi_queuecmd())
>>> -> __ata_scsi_queuecmd() -> ata_scsi_translate() -> ata_qc_issue()
>>>
>>> Before commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
>>> when receiving a TFES error IRQ, this was the call chain:
>>> ahci_error_intr() -> ata_port_abort() -> ata_do_link_abort() ->
>>> ata_qc_complete() -> ata_qc_schedule_eh() -> blk_abort_request() ->
>>> blk_rq_timed_out() -> q->rq_timed_out_fn() (scsi_times_out()) ->
>>> scsi_eh_scmd_add() -> scsi_host_set_state(shost, SHOST_RECOVERY)
>>>
>>> Which meant that as soon as the error IRQ was serviced, no additional
>>> commands sent from the block layer (scsi_queue_rq()) would be sent down
>>> to the device. (ATA internal commands originating for ATA EH could of
>>> course still be sent.)
>>>
>>> However, after commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
>>> scsi_times_out() would instead result in a call to scsi_abort_command() ->
>>> queue_delayed_work(). work function: scmd_eh_abort_handler() would call
>>> scsi_eh_scmd_add(), which calls scsi_host_set_state(shost, SHOST_RECOVERY).
>>>
>>> (It was possible to get the old behavior if host->hostt->no_async_abort
>>> was set, but libata never used it, and this option was completely removed
>>> in commit a06586325f37 ("scsi: make asynchronous aborts mandatory"))
>>>
>>> Additionally, later in commit 358f70da49d7 ("blk-mq: make
>>> blk_abort_request() trigger timeout path"), blk_abort_request() was changed
>>> to also call the abort callback asynchronously.
>>>
>>> So now, after the TFES error irq has been serviced, we need to wait for
>>> two different workqueues to run their work, before the SHOST_RECOVERY
>>> state gets set.
>>>
>>> While the ATA specification states that a device should return command
>>> aborted for all commands queued after the device has entered error state,
>>> since ATA only keeps the sense data for the latest command (in non-NCQ
>>> case), we really don't want to send block layer commands to the device
>>> after it has entered error state. (Only ATA EH commands should be sent,
>>> to read the sense data etc.)
>>>
>>> While we could just call scsi_host_set_state(shost, SHOST_RECOVERY) from
>>> ata_qc_schedule_eh() directly, that might be a layering violation.
>>> So instead of doing that, add an additional check against the libata's own
>>> EH flag(s) before calling the qc_defer callback.
>>>
>>> Fixes: e494f6a72839 ("[SCSI] improved eh timeout handler")
>>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>>> ---
>>> Changes since v1:
>>> -Implemented review comments from Damien.
>>>
>>>   drivers/ata/libata-scsi.c | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>> index 4cb914103382..383a208f5f99 100644
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>>> @@ -1736,6 +1736,26 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>>>   	if (xlat_func(qc))
>>>   		goto early_finish;
>>> +	/*
>>> +	 * scsi_queue_rq() will defer commands when in state SHOST_RECOVERY.
>>> +	 *
>>> +	 * When getting an error interrupt, ata_port_abort() will be called,
>>> +	 * which ends up calling ata_qc_schedule_eh() on all QCs.
>>> +	 *
>>> +	 * ata_qc_schedule_eh() will call ata_eh_set_pending() and then call
>>> +	 * blk_abort_request() on the given QC. blk_abort_request() will
>>> +	 * asynchronously end up calling scsi_eh_scmd_add(), which will set
>>> +	 * the state to SHOST_RECOVERY and wake up SCSI EH.
>>> +	 *
>>> +	 * In order to avoid requests from being issued to the device from the
>>> +	 * time ata_eh_set_pending() is called, to the time scsi_eh_scmd_add()
>>> +	 * sets the state to SHOST_RECOVERY, we defer requests here as well.
>>> +	 */
>>> +	if (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS)) {
>>> +		rc = ATA_DEFER_LINK;
>>> +		goto defer;
>>
>> Could we move this check earlier? I mean, we didn't need to have the qc
>> alloc'ed and xlat'ed for this check to be done, right?
> 
> Sure, we could put it in e.g. ata_scsi_queuecmd() or __ata_scsi_queuecmd().
> 
> 
> Or, perhaps it is just time to accept that ATA EH is so interconnected with
> SCSI EH, so the simplest thing is just to do:
> 
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -913,6 +913,7 @@ void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
>  
>         qc->flags |= ATA_QCFLAG_FAILED;
>         ata_eh_set_pending(ap, 1);
> +       scsi_host_set_state(ap->scsi_host, SHOST_RECOVERY);

Why put this in this function ? Nothing in ata_qc_schedule_eh() calls
scsi_schedule_eh() or scsi_eh_scmd_add(), which set that state.
It looks like ata_port->ops->sched_eh(), that is, ata_std_sched_eh(),
would be a better place for this.

>  
>         /* The following will fail if timeout has already expired.
>          * ata_scsi_error() takes care of such scmds on EH entry.
> 
> 
> Which appears to work just as well as the patch in $subject.
> 
> In commit ee7863bc68fa ("[PATCH] SCSI: implement shost->host_eh_scheduled")
> Tejun mentioned that "... libata is planning to depart from SCSI, so, for the
> time being, libata will be using SCSI EH to handle such exceptions."
> 
> Now, 16 years later, ATA is still using SCSI EH (see ata_port_schedule_eh() and
> ata_std_sched_eh()) to schedule EH in the case when there are no QCs to abort:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-eh.c?h=v6.1-rc4#n1004
> 
> Damien, thoughts?

I like this simpler fix better, but it does introduce a risk of (again)
having problems with ata EH if scsi EH trigger/timing is changed.
Unlikely now, but as this fix proves, not unheard of.

The v2 change is fine too, modulo John's suggestion, which I agree with.
At least it is consistent with the ata internal eh state accounting, so
self contained within libata and somewhat less dependent on scsi state
machine.

Martin ? James ? Thoughts ?

-- 
Damien Le Moal
Western Digital Research

