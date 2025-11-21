Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB2834B1BE
	for <linux-ide@vger.kernel.org>; Fri, 21 Nov 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735354; cv=none; b=qBCRlzuTTwfNG6xX3v9maCOFmaRHqCNZwNpQFsrDWntFsujl9UR/iqfuAVa/Zdlhj96lNw/yEBQjD9FjIVlJYpOsy/uw9m7kbpS2lt5hoXnp8c+c1vkikM8mwbvlTh15cebjAi353pqpAxHMgWfDfrBAabwHFkvzmmI7OBD+oQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735354; c=relaxed/simple;
	bh=L5neIU+B3Qd0SjFCSzG9s5q9Hy39GOAZZj7ZySSWBUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGwUpcrMZTGjJcpyGUdYLYLaat1g6nLWhcwr6qmWlm7Lnk5SgcTJSAmNfioZHiUN0knP5fE1DhkAZ+yFAxSbWBmcnbY72300V7IwSpQfiQNJS6tqa0qE2t9QhNrBwI+5MjqkcnnK0Do+jFC/NxqMerYs1e/6nnaiwcqBCXRMmm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKCt8o6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKCt8o6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26620C4CEF1;
	Fri, 21 Nov 2025 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763735352;
	bh=L5neIU+B3Qd0SjFCSzG9s5q9Hy39GOAZZj7ZySSWBUo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PKCt8o6G1eJzBqHi/w7UL4GUlZbfxvFq+V5vbdWH+/0RBXqRYBJxm8nZIvpNieXuW
	 8CP8d1eYCp6bYjkQK6r31e561NimK+XvCSh3owyL7y4l2ZtaxwTrQ+qdiLGgdHtX0c
	 Y3jTyhvEW/gXRA9zxCrIrOWK0tU0A8DkiLl6zLRGTcjLyIcbdAEhijmkPwxUDpI/Ex
	 aw/pDjEqga6/3/83ieIVshrAt3D+QQMMOCm4X9wVZoxRC1MuM//kySuzsaJqUPovHM
	 8RFY8C8fSNDEryNMIujeLtGMVc5oM2RDD7FnPllrS2ZQaB6D8lqAYLG0CEACE6yR7V
	 Fvwf5Ap448sDg==
Message-ID: <eb6411bf-141f-47a8-bf73-a9f669399c6a@kernel.org>
Date: Fri, 21 Nov 2025 08:29:11 -0600
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] ata: ahci: IO error with the default
 med_power_with_dipm
To: Niklas Cassel <cassel@kernel.org>, Yihang Li <liyihang9@h-partners.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, linuxarm@huawei.com,
 liuyonglong@huawei.com
References: <20251121073502.3388239-1-liyihang9@h-partners.com>
 <aSB0ilF_cI5PS8M0@ryzen>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <aSB0ilF_cI5PS8M0@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/21/2025 8:17 AM, Niklas Cassel wrote:
> On Fri, Nov 21, 2025 at 03:35:02PM +0800, Yihang Li wrote:
>> Hello Mario, Damien,
>>
>> After commit 5433f0e7427ae ("ata: Kconfig: Update SATA_MOBILE_LPM_POLICY
>> default to med_power_with_dipm") from linux v6.11, I am seeing the error,
>> and eventually, my file system became read-only and could no longer
>> be used. Please help check whether this is reasonable and how to resolve
>> this issue?
>>
>> I am using an standard AHCI controller, connected to a SATA disk, and
>> using this disk as the system drive.
>>
>> # lsblk
>> NAME               MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
>> sda                  8:0    0 447.1G  0 disk
>> ├─sda1               8:1    0   600M  0 part /boot/efi
>> ├─sda2               8:2    0     1G  0 part /boot
>> └─sda3               8:3    0 445.5G  0 part
>>    ├─openeuler-root 252:0    0    70G  0 lvm  /
>>    ├─openeuler-swap 252:1    0     4G  0 lvm  [SWAP]
>>    └─openeuler-home 252:2    0 371.5G  0 lvm  /home
>>
>> Any suggestions on the problem are welcome.
> 
> Hello Yihang Li,
> 
> As far as we can tell, it appears that a lot of vendors have not
> implemented LPM properly, or have issues with LPM in their firmware.
> 
> The way we solve it is to quirk these broken devices, see e.g.:
> https://github.com/torvalds/linux/blob/v6.18-rc6/drivers/ata/libata-core.c#L4209-L4213
> 
> 
> Please tell us which the model of your drive:
> 
> $ lsblk -o MODEL /dev/sdX
> 
> and the firmware version
> $ lsblk -o REV /dev/sdX
> 
> 
> So we can create a quirk.
> 
> 
> It would also be helpful if you could share which AHCI adapter you are using:
> $ lspci -nn | grep -i ahci
> $ lspci -nn | grep -i sata
> 
> 
> If you want to verify that disabling LPM works for your drive, you can add:
> 
> libata.force=nolpm on the kernel command line.
> 
> 
> Kind regards,
> Niklas

It would be ideal to please reproduce on a mainline kernel if you 
haven't already.

Also; just to confirm did you reach this result with a bisect?  Or did 
you encounter this issue with a mainline kernel?
