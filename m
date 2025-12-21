Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432E12AE68
	for <linux-ide@vger.kernel.org>; Sun, 21 Dec 2025 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766357041; cv=none; b=SWZHfaySPqisiz0/5eP5joe+idUu+qn96XZ77FHzSQ7GhK4+XvLS8aUSGEYgoAeKVM4F8aw0O18Ockrdc9u/Ber3HAYVUfYPU3uDKC8qir5e9Z2QFJK6StIaRoCxGCKOrtBFQdQVV7SVZSElHdiGgaAj94xtzIMPim5AGNsm7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766357041; c=relaxed/simple;
	bh=77t+96EuHobf7RwBgeHOtFWHKBhWwvGoZf5BkMk2W08=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LvEUzjx857BPmvqW+y3Hui7eIDZ5/z1xitphPH/zMOeETcuJMWO4edfKLSb4/yM2F7FXZf/BzN7fegJoQbbknaHZOXQkPRIVy6f+ZurIP6vkc17ySb7hBP2kcVUxwDc/jOicU3tHhADS/ztsWyqGBmJywH5IvjWmTrYqIZP0LBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.78.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4dZGXV289Yz8vCL;
	Mon, 22 Dec 2025 09:43:54 +1100 (AEDT)
Message-ID: <3e81e6ae-1ef0-454c-935f-eee2bba91176@eyal.emu.id.au>
Date: Mon, 22 Dec 2025 09:43:53 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eyal@eyal.emu.id.au
Subject: Re: ata timeout exceptions
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
To: list linux-ide <linux-ide@vger.kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <080383fe-63cf-4198-966a-b32d798bea06@eyal.emu.id.au>
 <13bf2e98-1774-4444-bc56-38a39d539d8e@kernel.org>
 <79fcb2f0-d09b-4649-bda0-55f309b20985@eyal.emu.id.au>
 <746FB9BB-5945-415F-915F-3F05D8A6B063@kernel.org>
 <582e748c-3e29-4f21-af7c-c799fb457e59@eyal.emu.id.au>
 <3d476e67-31a9-4e7d-b8cc-5bb298a6d62f@kernel.org>
 <9933af72-944e-4bb3-bab9-fdbd4fb0fad0@eyal.emu.id.au>
Content-Language: en-US
In-Reply-To: <9933af72-944e-4bb3-bab9-fdbd4fb0fad0@eyal.emu.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/12/25 23:12, Eyal Lebedinsky wrote:
> On 21/12/25 19:34, Damien Le Moal wrote:
>> On 12/20/25 13:03, Eyal Lebedinsky wrote:
>>> On 17/12/25 23:02, Niklas Cassel wrote:
>>>> On 17 December 2025 20:56:07 GMT+09:00, Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>>>
>>> [trimmed]
>>>
>>>>> Do you want me to try different max_sectors_kb values to see where it breaks?
>>>>>
>>>>
>>>> You can also try this:
>>>>
>>>> https://github.com/floatious/max-sectors-quirk
>>>>
>>>> It tries these max_sector_kb values:
>>>> declare -a sizes=(128 1024 2048 3072 4095 4096)
>>>>
>>>> You can simply modify the script if you want to try more intermediate sizes.
>>>
>>> After testing the script on a sacrificial disk, I got brave and ran it on the offending disk.
>>> See comments after the test report.
>>
>>> From your test results, it seems that the drive actually correctly handles very
>> large write commands, but because it is a drive-managed SMR disk, such commands
>> can take a very long time to process (due to the drive needing internal garbage
>> collection first), which triggers a timeout and a reset as the ata subsystem
>> assumes that the drive has stopped responding.
>>
>> Limiting write commands to smaller sizes seems to mostly avoid this issue, even
>> though I do not think that gives any guarantees that the same issue will not
>> happen for small writes too.
>>
>> So my suggestion is that you run with something like "libata.force=[<port
>> ID>:]max_sec=1024" for that drive. We can also add a permanent quirk for it too,
>> but that would be a really more of a big hammer solution.
> 
> I mostly agree. However, extending the timeout did not help in the past.
> I found that even setting it to 240 was not enough.
> If there is no response in 30s then none is coming. I never saw a pause longer than 30s that came back later.
> The pause is either up to 30s or unlimited (until timeout is reached and a reset).
> 
> ATM I have the setting of timeout=120 in rc.local.
> 
> I also have in my boot cmd:
>      libata.force=2.00:noncq
> This is because with ncq, if a pause reaches a timeout then the disk records a Command_Timeout.
> In the smart log it is now up to 34360262682 (8,8,26) but stable since ncq was disabled (at 1/Nov)
> despite many timeout resets since.
> 
> I suspect a fw bug or a design fault(*), but just for fun I will run with max_sectors_kb=4096 and timeout=1024.

Have just ran the test, failed quickly, see below.
It shows a 17 minutes pause followed by a reset and a resumption and completion of the test.

The important question is: do we need a quirk?
	Is this an inherent problem with this model? If so then a quirk is justified.
	Is this an inherent problem after this model had many writes? Again, a quirk is justified.
	Is this a fault with my specific disk? No quirk, I will keep my safe settings.

Let me know if further testing, or more information, is required.

Regards,
	Eyal

08:45:33 sudo sh -c 'echo 1024 >/sys/block/sda/device/timeout'
08:45:45 sudo sh -c 'echo 4096 > /sys/block/sda/queue/max_sectors_kb'
08:51:00 sudo /usr/local/bin/sync-tellerstats.sh		# start a test
         Quickly got a few shorter timeouts then an indefinite one:
08:51:10 2025-12-22
08:51:10 Device   wareq-sz      w/s     kB_w/s       kB_w
08:51:00 sda          0.00     0.00       0.00       0.00
08:51:10 sda       2187.47    59.90  131029.45 1310294.53	start of test
08:51:20 sda       2041.32    75.90  154936.19 1549361.88
08:51:30 sda       1745.31    87.50  152714.62 1527146.25
08:51:40 sda       1601.22    92.50  148112.85 1481128.50
08:51:50 sda       1444.75    97.40  140718.65 1407186.50
08:52:00 sda       2097.17    37.90   79482.74  794827.43
08:52:10 sda          0.00     0.00       0.00       0.00	short pause
08:52:20 sda          0.00     0.00       0.00       0.00
08:52:30 sda        622.74     7.30    4546.00   45460.02
08:52:40 sda          0.00     0.00       0.00       0.00	short pause
08:52:50 sda          0.00     0.00       0.00       0.00
08:53:00 sda          0.00     0.00       0.00       0.00
08:53:10 sda       2083.45    35.00   72920.75  729207.50
08:53:20 sda       1285.02   107.00  137497.14 1374971.40
08:53:30 sda       1882.78    77.30  145538.89 1455388.94
08:53:40 sda       1839.43    14.70   27039.62  270396.21
08:53:50 sda          0.00     0.00       0.00       0.00	pause
08:54:00 sda          0.00     0.00       0.00       0.00
08:54:10 sda          0.00     0.00       0.00       0.00
08:54:20 sda          0.00     0.00       0.00       0.00	longer than 30s
08:54:30 sda          0.00     0.00       0.00       0.00
...
09:10:50 sda          0.00     0.00       0.00       0.00	17 minutes later...
09:11:00 sda       1648.50    52.40   86381.40  863814.00
09:11:10 sda       1240.31   111.80  138666.66 1386666.58
09:11:20 sda       2172.02    64.50  140095.29 1400952.90
09:11:30 sda       2592.31    47.90  124171.65 1241716.49
09:11:40 sda       2143.92    57.60  123489.79 1234897.92
09:11:50 sda       1604.22    89.40  143417.27 1434172.68
09:12:00 sda       1550.97    88.60  137415.94 1374159.42
09:12:00 2025-12-22
09:12:10 Device   wareq-sz      w/s     kB_w/s       kB_w
09:12:10 sda       1215.60    47.50   57741.00  577410.00	end of test
09:12:20 sda          0.00     0.00       0.00       0.00
09:12:30 sda          0.00     0.00       0.00       0.00
-- system log:
2025-12-22T09:10:52+11:00 kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
2025-12-22T09:10:52+11:00 kernel: ata2.00: failed command: WRITE DMA EXT
2025-12-22T09:10:52+11:00 kernel: ata2.00: cmd 35/00:00:00:c8:d0/00:20:af:00:00/e0 tag 1 dma 4194304 out
                                            res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
2025-12-22T09:10:52+11:00 kernel: ata2.00: status: { DRDY }
2025-12-22T09:10:52+11:00 kernel: ata2: hard resetting link
2025-12-22T09:10:53+11:00 kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
2025-12-22T09:10:53+11:00 kernel: ata2.00: configured for UDMA/133
2025-12-22T09:10:53+11:00 kernel: ata2: EH complete
-- end of test:
09:13:37 sudo sh -c 'echo 3584 > /sys/block/sda/queue/max_sectors_kb'
09:13:56 sudo sh -c 'echo 120 >/sys/block/sda/device/timeout'

smart does NOT show increased '188 Command_Timeout'.

-- 
Eyal at Home (eyal@eyal.emu.id.au)
