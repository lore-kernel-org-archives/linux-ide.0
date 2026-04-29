Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2BE33A9F3;
	Wed, 29 Apr 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446115; cv=none; b=QDN0xSYGU3YO39dsbX1+5LdorauJ/ik8Lkt7tqOcjnFPXTYxc6pMs6OczUsCjilSE2ZRdWzejio0oKH5BQa6OlZs6omtJuYp9G4YtvCjrOgxPd/CjucUlCp7eWDTSHz8Wdkfn38DmNpzA2/fuQR2YWfvf5N6YqD5Peq2hIsvQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446115; c=relaxed/simple;
	bh=703zLGMUwnJRugy7XjlPoYHwCoOwLPBvMMWK1Drp5WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LdMAB2YYD9cDl69V54BHEfSXAY8vRjMhsd8jKL8KeBhPuYuncflVh8B6a4KSXDwvqmUkp7ABz5ZNO3tDvePYG7r1hRsNx+YEY1tY3r2Ri+CByjywosTR/1Uo2YUBjHxFZ5dJitQdjN9k9cBfe6PH3PGgUSr/4FrlnnZkNZ2vquw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=V9XGB1x8; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="V9XGB1x8"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BhKfaY3u3QrBK4OJw/K1RR5Nfo0/d3vhjT28vZ6g8sk=;
	b=V9XGB1x8sACKmizSqPVV5ROL5T47OzyOiWxWva4/6QSffp0dizrFK1+e/vqzBGSwdy2+6/O9k
	3oHTr4rhCLc4EDh6zYo6oB+CNgI9Xi6d8BtAPGd2lP95djC0nctSLiwe3+Cf+hlf3J9fG2Cierj
	Jf+mp29uPPNib22jTVAm0ZM=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4g57NW1VGfz1cyp9;
	Wed, 29 Apr 2026 14:55:23 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4262C40649;
	Wed, 29 Apr 2026 15:01:49 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 29 Apr 2026 15:01:48 +0800
Message-ID: <c78f6dad-b0fe-a2fb-8458-9fe182cd6b54@huawei.com>
Date: Wed, 29 Apr 2026 15:01:48 +0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] ata: libata-sata: retry hardreset when device detected
 but PHY not established
Content-Language: en-CA
To: Damien Le Moal <dlemoal@kernel.org>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <liuyonglong@huawei.com>,
	<kangfenglong@huawei.com>, <linux-ide@vger.kernel.org>
References: <20260425060447.1312763-1-yangxingui@huawei.com>
 <e8d237bc-7191-4881-924b-86a34ff0f3b9@kernel.org>
 <a118114e-9828-06d6-d38b-2b426c92bb14@huawei.com>
 <33299d0d-d863-4e00-951e-4728ddc823e2@kernel.org>
 <0539efac-d9b5-4f95-eecd-b88cb3cb8724@huawei.com>
 <66bc004a-4a18-43d1-b296-463ea72cbc85@kernel.org>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <66bc004a-4a18-43d1-b296-463ea72cbc85@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepemh500001.china.huawei.com (7.202.181.130) To
 kwepemj100018.china.huawei.com (7.202.194.12)



On 2026/4/29 9:36, Damien Le Moal wrote:
> On 4/29/26 10:14, yangxingui wrote:
>>
>>
>> On 2026/4/27 12:45, Damien Le Moal wrote:
>>> On 4/27/26 10:51 AM, yangxingui wrote:
>>>>
>>>>
>>>> On 2026/4/26 6:53, Damien Le Moal wrote:
>>>>> On 4/25/26 15:04, Xingui Yang wrote:
>>>>>> When sata_link_hardreset() detects that the link is offline, it currently
>>>>>> returns immediately without distinguishing the reason. According to SATA
>>>>>> specification, the SStatus register's det filed (bits 0-3) indicates:
>>>>>>      - 0x0: No device detected, PHY not communicating
>>>>>>      - 0x1: Device detected but PHY communication not established
>>>>>>      - 0x3: Device detected and PHY communication established
>>>>>>
>>>>>> This patch helps improve device detection reliability and adds a check
>>>>>> when the link is offline but det filed shows 0x1, return -EAGAIN to
>>>>>> trigger retry, rather than giving up immediately.
>>>>>>
>>>>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>>>>>
>>>>> This is a pure ATA patch so please CC the linux-ide list, not the linux-scsi
>>>>> list.
>>>>
>>>> Ok.
>>>>>
>>>>> Also, please check your mail setup: your email was in my Junk folder.
>>>>
>>>> Well, patche was sent using the git send command.
>>>
>>> Not git send-email, your smtp server. It probably has something wrong with
>>> DMARC. All your emails endup in my junk folder.
>>
>> Alright, it might be related to the company's SMTP server, but this
>> configuration is fixed, and I'm not quite sure how to fix it yet.
>>
>>>
>>>>> This is preceeded by a call to sata_link_resume(), which calls
>>>>> sata_link_debounce() and that function makes sure that DET is stable. So if
>>>>> after that DET still shows that their is no PHY, there is likely a big problem
>>>>> with it and it is super slow to be established.
>>>>>
>>>>> In this case, I do not think that doing another hardreset is the right thing to
>>>>> do. Have you tried increasing the deadline for hardreset ? That deadline is used
>>>>> as the limit for the link debounce too.
>>>>>
>>>>> Do you have a specific controller/device where you see this issue ? What exactly
>>>>> is the hardware setup where you see this issue ?
>>>>
>>>> Our customer imports and verifies a new disk, there is an occasional failure in
>>>> performing a hard reset on the disk and no exception log is generated for
>>>> resume and debounce.
>>>
>>> Does this hold for all disks or for only one or some models ?
>>
>> It may be some models, It is not found on other disks.
> 
> Some model ? Which one ?

When the disk is properly connected, the log is as follows:

[   22.658068][ T1297] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 
300)
[   22.665083][ T1297] ata1.00: ATA-10: S1XE240S3N6Y9TC1AP, F66002.0, 
max UDMA/100
[   22.727017][  T806] scsi 0:0:0:0: Direct-Access     ATA 
S1XE240S3N6Y9TC1 02.0 PQ: 0 ANSI: 5
> 
> And please remove linux-scsi from your emails for this topic.

Ok.

Thanks,
Xingui
.

