Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACE35C613;
	Mon, 17 Aug 2026 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931386; cv=none; b=cEmnAMYPA92I9WpzSepsW/pqPl1qYs5/cnebvBJwPHgqlvVlo31BFIfvCg5xSPxISlUqVVTCEPcfvljK763SAtBFODD72O0Qh3emXnMyLDBxemt3I0efkBhd90bndTk4blEdNuB39elj3Dzj6/sRy2RwI1MaFhT7z6/8ZAd0hdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931386; c=relaxed/simple;
	bh=GOBZf0nXfi1VHaNSS6+rco/7ICIqyicIDrAxhkH8sYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AkE99A1VmbucBmR3LOWbN3ZcDeXe6tUv1syjjD3lKk9qIh6CRQvgE7ZaIaJDtbBEKSaOXeCWpy7RNxNx3Sbx8rVDupKgOf0C+amnVg8P5DvzLx+XdZrxzVdIGwvyWixILLXcPQWJDwF0D3dl/ZBkFn87m/h9RTTTkGIrY12lISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=csaz/hqI; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="csaz/hqI"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rwcFdPV7QfAmDXPQOq4iQVX49qz2TCDn/TcRUwhwTDc=;
	b=csaz/hqI10tCBBPya8F3rv4C+YVAoA4bamtpd9oZDqshzgEU2OvQq8VEttGInBwpENnPZaoXn
	Lk+vk7UY30IPZ4rKxJHHFaguVgikPiuWOiXF5UvxnuvFNhmxM2ZcVpqvdH5EhUHwpfI3mrV48RR
	PzCndJ3g8LCzzT1BeakAHVE=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hNb920bcCzcb0T;
	Mon, 17 Aug 2026 09:39:18 +0800 (CST)
Received: from kwepemp100003.china.huawei.com (unknown [7.202.195.218])
	by mail.maildlp.com (Postfix) with ESMTPS id C8FD240575;
	Mon, 17 Aug 2026 09:49:33 +0800 (CST)
Received: from kwepemp500015.china.huawei.com (7.202.195.9) by
 kwepemp100003.china.huawei.com (7.202.195.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 09:49:33 +0800
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemp500015.china.huawei.com (7.202.195.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 09:49:25 +0800
Message-ID: <31bc1803-7242-c809-07e8-96b57b89576d@huawei.com>
Date: Mon, 17 Aug 2026 09:49:24 +0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v1] ata: libata-eh: Add timeout table entry for STANDBY
 IMMEDIATE
Content-Language: en-CA
To: Niklas Cassel <cassel@kernel.org>
CC: <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<liuyonglong@huawei.com>, <kangfenglong@huawei.com>
References: <20260814035846.2032778-1-yangxingui@huawei.com>
 <an72ZpuHX6JhukdS@ryzen>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <an72ZpuHX6JhukdS@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepemh100012.china.huawei.com (7.202.181.97) To
 kwepemp500015.china.huawei.com (7.202.195.9)


Hi, Niklas.

On 2026/8/14 19:05, Niklas Cassel wrote:
> On Fri, Aug 14, 2026 at 11:58:46AM +0800, Xingui Yang wrote:
>> ATA_CMD_STANDBYNOW1 is not in the ata_eh_cmd_timeout_table and falls
>> back to the 5s default (ATA_EH_CMD_DFL_TIMEOUT), which is too short
>> for some drives to complete a STANDBY IMMEDIATE command issued from
>> ata_dev_power_set_standby() via ata_exec_internal():
>>
>>    ata1.00: qc timeout after 5000 msecs (cmd 0xe0)
>>    ata1.00: STANDBY IMMEDIATE failed (err_mask=0x4)
>>
>> Reuse the existing ata_eh_flush_timeouts for this command, as a drive
>> entering standby may need to flush its internal cache, making the flush
>> timeout a natural fit.
>>
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>> ---
>>   drivers/ata/libata-eh.c | 2 ++
>>   include/linux/libata.h  | 2 +-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index 05df7ea6954a..8f9e12f460c3 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -149,6 +149,8 @@ ata_eh_cmd_timeout_table[ATA_EH_CMD_TIMEOUT_TABLE_SIZE] = {
>>   	  .timeouts = ata_eh_flush_timeouts },
>>   	{ .commands = CMDS(ATA_CMD_VERIFY),
>>   	  .timeouts = ata_eh_reset_timeouts },
>> +	{ .commands = CMDS(ATA_CMD_STANDBYNOW1),
>> +	  .timeouts = ata_eh_flush_timeouts },
>>   };
>>   #undef CMDS
>>   
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 96e626d6a7ca..6c0d385b2cde 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -425,7 +425,7 @@ enum {
>>   	/* This should match the actual table size of
>>   	 * ata_eh_cmd_timeout_table in libata-eh.c.
>>   	 */
>> -	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 8,
>> +	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 9,
>>   
>>   	/* User visible DMA mask for DMA control. DO NOT renumber. */
>>   	ATA_DMA_MASK_ATA	= (1 << 0),	/* DMA on ATA Disk */
>> -- 
>> 2.43.0
>>
> 
> This patch does not seem to be on top of latest Linus tree.
> 
> If you look at latest Linus tree, it already has:
> 1e024d2b41ee ("ata: libata-eh: Increase STANDBY IMMEDIATE timeout")
> 
> Which looks to solve the same problem as this patch.

Aha, thanks for the quick review!

I usually base my work on the "for-next" branches of 
"kernel/git/jejb/scsi.git" and kernel/git/mkp/scsi.git", and I 
mistakenly thought there were no new changes in latest Linus tree.

Thanks,
Xingui
.
