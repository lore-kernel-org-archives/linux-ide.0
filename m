Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C90C433FE
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 07:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiKHHKV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiKHHKU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 02:10:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B3A19003
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 23:10:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0972822492;
        Tue,  8 Nov 2022 07:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667891417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1Zc9+1FcPge/NJtlOtsmYnEzy43hL4VkJ9kMBFNHqI=;
        b=s5Tfjauj80sC0nfFHF/WRFIQYCdKoViFcqowxoWgwDMCjZN0HSoYd+EDUMB8//TPMpkFGL
        0Z74jflHB/gOeJxro+zWUwKIr5VpwX7OBn1hqHdM4RCNtbPfImq6vgv1DO3JsUEmFUm5E4
        kAQ0hrZCND1Q4cFf10g6VZ0ZcBIYBak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667891417;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1Zc9+1FcPge/NJtlOtsmYnEzy43hL4VkJ9kMBFNHqI=;
        b=gS0BHppwGKhR1LhHoyAQoN3ut4SGarh/TepGC+ntgjPQDkOCdrmXjYC9V189oKtGERTLO9
        1+rx1w46x+TBbpBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB16A139F1;
        Tue,  8 Nov 2022 07:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VSJoNNgAamM7JgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 08 Nov 2022 07:10:16 +0000
Message-ID: <00204846-726c-7fbc-fc4b-43ac432500f8@suse.de>
Date:   Tue, 8 Nov 2022 08:10:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] ata: libata-core: do not issue non-internal commands
 once EH is pending
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        John Garry <john.g.garry@oracle.com>
Cc:     "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20221107161036.670237-1-niklas.cassel@wdc.com>
 <5a4fa5db-c706-5cf2-1145-bf091445d20e@oracle.com>
 <Y2mbX8MvYrF0FHaI@x1-carbon>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <Y2mbX8MvYrF0FHaI@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/8/22 00:57, Niklas Cassel wrote:
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
>>>    drivers/ata/libata-scsi.c | 20 ++++++++++++++++++++
>>>    1 file changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>> index 4cb914103382..383a208f5f99 100644
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>>> @@ -1736,6 +1736,26 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>>>    	if (xlat_func(qc))
>>>    		goto early_finish;
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
>          qc->flags |= ATA_QCFLAG_FAILED;
>          ata_eh_set_pending(ap, 1);
> +       scsi_host_set_state(ap->scsi_host, SHOST_RECOVERY);
>   
>          /* The following will fail if timeout has already expired.
>           * ata_scsi_error() takes care of such scmds on EH entry.
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

Yeah, that was the original idea. By the time libata was designed we 
still had quite a lot of drivers in drivers/ide, and it wasn't quite 
clear if managing everything via SATL was the way to go.
So one idea was to allow libata to become stand-alone, and SATL working 
as a modular interface on top of libata.
However, this never materialized, as everyone was quite happy having to 
deal with SCSI devices only, even if that meant to go via an additional 
layer of interpolation.

With the introduction of libsas this idea became even more dubious, as 
libsas really called for a _tighter_ integration with SCSI.
Plus ATA in general seems to be heading into the sunset, so I sincerely 
doubt anyone really wants to head that way.

In fact, with the recent patches we should finally drop the pretension 
that libata will ever be standalone, and concentrate on making it more 
aligned with SCSI.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

