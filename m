Received: from pasta.tip.net.au (mx1.tip.net.au [203.10.76.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024588F5B
	for <linux-ide@vger.kernel.org>; Sat, 20 Dec 2025 04:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.10.76.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766203417; cv=none; b=Bc2nJyUKeng+pY6t17eXTmv808TovxnJ/RhOYll/iqtbICQ2LnjWBEVYFpBKxuOSDrq5NbPg4wQlt5TOMj59Ei9rmUMlPviIgTDbgRI/DUOucqWRmJyiVgCHZh8aJP4Ctj9oh9futVScwrIvPacrOItapH4ED2o3Q3C4Wu21ELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766203417; c=relaxed/simple;
	bh=eiYYQEVD/KmF+dYrbPbBG+U1D3wzFm9A3Zvem3nOWiI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QAtxIDjGNq1MJCzbEutblClb39iRmqhfkHz0KmQwyBnhdpYf5iD3cfxlY9W0jhxJ77kh/zMfAYXnqDf2APBYl7yUrD34ApoQQj/Q2ELo9giXkAz1vd/LE93pGLCkh5PeSqiVw+zYULFt2c7wxvHAjAJPdtRivIegi5Ij1iHnmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au; spf=pass smtp.mailfrom=eyal.emu.id.au; arc=none smtp.client-ip=203.10.76.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eyal.emu.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eyal.emu.id.au
Received: from [192.168.2.7] (unknown [101.115.78.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhost.tip.net.au (Postfix) with ESMTPSA id 4dY9k54lydz8v3Q;
	Sat, 20 Dec 2025 15:03:25 +1100 (AEDT)
Message-ID: <582e748c-3e29-4f21-af7c-c799fb457e59@eyal.emu.id.au>
Date: Sat, 20 Dec 2025 15:03:18 +1100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: ata timeout exceptions
Reply-To: eyal@eyal.emu.id.au
To: list linux-ide <linux-ide@vger.kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <080383fe-63cf-4198-966a-b32d798bea06@eyal.emu.id.au>
 <13bf2e98-1774-4444-bc56-38a39d539d8e@kernel.org>
 <79fcb2f0-d09b-4649-bda0-55f309b20985@eyal.emu.id.au>
 <746FB9BB-5945-415F-915F-3F05D8A6B063@kernel.org>
Content-Language: en-US
In-Reply-To: <746FB9BB-5945-415F-915F-3F05D8A6B063@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/25 23:02, Niklas Cassel wrote:
> On 17 December 2025 20:56:07 GMT+09:00, Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:

[trimmed]

>> Do you want me to try different max_sectors_kb values to see where it breaks?
>>
> 
> You can also try this:
> 
> https://github.com/floatious/max-sectors-quirk
> 
> It tries these max_sector_kb values:
> declare -a sizes=(128 1024 2048 3072 4095 4096)
> 
> You can simply modify the script if you want to try more intermediate sizes.

After testing the script on a sacrificial disk, I got brave and ran it on the offending disk.
See comments after the test report.

------------------ test start
$ sudo sh ./find-max-sectors.sh /dev/sda
Drive model:
ST8000AS0002-1NA17Z

Drive firmware:
AR13

SATA / AHCI controller:
00:17.0 SATA controller [0106]: Intel Corporation Cannon Lake PCH SATA AHCI Controller [8086:a352] (rev 10)

Drive values before running the test:
/sys/block/sda/queue/max_hw_sectors_kb:32767
/sys/block/sda/queue/max_sectors_kb:4096
/sys/block/sda/queue/read_ahead_kb:8192

Running test with max_sectors 128 KiB
Test: PASS

Running test with max_sectors 1024 KiB
Test: PASS

Running test with max_sectors 2048 KiB
Test: PASS

Running test with max_sectors 3072 KiB
Test: PASS

Running test with max_sectors 4095 KiB
Test: PASS

Running test with max_sectors 4096 KiB
Test: PASS
------------------ test end

For the last few days I tested my usual workload with 3072, 4095 and 4096.

Up to 3072 all runs were clean, no pauses.

While I failed to produce a reset, the last (large) sizes often triggered pauses, about 30s each,
after which the job continued to completion. With 4096 I did see a long pause triggering a reset.

Note: What I saw so far (many times) is that if a pause is longer than 30s it never recovers until a reset.

Important: my workload is writing to this disk, I never saw any problems reading from it.

My guess is that the disk has confidence in accepting large write blocks but it fails to live up to the promise.
Writing is more involved on SMR and maybe there is an issue specific to large writes.

Looking at the smart stats, the disk had only 180TB lifetime writes, and it is specced for 55TB/year (or 180TB/y with v2 and v3).
So it is far from full.

I will now leave it running for a few days with max_sector_kb=4095 to see if it also triggers a reset.

Regards,
	Eyal

----- example of my workload, no pause. max_sector_kb=4096, timeout=120
18:06:52 2025-12-19
18:07:02 Device   wareq-sz      w/s     kB_w/s       kB_w
18:07:02 sda          0.00     0.00       0.00       0.00
18:07:12 sda          0.00     0.00       0.00       0.00
18:07:22 sda          0.00     0.00       0.00       0.00
18:07:32 sda          0.00     0.00       0.00       0.00
18:07:42 sda          0.00     0.00       0.00       0.00
18:07:52 sda          0.00     0.00       0.00       0.00
18:08:02 sda       1027.69    14.00   14387.66  143876.60
18:08:12 sda        912.34   105.60   96343.10  963431.04
18:08:22 sda       1303.94   106.50  138869.61 1388696.10
18:08:32 sda       1844.63    72.60  133920.14 1339201.38
18:08:42 sda       2083.31    66.30  138123.45 1381234.53
18:08:52 sda       1339.79    71.30   95527.03  955270.27
18:09:02 sda       2427.31    47.70  115782.69 1157826.87
18:09:12 sda       1817.04    69.80  126829.39 1268293.92
18:09:22 sda       1805.27    54.70   98748.27  987482.69
18:09:32 sda       1186.68    90.10  106919.87 1069198.68
18:09:42 sda       1041.10   114.10  118789.51 1187895.10
18:09:52 sda        972.94   141.80  137962.89 1379628.92
18:10:02 sda       1086.14    90.70   98512.90  985128.98
18:10:12 sda       1360.86    74.50  101384.07 1013840.70
18:10:22 sda       1354.29    87.60  118635.80 1186358.04
18:10:32 sda       1712.45    63.00  107884.35 1078843.50
18:10:42 sda       1529.06    74.20  113456.25 1134562.52
18:10:52 sda       1681.66    65.80  110653.23 1106532.28
18:11:02 sda       1589.97    73.80  117339.79 1173397.86
18:11:12 sda       1623.92    35.40   57486.77  574867.68
18:11:22 sda          0.00     0.00       0.00       0.00
18:11:32 sda          0.00     0.00       0.00       0.00
18:11:42 sda          0.00     0.00       0.00       0.00
18:11:52 sda          0.00     0.00       0.00       0.00
-----

----- example of my workload, showing two pauses followed by a 3rd long pause+reset
22:06:53 2025-12-19
22:07:03 Device   wareq-sz      w/s     kB_w/s       kB_w
22:07:03 sda          0.00     0.00       0.00       0.00
22:07:13 sda          0.00     0.00       0.00       0.00
22:07:23 sda          0.00     0.00       0.00       0.00
22:07:33 sda          0.00     0.00       0.00       0.00
22:07:43 sda          0.00     0.00       0.00       0.00
22:07:53 sda          0.00     0.00       0.00       0.00
22:08:03 sda        584.10    27.70   16179.57  161795.70
22:08:13 sda        865.20   137.40  118878.48 1188784.80
22:08:23 sda       1035.57    73.50   76114.39  761143.95
22:08:33 sda        928.37   133.00  123473.21 1234732.10
22:08:43 sda        740.79   153.30  113563.11 1135631.07
22:08:53 sda        780.15   103.90   81057.59  810575.85
22:09:03 sda       1061.52   107.60  114219.55 1142195.52
22:09:13 sda        674.01   127.40   85868.87  858688.74
22:09:23 sda        959.01   137.80  132151.58 1321515.78
22:09:33 sda       1427.83    81.90  116939.28 1169392.77
22:09:43 sda       1210.29    90.50  109531.24 1095312.45
22:09:53 sda        864.15    32.90   28430.53  284305.35
22:10:03 sda          0.00     0.00       0.00       0.00
22:10:13 sda          0.00     0.00       0.00       0.00
22:10:23 sda       1787.96    11.00   19667.56  196675.60
22:10:33 sda          0.00     0.00       0.00       0.00
22:10:43 sda          0.00     0.00       0.00       0.00
22:10:53 sda          0.00     0.00       0.00       0.00
22:11:03 sda       1569.92    33.40   52435.33  524353.28
22:11:13 sda       1262.29    69.50   87729.15  877291.55
22:11:23 sda          0.00     0.00       0.00       0.00
22:11:33 sda          0.00     0.00       0.00       0.00
22:11:43 sda          0.00     0.00       0.00       0.00
22:11:53 sda          0.00     0.00       0.00       0.00
22:11:53 2025-12-19
22:12:03 Device   wareq-sz      w/s     kB_w/s       kB_w
22:12:03 sda          0.00     0.00       0.00       0.00
22:12:13 sda          0.00     0.00       0.00       0.00
22:12:23 sda          0.00     0.00       0.00       0.00
22:12:33 sda          0.00     0.00       0.00       0.00
22:12:43 sda          0.00     0.00       0.00       0.00
22:12:53 sda          0.00     0.00       0.00       0.00
22:13:03 sda          0.00     0.00       0.00       0.00
22:13:13 sda          0.00     0.00       0.00       0.00
22:13:23 sda        972.28   122.40  119007.07 1190070.72
22:13:33 sda       1303.25    92.00  119899.00 1198990.00
22:13:43 sda       2139.47    51.80  110824.55 1108245.46
22:13:53 sda       1240.71    99.60  123574.72 1235747.16
22:14:03 sda       1516.56    74.00  112225.44 1122254.40
22:14:13 sda       1832.90    56.60  103742.14 1037421.40
22:14:23 sda       1112.75   108.90  121178.48 1211784.75
22:14:33 sda        573.11    93.50   53585.79  535857.85
22:14:43 sda          0.00     0.00       0.00       0.00
22:14:53 sda          0.00     0.00       0.00       0.00
-- the system log shows the reset:
2025-12-19T22:13:12+11:00 kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
2025-12-19T22:13:12+11:00 kernel: ata2.00: failed command: WRITE DMA EXT
2025-12-19T22:13:12+11:00 kernel: ata2.00: cmd 35/00:00:00:08:34/00:20:ba:01:00/e0 tag 15 dma 4194304 out
                                            res 40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
2025-12-19T22:13:12+11:00 kernel: ata2.00: status: { DRDY }
2025-12-19T22:13:12+11:00 kernel: ata2: hard resetting link
2025-12-19T22:13:13+11:00 kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
2025-12-19T22:13:13+11:00 kernel: ata2.00: configured for UDMA/133
2025-12-19T22:13:13+11:00 kernel: ata2: EH complete
-----

> Kind regards,
> Niklas


-- 
Eyal at Home (eyal@eyal.emu.id.au)
