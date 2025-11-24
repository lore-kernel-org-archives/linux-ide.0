Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A67260D
	for <linux-ide@vger.kernel.org>; Mon, 24 Nov 2025 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975222; cv=none; b=GO8Aotx74QiVZ4WW0idS5tQstvqwy+0tsEPD127fDof0pqQH5TZa29z8lUhU6IZnNbDevK7yMtK/87eErALYX7WPkPy5M29y1yk3GGP63KpcJSNyygjHXcxDSnIgWESwym3z3B8Y8y7H5hS3IaAMUaXhy8bWANEN7wOA/u/D7qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975222; c=relaxed/simple;
	bh=bB7DyzQeCt8Drz2m9dGKV+1YpUkNtql7D3wdZ7t1RAc=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OwQydvRh7I7ilf4iDcFC9tX2xj2thNQkhV+GXhX+C5xtaWoa4pocaVpx3nQ+gDrn01IS4QLnIEaolMLZW5NvWbl976U4c682YVlHnKorS4Dwf8t3SMcWc4NCO+UYpyfon1nUVl981vwkIypKZkht48jyOvfKncafYI9vcQCWkX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=O8c3kG7U; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="O8c3kG7U"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tur1euxp9S9cXqgvFeM02PxEeq2/Vaaamf5kszZRwoc=;
	b=O8c3kG7UFGUHjIcBjhu5+numVuvvePnRm4C2jXAonsL6UAU6/kkmAYLb/cO9bLvk9J1mEL4Is
	s9Qfl7YCGTYDcfLs9RwxhT5vmbu/wqVqOjbrk6ZfcoXCD1VHvyVo+wOGs8ieo2HBg6YLm/CL7hE
	XXAI3l+6dDKcf8lqImbpFm0=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dFKf80WtXzLlTK;
	Mon, 24 Nov 2025 17:05:04 +0800 (CST)
Received: from kwepemh200005.china.huawei.com (unknown [7.202.181.112])
	by mail.maildlp.com (Postfix) with ESMTPS id 7622C1A0174;
	Mon, 24 Nov 2025 17:06:50 +0800 (CST)
Received: from [10.67.120.126] (10.67.120.126) by
 kwepemh200005.china.huawei.com (7.202.181.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Nov 2025 17:06:49 +0800
Subject: Re: [bug report] ata: ahci: IO error with the default
 med_power_with_dipm
To: Niklas Cassel <cassel@kernel.org>
References: <20251121073502.3388239-1-liyihang9@h-partners.com>
 <aSB0ilF_cI5PS8M0@ryzen>
CC: <mario.limonciello@amd.com>, <dlemoal@kernel.org>,
	<linux-ide@vger.kernel.org>, <linuxarm@huawei.com>, <liuyonglong@huawei.com>,
	Yihang Li <liyihang9@h-partners.com>
From: Yihang Li <liyihang9@h-partners.com>
Message-ID: <53fad0bf-007e-d658-755e-455dc1838284@h-partners.com>
Date: Mon, 24 Nov 2025 17:06:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aSB0ilF_cI5PS8M0@ryzen>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemh200005.china.huawei.com (7.202.181.112)

Hi Niklas,

On 2025/11/21 22:17, Niklas Cassel wrote:

> Please tell us which the model of your drive:
> 
> $ lsblk -o MODEL /dev/sdX
> 
> and the firmware version
> $ lsblk -o REV /dev/sdX
> 
> So we can create a quirk.

Thank you for your reply. On my machine, the model information is as follows:

# lsblk -o MODEL /dev/sda
MODEL
MD619HXCLDE3TC

# lsblk -o REV /dev/sda
 REV
ID

> 
> It would also be helpful if you could share which AHCI adapter you are using:
> $ lspci -nn | grep -i ahci
> $ lspci -nn | grep -i sata
> 

# lspci -nn | grep -i ahci
38:05.0 SATA controller [0106]: Huawei Technologies Co., Ltd. HiSilicon AHCI HBA [19e5:a235] (rev 30)


> 
> If you want to verify that disabling LPM works for your drive, you can add:
> 
> libata.force=nolpm on the kernel command line.
> 

Thanks!
I will try this method to verify whether it can prevent this problem from occurring.

Thanks,
Yihang

