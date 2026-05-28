Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D5819E96D;
	Thu, 28 May 2026 07:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951713; cv=none; b=qwz8ilzYuGmQ+9o9U/3hrO09TUD58A6xCxj2szSY0JuYwmZKaO2mh2vxhxIj8zJwPncO5Kd7+qGRTadQnY8LBFBU4SmHZhBXoX3Otae5bH8N7CS7aUqQrU+ireY1OINuomMm/D5hSRa3EIOvkoVvgsnbcgjUXOaK7/5XxKejSJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951713; c=relaxed/simple;
	bh=fFNVziiFmUYGwcF/rj10E3J9In1ZrmA0cA47uNDb6tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Oa+6bxHk2LXREQSCKsLJmkc9tvotFkVqxoej5ajYRH6oBGPiPTRqhwc6obHGp0E31uQyocMeZEGCqhfr8KnDqsXRRea7D/yOq/YigazWRYygGJiFM8sBETiFuvmufRMXnow/VGTnYl1MZUBnByWBRiLjbk3vrc+ZRu356MTjpNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=QK2HDrUv; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="QK2HDrUv"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=V5R5uaXWK6QZX36zl6bADEYxtBi4h7vhAB2KFgUaLNg=;
	b=QK2HDrUvNAcBpn1oqZpmj3DX2+Ms5nUB4LR6RrQgrIjH0efzE+p9Qvy3MiWMNdVer19ffJr+/
	VJrKSVgQi/XbGoHzKlWFtAu0OOQMYk5NYkdJThET8vsDk0jjXn5zxfdcnKYed2JtHWf9+KdUCJt
	yhQI9MXtRJRHtaw9jAjbFGs=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gQxzD2ncnznTV5;
	Thu, 28 May 2026 14:53:44 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 07A274048B;
	Thu, 28 May 2026 15:01:41 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 28 May 2026 15:01:40 +0800
Message-ID: <b241ef3f-d476-12f2-2862-ca95ff509046@huawei.com>
Date: Thu, 28 May 2026 15:01:39 +0800
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
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <afMW2scJrBSI_jLo@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepemh200012.china.huawei.com (7.202.181.121) To
 kwepemj100018.china.huawei.com (7.202.194.12)



On 2026/4/30 16:46, Niklas Cassel wrote:
> On Wed, Apr 29, 2026 at 03:01:48PM +0800, yangxingui wrote:
>>>>>>> This is preceeded by a call to sata_link_resume(), which calls
>>>>>>> sata_link_debounce() and that function makes sure that DET is stable. So if
>>>>>>> after that DET still shows that their is no PHY, there is likely a big problem
>>>>>>> with it and it is super slow to be established.
> 
> I agree with Damien, sata_link_debounce() is supposed to make sure that
> DET is stable.
> 
> 
> sata_link_debounce() will not explicitly wait for SStatus.DET to turn 0x3.
> 
> If value is stable, and SStatus.DET == 1, and time is before "deadline",
> sata_link_debounce() will continue looping.
> 
> Else, if value is stable, and has been stable for "duration" amount of time,
> it will return.
> 
> Since your print shows that SStatus == 1, that most likely means that the
> deadline expired in sata_link_debounce().
> 
> I suggest that you try to increase the deadline, perhaps start off by simply
> multiplying it by some factor in sata_link_debounce().
> 
> 
> It would also be helpful if your commit message explained why returning
> -EAGAIN makes a difference, because from what I can see, if the deadline
> expires, sata_link_debounce() returns 0, which should cause sata_link_resume()
> to return 0, which should cause sata_link_hardreset() to
> return 0, with online == false.
> 
> If that is the case ata_do_reset() would return 0, and
> ata_eh_followup_srst_needed() (returns true only if -EAGAIN) would return false.
> 
> Which should eventually cause us to retry another hard reset, as long as
> tries <= max_tries.
> 
> 
> By making sata_link_hardreset() return -EAGAIN, the difference I see is that
> we will for a software reset followed by the hardreset, but you commit message
> did not mention that.
> 
> So, my question is, why is it not sufficient to retry another
> hardreset/COMRESET?
> 
> Does it work to only do a hardreset (without if a follow up softreset) if you
> increase the deadline?

Latest update: The issue we are currently facing is that the SATA host 
side is continuously waiting for the disk to return the COMWAKE 
primitive. From the SATA analyzer, it can be seen that the disk has 
already returned the COMWAKE primitive. This may be related to poor 
COMWAKE signal quality, causing the host to fail to recognize it. 
Performing a hard reset might be able to fix the issue.

Thanks
Xingui
