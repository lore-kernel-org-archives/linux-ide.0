Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7725298CB2;
	Fri, 29 May 2026 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017681; cv=none; b=nexHAR3N+yWFpyDIAYn6kaXU8Jtp6+kGPxXmMTw27KqHLdRip//GHrFXC0zQPHy5L9B0YImGY1fdndL1k9lK01hCvnL0LgAvNLLuh+L3C0RXml+hMgzqa/wpUkwmXsUnZDEo2CQG9T9OQw5sH/F9JCSUvjaE8dksSq+uDFDkojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017681; c=relaxed/simple;
	bh=fo2jmO6yzC90MJxwyYc1arU2eHJ7uj9XjIp/XwGac64=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F84b/N3tQTfyYrr6GpZ3GLvxsScfZygKmBkN15rcEuF/Ok8aYad3PV952p98OrgaYeJI9/RK7bzTo7R6kKIzmQI8260dy/tCWyDs8m0eWVGaUp6Un0SQe69UshG7ukYC/25aENJwjuPVtkCdUdFqUAIWt1q4ff66svkFxw0wFC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=ppXa1tsu; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="ppXa1tsu"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1Xpi6heqDuy5mPbqwteKc0DFf6ftoNED4IpHsOTITJM=;
	b=ppXa1tsuEaV6HRUJiEXwHjsVgL4BAn+RYs5N4Lr3pejgPXsgAITmkBbTuKFoVKDgpk/r4aKkQ
	4GCCzf1Ck9QdrLUVjzuRDtsJFVg88AvT9tCKtsoFyvkjMhWA3yg5cTV5jkIjbYB5ZPFvjTBxB3D
	ksvFEfBA1Zcavxu2Uqwy5xw=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gRQNB51S7z1cyPP;
	Fri, 29 May 2026 09:13:30 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F4B84048B;
	Fri, 29 May 2026 09:21:16 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 29 May 2026 09:21:15 +0800
Message-ID: <47bb8e36-8e28-5190-ade6-0a18a51f2009@huawei.com>
Date: Fri, 29 May 2026 09:21:14 +0800
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
To: Niklas Cassel <cassel@kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyonglong@huawei.com>, <kangfenglong@huawei.com>,
	<linux-ide@vger.kernel.org>
References: <20260425060447.1312763-1-yangxingui@huawei.com>
 <e8d237bc-7191-4881-924b-86a34ff0f3b9@kernel.org>
 <a118114e-9828-06d6-d38b-2b426c92bb14@huawei.com>
 <33299d0d-d863-4e00-951e-4728ddc823e2@kernel.org>
 <0539efac-d9b5-4f95-eecd-b88cb3cb8724@huawei.com>
 <66bc004a-4a18-43d1-b296-463ea72cbc85@kernel.org>
 <c78f6dad-b0fe-a2fb-8458-9fe182cd6b54@huawei.com> <afMW2scJrBSI_jLo@ryzen>
 <b241ef3f-d476-12f2-2862-ca95ff509046@huawei.com> <ahfqQtalkjBuMa9f@ryzen>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <ahfqQtalkjBuMa9f@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepemh500014.china.huawei.com (7.202.181.147) To
 kwepemj100018.china.huawei.com (7.202.194.12)



On 2026/5/28 15:09, Niklas Cassel wrote:
> Hello Xingui,
> 
> On Thu, May 28, 2026 at 03:01:39PM +0800, yangxingui wrote:
>>
>> Latest update: The issue we are currently facing is that the SATA host side
>> is continuously waiting for the disk to return the COMWAKE primitive. From
>> the SATA analyzer, it can be seen that the disk has already returned the
>> COMWAKE primitive. This may be related to poor COMWAKE signal quality,
>> causing the host to fail to recognize it. Performing a hard reset might be
>> able to fix the issue.
> 
> I'm a little confused. In your previous update you said that the issue had
> been resolved.
> 
> Now you say that an additional hard reset (COMRESET) "might be able" to
> fix the issue.
> That does not sound like you have actually verified if it does so or not.
> 
> Perhaps you can try implementing my suggestion in:
> https://lore.kernel.org/linux-ide/afMgoFBFPWR0f4gK@ryzen/
> 
> which does an additional hard reset (COMRESET).
> 
> But please only send out a patch if you have actually verified that the
> suggestion actually resolves your issue.

Hi, Niklas

Thank you for your suggestions.
Okay, yes, initially the disk actively initiated a COMINIT to 
re-establish the link, which was found to resolve the issue. However, 
the root cause is unknown. Recently, it was discovered that the disk 
fails to establish a link because the host did not receive the COMWAKE.

Let's check whether the customer still needs a software fix for this 
problem and try to test.

Thanks
Xingui


