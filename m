Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280601C32
	for <linux-ide@vger.kernel.org>; Mon,  4 Nov 2024 04:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730692892; cv=none; b=fwRifvAwp1ICMFrpaFmPNKBbVKCE8wi511PKtZr5wFs2xZL/JaspjzHpHwZxj++Ss85JHYVmsf+HVBzQl1PUSKKBA8CU2XuumvrnFZixMqckzxisMoHpqAihZr6qHTKVYtTtMHQrFAXURHbLgnyw6NpBuGbHRNk++g5urDzXx7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730692892; c=relaxed/simple;
	bh=xpF6iu04ICW0+Uaa7l793nzTnrz7TJgikBkzA1T2a9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mAtj6F7cQ3Wu10oqEL6LxbQU7pSvQC5QpzpJzgGbYuu1156/DnWQrkkPJzPBrVQIJFQv+7L4o5SCpnCsMBAWxR714cjUXllwGqJHauIbBi9C9iPNvQsYDJE1VG7qCXggJGhXihdu35l6K6PewEitvL2Afw+djU/6zMGr3pz1xDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xhd4l0TWkz10PX2;
	Mon,  4 Nov 2024 11:59:03 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 55D1618007C;
	Mon,  4 Nov 2024 12:01:20 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Nov 2024 12:01:19 +0800
Message-ID: <baceec65-ad60-f8e5-f417-0316c19a0234@huawei.com>
Date: Mon, 4 Nov 2024 12:01:19 +0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/2] ata: libata: Issue non-NCQ command via EH when NCQ
 commands in-flight
Content-Language: en-CA
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
CC: Hannes Reinecke <hare@suse.de>, Yu Kuai <yukuai1@huaweicloud.com>,
	<linux-ide@vger.kernel.org>
References: <20241031140731.224589-4-cassel@kernel.org>
 <20241031140731.224589-6-cassel@kernel.org>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <20241031140731.224589-6-cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepemh100015.china.huawei.com (7.202.181.101) To
 kwepemg100017.china.huawei.com (7.202.181.58)

Hi, Niklas

On 2024/10/31 22:07, Niklas Cassel wrote:
> libata is responsible to ensure that NCQ and non-NCQ commands are not mixed
> in the command list for the same device.
> 
> This is handled using the .qc_defer callback (ata_std_qc_defer()), which
> will defer a non-NCQ command as long as there are NCQ commands in flight.
> 
> The problem is that if an application is continuously submitting NCQ
> commands (e.g. fio with a queue depth greater than 1), this can completely
> starve out another application that is sending a non-NCQ command (because
> the non-NCQ command will be deferred forever).
> 
> Solve this by triggering EH if there are NCQ commands in flight when a
> non-NCQ is submitted. If EH is scheduled, no new commands will be accepted,
> and EH will wake up when there are no commands in flight. We will then
> submit the non-NCQ command from EH context, and synchronously wait for the
> completion. When EH is finished, libata will continue to accept new
> commands like normal.
> 
> Reported-by: Xingui Yang <yangxingui@huawei.com>
> Closes: https://lore.kernel.org/linux-block/eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com/
> Suggested-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-core.c | 169 +++++++++++++++++++++++++++++++++++---
>   drivers/ata/libata-eh.c   |  60 +++++++++++++-
>   drivers/ata/libata-scsi.c |  16 +++-
>   drivers/ata/libata.h      |   1 +
>   include/linux/libata.h    |   7 +-
>   5 files changed, 237 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 2b7d265e4a7b..c53de1d3baba 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1633,6 +1633,134 @@ unsigned int ata_exec_internal(struct ata_device *dev, struct ata_taskfile *tf,
>   	return err_mask;
>   }
>   
> +/**
> + *	ata_issue_via_eh - issue non-NCQ command via EH synchronously
> + *	@qc: command to issue to device
> + *
> + *	Issues a non-NCQ command via EH and waits for completion. @qc contains
> + *	the command on entry and the result on return. Timeout and error
> + *	conditions are reported via the return value. No recovery action is
> + *	needed, since flag ATA_QCFLAG_EH is set on entry and on exit, so in case
> + *	of error, EH will clean it up during ata_eh_finish().
> + *
> + *	LOCKING:
> + *	None.  Should be called with kernel context, might sleep.
> + *
> + *	RETURNS:
> + *	Zero on success, AC_ERR_* mask on failure
> + */
> +unsigned int ata_issue_via_eh(struct ata_queued_cmd *qc)

After testing, the issues we encountered were resolved.

But the kernel prints the following log:

[246993.392832] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
[246993.392839] sas: ata5: end_device-4:0: cmd error handler
[246993.392855] sas: ata5: end_device-4:0: dev error handler
[246993.392860] sas: ata6: end_device-4:3: dev error handler
[246993.392863] sas: ata7: end_device-4:4: dev error handler
[246993.606491] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1 
tries: 1

And because the current EH will set the host to the recovery state, when 
we test and execute the smartctl command, it will affect the performance 
of all other disks under the same host.

Perhaps we can continue to improve the EH mechanism that Wenchao tried 
to do before, and implement EH for a single disk. After a single disk 
enters EH, it may not affect other disks under the same host.

https://lore.kernel.org/linux-scsi/20230901094127.2010873-1-haowenchao2@huawei.com/

Thanks，

Xingui
