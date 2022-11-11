Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7568C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 11 Nov 2022 08:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiKKIzb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Nov 2022 03:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiKKIza (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2022 03:55:30 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A1CF5AA
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 00:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668156928; x=1699692928;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PU77J7LZ/t/WN3p02lZ0aEAPJliCIhed95otFDMM5v0=;
  b=jXiHTiFiHLKuvYqU0TvqcCOgy31t1W3BGX/dIrP60qmedVgThlAGgmkR
   uINVPAKeE02Q3kWH4mKGqqESmoPtUecMQH/9oMQNmdW37/b+/KnCnqTZ0
   AIUVohm4WRIkAFEmlZGSwqlw/np+ZgdB7s1uzTDZip+egNYwN3x8ThWLz
   WoPwFLrK66bK8ykDnd9cNscojK8aETw/28EnJW1yYUgZh48EcBo5VmfT9
   FLOiq4VLnesKF9bewgUJZRHX4lYfgmlwNTUFFeIzYp7ogSm5s0s9aH/zj
   32928b2Pio48eiYi1jE2H1F07TJkqip/WMim9BQwVNEP/m5HLdssy9f5E
   w==;
X-IronPort-AV: E=Sophos;i="5.96,156,1665417600"; 
   d="scan'208";a="216040678"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2022 16:55:27 +0800
IronPort-SDR: JIOgMsvEQSyO6ceKy3L6eFkE3/J6XnLJoNtSPpBSsMWjoY21lEiwyxtzgms3sMjPpi/Nk9hpzs
 ARWqJPFo6gDGe03zDMKW89inwO0eSnTf4vIkSYG4578n50ZwID5s8ESGg1wJy+JEwHmF256zz4
 idkR8gL5PeJ6GDpSzFCNJtU9wRSsSqyVnXaPIYkMqGtm2DZenI+VrS34DVx+wzdqAtFerG6Ws1
 1Xx/LRioHsOMq1cwSXwu4nvYE4DwRTO1VE01IrUCbOxKdEqrxHV1IOWxQZw2fnoaZ8MjsYQ+1L
 I9k=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 00:14:30 -0800
IronPort-SDR: tKk49b3GRHWXXNxIfGQ0onfEWrb46DcULuchw6pzWbEYfoY1MezQTjPslgZFg7NaxBkUeKs/6l
 81aBh6lXjg/pY+dPQ9e+2f/8dXY7dlb11wwA1QUJIzFHLvywDAUBvXh2UsxnetRHdq3iKaiyC/
 6XEnBzvSbQS/DMUzh1zWaILZIOERoqK5U9WSVMlakNQG+DcCLRuym/YjINxaVC+Oi/Z4Z8ke2c
 RjuedXcL5VYIdcvnZ1glOJl1Y0gArwbP5OztQNdP8mchDWGkTzHiY5sYtmtWJkxZ3obXDTe+Ih
 JMk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 00:55:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N7swv2mJ8z1Rwrq
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 00:55:27 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668156926; x=1670748927; bh=PU77J7LZ/t/WN3p02lZ0aEAPJliCIhed95o
        tFDMM5v0=; b=idi1L+3EgkOPdqUDcU/NdNcLYKw1KUQIdmx3GVVoo3Zx8DA87BH
        yRxSbCgYXEXfp1cNgBTtllYwec/dqDH3Y2jFJNC8m23b+hkR6WMoB+sj9ExTZYrq
        wVseLeNmwllNfL9CFOWf4aeURlMbfyf0Lu/DkJfrFIs7+AcinX7B8hmQHb9LKj+F
        dJemO64Cu6Bb9lhxKFY7+R4L9c4CyhsGtdM5ShRLhnWtXhkBAMn4CXnQ/9UBEYhF
        9J5V/UpONy+XHCYyWuckw7P7h2tGYEO2mb8DRpK9QCe+utO+K38KG1LsoQ9lnVhn
        CACnFolZpWKjZIR+L9Qso7Sf0LPFzERByAg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d6mlVDC08Mh4 for <linux-ide@vger.kernel.org>;
        Fri, 11 Nov 2022 00:55:26 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N7swt1VMyz1RvLy;
        Fri, 11 Nov 2022 00:55:26 -0800 (PST)
Message-ID: <8a9a84da-13fc-04e9-ec23-807933b616e4@opensource.wdc.com>
Date:   Fri, 11 Nov 2022 17:55:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3] ata: libata-core: do not issue non-internal commands
 once EH is pending
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>, tj@kernel.org, hare@suse.de
Cc:     linux-ide@vger.kernel.org
References: <20221108231534.982516-1-niklas.cassel@wdc.com>
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

Applied to for-6.1-fixes. Thanks !

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
>  	if (unlikely(!scmd->cmd_len))
>  		goto bad_cdb_len;
>  

-- 
Damien Le Moal
Western Digital Research

