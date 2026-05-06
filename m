Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104C01DF27F;
	Wed,  6 May 2026 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034205; cv=none; b=VPRRdq13VsbBCobDt71oVG5ugbzPGLmpTqjFFWAG1sx7QkZUA2G1dxeXoJeAM35r9Vbdojk2aHOveYAumknjbj+9KUv98lehht5c9pLjsfy+Mxca3uZ7r7lnp3a+kb3bGCWPkcm+2+/KR8qYJFj4fHW3WD3FMilfPpgiCDS6tUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034205; c=relaxed/simple;
	bh=eg/HUtRZV1OfB32Pl9hX1Wd/RgbyKgKq33zgOaab4gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FZ6VPFgV1Q+rl4dORkAc5S9CAXR64L0f/NnwDzoFyxHE98rY/SeFVYACmb4+QH+NqcFBAlYmpQZ2/WFqYqnziZmbiPZhfnQUcjCNQ/EhsDCpOl8aU4zoGaEFEc+Xe5IFKUj6s9vZ5SDNcJctIJQaOkQPZ2ljVCIaSdB7dhbh0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=KPTe1jf9; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="KPTe1jf9"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ngKZ03eUekUOWNvvm7qOrxc0VTAY6W/3Fi1OVrsl050=;
	b=KPTe1jf9Y7soOz806adleYvYOoZ1nD8ugbsyIlMWz2vdCYtOmW6f92Q2THxdEcSBbB+ijWebC
	4ec8RiBQFaV1xzWA1FTsy07rq3cYIICbVo6ZCRJhUIu/IpKGExA3zZ66M3dNg6hod8wDD0yPGVo
	/wnvpf43+B4J7nv34f31XOk=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g9Js31hKQznTW4;
	Wed,  6 May 2026 10:16:07 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 374AB4048B;
	Wed,  6 May 2026 10:23:14 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 6 May 2026 10:23:13 +0800
Message-ID: <a6bd2366-dbea-f82b-92b5-fd038c3a768d@huawei.com>
Date: Wed, 6 May 2026 10:23:13 +0800
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
 <afMgoFBFPWR0f4gK@ryzen>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <afMgoFBFPWR0f4gK@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepemh100002.china.huawei.com (7.202.181.84) To
 kwepemj100018.china.huawei.com (7.202.194.12)



On 2026/4/30 17:28, Niklas Cassel wrote:
> On Thu, Apr 30, 2026 at 10:46:22AM +0200, Niklas Cassel wrote:
>> If that is the case ata_do_reset() would return 0, and
>> ata_eh_followup_srst_needed() (returns true only if -EAGAIN) would return false.
>>
>> Which should eventually cause us to retry another hard reset, as long as
>> tries <= max_tries.
> 
> I see now that max_tries is just set to 1.
> 
> I think I would prefer another hardreset (with a larger timeout) over
> a follow-up softreset after the hardreset...
> 
> If -EAGAIN is reserved for "do an follow up SRST after the COMRESET",
> because certain Port Multipliers need it.
> 
> Perhaps introduce another error code, which means, device detected,
> overload max_tries to 3 and goto retry.
> 
> That way we will retry using COMRESET, with increasing timeouts, since:
> deadline = ata_deadline(jiffies, ata_eh_reset_timeouts[try++]);
> 
Increasing the deadline of the debound does not solve the problem. 
Additionally, we do not have a customer environment locally, so we are 
not sure whether retry a hardreset can completely resolve the issue. 
However, in this scenario, the SATA hard disk manufacturer has added a 
mechanism to attempt to proactively trigger COMINIT for re-establishing 
the link after an abnormal link establishment. Feedback from pressure 
testing indicates that the issue has been resolved. ^-^

Thanks,
Xingui
.
