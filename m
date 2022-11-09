Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71ABC4332F
	for <linux-ide@archiver.kernel.org>; Wed,  9 Nov 2022 05:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiKIFPl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Nov 2022 00:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKIFPc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Nov 2022 00:15:32 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D88C1C11A
        for <linux-ide@vger.kernel.org>; Tue,  8 Nov 2022 21:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667970930; x=1699506930;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tOuxJaQdW/boWeu2J4JWWqL3wfdBgB7LuinUER3cNaQ=;
  b=EQJzdr7hSkFSE9XIK5+BurhIkhb+BVXLjaw2c2ohq6PA5Hy6Vh1HKG/z
   /TzhdRhX6hpluJYKHo+cTkXikhpuWfgh+CBVzZMk39f43aOJt9Y4aXCIe
   opeUGNS4ZRIx9hzMPLtK8a9gb2Cxu1JSifqrIAwK9/WtDx1W7t9tZTal4
   2w6MJ+uBMU8XVo95Xy1PW7n0kNAZveBJzcir8NBIyDeRs5vCydBTXF6go
   HagV/zc/MlcDhmjdpw+Va8Zq8TDP43qITwUJLIN0YXAdPpRW9QZL/vzNL
   mAhvkNW9eL8o2dTK+UZDqep6vv60r6MSy9ylVH5tRhcY/VtmWtEb6Engl
   w==;
X-IronPort-AV: E=Sophos;i="5.96,149,1665417600"; 
   d="scan'208";a="327928266"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2022 13:15:29 +0800
IronPort-SDR: aYEIDYolHAYyzn1gpND0Y/cKd7IGju7jlNgEBD9fkFu3opsZLaXUolHN2gv2Spvw45N5XLr5XL
 uxXEx4ccQw2o09KKkk63rAMvLX9/ZuNLbQOj/gyfGdAHyzZ3nqq5+PLMSYqBnbeW8UIfdSVU0s
 P++cLUg70SbOglj7X0cxavuD3BqQQQqJlRqIAysvF+itO6HkQS1O2uTOckgIQrajz0cCuZH011
 Dv6djKdptESWgvhRwA52Ye1tg65hoBSBPA+ydDI4zYAJ/JlNo1rClwT6brMR/ER1Las5BOu6j3
 C7A=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2022 20:28:50 -0800
IronPort-SDR: TntrxGox7yyk/ikhsLbW9O7I77xQXUktP731oSYGrGmh/1aLpy6z0GNkuYg6S1lFmg6/v6Uj8N
 IxFtTJFXJhUIgjMUTpRU0kcR9NJ9lswuZ4+0P9vdSYplyAfs0qqKWaJ7n6iaEWegBI2KJf7BMA
 2WHwtivjZ8JQd6vUAu/y6KX1z4V3Izm0CKJraHnBQKAs6gSzERdWALe+MoLzIaoGUB7ZqnrDPR
 jW6VgxjZpNwx8wDBWNVSmcVYp2P17YZglYQlUu+FC7BJ0CoXujSdbfR0T48grAQaA4xSYtFAyj
 1O4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2022 21:15:30 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N6Y805mlpz1RwqL
        for <linux-ide@vger.kernel.org>; Tue,  8 Nov 2022 21:15:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667970928; x=1670562929; bh=tOuxJaQdW/boWeu2J4JWWqL3wfdBgB7Luin
        UER3cNaQ=; b=hJCWKbClg8g7sBU6GjE+kO3xWNQJ1NcJZBB/xAUcRml2a7sNeD1
        WaSGy7Hvd5UIV83AC5pKGtmJM1Rahkjs74ZOj793rDUU3SRW3Fn9JjmdIKllOMtx
        iP/WgoQKbWvd4PvzrsCjKqThRPqyQ4PGsrmlcaeXLkvmbvBWwCLL6KhDAkKh0EMj
        wS1JrKfZH8BIVYcANVjiKRR6R1NEVRRWn4051VDunKx2YBCYGlLI2eBaAj8e+ULN
        CWZ5q7OqQ8xz5pOqQXujeslfXZy77C++MacWDrRlG2UiXpI+0PjYTIQ9bIn+kSGi
        ia1Vo8VjuEtsQN3er8++7b3p7TmGduJpJVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RuxH1Yflgd5W for <linux-ide@vger.kernel.org>;
        Tue,  8 Nov 2022 21:15:28 -0800 (PST)
Received: from [10.225.163.37] (unknown [10.225.163.37])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N6Y7z2TcKz1RvLy;
        Tue,  8 Nov 2022 21:15:27 -0800 (PST)
Message-ID: <5b63945b-b12c-480c-3b3d-cea9420d08d4@opensource.wdc.com>
Date:   Wed, 9 Nov 2022 14:15:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3] ata: libata-core: do not issue non-internal commands
 once EH is pending
To:     Niklas Cassel <niklas.cassel@wdc.com>, tj@kernel.org, hare@suse.de,
        John Garry <john.g.garry@oracle.com>
Cc:     linux-ide@vger.kernel.org
References: <20221108231534.982516-1-niklas.cassel@wdc.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221108231534.982516-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/9/22 08:15, Niklas Cassel wrote:
> While the ATA specification states that a device should return command
> aborted for all commands queued after the device has entered error state,
> since ATA only keeps the sense data for the latest command (in non-NCQ
> case), we really don't want to send block layer commands to the device
> after it has entered error state. (Only ATA EH commands should be sent,
> to read the sense data etc.)
> 
> Currently, scsi_queue_rq() will check if scsi_host_in_recovery()
> (state is SHOST_RECOVERY), and if so, it will _not_ issue a command via:
> scsi_dispatch_cmd() -> host->hostt->queuecommand() (ata_scsi_queuecmd())
> -> __ata_scsi_queuecmd() -> ata_scsi_translate() -> ata_qc_issue()
> 
> Before commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
> when receiving a TFES error IRQ, the call chain looked like this:
> ahci_error_intr() -> ata_port_abort() -> ata_do_link_abort() ->
> ata_qc_complete() -> ata_qc_schedule_eh() -> blk_abort_request() ->
> blk_rq_timed_out() -> q->rq_timed_out_fn() (scsi_times_out()) ->
> scsi_eh_scmd_add() -> scsi_host_set_state(shost, SHOST_RECOVERY)
> 
> Which meant that as soon as an error IRQ was serviced, SHOST_RECOVERY
> would be set.
> 
> However, after commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
> scsi_times_out() will instead call scsi_abort_command() which will queue
> delayed work, and the worker function scmd_eh_abort_handler() will call
> scsi_eh_scmd_add(), which calls scsi_host_set_state(shost, SHOST_RECOVERY).
> 
> So now, after the TFES error IRQ has been serviced, we need to wait for
> the SCSI workqueue to run its work before SHOST_RECOVERY gets set.
> 
> It is worth noting that, even before commit e494f6a72839 ("[SCSI] improved
> eh timeout handler"), we could receive an error IRQ from the time when
> scsi_queue_rq() checks scsi_host_in_recovery(), to the time when
> ata_scsi_queuecmd() is actually called.
> 
> In order to handle both the delayed setting of SHOST_RECOVERY and the
> window where we can receive an error IRQ, add a check against
> ATA_PFLAG_EH_PENDING (which gets set when servicing the error IRQ),
> inside ata_scsi_queuecmd() itself, while holding the ap->lock.
> (Since the ap->lock is held while servicing IRQs.)
> 
> Fixes: e494f6a72839 ("[SCSI] improved eh timeout handler")
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
> Changes since v2:
> -Improve commit message and the comment inside the code.
> -Move the check to __ata_scsi_queuecmd().
> 
>  drivers/ata/libata-scsi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 4cb914103382..93ebcdf2e354 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3978,9 +3978,19 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
>  
>  int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
>  {
> +	struct ata_port *ap = dev->link->ap;
>  	u8 scsi_op = scmd->cmnd[0];
>  	ata_xlat_func_t xlat_func;
>  
> +	/*
> +	 * scsi_queue_rq() will defer commands if scsi_host_in_recovery().
> +	 * However, this check is done without holding the ap->lock (a libata
> +	 * specific lock), so we can have received an error irq since then,
> +	 * therefore we must check if EH is pending, while holding ap->lock.
> +	 */
> +	if (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS))
> +		return SCSI_MLQUEUE_DEVICE_BUSY;
> +

I prefer this to the scsi recovery state approach.

John,

Can you test this with libsas ?


>  	if (unlikely(!scmd->cmd_len))
>  		goto bad_cdb_len;
>  

-- 
Damien Le Moal
Western Digital Research

