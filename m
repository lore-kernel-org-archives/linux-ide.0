Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14BE5478D
	for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2025 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765935366; cv=none; b=SrwnvgNMXihx5taDeVDFMDM5FOi8CxXxKh9swto5xrd+8ylyh/qAu/OhDmPjSxeewbipAryKROzAq/wIiT9ZF7tEBGmJQmW7TyczOkky1UiB4EFOaMgNTxsX85dzCGQ9X1u9KE528HUZZfvBVm0WgKEL99WsDBWI7EXtGS6auPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765935366; c=relaxed/simple;
	bh=8hQEYyL6UR6TETq9ZcIxkjTL9trvld552vt7RsfSZAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C0/TzaFV9mfWalOAkFHTb28x/TOtrzLO/RBcbe21Vl0FU8ruPE64tQDZ0374+haGrpR0PEaV/vRjbd0l1TroTGCjNhpq5KbvcOpo14A5dB324L2GEgVOb+hpRLYw0C8Y6StskyLz6wrbWEQcaOQUxjSsKksm2MU+wSgaxVwetrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/rD3Rsa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/rD3Rsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF154C4CEF1;
	Wed, 17 Dec 2025 01:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765935363;
	bh=8hQEYyL6UR6TETq9ZcIxkjTL9trvld552vt7RsfSZAk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=H/rD3RsaGbPyvsA5/Gm6zc+YdXswJLrj7rniG4lOx2bOPiUQVrUsNEeiec9lAi6sh
	 TsEEm+muF9GZRXom85hh4ElnqZIFIck6xuqv3XWwhGQruTRmWmD3h82d/+DkW/BouM
	 6TsfF4it4Gf2y5bbb6NYe7NxHOqVAOVett7rJSHy3MqynqpNc4QKh7UOu/m96NKy/W
	 FUOM19iUBT/83uJ8U01AyH1NUyz+31NuDwFT2AkhuLLgjYBDP0Ty0E03LR5JxUq0f+
	 pnbviHrQQZlq0KpuXyl+ePijvlWDgvQdHgVgiyOCbNEDCPWVQnwH4ooPpavZyHjGUv
	 M7HqzWSh7BoTA==
Message-ID: <13bf2e98-1774-4444-bc56-38a39d539d8e@kernel.org>
Date: Wed, 17 Dec 2025 10:35:56 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ata timeout exceptions
To: eyal@eyal.emu.id.au, list linux-ide <linux-ide@vger.kernel.org>,
 Niklas Cassel <cassel@kernel.org>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <080383fe-63cf-4198-966a-b32d798bea06@eyal.emu.id.au>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <080383fe-63cf-4198-966a-b32d798bea06@eyal.emu.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/17/25 08:39, Eyal Lebedinsky wrote:
> Resolved.
> 
> Limiting disk access bandwidth (as suggested by Damien Le Moal <dlemoal@kernel.org>)
> 	# echo 1280 > /sys/block/sdX/queue/max_sectors_kb
> did the trick. No pauses/resets anymore for over a month.

We now have patches queued up to limit max_sectors_kb for devices and
controllers behaving badly. If you send us your device information (hdparm -I)
and controller info (PCI ID of your AHCI adapter), we can add a permanent quirk.

Though we would need to determine if is is the device or the adapter that is
mis-behaving, and also ideally, the command size at which things break.
We had another case with a device breaking above 4MiB commands. A quirk setting
max hw sectors to 8191 sectors solved the issue.

> 
> Setting
> 	# echo 180 >/sys/block/sda/device/timeout
> did not help, only made the pauses longer before the reset.
> 
> Thanks everyone.
> 	Eyal
> 
> On 3/11/25 15:13, Eyal Lebedinsky wrote:
>> I have a sata disk that is probably on its last legs.
>> It is a plain disk (no RAID or such). If it matters, it is an old 8TB Seagate SMA disk.
>> It sees very little activity.
>>
>> Every two hours a small rsync copies a directory into this disk. A few 100s of files are copied each time, a few 10s of GB in total.
>>
>> For the last few weeks it started to log timeout errors (not always) like this:
>>
>>    kernel: ata2.00: exception Emask 0x0 SAct 0x2020 SErr 0x0 action 0x6 frozen
>>    kernel: ata2.00: failed command: WRITE FPDMA QUEUED
>>    kernel: ata2.00: cmd 61/80:28:a0:10:df/00:00:d1:01:00/40 tag 5 ncq dma 65536 out
>>                     res 40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
>>    kernel: ata2.00: status: { DRDY }
>>    kernel: ata2.00: failed command: WRITE FPDMA QUEUED
>>    kernel: ata2.00: cmd 61/00:68:18:15:30/20:00:20:01:00/40 tag 13 ncq dma 4194304 out
>>                     res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
>>    kernel: ata2.00: status: { DRDY }
>>    kernel: ata2: hard resetting link
>>    kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>    kernel: ata2.00: configured for UDMA/133
>>    kernel: ata2: EH complete
> 
> [trimmed]
> 


-- 
Damien Le Moal
Western Digital Research
