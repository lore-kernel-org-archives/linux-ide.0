Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F146FC3
	for <linux-ide@vger.kernel.org>; Fri, 14 Nov 2025 04:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763094759; cv=none; b=W4F4eIXIYrg4WBagJ4Z2d8/bML53yeDiCXW+zcDjmTAfQ8zaMYXo8ryCBX+gA48KBwOqp5wVrkj0ZI6zy3wLHZZs8QUcw3WJzxH6S3z3ZGDBHYABZH5GCu5sq6+0nzrbL1xZTG93XKj8MQPyJdmz0HkT9uID/t/gzkZOjsKmdIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763094759; c=relaxed/simple;
	bh=S5TxU6WQSSijTwXxJn1HY2WQkABTyDWlvrVlr5m7j0w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Gsb+N9rrGB5/sWa/ZyHCzjuLJ+g91/NbG/cQLQJ7haaJxoMXgr7wg22p06m6jh9KOgA9aZ2AV+BxsuMpRDKbMIYLsV043cCDe8Ts5+r0lESDl5qAV4iODGam57ElPYbvfO81PBfBXnqMkMqJGMVGxJbck+fh94fRPR/enbh3AQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.72.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4d744C1b7Rz8v0W
	for <linux-ide@vger.kernel.org>; Fri, 14 Nov 2025 15:32:27 +1100 (AEDT)
Message-ID: <4f0fa70c-b259-4998-bf94-c6c6fd8c733c@eyal.emu.id.au>
Date: Fri, 14 Nov 2025 15:32:20 +1100
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
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
Content-Language: en-US
In-Reply-To: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/25 15:13, Eyal Lebedinsky wrote:
> I have a sata disk that is probably on its last legs.
> It is a plain disk (no RAID or such). If it matters, it is an old 8TB Seagate SMA disk.
	It is ST8000AS0002-1NA17Z from 2016.> It sees very little activity.
> 
> Every two hours a small rsync copies a directory into this disk. A few 100s of files are copied each time, a few 10s of GB in total.
> 
> For the last few weeks it started to log timeout errors (not always) like this:

For the last two weeks I was monitoring the activity on the disk and here is what I did:

- added to boot command line:	libata.force=2.00:noncq
	now smartmon sees no more Command_Timeout errors since
- added to rc.local:		echo 180 >/sys/block/sda/device/timeout	# was 30
	Drastically less timeout/resets
	No counters change in smartctl report

Q1) Do I need to also set eh_timeout?

Q2) Is there any disk parameter I should set?

Then ran iostat and monitored the system log.
Every 2 hours a sync of 20-30MB is done to this disk. 4 minutes for a smooth run.
Mostly it completes without errors logged.
However, once or twice a day the pauses become long enough to hit the 180s timeout.

Note: I do not see pauses longer that 30s but shorter than 180s.

See logs below.

Q3) What is going on in the disk during a pause? I understand that there was no communication from the disk,
just a long wait until the system issues a reset, when it probably retries successfully.

This disk was used for a few years without such errors. The first report is recent (from 25/Oct this year).

Regards,
	Eyal

## example sync with pauses but without resets (timeout set to 180s):
14:07:46 2025-11-14
14:07:46 Device       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd
14:07:56 sda         0.00         0.00         0.00         0.00          0          0          0
14:08:06 sda        29.60        10.40     55742.80         0.00        104     557428          0       start
14:08:16 sda        74.30         9.20    132401.60         0.00         92    1324016          0
14:08:26 sda        56.30         6.80    137086.80         0.00         68    1370868          0
14:08:36 sda        55.50         4.80    144625.20         0.00         48    1446252          0
14:08:46 sda        49.30         1.60     90455.20         0.00         16     904552          0
14:08:56 sda         0.00         0.00         0.00         0.00          0          0          0       pause #1
14:09:06 sda         0.00         0.00         0.00         0.00          0          0          0
14:09:16 sda         0.00         0.00         0.00         0.00          0          0          0
14:09:26 sda        95.50         3.60    135380.00         0.00         36    1353800          0
14:09:36 sda        85.20         1.60    164806.00         0.00         16    1648060          0
14:09:46 sda         4.10         0.80     10730.80         0.00          8     107308          0
14:09:56 sda         0.00         0.00         0.00         0.00          0          0          0       pause #2
14:10:06 sda         0.00         0.00         0.00         0.00          0          0          0
14:10:16 sda        16.80         0.80     33057.20         0.00          8     330572          0
14:10:26 sda         0.00         0.00         0.00         0.00          0          0          0       pause #3
14:10:36 sda         0.00         0.00         0.00         0.00          0          0          0
14:10:46 sda         0.00         0.00         0.00         0.00          0          0          0
14:10:56 sda        35.30         3.60     69011.20         0.00         36     690112          0
14:11:06 sda        75.90         4.00    145637.60         0.00         40    1456376          0
14:11:16 sda        10.00         0.80     24583.60         0.00          8     245836          0
14:11:26 sda         0.00         0.00         0.00         0.00          0          0          0       short pause #1
14:11:36 sda         9.00         0.40     14786.40         0.00          4     147864          0
14:11:46 sda        61.90         2.80    146004.80         0.00         28    1460048          0
14:11:56 sda        10.50         1.20     28356.80         0.00         12     283568          0
14:12:06 sda         0.00         0.00         0.00         0.00          0          0          0       pause #4
14:12:16 sda         0.00         0.00         0.00         0.00          0          0          0
14:12:26 sda        58.80         3.60    139051.20         0.00         36    1390512          0
14:12:36 sda        10.70         0.80     25866.40         0.00          8     258664          0
14:12:46 sda         0.00         0.00         0.00         0.00          0          0          0       short pause #2
14:12:46 sda         1.65        10.83      2721.90         0.00     142777   35897004          0
14:12:56 sda         0.00         0.00         0.00         0.00          0          0          0       short pause #3
14:13:06 sda        19.80         0.80     31588.00         0.00          8     315880          0
14:13:16 sda        34.50         2.00     84646.40         0.00         20     846464          0
14:13:26 sda         0.00         0.00         0.00         0.00          0          0          0       pause #5
14:13:36 sda         0.00         0.00         0.00         0.00          0          0          0
14:13:46 sda        68.20         2.80    118868.40         0.00         28    1188684          0
14:13:56 sda         0.20         0.00       380.80         0.00          0       3808          0
14:14:06 sda         0.00         0.00         0.00         0.00          0          0          0       pause #6
14:14:16 sda         0.00         0.00         0.00         0.00          0          0          0
14:14:26 sda        24.00         1.60     51746.40         0.00         16     517464          0
14:14:36 sda        63.80         5.20    136939.20         0.00         52    1369392          0
14:14:46 sda        59.70         4.80    125234.80         0.00         48    1252348          0
14:14:56 sda        16.70         1.20     40121.20         0.00         12     401212          0
14:15:06 sda         8.80         0.00        69.20         0.00          0        692          0
14:15:16 sda         0.00         0.00         0.00         0.00          0          0          0       end
14:15:26 sda         0.00         0.00         0.00         0.00          0          0          0
14:15:26 Device       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd

However, a few times a day the pauses become long enough to hit the 180s timeout:

## example sync with pauses and one reset (timeout set to 180s):
12:08:05 sda        29.20       194.80     45394.40         0.00       1948     453944          0       start
12:08:15 sda        36.40        14.40    104648.40         0.00        144    1046484          0
12:08:25 sda        37.10        13.20    107768.40         0.00        132    1077684          0
12:08:35 sda        28.60         8.80     99516.40         0.00         88     995164          0
12:08:45 sda        31.30         8.40    114315.60         0.00         84    1143156          0
12:08:55 sda        33.10         9.60    111729.20         0.00         96    1117292          0
12:09:05 sda        12.10         1.60     24356.00         0.00         16     243560          0
12:09:15 sda         0.00         0.00         0.00         0.00          0          0          0       pause #1
12:09:25 sda         0.00         0.00         0.00         0.00          0          0          0
12:09:35 sda         7.10         2.00     16304.00         0.00         20     163040          0
12:09:45 sda        51.40        10.00    109822.80         0.00        100    1098228          0
12:09:55 sda        58.10        33.20    111903.60         0.00        332    1119036          0
12:10:05 sda        40.20        11.20    111351.20         0.00        112    1113512          0
12:10:15 sda        45.00        15.60    101494.00         0.00        156    1014940          0
12:10:25 sda        43.80        10.80    121330.80         0.00        108    1213308          0
12:10:35 sda        41.30        17.20    112128.40         0.00        172    1121284          0
12:10:45 sda        46.30        10.00    111787.20         0.00        100    1117872          0
12:10:55 sda        43.80         9.20    108923.60         0.00         92    1089236          0
12:11:05 sda        47.70        11.60    115351.60         0.00        116    1153516          0
12:11:15 sda        68.90        11.60    122597.60         0.00        116    1225976          0
12:11:25 sda        35.60         7.20     76411.60         0.00         72     764116          0
12:11:35 sda        24.60         4.80     55798.80         0.00         48     557988          0
12:11:45 sda        11.90         0.80     24110.00         0.00          8     241100          0
12:11:55 sda         0.00         0.00         0.00         0.00          0          0          0       pause #2
12:12:05 sda         0.00         0.00         0.00         0.00          0          0          0
12:12:15 sda         9.90         0.80     10282.40         0.00          8     102824          0
12:12:25 sda         0.00         0.00         0.00         0.00          0          0          0       long pause
12:12:35 sda         0.00         0.00         0.00         0.00          0          0          0
12:12:45 sda         0.00         0.00         0.00         0.00          0          0          0
12:12:55 sda         0.00         0.00         0.00         0.00          0          0          0
12:13:05 sda         0.00         0.00         0.00         0.00          0          0          0
12:13:15 sda         0.00         0.00         0.00         0.00          0          0          0
12:13:25 sda         0.00         0.00         0.00         0.00          0          0          0
12:13:35 sda         0.00         0.00         0.00         0.00          0          0          0
12:13:45 sda         0.00         0.00         0.00         0.00          0          0          0
12:13:55 sda         0.00         0.00         0.00         0.00          0          0          0
12:14:05 sda         0.00         0.00         0.00         0.00          0          0          0
12:14:15 sda         0.00         0.00         0.00         0.00          0          0          0
12:14:25 sda         0.00         0.00         0.00         0.00          0          0          0
12:14:35 sda         0.00         0.00         0.00         0.00          0          0          0
12:14:45 sda         0.00         0.00         0.00         0.00          0          0          0
12:14:45 2025-11-14
12:14:45 Device       tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd
12:14:45 sda         2.20        23.25      3139.39         0.00     142021   19175400          0
12:14:55 sda         0.00         0.00         0.00         0.00          0          0          0
12:15:05 sda         0.00         0.00         0.00         0.00          0          0          0       timeout

12:15:14+11:00 kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
12:15:14+11:00 kernel: ata2.00: failed command: WRITE DMA EXT
12:15:14+11:00 kernel: ata2.00: cmd 35/00:00:00:68:4e/00:20:77:00:00/e0 tag 28 dma 4194304 out
                                 res 40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
12:15:14+11:00 kernel: ata2.00: status: { DRDY }
12:15:14+11:00 kernel: ata2: hard resetting link
12:15:15+11:00 kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
12:15:15+11:00 kernel: ata2.00: configured for UDMA/133
12:15:15+11:00 kernel: ata2: EH complete

12:15:15 sda         1.40         0.00      2985.20         0.00          0      29852          0
12:15:25 sda        50.60        11.60    121033.60         0.00        116    1210336          0
12:15:35 sda        15.00         1.60     30986.00         0.00         16     309860          0
12:15:45 sda         0.00         0.00         0.00         0.00          0          0          0       pause #3
12:15:55 sda         0.00         0.00         0.00         0.00          0          0          0
12:16:05 sda        11.00         0.40     14271.20         0.00          4     142712          0
12:16:15 sda         5.50         4.00      5271.60         0.00         40      52716          0
12:16:25 sda         0.00         0.00         0.00         0.00          0          0          0       end
12:16:35 sda         0.00         0.00         0.00         0.00          0          0          0

-- 
Eyal at Home (eyal@eyal.emu.id.au)
