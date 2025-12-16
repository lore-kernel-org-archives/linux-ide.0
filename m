Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A1A33AD9C
	for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2025 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765928704; cv=none; b=n4uNzn6tF74pCO5O+4rL72ZQC9aZ04Q0Z/l8cqR0CDSEHeYc7QmiUZUOq3EgEtl3iAtVvkmROyBFeRNlCD4pFsZ0lJTKWZB4kzhbKpTDD/MNOGsjel4HDGbpp8fbf6hHLGnIbiJv5rtIfTg2m/IlFINXqYUB+DBzatsnPrU+dVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765928704; c=relaxed/simple;
	bh=iFGpE6nosay+NzugTh9koOxn5k8d400SScWIYpZsLi4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=anf0/hnQQh+ny64ABiRYaNfo0u6QtMMzb77GawTBMOOvf0uCXA/xr3uda4IItU2CVAcO/Cq7pM2YOLan7gqpMB2MNdALv6EuI3nqYe5R6TMoCioBDC7syagWRMibDB0NNW2shD5KdySK2G+Kzc5ZHu6xOadkwEJJqMlMYFF3lZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.122.14] (unknown [101.115.78.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4dWD0k3C8Yz8vHD
	for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2025 10:39:18 +1100 (AEDT)
Message-ID: <080383fe-63cf-4198-966a-b32d798bea06@eyal.emu.id.au>
Date: Wed, 17 Dec 2025 10:39:11 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ata timeout exceptions
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
To: list linux-ide <linux-ide@vger.kernel.org>
Reply-To: eyal@eyal.emu.id.au
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
Content-Language: en-US
In-Reply-To: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Resolved.

Limiting disk access bandwidth (as suggested by Damien Le Moal <dlemoal@kernel.org>)
	# echo 1280 > /sys/block/sdX/queue/max_sectors_kb
did the trick. No pauses/resets anymore for over a month.

Setting
	# echo 180 >/sys/block/sda/device/timeout
did not help, only made the pauses longer before the reset.

Thanks everyone.
	Eyal

On 3/11/25 15:13, Eyal Lebedinsky wrote:
> I have a sata disk that is probably on its last legs.
> It is a plain disk (no RAID or such). If it matters, it is an old 8TB Seagate SMA disk.
> It sees very little activity.
> 
> Every two hours a small rsync copies a directory into this disk. A few 100s of files are copied each time, a few 10s of GB in total.
> 
> For the last few weeks it started to log timeout errors (not always) like this:
> 
>    kernel: ata2.00: exception Emask 0x0 SAct 0x2020 SErr 0x0 action 0x6 frozen
>    kernel: ata2.00: failed command: WRITE FPDMA QUEUED
>    kernel: ata2.00: cmd 61/80:28:a0:10:df/00:00:d1:01:00/40 tag 5 ncq dma 65536 out
>                     res 40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
>    kernel: ata2.00: status: { DRDY }
>    kernel: ata2.00: failed command: WRITE FPDMA QUEUED
>    kernel: ata2.00: cmd 61/00:68:18:15:30/20:00:20:01:00/40 tag 13 ncq dma 4194304 out
>                     res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
>    kernel: ata2.00: status: { DRDY }
>    kernel: ata2: hard resetting link
>    kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>    kernel: ata2.00: configured for UDMA/133
>    kernel: ata2: EH complete

[trimmed]

-- 
Eyal Lebedinsky	(eyal@eyal.emu.id.au)

