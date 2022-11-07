Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D93C433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 13:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKGNkH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Nov 2022 08:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiKGNkG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Nov 2022 08:40:06 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3511B78D
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 05:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667828404; x=1699364404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VgCvCmU6RzyIAkO2mAoNtQnEKhZVXAWr3RvJvvWvs7A=;
  b=rz6udvTHFdZ18Novfn+3rPGEMwklACmIwr+5OF3GMkSNNRPfQksH+5C6
   W+e2qvF/lXMuDzMVDaiJ7rgxZm2yAsoGLK3ljo4Gst5TslxMT9fdzqZu+
   f2wMuxRmoXg2MKbyWYXPLS60iO2JpjfQkgT00ort8im2phPCzplcH8npc
   pskuflnQ+C4rI2PcUT9KPJr8bl5+uUbKcBEdRBUyQFNSj5+rm0hAf6oCW
   qOUHJ+5chYEPtAD1a2DicPwzo7Z34MROKft7IFLd5xsUwe4RGYWzNLBbi
   QHfBX3oHHUPqsOsdxp/Qb8CP83ePJA7Yh+sLVVPstVMUc5i6AwnUazZ9w
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="213953028"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 21:40:02 +0800
IronPort-SDR: YvxkJoNzanMpL0b78LnjZtZwwFfU1YdCgcxekVnS9oTMCGd402sR4pyQT5AObUF/koqLWnARdF
 vIoQ25Q1hyId+YcUHepfMJBLFr1Eckfoj34O53dWqivIVJwZcQHTduZjADjGhd0RbpiaH6/QL+
 Cs163NpKGCVsZZCPWTrNYpAJCgoDklwQ0cFLgxFl8AUPLoAPs+806Bo75dgdHPACpxwteC9S+b
 DsTuvFgUHnrgDlhhncPXg+truULBdToDxxIy5mCwHhTndgNRVLDVQIX2xi9CV1GQSngsaooZ4u
 dgw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 04:53:25 -0800
IronPort-SDR: a1dmvFsA4wdSCDiYqTzu7HS0eArWv6UXdGOmqbwWNIvhrh/6GUZBwkaf8ABQ1JQ04dw9TEZXSp
 /sw6hEP8gnBmU5LkvYmJAhb44wQOf6Mn8oKja/r04TEtncNq0fkVripudLb/FIy3u5bR+YDp01
 rr6Y3o4xV0fpOfumrMHhiJAdHAKN7BQIRbNoR0tU7dI0pViLeM143mYvMmlWmrk1SvAKcxFVaj
 PdBMkqs4rD+y0V/jK0lLr+v4bXKlJPdA/40WAAHKdgln1RTWzjNVPAN4qYhZJSuyEdqnp4JU5t
 1H4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 05:40:03 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5XR64Cp3z1RvTp
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 05:40:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667828402; x=1670420403; bh=VgCvCmU6RzyIAkO2mAoNtQnEKhZVXAWr3Rv
        JvvWvs7A=; b=hOtDePoRFC6duRkZZ1EMOCeagSEP9bWxm0BUF7CYxrbldzcL/Gq
        GKNOYvwxd9HSHA0u++dQRltlNLd7RJlqmQ8zl6h2GqodHhMPmWT6ikmEQ+rrnS/D
        0uF2JZrrPT35FQSEcb+tYBgEJ8yauE+53aeHnHFArtTZ3G2oxmB87NE7yT7oR0vJ
        dLSLHbULpRn+LDYmJz0G1Vz+zat1eDf1JX+FEP74O0L/BUz36M+6SnbyOlj7ETte
        g6e+f1ScvARuD6FD0j3gr7yPfaOgnNYJEnF5sCHQUHWa0IfKRZohUAa62X+0p+/n
        29aN9GP7KedBtmunn9Qlxa1QvsZ+VPf0jvg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id At4gsp-W78wI for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 05:40:02 -0800 (PST)
Received: from [10.225.163.31] (unknown [10.225.163.31])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5XR52h1qz1RvLy;
        Mon,  7 Nov 2022 05:40:01 -0800 (PST)
Message-ID: <961ce72b-5374-3dbe-8515-2032779d8844@opensource.wdc.com>
Date:   Mon, 7 Nov 2022 22:40:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] ata: libata-core: do not issue non-internal commands once
 EH is pending
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>, tj@kernel.org, hare@suse.de
Cc:     linux-ide@vger.kernel.org
References: <20221107095104.625519-1-niklas.cassel@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221107095104.625519-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/7/22 18:51, Niklas Cassel wrote:
> scsi_queue_rq() will check if scsi_host_in_recovery() (state is
> SHOST_RECOVERY), and if so, it will _not_ issue a command via:
> scsi_dispatch_cmd() -> host->hostt->queuecommand() (ata_scsi_queuecmd())
> -> __ata_scsi_queuecmd() -> ata_scsi_translate() -> ata_qc_issue()
> 
> Before commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
> when receiving a TFES error IRQ, this is the call chain:
> ahci_error_intr() -> ata_port_abort() -> ata_do_link_abort() ->
> ata_qc_complete() -> ata_qc_schedule_eh() -> blk_abort_request() ->
> blk_rq_timed_out() -> q->rq_timed_out_fn() (scsi_times_out()) ->
> scsi_eh_scmd_add() -> scsi_host_set_state(shost, SHOST_RECOVERY)
> 
> Which meant that as soon as the error IRQ was serviced, no additional
> commands sent from the block layer (scsi_queue_rq()) would be sent
> down to the device. (ATA internal commands originating for ATA EH
> could of course still be sent.)
> 
> However, after commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
> scsi_times_out() would instead result in a call to scsi_abort_command() ->
> queue_delayed_work(). work function: scmd_eh_abort_handler() would call
> scsi_eh_scmd_add(), which calls scsi_host_set_state(shost, SHOST_RECOVERY).
> 
> (It was possible to get the old behavior if host->hostt->no_async_abort
> was set, but libata never used it, and this option was completely removed
> in commit a06586325f37 ("scsi: make asynchronous aborts mandatory"))
> 
> Additionally, later in commit 358f70da49d7 ("blk-mq: make
> blk_abort_request() trigger timeout path") blk_abort_request() was changed
> to also call the abort callback asynchronously.
> 
> Tejun mentioned that:
> "Note that this makes blk_abort_request() asynchronous - it initiates
> abortion but the actual termination will happen after a short while,
> even when the caller owns the request.  AFAICS, SCSI and ATA should be
> fine with that and I think mtip32xx and dasd should be safe but not
> completely sure."
> 
> So now, after the TFES irq has been serviced, we need to wait for two
> different workqueues to run their work, before the SHOST_RECOVERY state
> gets set.
> 
> While the ATA specification states that a device should return command
> aborted for all commands queued after the device has entered error state,
> since ATA only keeps the sense data for the latest command (in non-NCQ
> case), we really don't want to send block layer commands to the device
> after it has entered error state. (Only ATA EH commands should be sent,
> to read the sense data etc.)
> 
> While we could just call scsi_host_set_state(shost, SHOST_RECOVERY) from
> ata_qc_schedule_eh() directly, that smells like a layering violation,
> So instead of doing that, add an additional check against the libata's
> own EH flag(s) in the existing qc_defer callback.
> 
> Fixes: e494f6a72839 ("[SCSI] improved eh timeout handler")
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  drivers/ata/libata-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 884ae73b11ea..ab6c69be3d4a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4458,6 +4458,9 @@ int ata_std_qc_defer(struct ata_queued_cmd *qc)
>  {
>  	struct ata_link *link = qc->dev->link;
>  

The check looks OK but I think it is in the wrong function. Not all
drivers use ata_std_qc_defer(). Some implement their own. So to avoid
leaking this check depending on the LLD, I think it should be done from
the only place where ->qc_defer method is called: ata_scsi_translate().

Also, it would be nice to add a comment above the check explaining
(ideally shortly) why it is done.

> +	if (qc->ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS))
> +		return ATA_DEFER_LINK;
> +
>  	if (ata_is_ncq(qc->tf.protocol)) {
>  		if (!ata_tag_valid(link->active_tag))
>  			return 0;

-- 
Damien Le Moal
Western Digital Research

