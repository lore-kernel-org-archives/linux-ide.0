Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F1E23A9BD
	for <linux-ide@vger.kernel.org>; Sun,  5 Apr 2026 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775371511; cv=none; b=rgsDd/ONZiwiah3vcG8BVP8UfItY6KIJLpdLaSRtQelUmISVQ6ud98bd3pBjaNnxSlZNDNLt1tde+/rw8O06lvId2u2Ccoq2cCc2/8gjoRfggiKxw7cfHJwFr6GAjWhdJ8J5T3YeGgsgo2TR/Ba8mS5bbJ+vS3erkmkwTwMJH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775371511; c=relaxed/simple;
	bh=Rzfs6MGwjWCk6RFTVuxZJ3qnw8cEGIaHB3bqEM3gfCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCPTco8Ul6+ReLMaRWxpF0XDyb1LxMdN0V9jcbqZhtrhKxl8u+yi0UpfqLtr2WGNUnN2JnPQMa9OTqv4oLZcmI3OzvAwBLGj5gw2jFC0Rf2JE1IcgdxibmplsE6C0hFhTIKG+46uiYFdXX973vzp2ml5G+9vKaQ7jDMKR/2dWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObLnyWsb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObLnyWsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951D3C116C6;
	Sun,  5 Apr 2026 06:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775371511;
	bh=Rzfs6MGwjWCk6RFTVuxZJ3qnw8cEGIaHB3bqEM3gfCY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ObLnyWsbobK3hSHZ05bmFpSEsdF7/Si5io46vYkz4ZN4Oij9U0KGU9BI+zuYgUI1t
	 Gs/0nnaJZltAR1QdQXxzMcgy10Hf9O+Xn7pIghQb7DMdT3DouuRUUgVDeLr/KI4G8k
	 rOT2kVbDIKW9T5c6zLcUD+4sf+nA9LMmIOrlPS0dybv1VmoA4yVoLZzBlWB7raxazw
	 Ud6xMVYXPg2dPYDY6rZ1F+IMCFgGyYSxfoaheBPTEiRQDJXbn9NXJ1Zppkw9o3L+0/
	 +VMbsR5ee1b1zTY/OtZUKkNlozZPVUqWZsTZi5zGeYza14nvI87HONUetcODlrTg/L
	 77iy7iPn+t0fg==
Message-ID: <fb468ef1-8500-43db-a4b4-7dea882a7cee@kernel.org>
Date: Sun, 5 Apr 2026 08:45:09 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ATA port deferred qc fixes
To: Tommy Kelly <linux@tkel.ly>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/04/02 11:22, Tommy Kelly wrote:
> On 2/20/26 14:14, Damien Le Moal wrote:
>> The first patch addresses a use-after-free issue when a deferred qc
>> times out. The second patch avoids a call to a potentially sleeping
>> function while a port spinlock is held.
>>
>> Changes from v1:
>>  - Corrected typo in patch 1 message, improved comment in code and added
>>    a WARN_ON_ONCE() call to verify that a timed out qc is not active.
>>  - Fixed patch 2 to not call ata_scsi_requeue_deferred_qc() without the
>>    port lock held. This call is in fact removed: it is not needed as
>>    ata_scsi_requeue_deferred_qc() is called in EH, which is always run
>>    when removing a port.
>>
>> Damien Le Moal (2):
>>   ata: libata-eh: correctly handle deferred qc timeouts
>>   ata: libata-core: fix cancellation of a port deferred qc work
>>
>>  drivers/ata/libata-core.c |  8 +++-----
>>  drivers/ata/libata-eh.c   | 22 +++++++++++++++++++---
>>  2 files changed, 22 insertions(+), 8 deletions(-)
>>
> 
> 
> Hello, this is my first message on the LKML so please forgive me for
> likely not following etiquette.
> 
> I have what might be a regression from somewhere in the recent series of
> NCQ / QC patches.
> 
> I have a peculiar setup that might reveal the source of the bug. I'm
> using a SATA Port Multiplier (PMP), powered by JMB575, which expands 1
> SATA port to 5 drives.
> The device/driver/subsystem tree looks like rk3568-dwc-ahci -> scsi -> sda.
> The platform does not (yet) support FIS-Based Switching (FBS), so it is
> using Command-Based Switching (CBS). FBS support may land in Linux 7.1.
> 
>> kernel: ahci-dwc fc800000.sata: flags: ncq sntf pm led clo only pmp fbs pio slum part ccc apst
>> kernel: ahci-dwc fc800000.sata: port 0 is not capable of FBS
> 
> When switching from kernel 6.18.13 to 6.19.7, drive access became
> extremely slow, causing lock timeouts at the filesystem level. I solved
> the problem by changing /sys/block/sd*/device/queue_depth from 32 to 1.

We may have a bad interaction between PMP CBS and the deferred QC fix, though I
do not see how as long as NCQ commands are the main workload. Not sure what is
going on and we'll need to dig on this. Though this will be difficult as all the
PMP I have are FBS. I do not have any command based switching port multiplier.

Note that because of I do not have manual access to our lab for a while, this
may take some time. Please be patient.

> I also looked through the recent LPM patches, but the drives'
> performance didn't improve after changing LPM settings for the scsi host
> in sysfs.
> 
> Let me know if I need to provide more details or logs. I can see
> COMRESET a lot in each device's SMART logs but they aren't timestamped
> so I haven't proved that they are recent. Perhaps the slow drive
> switching is causing command starvation.

Please send the relevant parts of dmesg showing these resets and what leads to
them (e.g. any error).

> 
> 
> Thank you,
> Tommy


-- 
Damien Le Moal
Western Digital Research
