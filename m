Return-Path: <SRS0=k6T0=EJ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478F7C2D0A3
	for <linux-ide@archiver.kernel.org>; Tue,  3 Nov 2020 08:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F96206E3
	for <linux-ide@archiver.kernel.org>; Tue,  3 Nov 2020 08:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKCIXj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Nov 2020 03:23:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7451 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCIXj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 Nov 2020 03:23:39 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CQN8V14GWzhg8B;
        Tue,  3 Nov 2020 16:23:22 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 16:23:12 +0800
Subject: Re: [PATCH] libata: Increase the timeout of command
 ATA_CMD_READ_LOG_DMA_EXT
To:     <axboe@kernel.dk>, <tj@kernel.org>
References: <1602727060-200435-1-git-send-email-chenxiang66@hisilicon.com>
CC:     <john.garry@huawei.com>, <linux-ide@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <5cb24632-20b1-86aa-8cf1-851c8ec85f35@hisilicon.com>
Date:   Tue, 3 Nov 2020 16:23:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1602727060-200435-1-git-send-email-chenxiang66@hisilicon.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


ÔÚ 2020/10/15 9:57, chenxiang Ð´µÀ:
> From: Xiang Chen <chenxiang66@hisilicon.com>
>
> ATA_CMD_READ_LOG_DMA_EXT command normally uses the common internal command
> default timeout (5s), and it is adequate in most situations. But it is not
> enough for some disks such as ST4000NM0035 which causes qc timeout
> sometimes as follows:
> ...
> [  157.284284] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
> [  157.290124] sas: ata8: end_device-4:0:2: dev error handler
> [  157.290128] sas: ata9: end_device-4:0:8: dev error handler
> [  157.290131] sas: ata10: end_device-4:0:11: dev error handler
> [  164.588391] ata9.00: qc timeout (cmd 0x47)
> [  164.588393] ata8.00: qc timeout (cmd 0x47)
> [  164.588395] ata10.00: qc timeout (cmd 0x47)
> [  166.582572] ata10.00: READ LOG DMA EXT failed, trying PIO
> [  166.587960] ata10.00: NCQ Send/Recv Log not supported
> [  166.592997] ata10.00: ATA-10: ST4000NM0035-1V4107, TN03, max UDMA/133
> [  166.599414] ata10.00: 7814037168 sectors, multi 0: LBA48 NCQ (depth 32)
> [  166.606011] ata10.00: failed to set xfermode (err_mask=0x40)
> [  166.659253] ata8.00: READ LOG DMA EXT failed, trying PIO
> [  166.664559] ata8.00: NCQ Send/Recv Log not supported
> [  166.669506] ata8.00: ATA-10: ST4000NM0035-1V4107, TN03, max UDMA/133
> [  166.675837] ata8.00: 7814037168 sectors, multi 0: LBA48 NCQ (depth 32)
> [  166.682343] ata8.00: failed to set xfermode (err_mask=0x40)
> [  166.743458] ata9.00: READ LOG DMA EXT failed, trying PIO
> [  166.748765] ata9.00: NCQ Send/Recv Log not supported
> [  166.753713] ata9.00: ATA-10: ST4000NM0035-1V4107, TN03, max UDMA/133
> [  166.760045] ata9.00: 7814037168 sectors, multi 0: LBA48 NCQ (depth 32)
> [  166.766553] ata9.00: failed to set xfermode (err_mask=0x40)
> [  168.886378] ata10.00: configured for UDMA/133
> [  168.999943] ata8.00: configured for UDMA/133
> [  169.050801] ata9.00: configured for UDMA/133
> [  169.055071] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
> ...
> Actually it may takes about 9s to complete the command for disk ST4000NM0035
> sometimes. So to avoid the issue, increase the timeout of command
> ATA_CMD_READ_LOG_DMA_EXT from 5s to 15s.
>
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> Reviewed-by: John Garry <john.garry@huawei.com>

Hi Jens, do you have any idea about this patch?

> ---
>   drivers/ata/libata-eh.c | 9 +++++++++
>   include/linux/libata.h  | 2 +-
>   2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 474c6c3..6db9474 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -100,6 +100,13 @@ static const unsigned long ata_eh_flush_timeouts[] = {
>   	ULONG_MAX,
>   };
>   
> +static const unsigned long ata_eh_read_log_ext_timeouts[] = {
> +	15000,
> +	15000,
> +	30000,
> +	ULONG_MAX,
> +};
> +
>   static const unsigned long ata_eh_other_timeouts[] = {
>   	 5000,	/* same rationale as identify timeout */
>   	10000,	/* ditto */
> @@ -139,6 +146,8 @@ ata_eh_cmd_timeout_table[ATA_EH_CMD_TIMEOUT_TABLE_SIZE] = {
>   	  .timeouts = ata_eh_other_timeouts, },
>   	{ .commands = CMDS(ATA_CMD_FLUSH, ATA_CMD_FLUSH_EXT),
>   	  .timeouts = ata_eh_flush_timeouts },
> +	{ .commands = CMDS(ATA_CMD_READ_LOG_DMA_EXT, ATA_CMD_READ_LOG_EXT),
> +	  .timeouts = ata_eh_read_log_ext_timeouts },
>   };
>   #undef CMDS
>   
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index b0bd30e..bcc68b3 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -390,7 +390,7 @@ enum {
>   	/* This should match the actual table size of
>   	 * ata_eh_cmd_timeout_table in libata-eh.c.
>   	 */
> -	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 6,
> +	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 7,
>   
>   	/* Horkage types. May be set by libata or controller on drives
>   	   (some horkage may be drive/controller pair dependent */


